function forLatex(BirdData,numAoA,numV,birdtype)


    for a1=1:numAoA
        fprintf('\\begin{table}[H]\n\\centering\n')
        fprintf('\\caption{%s: $%0.1f^\\circ$ Flight Path Angle}',birdtype,BirdData(numV*(a1-1)+1).FPA)
        fprintf('\\label{%s:table:%0.1f}\n',datestr(now,'yyyymmdd'),BirdData(numV*(a1-1)+1).FPA)
        fprintf('\\begin{tabular}{l%s}\n\\hline\\hline\n',repmat('|c',[ 1 numV]));
        printTop('latex',BirdData(numV*(a1-1)+(1:numV)));
        printData('latex','Proximal, $\phi\ [^\circ]$',BirdData(numV*(a1-1)+(1:numV)),'sweepProximal');
        printData('latex','Distal, $\phi\ [^\circ]$',BirdData(numV*(a1-1)+(1:numV)),'sweepDistal');
        printData('latex','Proximal, $\psi\ [^\circ]$',BirdData(numV*(a1-1)+(1:numV)),'bendProximal');
        printData('latex','Distal, $\psi\ [^\circ]$',BirdData(numV*(a1-1)+(1:numV)),'bendDistal');
        printData('latex','Proximal, $\alpha\ [^\circ]$',BirdData(numV*(a1-1)+(1:numV)),'alpha_base');
        printData('latex','Proximal, $\beta\ [^\circ]$',BirdData(numV*(a1-1)+(1:numV)),'beta_base');
        printData('latex','Distal, $\alpha\ [^\circ]$',BirdData(numV*(a1-1)+(1:numV)),'alpha_tip');
        printData('latex','Distal, $\beta\ [^\circ]$',BirdData(numV*(a1-1)+(1:numV)),'beta_tip');
        printTaus('latex',BirdData(numV*(a1-1)+(1:numV)));
        fprintf('\\hline\n\\end{tabular}\n');
        fprintf('\\end{table}\n\n')
    end
end


