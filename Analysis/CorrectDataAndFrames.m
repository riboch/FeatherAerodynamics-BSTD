function BirdData=CorrectDataAndFrames(BirdData)
%   BirdData=CorrectDataAndFrames(BirdData)
%
%   This function forms the proximal and distal triangles from the raw
%   data, the proximal and distal frames, and proximal and distal
%   centroids.
%
%   A word of caution, most data is in row form, not columns.
%
%   
%   Inputs:
%
%       BirdData:   A structure returned by dataSelector.
%
%
%   Outputs:
%
%       BirdData:   A structure of the data and calculated quantities.
%                   The data is assumed to have a certain structure.
%
%
% Richard B. Choroszucha
% riboch@umich.edu
% 

    
    for a1=1:numel(BirdData)

        %Assume the first point is the root point and that it does not
        %change, move this to the origin, it is the point to rotate about.
        
        offset=[BirdData(a1).x(2) BirdData(a1).y(2) BirdData(a1).z(2)];
        offset_mat=repmat(offset,[3,1]);%For American Kestrel 20141212
        base=[BirdData(a1).x(1:3) BirdData(a1).y(1:3) BirdData(a1).z(1:3)]-offset_mat; 
        base_raw=base;
        
        %20170213: Correction for needle, moves it to the x-y plane in the original
        %coordinates.
        base(1,3)=0;
        R=rodrigues(BirdData(a1).FPA*pi/180,[1;0;0]);
        base=(R'*base')';
        
        base_cg=mean(base(2:3,:),1);%cg along the rachis.
        
        
        tip=[BirdData(a1).x(4:6) BirdData(a1).y(4:6) BirdData(a1).z(4:6)]-offset_mat; 
        tip_cg=mean(tip(1:2,:),1);%cg along the rachis.
            
        %Get Base Frame
            %Get normal of base:
            v1=base(1,:)-base(2,:);
            v2=base(3,:)-base(2,:);
            n=cross(v1,v2);
            n_base(:,1)=n/norm(n,2);
            %Get Tangent
            ivect=(base(3,:)-base(2,:));    
            n_base(:,2)=ivect/norm(ivect,2);
            %Get Binormal
            n_base(:,3)=cross(n_base(:,1),n_base(:,2));
            n_base=n_base(:,[2 3 1]); %Reorders to [x, y, z].
            
            BirdData(a1).offset=offset;
            BirdData(a1).base=base;
            BirdData(a1).base_raw=base_raw;
            BirdData(a1).base_cg=base_cg;
            BirdData(a1).baseframe=n_base;

        %Get Tip Frame
            %Get normal of base:
            v1=tip(1,:)-tip(2,:);
            v2=tip(3,:)-tip(2,:);
            n=cross(v1,v2);
            n_tip(:,1)=sign(dot(n,BirdData(a1).baseframe(:,3)))*n/norm(n,2);%Use the signum of the tip normal to the base normal to align them.
            %Get Tangent
            ivect=tip(2,:)-tip(1,:);
            n_tip(:,2)=ivect/norm(ivect,2);
            n_tip(:,3)=cross(n_tip(:,1),n_tip(:,2));
            n_tip=n_tip(:,[2 3 1]); %Reorders to [x, y, z].
        
            BirdData(a1).tip=tip;
            BirdData(a1).tip_cg=tip_cg;
            BirdData(a1).tipframe=n_tip; 
    end
end