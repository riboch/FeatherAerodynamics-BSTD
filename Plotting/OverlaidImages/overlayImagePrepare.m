function overlayImagePrepare(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
%   overlayImagePrepare(BirdData,numFPA,numV,camera_params,picfolder,birdAcronym)
%
%   This function displays the raw images and preps the subplots for
%   overlaying.
%
%   TODO: Implement better plotting options:
%           1) Do not rely on a formatted string for the picture filename
%              (this will require adding the filename to BirdData and
%              adjusting the other overlay* functions).
%           2) Options to plot the feather and overlays at a single
%              speed/flight path angle.  Again, require modifying overlay*
%              functions.
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
                    filename=sprintf('%s %dd%dm_C%d.png',birdAcronym,BirdData(ind).FPA*10,BirdData(ind).V,b1);
                    A=imread([picfolder filename]);
                    imagesc(flipud(A))%I used flipud here to avoid having to pass image properties. 
                    h_plot(a2,a1)=gca;
                    axis image;
                    colormap gray
                    title(sprintf('\\gamma: %0.1f, v: %0.1f',BirdData(ind).FPA,BirdData(ind).V))
                    %view(-180,90); %Rotates the plot, does not work with
                                    %linkaxes, and I am currently having a problem with
                                    %linkprop.
                    
%Preparing for image rotation.
%                     sA=size(A);
%                     figure(20000+a1+10*(b1-1))
%                         plot3(BirdData(ind).x([1:3 1]),BirdData(ind).y([1:3 1]),BirdData(ind).z([1:3 1]),'k')
%                         hold on;
%                         plot3(BirdData(ind).x([4:6 4]),BirdData(ind).y([4:6 4]),BirdData(ind).z([4:6 4]),'k')
%                         hold off;
%                     
%                         x_vect=mean(BirdData(ind).base,1);
%                         [X,Y]=meshgrid((1:sA(1))-BirdData(ind).offset(1),(1:sA(2))-BirdData(ind).offset(2));
%                         camMoved=[camera_params(1:4,b1)';camera_params(5:8,b1)';camera_params(9:11,b1)' 1]*RR;
%                         camMoved=camMoved/camMoved(3,4);
%                         %uvCen=cameraPosition(x_vect,camMoved)
%                         xyz=[X(:) Y(:) zeros(prod(sA),1)]';%+repmat(x_vect,[prod(sA) 1]);
%                         xyz=globalCoordinates(xyz,BirdData(ind).offset',BirdData(ind).R);
%                         uv=cameraPosition(xyz',camMoved);
%                         X=reshape(uv(:,1),sA);
%                         Y=reshape(uv(:,2),sA);
%                         surf(X,Y,zeros(size(A)),A,'LineStyle','none');
%                         colormap('gray')
            end
            
            
            
            %print(gcf,sprintf('%s%dd%dmC%d-Overlaid.png',birdAcronym,BirdData(ind).FPA*10,BirdData(ind).V,b1),'-dpng')
        end
        linkaxes(h_plot,'xy')
        %hprop(b1)=linkprop(h_plot,{'CameraPosition','CameraUpVector','XLim','YLim'});        
    end

end



% Special euclidean group (SE(3)) transformation
%     R=rodrigues(pi/12,[0;0;1]);
%     t=[0,0,0]';
%     RR=[R t;zeros(1,3) 1];