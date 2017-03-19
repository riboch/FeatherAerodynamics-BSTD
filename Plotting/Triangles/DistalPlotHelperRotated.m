function h=DistalPlotHelperRotated(BirdData,a1)

    linestys={'-','--','-.',':'};
    F=BirdData.tipframe;
    FBod=F'*F;
    Z=zeros(3,3);
    h=quiver3(Z(:,1),Z(:,2),Z(:,3),FBod(1,:)',FBod(2,:)',FBod(3,:)','b','LineStyle',linestys{a1});
    hold on;
    v=BirdData.v;
    v=F'*v;
    v_yz_tip=BirdData.v_yz_tip;
    v_yz_tip=F'*v_yz_tip;
    quiver3(0,0,0,v(1),v(2),v(3),'k','LineStyle',linestys{a1});
    quiver3(0,0,0,v_yz_tip(1),v_yz_tip(2),v_yz_tip(3),'r','LineStyle',linestys{a1});
end