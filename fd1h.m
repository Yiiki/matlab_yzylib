function y=fd1h(x)
y=x;
for i=1:length(x)
    y(i)=fermi(0.5,x(i));
end
end