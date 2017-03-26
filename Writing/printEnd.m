function printEnd(type)
%   printEnd(type)
%
%   Prints the last row(s) of the results table.
%   
%   Inputs:
%
%       type
%
%
%   Outputs:
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu
% 

    switch lower(type)
        case 'latex'
            fprintf('\\\\\n\\hline\n');
        case 'excel'
            fprintf('\n')
    end

end


