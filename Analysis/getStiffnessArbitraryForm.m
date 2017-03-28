function BirdData=getStiffnessArbitraryForm(BirdData,numFPA,numV)
%   BirdData=getStiffnessArbitraryForm(BirdData,numFPA,numV)
%
%   Calculates the stiffness tensor using least squares, this assumes that 
%   the stiffness tensor has non-zero elements corresponding to those of MASK.
%   
%   The stiffness tensor returned has the form:
%
%   K=K_trans (+) diag(k_theta,k_psi,k_phi), where K_trans is the 3x3 
%   symmetric translational stiffness, the diagonal matrix is the 
%   rotational stiffness, and (+) denotes the matrix direct sum.
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
   
    %Builds the mask
    type='diag-angular';
    switch type
        case 'arbitrary'
            MASK=true(6,6);
        case 'principal'
            MASK=diag(true(6,1));
        case 'isotropic'
            MASK=blkdiag(true(3,3),diag(true(3,1)));
        case 'principal-translational'
            MASK=blkdiag(diag(true(3,1)),true(3,3));
        case 'principal-angular'
            MASK=[true(3,3) diag(true(3,1));diag(true(3,1)) diag(true(3,1))];
        case 'diag-translational'
            MASK=[diag(true(3,1)) diag(true(3,1));diag(true(3,1)) true(3,3)];
        case 'diag-angular'
            MASK=[true(3,3) diag(true(3,1));diag(true(3,1)) diag(true(3,1))];
    end
    %To see the form of the stiffness matrix, type spy(mask)
    
    %Could even use different forms for the distal and proximal triangles
    [dM_prox,inds]=forStiffnessMatrixArbitrary(deltas_prox(:)',6,MASK);
    [dM_dist,inds]=forStiffnessMatrixArbitrary(deltas_dist(:)',6,MASK);
    
    K_prox=(dM_prox'*dM_prox)\(dM_prox'*FM(:));
    K_dist=(dM_dist'*dM_dist)\(dM_dist'*FM(:));

    K_prox=symmetrify(K_prox,inds);
    K_dist=symmetrify(K_dist,inds);
    for a1=1:numel(BirdData)
        BirdData(a1).K_prox=K_prox;
        BirdData(a1).K_dist=K_dist;
    end
    
    (K_prox*deltas_prox-FM)./FM
    (K_dist*deltas_dist-FM)./FM
    
end


function [M,inds]=forStiffnessMatrixArbitrary(dxtheta,n,MASK)
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
    nK=(sum(MASK(:))-sum(diag(MASK)))/2+sum(diag(MASK));
    
    if (isnumeric(dxtheta))
        M=zeros(npoints,nK);
    else%For testing
        M=sym(zeros(npoints,nK));
    end
    
    for a1=1:(npoints/n)
        [M(n*(a1-1)+(1:n),:),inds]=reverseSymmetricMatVectMultiplicationArbitrary(dxtheta(n*(a1-1)+(1:n)),MASK);
    end
end


function [N,inds]=reverseSymmetricMatVectMultiplicationArbitrary(dxtheta,MASK)
% N=reverseSymmetricMatVectMultiplicationArbitrary(dxtheta,MASK)
%
% We are trying to find F=K*delta, this reverses the multiplication order
% to N*K_vect, where the non-zero elements of K_vect are given by MASK.
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu

    n=numel(dxtheta);
    nK=(sum(MASK(:))-sum(diag(MASK)))/2+sum(diag(MASK));
    
    c1=0;
    for a1=1:size(MASK,1) %Which force
        for a2=a1:size(MASK,2) %Which displacement
            if (MASK(a1,a2))
                c1=c1+1;
                inds(c1,:)=[a1,a2];%(force,displacement), NOTE: the row of inds corresponds to the column of the variable in N.
            end
        end
    end

    if (isnumeric(dxtheta))
        N=zeros(n,c1);
    else%For testing
        N=sym(zeros(n,c1));
    end
    
    for a1=1:nK
        N(inds(a1,1),a1)=dxtheta(inds(a1,2));
    end
    
end


function K=symmetrify(K_vect,inds)

    for a1=1:size(inds,1)
        K(inds(a1,1),inds(a1,2))=K_vect(a1);
        K(inds(a1,2),inds(a1,1))=K_vect(a1);
    end

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
