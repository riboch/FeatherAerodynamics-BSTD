function x_global=globalCoordinates(x,offset,R)
%   x_global=globalCoordinates(x,offset,R
%
%   This function calculates the position of a 3D object in the "global frame"
%   used for DLT.
%
%   
%   Inputs:
%
%       x: vector of the object in 3D coordinates of a useful frame.
%
%       offset: affine term
%
%       R:  Rotation matrix
%
%   Outputs:
%
%       x_global: position of xyz on the camera.
%       
%
% Richard B. Choroszucha
% riboch@umich.edu  

    x_global=R'*x+repmat(offset,[1,size(x,2)]);
end


