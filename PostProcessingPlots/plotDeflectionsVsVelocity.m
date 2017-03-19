function plotDeflectionsVsVelocity(BirdData,BirdType,numFPA,numV)
%Bird data is a cell of structs.
    
    numBirds=numel(BirdData);
    colour=jet(numBirds);
    markerToUse={'o','x'};
    defDir={'x','y','z'};
    for b1=1:numBirds
        for a1=1:numFPA %This is backwards to how it is typically implemented in BendSweepTwist
            for a2=1:numV
                ind=numV*(a1-1)+a2;
                V(a2)=BirdData{b1}(ind).V;
                Pdef(:,a2)=BirdData{b1}(ind).ProximalDeflection;
                Ddef(:,a2)=BirdData{b1}(ind).DistalDeflection;
            end
            %Proximal deflection
            for a2=1:numel(defDir)
                figure(20000+a2)
                    h(b1,a2)=plot(V,Pdef(a2,:),'--','Color',colour(b1,:),'Marker',markerToUse{a1});
                    hold on
                figure(20000+numel(defDir)+a2)
                    plot(V,Ddef(a2,:),'--','Color',colour(b1,:),'Marker',markerToUse{a1})
                    hold on;
            end
        end
    end
    
    for a1=1:numFPA
        for a2=1:numel(defDir)
            figure(20000+a2)
                hold off;
                xlabel('V [m/s]')
                ylabel(sprintf('\\delta_%s [mm]',defDir{a2}))
                title(sprintf('Proximal %s-deflection (o - \\gamma=0^\\circ, x - \\gamma=13.5^\\circ)',defDir{a2}))
                
            figure(20000+numel(defDir)+a2)
                hold off;
                xlabel('V [m/s]')
                ylabel(sprintf('\\delta_%s [mm]',defDir{a2}))
                title(sprintf('Distal %s-deflection (o - \\gamma=0^\\circ, x - \\gamma=13.5^\\circ)',defDir{a2}))
        end
    end
    figure(20000+2*numel(defDir))
        legend(h(:,a2),BirdType,'Location','NW')
        
end