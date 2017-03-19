function BirdData=calculateAoAandAoS(BirdData,numFPA,numV)
%   BirdData=calculateAoAandAoS(BirdData,numFPA,numV)
%
%   This function calculates the local angle of attack and slip.
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

    radtodeg=180/pi;

    for a1=1:numFPA
        for a2=1:numV
            ind=numV*(a1-1)+a2;%At speed 

            v=[0;1;0];
            
            R=rodrigues(BirdData(ind).FPA/radtodeg,[1;0;0]);
            v=R*v;
            BirdData(ind).v=v;
            
            P_l_base_CCF=BirdData(ind).baseframe(:,2:3);
            v_yz_base=P_l_base_CCF*(P_l_base_CCF'*P_l_base_CCF)^-1*P_l_base_CCF'*v;%Projection of velocity vector onto y-z (local) frame, realized in the CCF
            
            P_l_tip_CCF=BirdData(ind).tipframe(:,2:3);
            v_yz_tip=P_l_tip_CCF*(P_l_tip_CCF'*P_l_tip_CCF)^-1*P_l_tip_CCF'*v;%Projection of velocity vector onto y-z (local) frame, realized in the CCF
            
            %Proximal
            y_yz_base_CCF=P_l_base_CCF(:,1);
            forSign_base=BirdData(ind).baseframe'*v_yz_base;
            %BirdData(ind).alpha_base=sign(g(2))*acos(v_yz_base'*y_yz_base_CCF/(norm(v_yz_base,2)*norm(y_yz_base_CCF,2)))*radtodeg;
            BirdData(ind).alpha_base=sign(forSign_base(3))*acos(v_yz_base'*y_yz_base_CCF/(norm(v_yz_base,2)*norm(y_yz_base_CCF,2)))*radtodeg;
            BirdData(ind).v_yz_base=v_yz_base;
            
            %Distal
            y_yz_tip_CCF=P_l_tip_CCF(:,1);
            forSign_tip=BirdData(ind).tipframe'*v_yz_tip;
            %BirdData(ind).alpha_tip=sign(g(2))*acos(v_yz_tip'*y_yz_tip_CCF/(norm(v_yz_tip,2)*norm(y_yz_tip_CCF,2)))*radtodeg;
            BirdData(ind).alpha_tip=sign(forSign_tip(3))*acos(v_yz_tip'*y_yz_tip_CCF/(norm(v_yz_tip,2)*norm(y_yz_tip_CCF,2)))*radtodeg;
            BirdData(ind).v_yz_tip=v_yz_tip;
            
            % Proximal
            %BirdData(ind).beta_base=sign(g(3))*acos(v_yz_base'*v/(norm(v_yz_base,2)*norm(v,2)))*radtodeg;
            forSign_base=BirdData(ind).baseframe'*v;
            BirdData(ind).beta_base=sign(forSign_base(1))*acos(v_yz_base'*v/(norm(v_yz_base,2)*norm(v,2)))*radtodeg;
            
            % Distal
            %BirdData(ind).beta_tip=sign(g(2))*acos(v_yz_tip'*v/(norm(v_yz_tip,2)*norm(v,2)))*radtodeg;
            forSign_tip=BirdData(ind).tipframe'*v;
            BirdData(ind).beta_tip=sign(forSign_tip(1))*acos(v_yz_tip'*v/(norm(v_yz_tip,2)*norm(v,2)))*radtodeg;
            
            
        end
    end
        
end