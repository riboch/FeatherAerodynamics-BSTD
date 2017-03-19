function BirdData=RotateData(BirdData,numFPA,numV)
%   BirdData=RotateData(BirdData,numV,numFPA)
%
%   This function rotates all the data into the v=0 m/s frame for each
%   flight path angle.  This makes subsequent data analysis easier.
%
%   
%   Inputs:
%
%       BirdData: A structure returned from CorrectDataAndFrames
%
%       numFPA: Number of flight path angles tested.
%
%       numV:   Number of velocity points tested.
%
%   Outputs:
%
%       BirdData:   A structure of the data and calculated quantities.
%
%
% Richard B. Choroszucha
% riboch@umich.edu

    m=numel(BirdData);
    
    for a1=1:numFPA
        O=BirdData(numV*(a1-1)+1).baseframe;
        theta=acos(1/2*(trace(O)-1));
        nhat=crossMatrixInverse(1/(2*sin(theta))*(O-O'));
        R=rodrigues(theta,nhat)';
        %Could just use O', but if we wanted the original vector that we
        %rotate about and accompanying angle, we do it this way.
        
        %visualizeTransformation(theta,nhat,BirdData(numV*(a1-1)+(1:numV)))
        
        for a2=1:numV
            ind=numV*(a1-1)+a2;
            BirdData(ind).R=R;
            BirdData(ind).base=(R*BirdData(numV*(a1-1)+a2).base')';%Rotates the base triangle
            BirdData(ind).base_raw=(R*BirdData(numV*(a1-1)+a2).base_raw')';%Rotates the raw base triangle data.
            BirdData(ind).base_cg=(R*BirdData(numV*(a1-1)+a2).base_cg')';%Rotates the "centroid" between points 2 and 3
            BirdData(ind).baseframe=R*BirdData(numV*(a1-1)+a2).baseframe;%Rotates the base frame
            
            BirdData(ind).tip=(R*BirdData(numV*(a1-1)+a2).tip')';%Rotates the distal triangle
            BirdData(ind).tip_cg=(R*BirdData(numV*(a1-1)+a2).tip_cg')';%Rotates the tip centroid between points 4 and 5
            BirdData(ind).tipframe=R*BirdData(numV*(a1-1)+a2).tipframe;%Rotates the tip frame
        end
    end

end