function plotDistalAOAAOSVsAnglesBodyFixed(BirdData,numFPA,numV)
%This function plots the distal triangle frames for constant velocity.

    for a2=1:numV
        figure(a2+5000)
        for a1=1:numFPA
            ind=numV*(a1-1)+a2;
            h(a1)=DistalPlotHelperRotated(BirdData(ind),a1);
            legent{a1}=sprintf('\\gamma: %0.1f',BirdData(numV*(a1-1)+a2).FPA);
        end
        axis image
        xlabel('$\hat{x}$','Interpreter','latex')
        ylabel('$\hat{y}$','Interpreter','latex')
        zlabel('$\hat{z}$','Interpreter','latex')
        hold off
        legend(h,legent)
        title(sprintf('Wind Speed (v): %d m/s, Body Fixed',BirdData(numV*(a1-1)+a2).V))
    end

end