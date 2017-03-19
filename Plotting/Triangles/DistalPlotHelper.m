function h=DistalPlotHelper(BirdData,a1)

    linestys={'-','--','-.',':'};
    F=BirdData.tipframe;
    Z=zeros(3,3);
    h=quiver3(Z(:,1),Z(:,2),Z(:,3),F(1,:)',F(2,:)',F(3,:)','b','LineStyle',linestys{a1});
    hold on;
    quiver3(0,0,0,BirdData.v(1),BirdData.v(2),BirdData.v(3),'k','LineStyle',linestys{a1});
    quiver3(0,0,0,BirdData.v_yz_tip(1),BirdData.v_yz_tip(2),BirdData.v_yz_tip(3),'r','LineStyle',linestys{a1});
end