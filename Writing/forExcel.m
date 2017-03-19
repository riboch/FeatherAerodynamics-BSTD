function forExcel(BirdData,numAoA,numV,birdtype)

    for a1=1:numAoA
        fprintf('%s: %0.1f Angle of Attack\n',birdtype,BirdData(numV*(a1-1)+1).FPA)
        printTop('excel',BirdData(numV*(a1-1)+(1:numV)));
        printData('excel','Proximal Sweep [degrees]',BirdData(numV*(a1-1)+(1:numV)),'sweepProximal');
        printData('excel','Distal Sweep [degrees]',BirdData(numV*(a1-1)+(1:numV)),'sweepDistal');
        printData('excel','Proximal Bend [degrees]',BirdData(numV*(a1-1)+(1:numV)),'bendProximal');
        printData('excel','Distal Bend [degrees]',BirdData(numV*(a1-1)+(1:numV)),'bendDistal');
        printTaus('excel',BirdData(numV*(a1-1)+(1:numV)));
        printData('excel','Distal alpha [degrees]',BirdData(numV*(a1-1)+(1:numV)),'alpha_tip');
        printData('excel','Distal beta [degrees]',BirdData(numV*(a1-1)+(1:numV)),'beta_tip');
        fprintf('\n\n\n')
    end
    
end


