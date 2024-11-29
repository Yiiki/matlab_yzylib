function [x,y]=cub_read_cutn3(out_rho,n1,n2,n3,j)


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