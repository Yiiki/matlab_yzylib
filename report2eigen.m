function data=report2eigen(report_file)
keywords='eigen energies, in eV';
endofdat='*********************************';
% fid=fopen('..\atom_frag\cSi_aSiO2_slab\REPORT_NONSCF','r');
fid=fopen(report_file,'r');
while ~feof(fid)
    lines=fgetl(fid);
    if contains(lines,'NUM_BAND')
        num_band=sscanf(lines,'%d');
    end
    if contains(lines,keywords)
        fprintf('%s\n',lines);
% find eigen energies
lines=fgetl(fid);
data=zeros(num_band,1);
ptr=0;
while ~contains(lines,endofdat)
    tmp=sscanf(lines,'%f');
    id1=ptr+1;id2=ptr+length(tmp);
    if(id2>num_band)
        error('please check or cheat it.\n')
    end
    data(id1:id2)=tmp;
    ptr=ptr+length(tmp);
    lines=fgetl(fid);
end        
% end of code block         
        break
    end
end
end