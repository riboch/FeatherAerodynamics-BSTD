function printTaus(type,BirdData)
%   printTaus(type,BirdData)
%
%   This function writes all the different twists contained in the tau
%   field of BirdData to the command line.
%   
%
%
%   
%   Inputs:
%
%       type: 'excel' or 'latex'
%
%       BirdData: A structure containing all the pertinent information.
%
%
%   Outputs:
%
%
%
% Richard B. Choroszucha
% riboch@umich.edu
% 

    for a2=1:numel(BirdData(1).tau)
        %{
        switch lower(type)
            case 'latex'
                %fprintf('$\\tau_{%s},\\ \\hat{n}\\ [\\ ]$',repmat('I',[1 a2]));
                fprintf('$\\tau_{%d},\\ \\hat{n}\\ [\\ ]$',a2);
                for a1=1:numel(BirdData) 
                    fprintf('& $\\begin{bmatrix}');
                    fprintf('%0.3f \\\\',BirdData(a1).tau(a2).nhat);
                    fprintf('\\end{bmatrix}$ ');
                end
                printEnd(type)
            case 'excel'
                %fprintf('tau_%s nhat [ ]\t',repmat('I',[1 a2]));
                fprintf('tau_%d nhat [ ]\t',a2);
                for a1=1:numel(BirdData) 
                    fprintf('%0.3f ',BirdData(a1).tau(a2).nhat);
                    fprintf('\t');
                end
                fprintf('\n');
        end
        %}
        
        switch lower(type)
            case 'latex'
                %fprintf('$\\tau_{%s},\\ \\theta\\ [^\\circ]$',repmat('I',[1 a2]));
                fprintf('$\\theta_{%d}\\ [^\\circ]$',a2);
                for a1=1:numel(BirdData) 
                    fprintf('& %0.1f',BirdData(a1).tau(a2).theta);
                end
                printEnd(type)
            case 'excel'
                %fprintf('tau_%s theta [degree]\t',repmat('I',[1 a2]));
                fprintf('theta_%d [degree]\t',a2);
                for a1=1:numel(BirdData) 
                    fprintf('%0.1f\t',BirdData(a1).tau(a2).theta);
                end
                fprintf('\n');
        end
        
    end
    
end


