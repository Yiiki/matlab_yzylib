function vr00=lww_interp3D(vr,n1,n2,n3,i0,j0,k0,xi0,xj0,xk0)
sft=2;
v=zeros(4,4,4)*NaN;v1=zeros(4,4);v2=zeros(4,1);
for it=-1:2
    for jt=-1:2
        for kt=-1:2
            it2=mod(it+i0+n1,n1)+1;
            jt2=mod(jt+j0+n2,n2)+1;
            kt2=mod(kt+k0+n3,n3)+1;
            v(sft+it,sft+jt,sft+kt)=vr(it2,jt2,kt2);
        end
    end
end
for it=-1:2
    for jt=-1:2
        v1(sft+it,sft+jt)=v(sft+it,sft+jt,sft+0)+(6*v(sft+it,sft+jt,sft+1)-2*v(sft+it,sft+jt,sft+-1)-   ...
             v(sft+it,sft+jt,sft+2)-3*v(sft+it,sft+jt,sft+0))/6*xk0 ...
          +(v(sft+it,sft+jt,sft+1)+v(sft+it,sft+jt,sft+-1)-2*v(sft+it,sft+jt,sft+0))/2*xk0.^2 ...
          +(v(sft+it,sft+jt,sft+2)+3*v(sft+it,sft+jt,sft+0)-3*v(sft+it,sft+jt,sft+1) ...
          -v(sft+it,sft+jt,sft+-1))/6*xk0.^3;
    end
end
for it=-1:2
    v2(sft+it)=v1(sft+it,sft+0)+(6*v1(sft+it,sft+1)-2*v1(sft+it,sft+-1)-  ...
          v1(sft+it,sft+2)-3*v1(sft+it,sft+0))/6*xj0 ...
      +(v1(sft+it,sft+1)+v1(sft+it,sft+-1)-2*v1(sft+it,sft+0))/2*xj0.^2 ...
      +(v1(sft+it,sft+2)+3*v1(sft+it,sft+0)-3*v1(sft+it,sft+1) ...
      -v1(sft+it,sft+-1))/6*xj0.^3;
end
v3=v2(sft+0)+(6*v2(sft+1)-2*v2(sft+-1)-v2(sft+2)-3*v2(sft+0))/6*xi0  ...
  +(v2(sft+1)+v2(sft+-1)-2*v2(sft+0))/2*xi0.^2 ...
  +(v2(sft+2)+3*v2(sft+0)-3*v2(sft+1)-v2(sft+-1))/6*xi0.^3;

vr00=v3;
end
