function out=read_atom_config_tilt_out_patch(filename)
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

tline=fgetl(fid);
atom_num=sscanf(tline,'%d*');
fprintf('atom_num=%d\n',atom_num);
% atom_num=str2double(tline);

frewind(fid);
i=0;
while i<2
    i=i+1;
    fgetl(fid);% read two line
end

lat_vec=zeros(3,3);
for j=1:3
    tline=fgetl(fid);
%    reg_tline=regexp(tline,' ','split');
    lat_vec(j,:)=sscanf(tline,'%f')';
%     for jj=[2,4,6]
%         lat_vec(j,jj/2)=str2double(reg_tline{jj});
%         fprintf('lat(%d,%d)=%.6f\n',j,jj/2,lat_vec(j,jj/2))
%     end
end

out.AL=lat_vec;

clear atom_initial atom_array
lab{atom_num,1}=[]; % create an empty cell
xyz=zeros(atom_num,3);
tat=zeros(atom_num,1);
tag=zeros(atom_num,1);
frewind(fid);
i=0;
while i<6
    i=i+1;
    fgetl(fid);
end
for k=1:atom_num
    tline=fgetl(fid);
    % %tline_new=regexprep(tline_old,' +',' ');
    % reg_tline=regexp(tline,' ','split');
    % regline=reg_tline(~cellfun('isempty',reg_tline));
    % atom_array(k).num=str2double(regline{1});
    % for kk=1:3
    %     atom_array(k).xyz(kk)=[str2double(regline{2}),str2double(regline{3}),str2double(regline{4})]*lat_vec(:,kk);
    % end
    tout=sscanf(tline,'%f');
    tatom=atom_num2char(tout(1));
    xatom=tout(2:4)'*lat_vec;
    tat(k)=tout(1);
    tag(k)=tout(8);
    lab{k}=tatom;
    xyz(k,:)=xatom;
end

out.xyz=xyz;
out.lab=lab;
out.tat=tat;
out.tag=tag;
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