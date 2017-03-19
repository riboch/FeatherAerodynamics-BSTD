function writeoutAngles(BirdData,numAoA,numV,birdtype,writeType)
%This function writes the output to the command line in either latex or excel format. 

    switch lower(writeType)
        case 'latex'
            forLatex(BirdData,numAoA,numV,birdtype);
        case 'excel'
            forExcel(BirdData,numAoA,numV,birdtype);
    end
end


