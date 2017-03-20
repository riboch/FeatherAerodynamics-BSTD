function BirdData=BirdDataCOHA20141213()

    BirdData=struct('AoA',[],'V',[],'x',[],'y',[],'z',[]);

    c1=0;
    %  pt1_X        pt1_Y       pt1_Z       pt2_X       pt2_Y       pt2_Z       pt3_X       pt3_Y       pt3_Z       pt4_X       pt4_Y       pt4_Z       pt5_X       pt5_Y       pt5_Z       pt6_X       pt6_Y       pt6_Z
    A=[58.543631	119.139776	50.174606	64.237159	96.104301	45.384164	76.786264	95.337307	45.954796	141.985879	85.719561	49.571229	179.749844	68.272683	58.411217	158.011562	71.364145	53.560788;
       58.049534	119.345223	50.736921	64.5237	96.240163	45.321514	76.696132	95.46745	45.610335	141.47476	84.971739	48.444724	179.469746	65.735172	52.826011	157.422264	70.114379	50.361456;
       58.113167	119.074937	50.225816	64.387364	96.477699	45.5986	76.761593	95.275992	45.266205	141.290398	84.096313	47.452019	178.711857	63.864166	49.655597	156.970857	68.832848	48.546789;
       58.332438	119.152707	50.661182	64.171055	96.042784	45.603299	76.898979	95.20232	45.506007	141.312741	83.15975	47.954389	178.258601	61.298914	50.22191	155.891007	67.44979	48.410429;
       58.298367	119.771144	45.111213	63.98491	96.462435	46.18411	76.717178	96.113178	46.248248	141.668133	86.779653	52.195321	179.62251	71.717014	64.918332	157.845937	73.999778	58.477455;
       58.436941	120.254407	44.966121	64.178664	96.530063	45.674666	76.79104	95.798233	45.778753	141.655436	85.036113	48.05537	179.82498	66.118762	53.095043	157.276731	70.267633	52.661836;
       58.409287	119.956518	44.967123	64.162693	96.353073	45.419872	76.565692	95.729785	45.614591	141.037534	83.699369	43.908693	177.87662	62.465633	40.636509	155.993155	67.858984	43.786715;
       58.2448	119.773224	45.908491	64.022369	96.300884	45.721993	76.724552	95.560709	45.43889	140.700856	82.910984	41.668316	176.071741	60.141854	35.195921	154.909066	66.066102	40.133497];... AoA=13.5, V=16 
                
    AoA=[0 0 0 0 13.5 13.5 13.5 13.5];
    V=[0 8 12 16 0 8 12 16];
    

    for a1=1:size(A,1)
        BirdData(a1).AoA=AoA(a1);
        BirdData(a1).V=V(a1);
        BirdData(a1).x=A(a1,1:3:end)';

        BirdData(a1).y=A(a1,2:3:end)';

        BirdData(a1).z=A(a1,3:3:end)';
    end
    
    
    
end
