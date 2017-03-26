function printTop(type,BirdData)
%   printTop(type,BirdData)
%
%   This function prints the top of the results tables (the velocities
%   tested) to the command line.
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

    delim=getDelim(type);
    
    for a1=1:numel(BirdData)
        fprintf([delim '%0.1f m/s'],BirdData(a1).V);
    end
    printEnd(type);
end