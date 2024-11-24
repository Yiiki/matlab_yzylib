function tmp=skip_write(fid)
tmp = fread(fid, 1,  '*int32');% for the write statement
end
% skip the write statement of unformatted binary file from FORTRAN