function plotOverlayedQuiver(x,v,BirdData,camera_params,colour,theScale)
%   plotOverlayedQuiver(x,v,BirdData,camera_params,colour,theScale)
%
%   Attachs a vector v in a local coordinate system (relative to x).
%   
%   TODO: 1) Change colour to be either a string or a row vector.
%
%   Inputs:
%
%       x: Origin of frame
%
%       v: Frame, provided as a 3x3 matrix with columns being the 
%
%       BirdData: A structure with all the information.
% 
%       camera_params: DLT camera parameters
% 
%       colour: A string specifying the color.
%
%       theScale: What multiple to scale the vector by so that it is
%                 visible on the overlay.
%
%   Outputs:
%
%       
%
% Richard B. Choroszucha
% riboch@umich.edu 

    p=globalCoordinates([x x+v],BirdData.offset',BirdData.R);%3xm matrix
    VelVect=cameraPosition(p',camera_params);
    quiver(VelVect(1,1),VelVect(1,2),VelVect(2,1)-VelVect(1,1),VelVect(2,2)-VelVect(1,2),theScale,colour)
    
end


