function plotDistalAOAAOSVsVelocityBodyFixed(BirdData,numFPA,numV)
%This function plots the distal triangle frames for constant flight path angle (AoA).

    for a1=1:numFPA
        figure(a1+4000)
        for a2=1:numV
            ind=numV*(a1-1)+a2;
            h(a2)=DistalPlotHelperRotated(BirdData(ind),a2);
            legent{a2}=sprintf('v: %d m/s',BirdData(numV*(a1-1)+a2).V);
        end
        axis image
        xlabel('$\hat{x}$','Interpreter','latex')
        ylabel('$\hat{y}$','Interpreter','latex')
        zlabel('$\hat{z}$','Interpreter','latex')
        hold off
        legend(h,legent)
        title(sprintf('Flight Path Angle (\\gamma): %0.1f, Body Fixed',BirdData(numV*(a1-1)+a2).FPA))
    end

end