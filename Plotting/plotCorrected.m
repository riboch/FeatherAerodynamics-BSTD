function plotCorrected(tip,R1,R2,F1,F2)
%   plotCorrected(tip,R1,R2,F1,F2)
%
%   This function plots the corrected frames as a concept check for different definitions of twist. 
%   
%
%
%   
%   Inputs:
%
%       tip: tip frame
%
%       R1: Rotation matrix 1
% 
%       R2: Rotation matrix 2
% 
%       F1: Frame 1
% 
%       F2: Frame 2
%
%   Outputs:
%
%       
%
% Richard B. Choroszucha
% riboch@umich.edu

    figure(101)
        I=eye(3,3);
        Z=zeros(3,3);
        quiver3(Z(1,:),Z(2,:),Z(3,:),I(1,:),I(2,:),I(3,:),'k');
        hold on;
        T=repmat(tip,[1 3]);
        quiver3(0,0,0,tip(1,:),tip(2,:),tip(3,:),'k');
        quiver3(T(1,:),T(2,:),T(3,:),F2(1,:),F2(2,:),F2(3,:),'k')
        
        tip=R2*tip;
        quiver3(0,0,0,tip(1,:),tip(2,:),tip(3,:),'b');
        T=R2*T;
        F2=R2*F1;
        quiver3(T(1,:),T(2,:),T(3,:),F2(1,:),F2(2,:),F2(3,:),'b')
    
        tip=R1'*tip;
        quiver3(0,0,0,tip(1,:),tip(2,:),tip(3,:),'r');
        T=R1'*T;
        F2=R1'*F1;
        quiver3(T(1,:),T(2,:),T(3,:),F2(1,:),F2(2,:),F2(3,:),'r')
        
    hold off;
    axis image;
end