function cpm=cpm_patch(mot,  dft_al, dft_n, xatom)
mot_al3=mot.al;
mot_n3=mot.n;
mot_rho=mot.rho;
mot_at=mot.at;
A_AU=0.52917721067d0; % bohr radius
cpm_rad_box=12*A_AU; % angstrom

rho=zeros(dft_n,1);
ydat=kron(ones(10,1),mot_rho); % rho should be collumn vector
xdat=(1:length(ydat))'-5*mot_n3; % this 10 times expand just to ensure spline work
% since, spline requires at least four points in each dimension

for i=1:dft_n
    r=(i-1)*dft_al/dft_n;
    iflag=0;
    for ii=[-1,0,1]
    dr=r-(ii+xatom)*dft_al;
    if(abs(dr)<=cpm_rad_box)
        iflag=iflag+1;
        if(iflag>1)
            error('no possible enter this code twice, should change to mot_AL < dft_AL, stop\n')
        end
    ri=dr+mot_at*mot_al3;
    zq=ri/mot_al3*mot_n3+1;
    rho(i)=interp1(xdat,ydat,zq,"spline");
    end
    end
end

cpm.rho=rho;
end