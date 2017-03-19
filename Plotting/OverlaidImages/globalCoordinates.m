function x_global=globalCoordinates(x,offset,R)

    x_global=R'*x+repmat(offset,[1,size(x,2)]);
end


