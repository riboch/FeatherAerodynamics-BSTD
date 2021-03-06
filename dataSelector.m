function [BirdData,numFPA,numV,picfolder,birdAcronym]=dataSelector(birdtype)
%[BirdData,numFPA,numV,picfolder,birdAcronym]=dataSelector(birdtype)
%
%
%This function gets the data and other parameters.
%
%   Inputs:
%
%       birdtype: A string used to specify which data set to use.
%
%   Outputs:
%       
%       BirdData: A structure containing the triangle positions
%       
%       numFPA: Number of flight path angles tested
%
%       numV:   Number of velocity points tests
%
%       picfolder:  Folder containing the raw images
%
%       birdAcronym: A unique acronym for the bird (used in saving images)
%
%
%
%   Richard B. Choroszucha
%   riboch@umich.edu

    picfolder='Pictures/';%Folder containing all the pictures
                          %Edited 3/19/2017 to reflect small change in folder structure - BKVO  

    numFPA=2;
    numV=4;
                
    switch lower(birdtype)
            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %20141225
        case 'american kestrel 20141225'
            BirdData=BirdDataAMKE20141225_12ms();        
            birdAcronym='AMKE';
            numV=4;
        case 'cooper''s hawk 20141225'
            BirdData=BirdDataCOHA20141225_12ms();
            birdAcronym='COHA';
            numV=4;
        case 'great horned owl 20141225'
            BirdData=BirdDataGHOW20141225_12ms();
            birdAcronym='GHOW';
            numV=4;
        case 'red-tailed hawk 20141225'
            BirdData=BirdDataRTHA20141225_12ms();
            birdAcronym='RTHA';
            numV=4;
        case 'osprey 20141225'
            BirdData=BirdDataOSPR20141225_12ms();
            birdAcronym='OSPR';
            numV=4;
        case 'merlin 20141225'
            BirdData=BirdDataMERL20141225_12ms();
            birdAcronym='MERL';
            numV=4;
        case 'peregrine falcon 20141225'
            birdAcronym='PEFA';
            BirdData=BirdDataPEFA20141225_12ms();
            numV=4;
            
            
            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %20141212-13
        case 'american kestrel 20141212'
            BirdData=BirdDataAMKE20141225_12ms();        
            numV=4;
        case 'cooper''s hawk 20141213'
            BirdData=BirdDataCOHA20141213();
            numV=3;
        case 'great horned owl 20141213'
            BirdData=BirdDataGHOW20141213();
            numV=3;
        case 'red-tailed hawk 20141213'
            BirdData=BirdDataRTHA20141213();
            numV=3;
        case 'osprey 20141213'
            BirdData=BirdDataOSPR20141213();
            numV=3;
        case 'merlin 20141213'
            BirdData=BirdDataMERL20141213();
            numV=3;
        case 'peregrine falcon 20141213'
            BirdData=BirdDataPEFA20141213();
            numV=3;
    end

    %Rename Angle of Attack to Flight Path Angle.
    for a1=1:numel(BirdData);
        BirdData(a1).FPA=BirdData(a1).AoA;
    end
    BirdData=rmfield(BirdData,'AoA');
    
    if (numel(BirdData)~=numFPA*numV)
        error(sprintf('Beware: %s does not have the correct number of either angles or velocities.\n',birdtype))
    end
    
end