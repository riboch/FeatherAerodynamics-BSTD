function plotBothTrianglesVsAngleFlightPath(BirdData,numFPA,numV)

    fontsize=14;
    fontname='Times';

    colours=lines(numV);
    
    I=eye(3,3);
    
    
    for b2=1:numV
        figure(b2+7000)
        for b1=1:numFPA
            a1=numV*(b1-1)+b2;
            radtodeg=180/(pi);
            R=rodrigues(-BirdData(a1).FPA/radtodeg,[1;0;0]);

            plot3(0,0,0,'ko','LineWidth',2,'MarkerSize',2);
            hold on

            %Proximal
            triang=(R*BirdData(a1).base')';
            base_cg=R*BirdData(a1).base_cg';
            baseframe=R*BirdData(a1).baseframe;
            v=R*BirdData(a1).v;
            v_yz_base=R*BirdData(a1).v_yz_base;
            
            h(b1)=plot3([triang(:,1);triang(1,1)],[triang(:,2);triang(1,2)],[triang(:,3);triang(1,3)],'-','Color',colours(b1,:));
            plot3(base_cg(1),base_cg(2),base_cg(3),'o','Color',colours(b1,:));
            quiver3(0,0,0,base_cg(1),base_cg(2),base_cg(3),1,'yo');% CCF
            quiver3(base_cg(1)*ones(1,3),base_cg(2)*ones(1,3),base_cg(3)*ones(1,3),...
                baseframe(1,:),baseframe(2,:),baseframe(3,:),'Color',colours(b1,:))% Local frame
            quiver3(base_cg(1),base_cg(2),base_cg(3),...
                	v(1),v(2),v(3),...
                    3,'Color',colours(b1,:),'LineStyle','--','LineWidth',2)% Velocity attached to local frame
            quiver3(base_cg(1),base_cg(2),base_cg(3),...
                	v_yz_base(1),v_yz_base(2),v_yz_base(3),...
                    3,'Color',colours(b1,:),'LineStyle','--','LineWidth',0.5)% Velocity projected to y-z local

            %Distal
            triang=(R*BirdData(a1).tip')';
            tip_cg=R*BirdData(a1).tip_cg';
            tipframe=R*BirdData(a1).tipframe;
            v_yz_tip=R*BirdData(a1).v_yz_tip;
            
            plot3([triang(:,1);triang(1,1)],[triang(:,2);triang(1,2)],[triang(:,3);triang(1,3)],'-','Color',colours(b1,:));
            plot3(tip_cg(1),tip_cg(2),tip_cg(3),'o','Color',colours(b1,:));
            %quiver3(0,0,0,BirdData(a1).tip_cg(:,1),BirdData(a1).tip_cg(:,2),BirdData(a1).tip_cg(:,3),'m');
            quiver3(tip_cg(1)*ones(1,3),tip_cg(2)*ones(1,3),tip_cg(3)*ones(1,3),...
                tipframe(1,:),tipframe(2,:),tipframe(3,:),'Color',colours(b1,:))
            quiver3(tip_cg(1),tip_cg(2),tip_cg(3),...
                	v(1),v(2),v(3),...
                    3,'Color',colours(b1,:),'LineStyle','--','LineWidth',2)% Velocity attached to local frame
            quiver3(tip_cg(1),tip_cg(2),tip_cg(3),...
                	v_yz_tip(1),v_yz_tip(2),v_yz_tip(3),...
                    3,'Color',colours(b1,:),'LineStyle','--','LineWidth',0.5)% Velocity projected to y-z local
                    
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