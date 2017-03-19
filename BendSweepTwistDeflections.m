function BirdData=BendSweepTwistDeflections(birdtype)
%   BirdData=BendSweepTwist(birdtype)
%
%   This function calculates and plots anything that we found interesting,
%   such as bend, sweep, twist, deflections, etc.
%
%   You will have to adjust the data path (this function) and "picfolder"
%   in dataSelector.
%   
%
%
%   
%   Inputs:
%
%       birdtype: A string used for data set selection
%
%
%   Outputs:
%
%       BirdData:   A structure of the data and calculated quantities.
%                   The data is assumed to have a certain structure.
%
%
% Richard B. Choroszucha
% riboch@umich.edu
% 
% Brett Klaassen van Oorschot
% bk115750@umconnect.umt.edu



%Remark 1: AoA should be defined as flight path angle.

    if (nargin==0)
        %birdtype='american kestrel 20141212';
        %birdtype='red-tailed hawk 20141213';
        %birdtype='Cooper''s Hawk 20141213';
        %birdtype='red-tailed hawk 20141225';
        %birdtype='peregrine falcon 20141225';
        birdtype='american kestrel 20141225';
    end


    %What format for the written data you would like (excel or latex).
    writeType='Excel';  %write 'latex' for latex output

    
    % Adds the data path
        addpath('../Data/20141225/');
    
    % Adds the analysis, plotting, and writing functions to the path
        addpath('Analysis/');
        plottingpaths=genpath('Plotting/');
        addpath(plottingpaths);
        addpath('Writing/');
                
    %Read In Data
        [BirdData,numFPA,numV,picfolder,birdAcronym]=dataSelector(birdtype);
    
    %Analysis portions
        BirdData=CorrectDataAndFrames(BirdData);    
        BirdData=RotateData(BirdData,numFPA,numV);
        BirdData=getAngles(BirdData,numFPA,numV);
        BirdData=getDeflections(BirdData,numFPA,numV);
    
    %Write things to the command line.
        writeoutAngles(BirdData,numFPA,numV,birdtype,writeType)
    
    %Plotting
        %Triangles and frames
        plotData(BirdData,numFPA,numV)
    
        %Overlaid images
        %Obtains the camera parameters for overlaying triangles, frames, and vectors onto the raw images.
            camera_params=DLTCameraParameters();
            %overlayOnCamera(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
            overlayDisplacementsOnCamera(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
    
    
end
