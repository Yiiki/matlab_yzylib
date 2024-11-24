function [x,y]=xsf_plot_cutn3(file,j)
addpath(genpath(pwd));
addpath(genpath('..\local_lib'))

out_wo=readxsf(file);


out_rho=out_wo.data;

n1=out_wo.dim(1);
n2=out_wo.dim(2);
n3=out_wo.dim(3);
len=n1*n2*n3;

id_lis=1:len;
id_cub=reshape(id_lis,[n1,n2,n3]);
out_rho_lis=reshape(out_rho,[len 1]);



pick_id=zeros(n3,1);
for i=1:n3
    % pick_id(i)=id_cub(51,51,i);
    pick_id(i)=id_cub(j,j,i);
end

pick_df_1=out_rho_lis(pick_id);


idx=(1:n3)';


x=idx;
y=pick_df_1;

end