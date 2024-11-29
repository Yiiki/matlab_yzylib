function [z,x,val]=xsf_plot_cutatzx(file,yi)
addpath(genpath(pwd));
addpath(genpath('..\local_lib'))

out_wo=readxsf(file);


out_rho=out_wo.data;

n1=out_wo.dim(1);
n2=out_wo.dim(2);
n3=out_wo.dim(3);

n1p=n1+1;
n3p=n3+1;

[x,z]=meshgrid((1:n1),(1:n3));
or=permute(out_rho,[3,1,2]);
val=or(:,:,yi);

end