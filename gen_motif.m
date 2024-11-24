function mot=gen_motif(dft,  mot_al3,    mot_n3)
%% input
rho=dft.rho;% length n
al3=dft.al;% unit : Angstrom
n3=dft.n;% should be the period n
zatom=dft.at;% fractional
A_AU=0.52917721067d0; % bohr radius
cpm_rad_box=12*A_AU; % angstrom
%% output
% mot.rho=mrho;      % length m3
% mot.al=mot_al3;    % latice Angstrom
% mot.n=mot_n3;      % period m3      
% mot.at=0.5;        % locate at center

mrho=zeros(mot_n3,1);
ydat=kron(ones(10,1),rho); % rho should be collumn vector
xdat=(1:length(ydat))'-5*n3; % this 10 times expand just to ensure spline work
% since, spline requires at least four points in each dimension

for i=1:mot_n3
    delr=0.5*mot_al3-(i-1)*mot_al3/mot_n3;
    if(abs(delr)<=cpm_rad_box) % only gen motif within cpm_rad_box sphere
    ri=zatom*al3-delr;% xyz-cor of iatom in dft rho
    if(ri>=0)
        rn=fix(ri/al3*n3); % how many fragments of al3/n3 are contained in ri
        rx=ri/al3*n3-rn;
    else
        rn=fix(ri/al3*n3)-1;
        rx=ri/al3*n3-rn;
    end
    rn=mod(rn,n3)+1;
    zq=rn+rx;
    mrho(i)=interp1(xdat,ydat,zq,'spline');
    end
end

mot.rho=mrho;      % length m3
mot.al=mot_al3;    % latice Angstrom
mot.n=mot_n3;      % period m3      
mot.at=0.5;        % locate at center
end