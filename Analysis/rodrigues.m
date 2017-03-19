function R=rodrigues(phi,v)
%   R=rodrigues(phi,v)
%
%   This constructs the rotation matrix R from the angle, phi (in radians), 
%   and the normal to rotate about v.
% 
%
% Richard B. Choroszucha
% riboch@umich.edu

    R=cos(phi)*eye(3,3)+(1-cos(phi))*v*v'+sin(phi)*crossMatrix(v);

end


