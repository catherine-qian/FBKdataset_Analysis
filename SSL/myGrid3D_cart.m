function [Grid_cart,X,Y,Z]=myGrid3D_cart(Xr,Yr,Zr)
% Description:
%   create a 3D grid in Cartesian coordinates
% Date: 12/06/2017
% Author: XQ
% Input:
%   Xr: 1 by 3 vector [start,step,end] point in X direction
%   Yr: 1 by 3 vector [start,step,end] point in Y direction
%   Zr: 1 by 3 vector [start,step,end] point in Z direction

X=Xr(1):Xr(2):Xr(3);
Y=Yr(1):Yr(2):Yr(3);
Z=Zr(1):Zr(2):Zr(3);

Grid_cart=zeros(3,length(X)*length(Y)*length(Z));


index=1;
for x=1:length(X)
    for y=1:length(Y)
        for z=1:length(Z)
         Grid_cart(1,index)=X(x);
         Grid_cart(2,index)=Y(y);
         Grid_cart(3,index)=Z(z);
        index=index+1;
        end
    end
end


end