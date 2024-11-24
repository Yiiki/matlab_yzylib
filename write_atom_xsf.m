function write_atom_xsf(filename,AL,xyz,tat)
% filename='missing_tiny_26.config';
% filename='device_large.config';
% out1=read_atom_config_tilt_out(filename);
fid=fopen(filename,'w');
frewind(fid)
% write title
fprintf(fid,'%8s\n%8s\n','CRYSTAL','PRIMVEC');
for i=1:3
    fprintf(fid,'%18.10f%18.10f%18.10f\n',AL(:,i));
end
fprintf(fid,'%10s\n','PRIMCOORD');
fprintf(fid,'%12d%12d\n',size(xyz,1),1);
for i=1:size(xyz,1)
    % xyz_tmp=(AL*xyz(i,:)')';
    xyz_tmp=xyz(i,:);
    fprintf(fid,'%4d%18.10f%18.10f%18.10f\n',tat(i),xyz_tmp);
end
fclose(fid);
end