function plotOverlayedQuiver(x,v,BirdData,camera_params,colour,theScale)
%Attachs vectors in a local coordinate system to points.    

    p=globalCoordinates([x x+v],BirdData.offset',BirdData.R);%3xm matrix
    VelVect=cameraPosition(p',camera_params);
    quiver(VelVect(1,1),VelVect(1,2),VelVect(2,1)-VelVect(1,1),VelVect(2,2)-VelVect(1,2),theScale,colour)
    
end


