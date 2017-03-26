function plotOverlayedFrames(x,F,BirdData,camera_params,colour)
%   plotOverlayedFrames(x,F,BirdData,camera_params,colour)
%
%   This function overlays the frames (F) with origin at x onto the raw
%   images.
%
%   Automatically scales the frame 25x to show up in the image.
%
%   TODO: 1) Add scaling to function prototype
%         2) Change colour to be either a string or a row vector.
%
%   Inputs:
%
%       x: Origin of frame
%
%       F: Frame, provided as a 3x3 matrix with columns being the 
%
%       BirdData: A structure with all the information.
% 
%       camera_params: DLT camera parameters
% 
%       colour: A string specifying the color.
%
%
%
%   Outputs:
%
%       
%
% Richard B. Choroszucha
% riboch@umich.edu 


    p=globalCoordinates([x repmat(x,[1 3])+F],BirdData.offset',BirdData.R);
    VelVect=cameraPosition(p',camera_params);
    
    anchor_point=repmat(VelVect(1,:),[3 1]);
    Vect=VelVect(2:end,:)-anchor_point;
    quiver(anchor_point(:,1),anchor_point(:,2),Vect(:,1),Vect(:,2),25,colour)

end

