function out=read_part_dos(filename)
fid=fopen(filename,"r");
frewind(fid);

% read the 1st line title info
str=fgetl(fid); % input
splitArray = strsplit(str); % split by space
splitArray = splitArray(~cellfun('isempty',splitArray)); % remove space
disp(splitArray); % output

% read the followed data
num_orbt=length(splitArray)-2;
data=[];

while ~feof(fid)
tline=fgetl(fid);
datav=sscanf(tline,'%f');
data=[data,datav];
end

out.eng=data(1,:)';
out.dos=data(2,:)';
out.pts=size(data,2);
out.num=size(data,1)-2;
out.nam=splitArray;
out.obt=data(3:end,:)';

fclose(fid);