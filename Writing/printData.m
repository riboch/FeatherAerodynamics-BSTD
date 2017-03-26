function printData(type,name,BirdData,field)
%   printData(type,name,BirdData,field)
%
%   Prints the data to the command line.
%   
%
%
%   
%   Inputs:
%
%       type: 'latex' or 'excel'.
% 
%       name: string of the variable name.
% 
%       BirdData: A structure containing all the pertinent information.
% 
%       field: structure field name of BirdData
%
%
%   Outputs:
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu
% 
    delim=getDelim(type);
    
    fprintf('%s',name);
    for a1=1:numel(BirdData)
        fprintf([delim '%0.1f'],BirdData(a1).(field));
    end
    printEnd(type);
end


