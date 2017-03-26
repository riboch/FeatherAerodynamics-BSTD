function plotData(BirdData,numFPA,numV)
%   plotData(BirdData,numFPA,numV)
%
%   This function contains the call to several triangle/frame plotting
%   routines (it does not, and should not, plot overlaid images.
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
%   Outputs:
%
%       
%
% Richard B. Choroszucha
% riboch@umich.edu    



%Keeps in CCF, does not plot with correct flight path angle.
%    plotBothTrianglesVsAngle(BirdData,numFPA,numV);
%    plotBothTrianglesVsVelocity(BirdData,numFPA,numV);
 
%Plots with the correct flight path angle.
    %plotBothTrianglesVsAngleFlightPath(BirdData,numFPA,numV)
    plotBothTrianglesVsVelocityFlightPath(BirdData,numFPA,numV)
    
    
%     plotDistalAOAAOSVsVelocity(BirdData,numFPA,numV);
%     plotDistalAOAAOSVsAngles(BirdData,numFPA,numV);
     
%     plotDistalAOAAOSVsVelocityBodyFixed(BirdData,numFPA,numV);
%     plotDistalAOAAOSVsAnglesBodyFixed(BirdData,numFPA,numV);
    
end