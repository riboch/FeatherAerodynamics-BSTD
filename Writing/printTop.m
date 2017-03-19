function printTop(type,BirdData)

    delim=getDelim(type);
    
    for a1=1:numel(BirdData)
        fprintf([delim '%0.1f m/s'],BirdData(a1).V);
    end
    printEnd(type);
end