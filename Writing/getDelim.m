function delim=getDelim(type)

    switch lower(type)
        case 'latex'
            delim=' & ';
        case 'excel'
            delim='\t';
            %Could also use ',' for CSV, but would have to change printTaus
    end

end

