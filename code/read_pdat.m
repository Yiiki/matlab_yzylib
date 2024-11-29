function mat=read_pdat(filename)
fid=fopen(filename,"r");
frewind(fid);
nn=sscanf(fgetl(fid),'%d');
num=prod(nn);
narray=zeros(num,1);
ptr=0;
while ~feof(fid)
    tline=fgetl(fid);
    tmp=sscanf(tline,'%f');
    add_ptr=length(tmp);
    narray(ptr+1:ptr+add_ptr)=tmp(1:add_ptr);
    ptr=ptr+add_ptr;
end
mat=reshape(narray,nn');
end