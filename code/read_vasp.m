function out=read_vasp(filename)
fid=fopen(filename);
frewind(fid);
for i=1:9
fgetl(fid);
end
out=[];
while ~feof(fid)
tline=fgetl(fid);
sline=sscanf(tline,'%f');
out=[out,sline];
end
out=out';
end