function plotBothTrianglesVsVelocity(BirdData,numFPA,numV)

    fontsize=14;
    fontname='Times';

    colours=lines(numV);
    
    I=eye(3,3);
    
    
    for b2=1:numV
        figure(b2+1000)
        for b1=1:numFPA
            a1=numV*(b1-1)+b2;

            plot3(0,0,0,'ko','LineWidth',2,'MarkerSize',2);
            hold on

            h(b1)=plot3([BirdData(a1).base(:,1);BirdData(a1).base(1,1)],...
                         [BirdData(a1).base(:,2);BirdData(a1).base(1,2)],...
                         [BirdData(a1).base(:,3);BirdData(a1).base(1,3)],'-','Color',colours(b1,:));
            plot3(BirdData(a1).base_cg(:,1),BirdData(a1).base_cg(:,2),BirdData(a1).base_cg(:,3),'o','Color',colours(b1,:));
            quiver3(0,0,0,BirdData(a1).base_cg(:,1),BirdData(a1).base_cg(:,2),BirdData(a1).base_cg(:,3),1,'yo');% CCF
            quiver3(BirdData(a1).base_cg(1)*ones(1,3),BirdData(a1).base_cg(2)*ones(1,3),BirdData(a1).base_cg(3)*ones(1,3),...
                BirdData(a1).baseframe(1,:),BirdData(a1).baseframe(2,:),BirdData(a1).baseframe(3,:),'Color',colours(b1,:))% Local frame
            quiver3(BirdData(a1).base_cg(1),BirdData(a1).base_cg(2),BirdData(a1).base_cg(3),...
                	BirdData(a1).v(1),BirdData(a1).v(2),BirdData(a1).v(3),...
                    3,'Color',colours(b1,:),'LineStyle','--','LineWidth',0.5)% Velocity attached to local frame
            quiver3(BirdData(a1).base_cg(1),BirdData(a1).base_cg(2),BirdData(a1).base_cg(3),...
                	BirdData(a1).v_yz_base(1),BirdData(a1).v_yz_base(2),BirdData(a1).v_yz_base(3),...
                    3,'Color',colours(b1,:),'LineStyle','--','LineWidth',0.5)% Velocity projected to y-z local

            plot3([BirdData(a1).tip(:,1);BirdData(a1).tip(1,1)],...
                  [BirdData(a1).tip(:,2);BirdData(a1).tip(1,2)],...
                  [BirdData(a1).tip(:,3);BirdData(a1).tip(1,3)],'-','Color',colours(b1,:));
            plot3(BirdData(a1).tip_cg(:,1),BirdData(a1).tip_cg(:,2),BirdData(a1).tip_cg(:,3),'o','Color',colours(b1,:));
            %quiver3(0,0,0,BirdData(a1).tip_cg(:,1),BirdData(a1).tip_cg(:,2),BirdData(a1).tip_cg(:,3),'m');
            quiver3(BirdData(a1).tip_cg(1)*ones(1,3),BirdData(a1).tip_cg(2)*ones(1,3),BirdData(a1).tip_cg(3)*ones(1,3),...
                BirdData(a1).tipframe(1,:),BirdData(a1).tipframe(2,:),BirdData(a1).tipframe(3,:),'Color',colours(b1,:))
            quiver3(BirdData(a1).tip_cg(1),BirdData(a1).tip_cg(2),BirdData(a1).tip_cg(3),...
                	BirdData(a1).v(1),BirdData(a1).v(2),BirdData(a1).v(3),...
                    3,'Color',colours(b1,:),'LineStyle','--','LineWidth',2)% Velocity attached to local frame
            quiver3(BirdData(a1).tip_cg(1),BirdData(a1).tip_cg(2),BirdData(a1).tip_cg(3),...
                	BirdData(a1).v_yz_tip(1),BirdData(a1).v_yz_tip(2),BirdData(a1).v_yz_tip(3),...
                    3,'Color',colours(b1,:),'LineStyle','--','LineWidth',0.5)% Velocity projected to y-z local
            
            %{
            n=4;
            quiver3(BirdData(a1).base_cg(1),BirdData(a1).base_cg(2),BirdData(a1).base_cg(3),...
                BirdData(a1).tau(n).nhat(1),BirdData(a1).tau(n).nhat(2),BirdData(a1).tau(n).nhat(3),2,'Color',[0 0 0])
            
            n=3;
            quiver3(BirdData(a1).tip_cg(1),BirdData(a1).tip_cg(2),BirdData(a1).tip_cg(3),...
                BirdData(a1).tau(n).nhat(1),BirdData(a1).tau(n).nhat(2),BirdData(a1).tau(n).nhat(3),2,'Color',[0 0 0])

            n=1;
            quiver3(BirdData(a1).tip_cg(1),BirdData(a1).tip_cg(2),BirdData(a1).tip_cg(3),...
                BirdData(a1).tau(n).nhat(1),BirdData(a1).tau(n).nhat(2),BirdData(a1).tau(n).nhat(3),2,'Color',[0 1 0])
            %}
                    
            legent{b1}=sprintf('\\gamma: %0.1f Degrees',BirdData(a1).FPA);
        end
        %set(gcf,'Position',[164   657   884   250]);
        %view([0 0])
        quiver3(zeros(1,3),zeros(1,3),zeros(1,3),I(1,:),I(2,:),I(3,:),5,'k','LineWidth',2)
        set(gca,'FontSize',fontsize,'FontName',fontname)
        legend(h,legent);
        %legend(h,legent,'Location','NW');
        xlabel('$\hat{X}$','Interpreter','LaTeX')
        ylabel('$\hat{Y}$','Interpreter','LaTeX')
        zlabel('$\hat{Z}$','Interpreter','LaTeX')

        axis image;
        %title(sprintf('\\alpha=%0.2f^\\circ',BirdData(a1).FPA));
        hold off;
        title(sprintf('Wind Speed (v): %0.1f m/s',BirdData(a1).V))
    end

end