function overlayFramesOnCamera(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
%   overlayFramesOnCamera(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
%
%   This function overlays the proximal and distal frames onto the raw
%   image.
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
                    hold on;
                    %Overlay frames
                        plotOverlayedFrames(BirdData(ind).base_cg',BirdData(ind).baseframe,BirdData(ind),camera_params(:,b1),'b')
                        plotOverlayedFrames(BirdData(ind).tip_cg',BirdData(ind).tipframe,BirdData(ind),camera_params(:,b1),'b')
                    %Overlay velocity vector projections
                        plotOverlayedQuiver(BirdData(ind).base_cg',BirdData(ind).v_yz_base,BirdData(ind),camera_params(:,b1),'m',50)
                        plotOverlayedQuiver(BirdData(ind).tip_cg',BirdData(ind).v_yz_tip,BirdData(ind),camera_params(:,b1),'m',50)

                    hold off;
            end
            %print(gcf,sprintf('%s%dd%dmC%d-Overlaid.png',birdAcronym,BirdData(ind).FPA*10,BirdData(ind).V,b1),'-dpng')
        end
        %linkaxes(h_plot,'xy')
        %hprop(b1)=linkprop(h_plot,{'CameraPosition','CameraUpVector','XLim','YLim'});
    end
    
end

