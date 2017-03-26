function visualizeTransformation(theta,nhat,BirdData)
%   visualizeTransformation(theta,nhat,BirdData)
%
%   This function makes a "movie" showing the rotation of BirdData about
%   nhat by the angle theta (in radians).
%
%   
%   Inputs:
%
%       theta: angle subtended in radians.
%
%       nhat: Normal vector to rotate about.
%
%       BirdData: A structure returned from RotateData
%
%       numFPA: Number of flight path angles tested.
%
%       numV:   Number of velocity points tested.
%
%   Outputs:
%
%       
%
% Richard B. Choroszucha
% riboch@umich.edu    

    R=rodrigues(theta,nhat)';
    data=[];
    for a1=1:numel(BirdData)
        data=[data;BirdData(a1).tip;BirdData(a1).base;(R*BirdData(a1).base')';(R*BirdData(a1).tip')'];
    end
    axissize=[min(data(:,1)) max(data(:,1)) min(data(:,2)) max(data(:,2)) min(data(:,3)) max(data(:,3))];
    
    figure(100)
    
    numV=numel(BirdData);
    colours=lines(numV);
    I=eye(3,3);
    
    t=linspace(0,theta,120);
    
    
    
    for a2=1:numel(t)
        R=rodrigues(t(a2),nhat)';
        
        for a1=1:numel(BirdData)
            
                plot3(0,0,0,'ko','LineWidth',5,'MarkerSize',10);
                
                hold on
                
                base=(R*BirdData(a1).base')';
                base_cg=(R*BirdData(a1).base_cg')';
                baseframe=R*BirdData(a1).baseframe;
                
                tip=(R*BirdData(a1).tip')';
                tip_cg=(R*BirdData(a1).tip_cg')';
                tipframe=R*BirdData(a1).tipframe;
                
                ind=a1-numV*floor((a1-1)/numV);
                plot3([BirdData(a1).base(:,1);BirdData(a1).base(1,1)],...
                             [BirdData(a1).base(:,2);BirdData(a1).base(1,2)],...
                             [BirdData(a1).base(:,3);BirdData(a1).base(1,3)],'--','Color',colours(ind,:));
                         
                plot3([base(:,1);base(1,1)],...
                             [base(:,2);base(1,2)],...
                             [base(:,3);base(1,3)],'-','Color',colours(ind,:));
                plot3(base_cg(:,1),base_cg(:,2),base_cg(:,3),'x','Color',colours(ind,:));
                quiver3(base_cg(1)*ones(1,3),base_cg(2)*ones(1,3),base_cg(3)*ones(1,3),baseframe(1,:),baseframe(2,:),baseframe(3,:),'Color',colours(ind,:))

                plot3([BirdData(a1).tip(:,1);BirdData(a1).tip(1,1)],...
                      [BirdData(a1).tip(:,2);BirdData(a1).tip(1,2)],...
                      [BirdData(a1).tip(:,3);BirdData(a1).tip(1,3)],'--','Color',colours(ind,:));
                plot3([tip(:,1);tip(1,1)],...
                      [tip(:,2);tip(1,2)],...
                      [tip(:,3);tip(1,3)],'-','Color',colours(ind,:));
                plot3(BirdData(a1).tip_cg(:,1),BirdData(a1).tip_cg(:,2),BirdData(a1).tip_cg(:,3),'x','Color',colours(ind,:));
                quiver3(tip_cg(1)*ones(1,3),tip_cg(2)*ones(1,3),tip_cg(3)*ones(1,3),...
                    tipframe(1,:),tipframe(2,:),tipframe(3,:),'Color',colours(ind,:))

                
        end
        quiver3(zeros(1,3),zeros(1,3),zeros(1,3),I(1,:),I(2,:),I(3,:),10,'k')
        quiver3(0,0,0,nhat(1),nhat(2),nhat(3),5,'k','LineWidth',2)
        axis(axissize);
        view([-120-a2/4 30-a2/4]);
        axis image
        hold off;
        drawnow;
    end
end