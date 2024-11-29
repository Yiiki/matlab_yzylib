function cpm=cpm_patch3D(mot,  dft_al, dft_n, xyzatom)
dft_al1=dft_al(1,1);
dft_al2=dft_al(2,2);
dft_al3=dft_al(3,3);
dft_n1=dft_n(1);
dft_n2=dft_n(2);
dft_n3=dft_n(3);
mot_al1=mot.al(1,1);
mot_al2=mot.al(2,2);
mot_al3=mot.al(3,3);
mot_n1=mot.n(1);
mot_n2=mot.n(2);
mot_n3=mot.n(3);
mot_rho=mot.rho;
mot_at=mot.at;
A_AU=0.52917721067d0; % bohr radius
cpm_rad_box=12*A_AU; % angstrom
xatom=xyzatom(1);
yatom=xyzatom(2);
zatom=xyzatom(3);
rho=zeros(dft_n);
for k=1:dft_n3
    rk=(k-1)*dft_al3/dft_n3;
    
for j=1:dft_n2
    rj=(j-1)*dft_al2/dft_n2;
    
for i=1:dft_n1
    ri=(i-1)*dft_al1/dft_n1;
    iflag=0;
    for kk=[-1,0,1]
    dr3=rk-(kk+zatom)*dft_al3;
    if(abs(dr3)>cpm_rad_box)
        continue
    end
        for jj=[-1,0,1]
    dr2=rj-(jj+yatom)*dft_al2;
    if(abs(dr2)>cpm_rad_box)
        continue
    end
            for ii=[-1,0,1]
    dr1=ri-(ii+xatom)*dft_al1;
    if(abs(dr1)>cpm_rad_box)
        continue
    end
    if(sqrt(dr1^2+dr2^2+dr3^2)>cpm_rad_box)
        continue
    end
        iflag=iflag+1;
        if(iflag>1)
            error('no possible enter this code twice, should change to mot_AL < dft_AL, stop\n')
        end
        %if(iflag==1)
        %    fprintf('got iflag=%d\n',iflag)
        %end
        ri1=dr1+mot_at(1)*mot_al1;% get the r in motif box
        ri2=dr2+mot_at(2)*mot_al2;% get the r in motif box
        ri3=dr3+mot_at(3)*mot_al3;% get the r in motif box
        if(ri1<0 || ri2<0 || ri3<0 || ri1>mot_al1 || ri2>mot_al2 || ri3>mot_al3)
            error('ri cannot fall out of motif box, stop')
        end
        rn1=fix(ri1/mot_al1*mot_n1);
        rn2=fix(ri2/mot_al2*mot_n2);
        rn3=fix(ri3/mot_al3*mot_n3);
        id1=mod(rn1+[0,1,2,3]-1,mot_n1)+1;
        id2=mod(rn2+[0,1,2,3]-1,mot_n2)+1;
        id3=mod(rn3+[0,1,2,3]-1,mot_n3)+1;
        xq=ri1/mot_al1*mot_n1-rn1+2;
        yq=ri2/mot_al2*mot_n2-rn2+2;
        zq=ri3/mot_al3*mot_n3-rn3+2;
            end
        end
    end
    if(iflag==1)
    Vdat=mot_rho(id1,id2,id3);
    % --------------method 1 --------------------
    % rho(i,j,k)=interp3(Vdat,yq,xq,zq,"spline");
    % --------------method 2 --------------------
    rho(i,j,k)=lww_interp3D(Vdat,mot_n1,mot_n2,mot_n3,1,1,1,xq-2,yq-2,zq-2);    
    end
end
end
end
cpm.rho=rho;
end