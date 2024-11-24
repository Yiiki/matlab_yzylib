function out=lap3D(varargin)
data=varargin{1};
bbtv=[1,1,1];
if(nargin>1)
bbtv=varargin{2};
end
% apply stencil to data
stencil(:,:,1)=[...
0,0,0 
0,1,0
0,0,0
];

stencil(:,:,2)=[...
0,1,0 
1,-6,1
0,1,0
];

stencil(:,:,3)=[...
0,0,0 
0,1,0
0,0,0
];

out=data.^0-1;
[n1,n2,n3]=size(data);

for i=1:n1
for j=1:n2
for k=1:n3
ii=mod([i-2,i-1,i],n1)+1;
jj=mod([j-2,j-1,j],n2)+1;
kk=mod([k-2,k-1,k],n3)+1;
data_local=data(ii,jj,kk);
if(bbtv(1)==0 && i==n1)
data_local(3,:,:)=0;
end
if(bbtv(1)==0 && i==1)
data_local(1,:,:)=0;
end

if(bbtv(2)==0 && j==n2)
data_local(:,3,:)=0;
end
if(bbtv(2)==0 && j==1)
data_local(:,1,:)=0;
end

if(bbtv(3)==0 && k==n3)
data_local(:,:,3)=0;
end
if(bbtv(3)==0 && k==1)
data_local(:,:,1)=0;
end

out(i,j,k)=sum(stencil.*data_local,'all');
end
end
end
