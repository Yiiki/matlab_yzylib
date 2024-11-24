function S=lat_frame(AL,ec,fc,lw)
xlim=[0 1];
ylim=[0 1];
zlim=[0 1];
% coord = [...
%     0    0    0;
%     0.5  0    0;
%     0.5  0.5  0;
%     0    0.5  0;
%     0    0    0.5;
%     0.5  0    0.5;
%     0.5  0.5  0.5;
%     0    0.5  0.5;];
clear S
S.Vertices=[kron(kron(xlim,ylim.^0),zlim.^0);
       kron(kron(xlim.^0,ylim),zlim.^0);
       kron(kron(xlim.^0,ylim.^0),zlim)]'*AL;
% AL 's row is a vector
S.Faces = [1 2 4 3; 
       1 3 7 5; 
       1 2 6 5; 
       8 4 3 7; 
       8 4 2 6; 
       8 6 5 7];
S.FaceColor=fc;
S.EdgeColor=ec;
S.LineWidth=lw;
end