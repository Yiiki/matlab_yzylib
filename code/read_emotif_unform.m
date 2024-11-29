function out=read_emotif_unform(varargin)
filename=varargin{1};
verbose=0;
if(nargin>1)
    verbose=1;
end
% filename='../tmp/toy.SCF';
% filename='../data/home/yzy/work/brc_SiO2_mp7000/emotif888/patch_null/MISSING_MOTIFS/EMOTIF4_14_1-Si-O-O-O-O';
fid=fopen(filename,'rb');
frewind(fid);
fread(fid, 1,  '*int32'); % write()
num_neigh_plus= fread(fid, 1,  '*int32');
rad_box= fread(fid, 1,  '*double');

if(verbose==1)
disp(num_neigh_plus)
disp(rad_box)
end

fread(fid, 1,  '*double'); % write()
AL_mbox_list=fread(fid, 9,  '*double');
AL_mbox=reshape(AL_mbox_list,[3,3]);

if(verbose==1)
disp(AL_mbox)
end

x123_mat=zeros(3,num_neigh_plus);
iat_mat=zeros(1,num_neigh_plus);

for i=1:num_neigh_plus
fread(fid, 1,  '*double'); % write()
iat=fread(fid, 1,  '*int32');
x123=fread(fid, 3,  '*double');
iat_mat(1,i)=iat;
x123_mat(1:3,i)=x123*0.529177+0.5;
if(verbose==1)
disp(iat)
disp(x123_mat(1:3,i))
end
end

fread(fid, 1,  '*double'); % write()
mb=fread(fid, 1,  '*int32');
E123=fread(fid, 3,  '*double');

if(verbose==1)
disp(mb)
disp(E123)
end

edim=2*mb+1;
enum=edim^3;

dens_mat=zeros(edim,edim,edim,3);
fread(fid, 1,  '*single'); % write()
dens_tmp=fread(fid, enum,  '*single'); 
dens_mat(:,:,:,1)=reshape(dens_tmp,[edim,edim,edim]);
dens_tmp=fread(fid, enum,  '*single'); 
dens_mat(:,:,:,2)=reshape(dens_tmp,[edim,edim,edim]);
dens_tmp=fread(fid, enum,  '*single'); 
dens_mat(:,:,:,3)=reshape(dens_tmp,[edim,edim,edim]);

if(verbose==1)
disp(dens_mat(20:23,20:23,20:23,1))
disp(dens_mat(20:23,20:23,20:23,2))
disp(dens_mat(20:23,20:23,20:23,3))
end

fclose(fid);
out.AL=AL_mbox;
out.iat=iat_mat;
out.x123=x123_mat;
out.rho=dens_mat;
out.dim=edim;

lab_cell{num_neigh_plus}='';
for i=1:num_neigh_plus
    lab_cell{i}=atom_num2char(iat_mat(1,i));
end
out.lab=lab_cell;
out.xyz=(out.AL*out.x123)'; % A
end
function chr=atom_num2char(at)
switch at
    case 1
        chr='H';
    case 8
        chr='O';
    case 14
        chr='Si';
    case 79
        chr='Au';
    case 31
        chr='Ga';
    case 33
        chr='As';
    otherwise
        fprintf('at=%d\n',at)
        error('Not expect.')
end
end