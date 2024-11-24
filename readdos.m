function data=readdos(filename)
fid=fopen(filename,'r');
data=[];
while ~feof(fid)
    tmp=sscanf(fgetl(fid),'%f');
    data=[data,tmp];
end
end