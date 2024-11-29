function out=read_atom_vasp(filename)
% input: .config file
% ouput: AL, xyz and lab
fid=fopen(filename,'r');
frewind(fid);
% % used to check the content
% while 1
%     tline=fgetl(fid);
%     if tline==-1
%         break
%     end
%     fprintf('%s',tline);
%     fprintf('\n');    
% end
for i=1:2
fgetl(fid)
end
AL=zeros(3,3);
for i=1:3
    tline=fgetl(fid);
    AL(1:3,i)=sscanf(tline,'%f');
end
% get atom name
tline=fgetl(fid);
sline=strsplit(tline);
lablib=sline(~cellfun('isempty',sline));
type_num=length(lablib);
% get atom type num
tline=fgetl(fid);
atom_type_fnum=sscanf(tline,'%d');    
if(length(atom_type_fnum)~=type_num)
error('error: two type num do not agree, stop')
end
atom_num=sum(atom_type_fnum);
fprintf('atom_num=%d\n',atom_num);
% skip direct 
for i=1:1 % note!!!!!! here, one should choose 1 or 2, it can be different!
fgetl(fid)
end
% start to read in xyz data
xyz=zeros(3,atom_num);
xatom=zeros(3,1);
for i=1:atom_num
    tline=fgetl(fid);
    xatom=sscanf(tline,'%f');
    xyz(1:3,i)=AL*xatom;
end
% start to fill in lab data
lab{atom_num}=' ';
address=atom_type_fnum;
for j=2:type_num
    address(j)=address(j-1)+atom_type_fnum(j);
end
startww=address;
startww(1)=1;
startww(2:type_num)=address(1:type_num-1)+1;
for j=1:type_num
    for i=startww(j):address(j)
    lab{i}=lablib{j};
    end
end
out.AL=AL;
out.xyz=xyz';
out.lab=lab;
end

% 
% % plot the cubic 
% xl=norm(lat_vec(1,:));
% yl=norm(lat_vec(2,:));
% zl=norm(lat_vec(3,:));% unit: Ang
% out.xl=xl;out.yl=yl;out.zl=zl;
% cubdat.x=[0 xl];
% cubdat.y=[0 yl];
% cubdat.z=[0 zl];
% S=cub_frame(cubdat,'k','none',2);
% if(tag==1)
% % plot the data
% h=figure;
% patch('Faces',S.Faces,'Vertices',S.Vertices,...
%     'EdgeColor',S.EdgeColor,'FaceColor',S.FaceColor,'LineWidth',S.LineWidth);
% 
% hold on
% 
% % set face color 
% FaceColor=[250 208 208;
%     255 51 48;
%     33 58 212;
%     220 157 55]./255;
% 
% for i=1:atom_type_num
% scatter3(gdat(i).x,gdat(i).y,gdat(i).z,...
%         'MarkerEdgeColor','k',...
%         'MarkerFaceColor',FaceColor(i,:))
% hold on
% end
% zlim([-0.1 1.1*lat_vec(3,3)])
% view([0 -1 0])
% axis equal
% hold off
% out.fig=h;
% end