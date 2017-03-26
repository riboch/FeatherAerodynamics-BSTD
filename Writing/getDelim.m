function delim=getDelim(type)
%   delim=getDelim(type)
%
%   Returns the delimeter used in the table for latex (&) or excel (\t).
%   
%
%
%   
%   Inputs:
%
%       type: 'latex' or 'excel'
%
%
%   Outputs:
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu
    switch lower(type)
        case 'latex'
            delim=' & ';
        case 'excel'
            delim='\t';
            %Could also use ',' for CSV, but would have to change printTaus
    end

end

