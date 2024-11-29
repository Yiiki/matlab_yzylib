function out=read_vaspv(filename)
fid=fopen(filename,"r");
frewind(fid);
fgetl(fid);
fgetl(fid);
AL=zeros(3,3);
for i=1:3
tline=fgetl(fid);
AL(:,i)=sscanf(tline,'%f');
end

str=fgetl(fid); % input
splitArray = strsplit(str); % split by space
splitArray = splitArray(~cellfun('isempty',splitArray)); % remove space
disp(splitArray); % output

num_type=length(splitArray);
tline=fgetl(fid);
dis_type=sscanf(tline,'%d');
% dis_type=[0;dis_type];
natom=sum(dis_type);
xyz=zeros(natom,3);
lab=cell(natom,1);

fgetl(fid);

iatom=0;
for itype=1:num_type
    iatom_in=iatom;
for i=1:dis_type(itype)
iatom=iatom+1;
tline=fgetl(fid);
xyz(iatom,1:3)=sscanf(tline,'%f')';
end
    lab(iatom_in+1:iatom)={splitArray{itype}};
end

out.AL=AL;
out.xyz=xyz;
out.lab=lab;

fclose(fid);