function plotDistalAOAAOSVsVelocity(BirdData,numFPA,numV)
%This function plots the distal triangle frames for constant flight path angle (AoA).

    for a1=1:numFPA
        figure(a1+2000)
        for a2=1:numV
            ind=numV*(a1-1)+a2;
            h(a2)=DistalPlotHelper(BirdData(ind),a2);
            legent{a2}=sprintf('v: %d m/s',BirdData(numV*(a1-1)+a2).V);
        end
        axis image
        xlabel('$\hat{X}$','Interpreter','latex')
        ylabel('$\hat{Y}$','Interpreter','latex')
        zlabel('$\hat{Z}$','Interpreter','latex')
        hold off
        legend(h,legent)
        title(sprintf('Flight Path Angle (\\gamma): %0.1f, CCF',BirdData(numV*(a1-1)+a2).FPA))
    end

end