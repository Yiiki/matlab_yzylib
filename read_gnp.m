function data=read_gnp(filename)
fid=fopen(filename);
frewind(fid);
line=0;
while ~feof(fid)
fgetl(fid);
line=line+1;
end
data=zeros(line,2);
frewind(fid);
for i=1:line
tline=fgetl(fid);
tmp=sscanf(tline,'%f');
data(i,1:2)=tmp';
end
fclose(fid);
end
