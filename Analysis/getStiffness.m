function BirdData=getStiffness(BirdData,numFPA,numV)
%   BirdData=getDeflections(BirdData,numFPA,numV)
%
%   Calculates the stiffness tensor using least squares.
%   
%   Currently only works if there are 6 or more deflections and forces. 
%   This can also be adapted to return the compliance tensor.
%   
%   Inputs:
%
%       BirdData: A structure returned from RotateData
%
%       numFPA: Number of flight path angles tested.
%
%       numV:   Number of velocity points tested.
%
%
%   Outputs:
%
%       BirdData:   A structure of the data and calculated quantities.
%
%
% Richard B. Choroszucha
% riboch@umich.edu

    degtorad=pi/180;

    c1=1;
    for a1=1:numFPA
        for a2=1:numV
            ind=numV*(a1-1)+a2;
            if (~(any(isnan(BirdData(ind).F')) | any(isnan(BirdData(ind).M'))))
                radtodeg=180/(pi);
                R=rodrigues(-BirdData(ind).FPA/radtodeg,[1;0;0]);
                F=R*BirdData(ind).F';
                M=R*BirdData(ind).M';
                FM(:,c1)=[F;M];
                
                %Deltas should have been calculated in "inertial frame" so
                %no rotation should be necessary
                dtheta_prox=[BirdData(ind).bendProximal BirdData(ind).tau(6).theta BirdData(ind).sweepProximal]'*degtorad;
                dtheta_dist=[BirdData(ind).bendDistal BirdData(ind).tau(2).theta BirdData(ind).sweepDistal]'*degtorad;
                
                dx_prox=BirdData(ind).ProximalDeflection;
                dx_dist=BirdData(ind).DistalDeflection;
                
                deltas_prox(:,c1)=[dx_prox;2*dtheta_prox];%The *2 comes from symmetry
                deltas_dist(:,c1)=[dx_dist;2*dtheta_dist];
                c1=c1+1;
            end
        end
    end
   
    [dM_prox]=forStiffnessMatrix(deltas_prox(:),6);
    [dM_dist]=forStiffnessMatrix(deltas_dist(:),6);
    
    K_prox=(dM_prox'*dM_prox)\(dM_prox'*FM(:));
    K_dist=(dM_dist'*dM_dist)\(dM_dist'*FM(:));

    K_prox=immersion(K_prox);
    K_dist=immersion(K_dist);
    for a1=1:numel(BirdData)
        BirdData(a1).K_prox=K_prox;
        BirdData(a1).K_dist=K_dist;
    end
    
end

function M=forStiffnessMatrix(dxtheta,n)
% M=forStiffnessMatrix(dxtheta,n)
%
% This function returns the matrix for least squares fitting of the
% stiffness tensor from forces and deflections.
%
%
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu

%Instead of multiplying so that FM=K*dxtheta, where K is symmetric, we swap
%the ordering so that K is vectorized and dxtheta is the matrix.
% Fx_i: 1
% Fy_i: 2
% Fz_i: 3
% Mx_i: 4
% My_i: 5
% Mz_i: 6

    npoints=numel(dxtheta);
    
    if (isnumeric(dxtheta))
        M=zeros(npoints,n*(n+1)/2);
    else%For testing
        M=sym(zeros(npoints,n*(n+1)/2));
    end
    
    for a1=1:(npoints/n)
        M(n*(a1-1)+(1:n),:)=reverseSymmetricMatVectMultiplication(dxtheta(n*(a1-1)+(1:n)),n);
    end
end

function N=reverseSymmetricMatVectMultiplication(dxtheta,n)
% N=reverseSymmetricMatVectMultiplication(dxtheta,n)
%
% We are trying to find F=K*delta, this reverses the multiplication order
% to N*K_vect.
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu


    if (isnumeric(dxtheta))
        N=zeros(n,n*(n+1)/2);
    else%For testing
        N=sym(zeros(n,n*(n+1)/2));
    end
    for a1=1:n
        ind0=(-(a1-1)^2+(2*n+1)*(a1-1))/2;
        ind=(1:(n-a1+1))+ind0;
        N(a1,ind)=dxtheta(a1:n)';
        ind=(1:(n-a1))+ind0+1;
        N((a1+1):n,ind)=dxtheta(a1)*eye(n-a1,n-a1);
    end
end


function X=immersion(Y)
% X=immersion(Y)
%
%   This function returns matrix of a vectorized symmetric matrix. 
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu

    nY=size(Y,1);
    nX=(-1+sqrt(1+8*nY))/2;
    X=zeros(nX,nX);
    for a1=1:nX
        inds=(1:(nX-a1+1))-0.5*(a1-1)^2+(nX+0.5)*(a1-1);
        X(a1:nX,a1)=Y(inds);
        X(a1,a1:nX)=Y(inds);
    end
end





%Unused functions


