function convert_cell(mat)
a=sqrt(sum(mat(1,:).^2));
b=sqrt(sum(mat(2,:).^2));
c=sqrt(sum(mat(3,:).^2));
alph=acos(mat(2,:)*mat(3,:)'.*(b*c).^-1)*180/pi;
beta=acos(mat(3,:)*mat(1,:)'.*(c*a).^-1)*180/pi;
gama=acos(mat(1,:)*mat(2,:)'.*(a*b).^-1)*180/pi;
abc=[a,b,c];
ang=[alph,beta,gama];
format long
table(abc)
table(ang)
end