function overlayTrianglesImage(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
% overlayTrianglesImage(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
%
%   This function overlays the proximal and distal triangles onto the raw
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
    
    v_global=[0;-1;0];

    for b1=1:3
        for a1=1:numFPA
            figure(10000+a1+10*(b1-1))
            for a2=1:numV             
                figure(10000+a1+10*(b1-1))
                subplot(2,2,a2);
                    ind=numV*(a1-1)+a2;
                   hold on;              
                    %Overlay Triangles
                        plotOverlayedTriangles(BirdData(ind).base_raw',BirdData(ind),camera_params(:,b1),'y');%Proximal triangle plot
                        plotOverlayedTriangles(BirdData(ind).base',BirdData(ind),camera_params(:,b1),'g');%Proximal triangle plot
                        %BirdData(ind).base does not work because we projected point 1.
                        plotOverlayedTriangles(BirdData(ind).tip',BirdData(ind),camera_params(:,b1),'g');%Distal triangle plot 
                    %Overlay Velocity Vectors
                        plotOverlayedQuiver_global(BirdData(ind).base_cg',v_global,BirdData(ind),camera_params(:,b1),'r',50);%Wind vector at proximal triangle
                        plotOverlayedQuiver_global(BirdData(ind).tip_cg',v_global,BirdData(ind),camera_params(:,b1),'r',50);% Wind Vector at distal triangle
                    hold off;
            end
            %print(gcf,sprintf('%s%dd%dmC%d-Overlaid.png',birdAcronym,BirdData(ind).FPA*10,BirdData(ind).V,b1),'-dpng')
        end
        %linkaxes(h_plot,'xy')
        %hprop(b1)=linkprop(h_plot,{'CameraPosition','CameraUpVector','XLim','YLim'});
    end
    
end




