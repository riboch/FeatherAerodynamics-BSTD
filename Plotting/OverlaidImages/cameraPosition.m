function uv=cameraPosition(xyz,c)
%   uv=cameraPosition(xyz,c)
%
%   This function calculates the position of a 3D object onto a 2D camera.
%
%   
%   Inputs:
%
%       xyz: vector of the object in 3D coordinates.
%
%       c: direct linear transformation (DLT) camera parameters
%
%   Outputs:
%
%       uv: position of xyz on the camera.
%       
%
% Richard B. Choroszucha
% riboch@umich.edu    

    uv(:,1)=(xyz(:,1).*c(1)+xyz(:,2).*c(2)+xyz(:,3).*c(3)+c(4))./(xyz(:,1).*c(9)+xyz(:,2).*c(10)+xyz(:,3).*c(11)+1);
    uv(:,2)=(xyz(:,1).*c(5)+xyz(:,2).*c(6)+xyz(:,3).*c(7)+c(8))./(xyz(:,1).*c(9)+xyz(:,2).*c(10)+xyz(:,3).*c(11)+1);
end