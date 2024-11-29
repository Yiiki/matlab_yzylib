function [x,y]=interp1xy(x1,y1,n)
x=linspace(x1(1),x1(end),n)';
y=interp1(x1,y1,x);
end