function writeoutAngles(BirdData,numFPA,numV,birdtype,writeType)
%   writeoutAngles(BirdData,numAoA,numV,birdtype,writeType)
%
%   This function writes the output to the command line in either latex or excel format. 
%   
%
%
%   
%   Inputs:
%
%       BirdData: A structure containing all the pertinent information.
% 
%       numFPA: Number of flight path angles tested.
% 
%       numV: Number of velocities tested.
% 
%       birdtype: A string used to identify the data.
% 
%       writeType: Whether to write in 'excel' or 'latex' format.
%
%
%   Outputs:
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu
% 
% Brett Klaassen van Oorschot
% bk115750@umconnect.umt.edu





    switch lower(writeType)
        case 'latex'
            forLatex(BirdData,numFPA,numV,birdtype);
        case 'excel'
            forExcel(BirdData,numFPA,numV,birdtype);
    end
end


