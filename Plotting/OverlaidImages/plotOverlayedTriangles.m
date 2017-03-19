function plotOverlayedTriangles(x,BirdData,camera_params,colour)

        x=[x x(:,1)];
        tri=globalCoordinates(x,BirdData.offset',BirdData.R);%3xm matrix
        tri_cam=cameraPosition(tri',camera_params);
        plot(tri_cam(:,1),tri_cam(:,2),colour,'LineWidth',2)
end


