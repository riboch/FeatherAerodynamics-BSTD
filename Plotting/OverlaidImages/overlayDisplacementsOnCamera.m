function overlayDisplacementsOnCamera(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
%   overlayDisplacementsOnCamera(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
%
%   This function overlays where the distal triangle is expected to be from
%   the proximal displacement (yellow triangle), where it actually is
%   (cyan triangle), and then the displacement (yellow vector).
%
%
%   Inputs:
%
%       BirdData: A structure with all the information.
%
%       numFPA: Number of flight path angles tested.
%
%       numV:   Number of velocity points tested.
% 
%       camera_params: DLT camera parameters
% 
%       picfolder: String of the path containing the raw image files.
%
%       birdAcronym: String of the bird name, required to match up with the
%                    file 
%
%
%   Outputs:
%
%       
%
% Richard B. Choroszucha
% riboch@umich.edu  
   
    for b1=1:3
        for a1=1:numFPA
            figure(10000+a1+10*(b1-1))
            for a2=1:numV             
                figure(10000+a1+10*(b1-1))
                subplot(2,2,a2);
                    ind=numV*(a1-1)+a2;
                    ind0V=numV*(a1-1)+1;
                    hold on;

                    %Overlay rotated distal triangle
                        plotOverlayedTriangles(BirdData(ind).baseframe*BirdData(ind0V).tip',BirdData(ind),camera_params(:,b1),'y');%Distal triangle corrected
                        plotOverlayedTriangles(BirdData(ind0V).tip',BirdData(ind0V),camera_params(:,b1),'c');%Distal triangle uncorrected 
                        plotOverlayedQuiver(BirdData(ind).baseframe*BirdData(ind0V).tip_cg',BirdData(ind).baseframe*BirdData(ind).DistalDeflection,BirdData(ind),camera_params(:,b1),'y',1)
%                         plotOverlayedQuiver([0;0;0],BirdData(ind).tip_cg',BirdData(ind),camera_params(:,b1),'y',1)
                    hold off;
            end   
            %print(gcf,sprintf('%s%dd%dmC%d-Overlaid.png',birdAcronym,BirdData(ind).FPA*10,BirdData(ind).V,b1),'-dpng')
        end
        %linkaxes(h_plot,'xy')
        %hprop(b1)=linkprop(h_plot,{'CameraPosition','CameraUpVector','XLim','YLim'});        
    end
    
end



