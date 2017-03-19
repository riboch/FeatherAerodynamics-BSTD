function printEnd(type)

    switch lower(type)
        case 'latex'
            fprintf('\\\\\n\\hline\n');
        case 'excel'
            fprintf('\n')
    end

end


