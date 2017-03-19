function plotData(BirdData,numFPA,numV)
    
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