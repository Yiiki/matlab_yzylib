function out=read_atom_config(filename)
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
atom_num=str2double(tline);

frewind(fid);
i=0;
while i<2
    i=i+1;
    fgetl(fid);% read two line
end

lat_vec=zeros(3,3);
for j=1:3
    tline=fgetl(fid);
    reg_tline=regexp(tline,' ','split');
    for jj=[2,4,6]
        lat_vec(j,jj/2)=str2double(reg_tline{jj});
    end
end

out.AL=lat_vec;

clear atom_initial atom_array
atom_initial.num=1;
atom_initial.xyz=[0,0,0];
atom_array(atom_num)=atom_initial;

frewind(fid);
i=0;
while i<6
    i=i+1;
    fgetl(fid);
end
for k=1:atom_num
    tline=fgetl(fid);
    %tline_new=regexprep(tline_old,' +',' ');
    reg_tline=regexp(tline,' ','split');
    regline=reg_tline(~cellfun('isempty',reg_tline));
    atom_array(k).num=str2double(regline{1});
    for kk=1:3
        atom_array(k).xyz(kk)=[str2double(regline{2}),str2double(regline{3}),str2double(regline{4})]*lat_vec(:,kk);
    end
end

% get atom type and define the group by their type
clear atom_type_vec
atom_type_vec(atom_num)=0;
for i=1:atom_num
    atom_type_vec(i)=atom_array(i).num;
end

atom_type=unique(atom_type_vec);% [1     8    14    79]
atom_type_num=length(atom_type);

out.atom_type_num=atom_type_num;
out.atom_type=atom_type;


clear obj atom_group
obj.num=1;% 1 -- H
obj.tag=boolean(zeros(atom_num,1));
atom_group(atom_type_num)=obj;
for i=1:atom_type_num
    atom_now=atom_type(i);
    atom_group(i).num=atom_now;
    for j=1:atom_num
        if atom_array(j).num==atom_now
            atom_group(i).tag(j)=boolean(1);
        end
    end
end


% get the graph data 
clear gdat_init gdat
gdat_init.x=zeros(100,1);
gdat_init.y=zeros(100,1);
gdat_init.z=zeros(100,1);
gdat_init.num=1;
gdat(atom_type_num)=gdat_init;

for i=1:atom_type_num
    atom_array_i=atom_array(boolean(atom_group(i).tag));
    atom_array_i_len=length(atom_array_i);
    x_i=zeros(atom_array_i_len,1);
    y_i=zeros(atom_array_i_len,1);
    z_i=zeros(atom_array_i_len,1);
    xyz_i=[x_i,y_i,z_i];
    for j=1:atom_array_i_len
        xyz_i(j,:)=atom_array_i(j).xyz;
    end
    x_i=xyz_i(:,1);
    y_i=xyz_i(:,2);
    z_i=xyz_i(:,3);
    gdat(i).x=x_i;gdat(i).y=y_i;gdat(i).z=z_i;
    gdat(i).num=atom_group(i).num;
end
out.dat=gdat;

% plot the data
figure

% plot the cubic 
xl=lat_vec(1,1);yl=lat_vec(2,2);zl=lat_vec(3,3);% unit: Ang
out.xl=xl;out.yl=yl;out.zl=zl;
cubdat.x=[0 xl];
cubdat.y=[0 yl];
cubdat.z=[0 zl];
S=cub_frame(cubdat,'k','none',2);
patch('Faces',S.Faces,'Vertices',S.Vertices,...
    'EdgeColor',S.EdgeColor,'FaceColor',S.FaceColor,'LineWidth',S.LineWidth);

hold on

% set face color 
FaceColor=[250 208 208;
    255 51 48;
    33 58 212;
    220 157 55]./255;

for i=1:atom_type_num
scatter3(gdat(i).x,gdat(i).y,gdat(i).z,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',FaceColor(i,:))
axis equal
hold on
end
hold off