function plotOverlayedTriangles(x,BirdData,camera_params,colour)
%   plotOverlayedTriangles(x,BirdData,camera_params,colour)
%
%   Calculates the triangle positions on the overlaid frame and plots them.
%   
%   
%   TODO: 1) Change colour to be either a string or a row vector.
%         2) Add LineWidth
%
%   Inputs:
%
%       x: Origin of frame
%
%
%       BirdData: A structure with all the information.
% 
%       camera_params: DLT camera parameters
% 
%       colour: A string specifying the color.
%
%
%   Outputs:
%
%       
%
% Richard B. Choroszucha
% riboch@umich.edu 

        x=[x x(:,1)];
        tri=globalCoordinates(x,BirdData.offset',BirdData.R);%3xm matrix
        tri_cam=cameraPosition(tri',camera_params);
        plot(tri_cam(:,1),tri_cam(:,2),colour,'LineWidth',2)
end


