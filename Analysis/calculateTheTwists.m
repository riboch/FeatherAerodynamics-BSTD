function BirdData=calculateTheTwists(BirdData,numFPA,numV)
%   BirdData=calculateTheTwists(BirdData,numFPA,numV)
%
%   This function calculates the various twists.  
%
%   Twist of interest: tau().theta ().
%
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
    
    radtodeg=180/pi;
    
    I=eye(3,3);
    P=I(:,1:2)*I(:,1:2)';%Projection matrix onto the X-Y plane.

    for a1=1:numFPA
        for a2=1:numV
        %Minus signs are to put the twist vector close to the first octant
        ind=numV*(a1-1)+a2;%At speed 
        ind0V=numV*(a1-1)+1;
        
            %Proximodistal twist: twist between proximal and distal
            %                     triangles frames at speed.
                F1=BirdData(ind).baseframe;
                F2=BirdData(ind).tipframe;
                BirdData(ind).tau(1).theta=calculateTwist(F1,F2,false)*radtodeg;
            
            
            %Distodistal Twist: twist between rest distal frame and at
            %                   speed distal frame
                F1=BirdData(ind0V).tipframe;
                F2=BirdData(ind).tipframe;
                BirdData(ind).tau(2).theta=calculateTwist(F1,F2,false)*radtodeg;
            
            
            %Global Twist:  distal twist relative to inertial frame
                F1=eye(3,3);
                F2=BirdData(ind).tipframe;
                BirdData(ind).tau(3).theta=calculateTwist(F1,F2,false)*radtodeg;

            
            %Corrected Global Twist: Removes the bend and sweep before calculating distal twist.
                R1=rodrigues(-BirdData(ind).bendDistal/radtodeg,[0;1;0]);%Rotate about y
                R2=rodrigues(-BirdData(ind).sweepDistal/radtodeg,[0;0;1]);%Rotate about z
                F2prime=R1'*R2*F2;
                %plotCorrected(BirdData(a1).tip(2,:)',R1,R2,F1,F2)
                BirdData(ind).tau(4).theta=calculateTwist(F1,F2prime,false)*radtodeg;
            
            %Corrected proximodistal twist: Removes the bend and sweep
            %between proximal and distal frame before calculating distal twist.
                F1=BirdData(ind).baseframe;
                F2=BirdData(ind).tipframe;%Rotate proximal frame to be in the global frame.
                g=F1'*BirdData(ind).tip(2,:)';%Picks out point 5, the tip.
                h=P*g;%Projects onto I-J plane

                sweepDistal=sign(g(2))*acos(I(:,1)'*h/(norm(h,2)));%Determines sweep relative to proximal frame.
                bendDistal=sign(g(3))*acos(g'*h/(norm(g,2)*norm(h,2)));%Determines bend relative to the proximal frame


                %R1=rodrigues(bendDistal,cross(h,g)/norm(cross(h,g),2));%Rotate about y
                R1=rodrigues(-bendDistal,[0;1;0]);%Rotate about y
                R2=rodrigues(-sweepDistal,[0;0;1]);%Rotate about z
                F2prime=R1'*R2*F1'*F2;
                %plotCorrected(g,R1,R2,F1,F1'*F2)
                BirdData(ind).tau(5).theta=calculateTwist(I,F2prime,false)*radtodeg;
            
            
            %Proximoproximal Twist
                F1=BirdData(ind0V).baseframe;
                F2=BirdData(ind).baseframe;
                BirdData(ind).tau(6).theta=calculateTwist(F1,F2,false)*radtodeg;
                
                
        %Slipped angle of attack, 2017-02-03
            
        end
    end


end