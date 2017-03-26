function forExcel(BirdData,numAoA,numV,birdtype)
%   forExcel(BirdData,numFPA,numV,birdtype)
%
%   This function writes the results table in the excel format to the
%   command line.
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

    for a1=1:numAoA
        fprintf('%s: %0.1f Angle of Attack\n',birdtype,BirdData(numV*(a1-1)+1).FPA)
        printTop('excel',BirdData(numV*(a1-1)+(1:numV)));
        printData('excel','Proximal Sweep [degrees]',BirdData(numV*(a1-1)+(1:numV)),'sweepProximal');
        printData('excel','Distal Sweep [degrees]',BirdData(numV*(a1-1)+(1:numV)),'sweepDistal');
        printData('excel','Proximal Bend [degrees]',BirdData(numV*(a1-1)+(1:numV)),'bendProximal');
        printData('excel','Distal Bend [degrees]',BirdData(numV*(a1-1)+(1:numV)),'bendDistal');
        printTaus('excel',BirdData(numV*(a1-1)+(1:numV)));
        printData('excel','Distal alpha [degrees]',BirdData(numV*(a1-1)+(1:numV)),'alpha_tip');
        printData('excel','Distal beta [degrees]',BirdData(numV*(a1-1)+(1:numV)),'beta_tip');
        fprintf('\n\n\n')
    end
    
end


