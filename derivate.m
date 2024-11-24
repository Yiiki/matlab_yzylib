function [xou,you]=derivate(xin,yin)
xlis=linspace(min(xin),max(xin),1001);
ylis=interp1(fliplr(xin),fliplr(yin),xlis,'spline');
xout=xlis(2:end-1);
yout=xout;
for i=2:length(xlis)-1
    yout(i-1)=(ylis(i+1)-ylis(i-1))/(xlis(i+1)-xlis(i-1));
end
xou=xin(2:end-1);
you=interp1(xout,yout,xou,"spline");
end