function overlayDisplacementsOnCamera(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)

    
    v_global=[0;-1;0];
    
    R=rodrigues(pi/12,[0;0;1]);
    t=[0,0,0]';
    RR=[R t;zeros(1,3) 1];
    
    for b1=1:3
        for a1=1:numFPA
            figure(10000+a1+10*(b1-1))
            for a2=1:numV             
                figure(10000+a1+10*(b1-1))
                subplot(2,2,a2);
                    ind=numV*(a1-1)+a2;
                    ind0V=numV*(a1-1)+1;
                    filename=sprintf('%s %dd%dm_C%d.png',birdAcronym,BirdData(ind).FPA*10,BirdData(ind).V,b1);
                    A=imread([picfolder filename]);
                    imagesc(flipud(A))
                    h_plot(a2,a1)=gca;
                    axis image;
                    colormap gray
                    title(sprintf('\\gamma: %0.1f, v: %0.1f',BirdData(ind).FPA,BirdData(ind).V))
                    hold on;
                                            
                    %Overlay Triangles
                        plotOverlayedTriangles(BirdData(ind).base_raw',BirdData(ind),camera_params(:,b1),'y');%Proximal triangle plot
                        plotOverlayedTriangles(BirdData(ind).base',BirdData(ind),camera_params(:,b1),'g');%Proximal triangle plot
                        %BirdData(ind).base does not work because we projected point 1.
                        plotOverlayedTriangles(BirdData(ind).tip',BirdData(ind),camera_params(:,b1),'g');%Distal triangle plot 
                    %Overlay Velocity Vectors
                        plotOverlayedQuiver_global(BirdData(ind).base_cg',v_global,BirdData(ind),camera_params(:,b1),'r',50);%Wind vector at proximal triangle
                        plotOverlayedQuiver_global(BirdData(ind).tip_cg',v_global,BirdData(ind),camera_params(:,b1),'r',50);% Wind Vector at distal triangle

                    %Overlay rotated distal triangle
                        plotOverlayedTriangles(BirdData(ind).baseframe*BirdData(ind0V).tip',BirdData(ind),camera_params(:,b1),'y');%Distal triangle corrected
                        plotOverlayedTriangles(BirdData(ind0V).tip',BirdData(ind0V),camera_params(:,b1),'c');%Distal triangle uncorrected 
                        plotOverlayedQuiver(BirdData(ind).baseframe*BirdData(ind0V).tip_cg',BirdData(ind).baseframe*BirdData(ind).DistalDeflection,BirdData(ind),camera_params(:,b1),'y',1)
%                         plotOverlayedQuiver([0;0;0],BirdData(ind).tip_cg',BirdData(ind),camera_params(:,b1),'y',1)
                    hold off;
            end
            
            
            
            %print(gcf,sprintf('%s%dd%dmC%d-Overlaid.png',birdAcronym,BirdData(ind).FPA*10,BirdData(ind).V,b1),'-dpng')
        end
        linkaxes(h_plot,'xy')
        %hprop(b1)=linkprop(h_plot,{'CameraPosition','CameraUpVector','XLim','YLim'});        
    end
    
end



