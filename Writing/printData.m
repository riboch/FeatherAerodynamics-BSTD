function printData(type,name,BirdData,field)

    delim=getDelim(type);
    
    fprintf('%s',name);
    for a1=1:numel(BirdData)
        fprintf([delim '%0.1f'],BirdData(a1).(field));
    end
    printEnd(type);
end


