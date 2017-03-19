function pullOutImage(birdAcronym)

    if (nargin==0)
        birdAcronym='RTHA';
    end
    
    foldername=sprintf('Videos/%sRound03/',birdAcronym);
    picfolder='../Pictures/';
    filetype='.avi';

    mkdir([foldername picfolder])
    d=dir([foldername '*' filetype]);
    for a1=1:numel(d)
        V=VideoReader([foldername d(a1).name]);
        IM=readFrame(V);%Only gets the first frame
        [~,filename,fileext]=fileparts(d(a1).name);
        imagesc(IM);colormap gray;
        imwrite(IM,[foldername picfolder filename '.png']);
    end

end