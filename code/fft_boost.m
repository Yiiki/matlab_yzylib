function fout=fft_boost(fin,n)
fin1=[fin;fin(1)];% fin : [0,N-1]
ftmp=interpft(fin1,n);
m=length(fin);
dy=(m+1)/(m*n);
x2=0:dy:1;
fout=ftmp(1:length(x2)-1);
end