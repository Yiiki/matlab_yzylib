function out=read_unform(filename)
% filename='../tmp/toy.SCF';
fid=fopen(filename,'rb');
frewind(fid);
fread(fid, 1,  '*int32'); % write()
a = fread(fid, 4,  '*int32');
fread(fid, 1,  '*double'); % write()
ALlis = fread(fid, 9,  '*double');

n1=a(1);n2=a(2);n3=a(3);
nnodes_tmp=a(4);
AL=reshape(ALlis,[3,3]);
nr_n=(n1*n2*n3)/nnodes_tmp;% in MATLAB, int 6 / int 4 = int 2 !!!! not 1 !!
rho=zeros(n1,n2,n3);
for iread=1:nnodes_tmp
  fread(fid, 1,  '*double'); % write()
  vr_tmp=fread(fid,nr_n,'*double');
  for ii=1:nr_n
    jj=ii+(iread-1)*nr_n;
    i=floor((double(jj)-1)/double(n2*n3))+1;
    j=floor(double(jj-1-(i-1)*n2*n3)/double(n3))+1;
    k=jj-(i-1)*n2*n3-(j-1)*n3;
    rho(i,j,k)=vr_tmp(ii);
  end
end
fclose(fid);
out.AL=AL;
out.rho=rho;
out.dim=a;
end