function Y=submersion(X)

    
    nX=size(X,1);
    if isnumeric(X)
        Y=zeros(nX*(nX+1)/2,1);
    else
        Y=sym(zeros(nX*(nX+1)/2,1));
    end
    for a1=1:nX
        inds=(1:(nX-a1+1))-0.5*(a1-1)^2+(nX+0.5)*(a1-1);
        Y(inds)=X(a1:nX,a1);
    end
end


function M=findStiffnessVectorMatMult(Delta)

    M=[];
    I=eye(size(Delta,1));
    for a1=1:size(Delta,2)
        M0=kron(Delta(:,a1)',I);
        M=[M;M0];
    end
    MS=symmetryConstraint(size(Delta,1));
    M=[M;MS];
    M=[M;null(M)'];
    
end


function M=symmetryConstraint(n)

    M=zeros(n*(n-1)/2,n*n);
    c1=1;
    for a1=1:n
        for a2=(a1+1):n
            ind1=n*(a1-1)+a2;
            ind2=n*(a2-1)+a1;
            M(c1,ind1)=1;
            M(c1,ind2)=-1;
            c1=c1+1;
        end
    end
    
end


function K=findStiffnessQuadForm(FM,Delta,n)

    F=FM(:);
    dxtheta=Delta(:);

    M=forStiffnessMatrix(dxtheta,n);
    
    
    for a1=1:size(FM,2)
        for a2=1:size(Delta,2)
            F(end+1)=Delta(:,a2)'*FM(:,a1);
            
            A=Delta(:,a2)*Delta(:,a2)';
            B=A-diag(diag(A));
            A=diag(diag(A))+2*B;
            M(end+1,:)=submersion(A)';
        end
    end

    M0=null(M)';
    M=[M;M0];
    F=[F;zeros(size(M0,1),1)];
    
    Kvect=(M'*M)\(M'*F);
    %K=immersion(Kvect);
    K=Kvect;
    
end


%Other test code
%     M=findStiffnessVectorMatMult(deltas_dist);
%     K_dist=(M'*M)\M'*FM(:);
%     K_dist=reshape(K_dist,[6,6]);
    
%     K_prox=findStiffnessQuadForm(FM,deltas_prox,6);
%     K_dist=findStiffnessQuadForm(FM,deltas_dist,6);


  %Symbolic test code
    %{
    %Why does this work for 6, but not 4?  There are 21 variables, we have
    %24 measurements, so 
    num_data=2;
    n=3;
%     Kvect=randn(21,1);
%     K=immersion(Kvect);
%     delta=zeros(6,num_data);
%     Ftest=zeros(6,num_data);
%     for a1=1:num_data
%         delta(:,a1)=randn(6,1);
%         Ftest(:,a1)=K*delta(:,a1);
%     end
%     dM=forStiffnessMatrix(delta(:));
%     Ktilde=(dM'*dM)\(dM'*Ftest(:))
%     KtildeM=immersion(Ktilde);
%     KtildeM-K
    
    delta=sym(zeros(num_data*n,1));
    for a1=1:num_data
        if (n==6)
            delta(6*(a1-1)+1)=sym(sprintf('delta_x%d',a1),'real');
            delta(6*(a1-1)+2)=sym(sprintf('delta_y%d',a1),'real');
            delta(6*(a1-1)+3)=sym(sprintf('delta_z%d',a1),'real');
            delta(6*(a1-1)+4)=2*sym(sprintf('delta_theta%d',a1),'real');
            delta(6*(a1-1)+5)=2*sym(sprintf('delta_phi%d',a1),'real');
            delta(6*(a1-1)+6)=2*sym(sprintf('delta_psi%d',a1),'real');
        elseif (n==3)
            delta(3*(a1-1)+1)=sym(sprintf('delta_x%d',a1),'real');
            delta(3*(a1-1)+2)=sym(sprintf('delta_y%d',a1),'real');
            delta(3*(a1-1)+3)=2*sym(sprintf('delta_theta%d',a1),'real');
        end
    end
    K=sym(zeros(n,n));
    for a1=1:n
        K(a1,a1)=sym(sprintf('K_%d%d',a1,a1),'real');
        for a2=(a1+1):n
            K(a1,a2)=2*sym(sprintf('K_%d%d',a1,a2),'real');
        end
    end
    K=(K+K')/2;
    if (n==6)
        Kvect=[K(1,1:n)';K(2,2:n)';K(3,3:n)';K(4,4:n)';K(5,5:n)';K(6,6:n)']
    elseif (n==3)
        Kvect=[K(1,1:n)';K(2,2:n)';K(3,3:n)']
    end
        dM=forStiffnessMatrix(delta,n);
        dM(1:n,:)*Kvect-K*delta(1:n)
    
    K=findStiffnessQuadForm(sym(randn(n,num_data)),reshape(delta,[n,num_data]),n);
    
    %}
