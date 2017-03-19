clc

BirdType={'american kestrel 20141225',...
    'cooper''s hawk 20141225',...
    'great horned owl 20141225',...
    'red-tailed hawk 20141225',...
    'osprey 20141225',...
    'merlin 20141225',...
    'peregrine falcon 20141225'}



for a1=1:numel(BirdType)
    fprintf('\n\n\\subsection{%s}\n\n',BirdType{a1});
    BirdData{a1}=BendSweepTwist(BirdType{a1});
end


%Plot Displacements vs velocity

    addpath('PostProcessingPlots/')

    numV=4;
    numFPA=2;
    plotDeflectionsVsVelocity(BirdData,BirdType,numFPA,numV)