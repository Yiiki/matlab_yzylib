function out=readxsf(file_comp)


% clear variables
% close all
% clc

%% define the xsf file
% [filename,pathname] = uigetfile('*.xsf','Select the .XSF file');
% [~,name,ext]=fileparts(file_comp);
% filename=[name,ext];
%% read-in data from the xsf file
fileID = fopen(file_comp,'r');

A = regexp(fileread(file_comp),'\n','split');
end_grid_row = find(contains(A,'END_DATAGRID_3D'));
data_dim_row = find(contains(A,'BEGIN_DATAGRID_3D_XSF_FILE'));

delimiter = ' ';

startRow = data_dim_row+6+1;
endRow = end_grid_row-1;
% formatSpec = '%.12f%.12f%.12f%.12f%.12f%.12f%[^\n\r]'; % old format
formatSpec = '%24.16f%24.16f%24.16f%24.16f%24.16f%24.16f%[^\n\r]'; % new convert_rho.x required June9, 2024
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, ...
    'Delimiter', delimiter, ...
    'MultipleDelimsAsOne', true, ...
    'TextType', 'string', ...
    'HeaderLines', startRow-1, ...
    'ReturnOnError', false, ...
    'EndOfLine', '\r\n');
raw = [dataArray{1:end-1}];
fclose(fileID);

% read-in data from the xsf file
fileID = fopen(file_comp,'r');
data_dim = textscan(fileID,'%.12f %.12f %.12f',1, ...
    'Delimiter', delimiter, ...
    'MultipleDelimsAsOne', true, ...
    'headerlines',data_dim_row);
fclose(fileID);

% clearvars filename delimiter startRow endRow formatSpec fileID dataArray ans;

%% reshape the data

% dimensions of the 3D data grid 
nx=data_dim{1,1};
ny=data_dim{1,2};
nz=data_dim{1,3};

raw0=reshape(raw',[],1);% translate the vector into collumn
raw1=raw0(1:nx*ny*nz);% cut off the NaN values
data=reshape(raw1, [nx,ny,nz]);
fprintf('target dimension is %i\n', nx*ny*nz)
fprintf("reshaped %i x %i array\n",size(raw,1), size(raw,2))


out.raw=raw1;
out.data=data;
out.dim=[nx,ny,nz];

end