function write_atom_cfg(filename,AL,xyz,tat)
fid=fopen(filename,"w");
natom=size(xyz,1);
fprintf(fid,'%18d\n',natom);
fprintf(fid,'%s\n','Lattice vector');
for i=1:3
    fprintf(fid,'%18.10f%18.10f%18.10f\n',AL(:,i));
end
fprintf(fid,'%s\n','Position move_x, move_y, move_z');
for i=1:natom
    % xyz_tmp=(AL*xyz(i,:)')';
    xyz_tmp=xyz(i,:);
    fprintf(fid,'%4d%18.10f%18.10f%18.10f%4d%4d%4d\n',tat(i),xyz_tmp,1,1,1);
end
fclose(fid);
end