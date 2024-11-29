function write_W(r,rho,tag,iatom,rho0,a0)
col=4;
fid=fopen([tag,'_W'],'w');
% frewind(fid)
nrr=length(r);
if(nrr~=length(rho))
    error("not equal length")
end
fprintf(fid,'%d %d %.2f %.2f\n',iatom,nrr,rho0,a0);
fprintf(fid,'<PP_R type="real" size="%d" column="%d">\n',nrr,col);
leftn=mod(nrr,col);
r_mat=reshape(r(1:end-leftn),col,[])';
rho_mat=reshape(rho(1:end-leftn),col,[])';
lines=size(r_mat,1);
for i=1:lines
    fprintf(fid,'%.12e %.12e %.12e %.12e\n',r_mat(i,:)); % col=4, otherwise not
end
if(leftn>0)
    for j=(leftn-1):-1:0
    fprintf(fid,'%.12e ',r(end-j));
    end
    fprintf(fid,'\n');
end
fprintf(fid,'</PP_R>\n');
fprintf(fid,'<PP_RHOATOM type="real" size="%d" column="%d">\n',nrr,col);
for i=1:lines
    fprintf(fid,'%.12e %.12e %.12e %.12e\n',rho_mat(i,:)); % col=4, otherwise not
end
if(leftn>0)
    for j=(leftn-1):-1:0
    fprintf(fid,'%.12e ',rho(end-j));
    end
    fprintf(fid,'\n');
end
fprintf(fid,'</PP_RHOATOM>\n');
fprintf(fid,'</UPF>');
fclose(fid);
end