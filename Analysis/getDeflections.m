function BirdData=getDeflections(BirdData,numFPA,numV)
%   BirdData=getDeflections(BirdData,numFPA,numV)
%
%   Calculates the proximal deflection and the corrected distal deflection.
%
%   
%   Inputs:
%
%       BirdData: A structure returned from RotateData
%
%       numFPA: Number of flight path angles tested.
%
%       numV:   Number of velocity points tested.
%
%
%   Outputs:
%
%       BirdData:   A structure of the data and calculated quantities.
%
%
% Richard B. Choroszucha
% riboch@umich.edu

    

    for a1=1:numFPA
        for a2=1:numV
            ind=numV*(a1-1)+a2;
            ind0V=numV*(a1-1)+1;%0 Velocity index
            
            %Proximal deflection: simply x_v-x_0
            BirdData(ind).ProximalDeflection=BirdData(ind).base_cg'-BirdData(ind0V).base_cg';
            
            
            %Distal, Rotate proximal triangle P_0 (proximal triangle at V=0) by R to align with T_V
            %(proximal triangle at V), then apply R to D_0 (distal triangle at V=0), and take x_v-R*x_0
            FPv=BirdData(ind).baseframe;
            %FP0 = I, so R=FPv'
            R=FPv;
            
            %Calculates in at speed frame
            %BirdData(ind).DistalDeflection=BirdData(ind).tip_cg'-R*BirdData(ind0V).tip_cg';
            
            %Calculates in at rest frame (V=0 m/s) (Makes more sense)
            BirdData(ind).DistalDeflection=R'*BirdData(ind).tip_cg'-BirdData(ind0V).tip_cg';
            
        end
    end


end