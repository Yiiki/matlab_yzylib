function [xout,yout,zout]=cub_plot(cubdat)
xlim=cubdat.x;
ylim=cubdat.y;
zlim=cubdat.z;
% coord = [...
%     0    0    0;
%     0.5  0    0;
%     0.5  0.5  0;
%     0    0.5  0;
%     0    0    0.5;
%     0.5  0    0.5;
%     0.5  0.5  0.5;
%     0    0.5  0.5;];

coord=[kron(kron(xlim,ylim.^0),zlim.^0);
       kron(kron(xlim.^0,ylim),zlim.^0);
       kron(kron(xlim.^0,ylim.^0),zlim)]';
idx = [1 2 4 3 1; 
       1 3 7 5 1; 
       1 2 6 5 1; 
       8 4 3 7 8; 
       8 4 2 6 8; 
       8 6 5 7 8]';

xc = coord(:,1);
yc = coord(:,2);
zc = coord(:,3);

xout=xc(idx);
yout=yc(idx);
zout=zc(idx);

end