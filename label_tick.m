function [xtck,xtcg]=label_tick(varargin)
xtck=varargin{1};
fmt=varargin{2};
if(nargin>2)
    fmt2=varargin{3};
    fmt3=varargin{4};
end
xtcg{length(xtck)}='';
for i=1:length(xtck)
    xtcg{i}=sprintf(fmt,xtck(i));
    if(nargin>2)
    if(abs(xtck(i))<1e-12)
    xtcg{i}=fmt2;
    end
    if((xtck(i))>1e-12)
    xtcg{i}=sprintf(fmt3,xtck(i));
    end
    end
end
xtcg=strjust(xtcg,'right');
end