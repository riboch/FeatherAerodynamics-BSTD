function BirdData=getAngles(BirdData,numFPA,numV)
%   BirdData=getAngles(BirdData,numFPA,numV)
%
%   This function calculates the sweep, bend, various twists, local
%   angle of attack, and local angle of slip.
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

    %Get the bend and sweep.
        BirdData=calculateBendAndSweep(BirdData);
    
    %Get the various twists
        BirdData=calculateTheTwists(BirdData,numFPA,numV);
    
    %Gets the Angle of Attack and Angle of Slip.
        BirdData=calculateAoAandAoS(BirdData,numFPA,numV);
end