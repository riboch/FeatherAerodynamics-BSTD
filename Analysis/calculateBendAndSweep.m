function BirdData=calculateBendAndSweep(BirdData)
%   BirdData=getAngles(BirdData,numFPA,numV)
%
%   This function calculates the sweep (phi) and bend (psi).  
%
%   
%   Inputs:
%
%       BirdData: A structure returned from RotateData
%
%   Outputs:
%
%       BirdData: A structure of the data and calculated quantities.
%
%
% Richard B. Choroszucha
% riboch@umich.edu

    radtodeg=180/pi;

    I=eye(3,3);
    P=I(:,1:2)*I(:,1:2)';%Projection matrix onto the X-Y plane.

    for a1=1:numel(BirdData)
        %g=BirdData(a1).tip_cg';
        g=BirdData(a1).tip(2,:)';%Picks out point 5.
        h=P*g;%Projects point 5 on X-Y plane for bend calculation
        
        BirdData(a1).sweepDistal=sign(g(2))*acos(I(:,1)'*h/(norm(h,2)))*radtodeg; %Cosine formula
        BirdData(a1).bendDistal=sign(g(3))*acos(g'*h/(norm(g,2)*norm(h,2)))*radtodeg;
        
        
        g=BirdData(a1).base_cg';
        h=P*g;%Projects the base centroid onto the X-Y plane for bend calculation
        
        BirdData(a1).sweepProximal=sign(g(2))*acos(I(:,1)'*h/(norm(h,2)))*radtodeg;
        BirdData(a1).bendProximal=sign(g(3))*acos(g'*h/(norm(g,2)*norm(h,2)))*radtodeg;
        
    end

end