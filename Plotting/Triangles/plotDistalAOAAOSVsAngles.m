function plotDistalAOAAOSVsAngles(BirdData,numFPA,numV)
%This function plots the distal triangle frames for constant velocity.

    for a2=1:numV
        figure(a2+3000)
        for a1=1:numFPA
            ind=numV*(a1-1)+a2;
            h(a1)=DistalPlotHelper(BirdData(ind),a1);
            legent{a1}=sprintf('\\gamma: %0.1f',BirdData(ind).FPA);
        end
        axis image
        xlabel('$\hat{X}$','Interpreter','latex')
        ylabel('$\hat{Y}$','Interpreter','latex')
        zlabel('$\hat{Z}$','Interpreter','latex')
        hold off
        legend(h,legent)
        title(sprintf('Wind Speed (v): %d m/s, CCF',BirdData(ind).V))
    end

end









