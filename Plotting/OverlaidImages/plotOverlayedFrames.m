function plotOverlayedFrames(x,F,BirdData,camera_params,colour)

    p=globalCoordinates([x repmat(x,[1 3])+F],BirdData.offset',BirdData.R);
    VelVect=cameraPosition(p',camera_params);
    
    anchor_point=repmat(VelVect(1,:),[3 1]);
    Vect=VelVect(2:end,:)-anchor_point;
    quiver(anchor_point(:,1),anchor_point(:,2),Vect(:,1),Vect(:,2),25,colour)

end

