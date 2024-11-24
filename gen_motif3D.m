function mot=gen_motif3D(dft,  mot_al,    mot_n)
%% input
rho=dft.rho;% length n
al1=dft.al(1,1);% unit : Angstrom
al2=dft.al(2,2);% unit : Angstrom
al3=dft.al(3,3);% unit : Angstrom
n1=dft.n(1);% should be the period n
n2=dft.n(2);% should be the period n
n3=dft.n(3);% should be the period n
xatom=dft.at(1);% fractional
yatom=dft.at(2);% fractional
zatom=dft.at(3);% fractional
A_AU=0.52917721067d0; % bohr radius
cpm_rad_box=12*A_AU; % angstrom
mot_n1=mot_n(1);
mot_n2=mot_n(2);
mot_n3=mot_n(3);
mot_al1=mot_al(1,1);
mot_al2=mot_al(2,2);
mot_al3=mot_al(3,3);
%% output
% mot.rho=mrho;      % length m3
% mot.al=mot_al3;    % latice Angstrom
% mot.n=mot_n3;      % period m3      
% mot.at=0.5;        % locate at center

mrho=zeros(mot_n1,mot_n2,mot_n3);
for k=1:mot_n3
% ------------------------    
    delr3=0.5*mot_al3-(k-1)*mot_al3/mot_n3;
    if(abs(delr3)>cpm_rad_box) 
        continue % only gen motif within cpm_rad_box sphere
    end
 
for j=1:mot_n2
% ------------------------    
    delr2=0.5*mot_al2-(j-1)*mot_al2/mot_n2;
    if(abs(delr2)>cpm_rad_box) 
        continue % only gen motif within cpm_rad_box sphere
    end
  
for i=1:mot_n1
% ------------------------    
    delr1=0.5*mot_al1-(i-1)*mot_al1/mot_n1;
    if(abs(delr1)>cpm_rad_box) 
        continue % only gen motif within cpm_rad_box sphere
    end
    if(sqrt(delr1^2+delr2^2+delr3^2)>cpm_rad_box) 
        continue % only gen motif within cpm_rad_box sphere
    end
% ------------------------    
    ri=zatom*al3-delr3;% xyz-cor of iatom in dft rho
    if(ri>=0)
        rn=fix(ri/al3*n3); % how many fragments of al3/n3 are contained in ri
    else
        rn=fix(ri/al3*n3)-1;
    end
        rx=ri/al3*n3-rn;
    rn=mod(rn,n3)+1;
    id3=rn+[-1,0,1,2];
    id3=mod(id3-1,n3)+1;
    zq=2+rx;  
% ------------------------    
    ri=yatom*al2-delr2;% xyz-cor of iatom in dft rho
    if(ri>=0)
        rn=fix(ri/al2*n2); % how many fragments of al3/n3 are contained in ri
    else
        rn=fix(ri/al2*n2)-1;
    end
        rx=ri/al2*n2-rn;
    rn=mod(rn,n2)+1;
    id2=rn+[-1,0,1,2];
    id2=mod(id2-1,n2)+1;
    yq=2+rx; 
% ------------------------    
    ri=xatom*al1-delr1;% xyz-cor of iatom in dft rho
    if(ri>=0)
        rn=fix(ri/al1*n1); % how many fragments of al3/n3 are contained in ri
    else
        rn=fix(ri/al1*n1)-1;
    end
        rx=ri/al1*n1-rn;
    rn=mod(rn,n1)+1;
    id1=rn+[-1,0,1,2];
    id1=mod(id1-1,n1)+1;
    xq=2+rx;   
% ------------------------   
% Warning!!!! interp3: X=1:n, Y=1:m, Z=1:p, where [m,n,p] = size(V). 
%                      ------------                ---          
% that is to say, x and y dim are swap in V

Vdat=rho(id1,id2,id3);
% --------------method 1 --------------------
% mrho(i,j,k)=interp3(Vdat,yq,xq,zq,'spline');
% --------------method 2 --------------------
mrho(i,j,k)=lww_interp3D(Vdat,n1,n2,n3,1,1,1,xq-2,yq-2,zq-2);    
end
end
end

mot.rho=mrho;      % length m3
mot.al=mot_al;    % latice Angstrom
mot.n=mot_n;      % period m3      
mot.at=[0.5 0.5 0.5];        % locate at center
end