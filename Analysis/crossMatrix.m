function nx=crossMatrix(n)
%   nx=crossMatrix(n)
%
%   Given the cross product nxm , this function constructs the 
%   cross product matrix of n, [n] such that [n]m=nxm.
% 
%
% Richard B. Choroszucha
% riboch@umich.edu

    nx=[0 -n(3) n(2);n(3) 0 -n(1);-n(2) n(1) 0];
end

