function dout=doping_Q(x,sts)
kbt=1.380649d-23;
elec_charge=1.6021766208d-19;
temp=sts.temp;
kt1=temp*kbt/elec_charge;
egap1=sts.egap;
nc1=sts.nc;
nv1=sts.nv;
ed1=sts.ed;
ea1=sts.ea;
nd1=sts.nd;
na1=sts.na;
dout= fd1h(-x/kt1)*nc1-fd1h((x-egap1)/kt1)*nv1-0.5d0*(nd1-na1)+ ...
      0.5d0*(nd1*tanh(0.5d0*(ed1-x)/kt1)- ...
      na1*tanh(0.5d0*(x+ea1-egap1)/kt1));
end