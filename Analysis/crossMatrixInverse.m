function n=crossMatrixInverse(nx)
%   n=crossMatrixInverse([n])
% 
%   Given the cross product matrix [n], this returns the vector n. 
% 
%
% Richard B. Choroszucha
% riboch@umich.edu

    n=[nx(3,2);nx(1,3);nx(2,1)];
end