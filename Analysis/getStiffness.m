function BirdData=getStiffness(BirdData,numFPA,numV)
%   BirdData=getDeflections(BirdData,numFPA,numV)
%
%   Calculates the stiffness tensor using least squares.
%   
%   Currently does not work.
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
    
    [dM_prox]=forStiffnessMatrix(deltas_prox(:));
    [dM_dist]=forStiffnessMatrix(deltas_dist(:));
    
    K_prox=(dM_prox'*dM_prox)\(dM_prox'*FM(:));
    K_dist=(dM_dist'*dM_dist)\(dM_dist'*FM(:));

    K_prox=immersion(K_prox);
    K_dist=immersion(K_dist);
    for a1=1:numel(BirdData)
        BirdData(a1).K_prox=K_prox;
        BirdData(a1).K_dist=K_dist;
    end
    
    
    %Test
    %{
    %Why does this work for 6, but not 4?  There are 21 variables, we have
    %24 measurements, so 
    num_data=6;
    K=randn(21,1);
    K=immersion(K);
    delta=zeros(6,num_data);
    Ftest=zeros(6,num_data);
    for a1=1:num_data
        delta(:,a1)=randn(6,1);
        Ftest(:,a1)=K*delta(:,a1);
    end
    dM=forStiffnessMatrix(delta(:));
    Ktilde=(dM'*dM)\(dM'*Ftest(:))
    KtildeM=immersion(Ktilde);
    KtildeM-K
    %}
    
    
end


function M=forStiffnessMatrix(dxtheta)
%Instead of multiplying so that FM=K*dxtheta, where K is symmetric, we swap
%the ordering so that K is vectorized and dxtheta is the matrix.
% Fx_i: 1
% Fy_i: 2
% Fz_i: 3
% Mx_i: 4
% My_i: 5
% Mz_i: 6

    npoints=numel(dxtheta);
    M=zeros(npoints,21);
    
    for a1=1:(npoints/6)
        M(6*(a1-1)+(1:6),:)=reverseSymmetricMatVectMultiplication(dxtheta(6*(a1-1)+(1:6)));
    end
    


end


function N=reverseSymmetricMatVectMultiplication(dxtheta)

    N=zeros(6,21);
    for a1=1:6
        ind0=(-(a1-1)^2+13*(a1-1))/2;
        ind=(1:(6-a1+1))+ind0;
        N(a1,ind)=dxtheta(a1:6)';
        ind=(1:(6-a1))+ind0+1;
        N((a1+1):6,ind)=dxtheta(a1)*eye(6-a1,6-a1);
    end
end


function X=immersion(Y)

    nY=size(Y,1);
    nX=(-1+sqrt(1+8*nY))/2;
    X=zeros(nX,nX);
    for a1=1:nX
        inds=(1:(nX-a1+1))-0.5*(a1-1)^2+(nX+0.5)*(a1-1);
        X(a1:nX,a1)=Y(inds);
        X(a1,a1:nX)=Y(inds);
    end
end
