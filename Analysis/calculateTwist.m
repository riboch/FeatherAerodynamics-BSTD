function theta=calculateTwist(F1,F2,plotstuff)
%   BirdData=calculateAoAandAoS(BirdData,numFPA,numV)
%
%   This function calculates the twist about the x-axes of frame F2 relative to frame F1.
%
%   
%   Inputs:
%
%       F1: Frame 1
%
%       F2: Frame 2
%
%       plotstuff: a logical for whether or not to plot the frames
%
%
%   Outputs:
%
%       theta:   The twist in radians.
%
%
% Richard B. Choroszucha
% riboch@umich.edu

%Returns radians
    beta=acos(F1(:,1)'*F2(:,1));%Angle between x-axis of both frames
    mhat=cross(F1(:,1),F2(:,1));%Normal to x-axes
    mhat=mhat/norm(mhat,2);%Normalize mhat 
    R=rodrigues(beta,mhat);%Rotation about mhat by beta radians
    F3=R'*F2;   %Rotate so that x-axis are aligned.
    theta=acos(dot(F1(:,3),F3(:,3)));%Angle required to rotate about x-axis to get from one frame to the other.
    
    if (isnan(theta))
        theta=0;
    end

    if (plotstuff)
        %This plots all the different frames together.
        F3-F1
        R=rodrigues(theta,F1(:,1));
        F4=R*F3;

        Z=zeros(3,3);
        figure(10);

            quiver3(Z(1,:),Z(2,:),Z(3,:),F1(1,:),F1(2,:),F1(3,:),'k');
            hold on;
            quiver3(Z(1,:),Z(2,:),Z(3,:),F2(1,:),F2(2,:),F2(3,:),'r');
            quiver3(Z(1,:),Z(2,:),Z(3,:),F3(1,:),F3(2,:),F3(3,:),'b');
            quiver3(Z(1,:),Z(2,:),Z(3,:),F4(1,:),F4(2,:),F4(3,:),'m');
            hold off;
            axis image;
            legend({'Proximal Frame','Distal Frame','I-aligned Distal Frame',sprintf('I-aligned Rotated by %0.2f^\\circ',theta*180/pi)})
    end
end