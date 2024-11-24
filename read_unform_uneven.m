function out=read_unform_uneven(filename)

% open the binary
fid = fopen(filename, 'r', 'ieee-le'); % little-Endian format by default
if fid == -1
    error('Fail in openning file: %s', filename);
end

%             dtmp = fread(fid, 20, '*uint8'); % 按字节读取无符号 8 位整数
%             
%             % print data as HEX format
%             disp('Hexadecimal representation:');
%             disp(dec2hex(dtmp)); % 将字节数据转换为十六进制并显示
% 
%             error('stop')

% (n1, n2, n3, nnodest)
fseek(fid, 4, 'cof'); % skip head info
header = fread(fid, 4, 'int32');
n1 = header(1);
n2 = header(2);
n3 = header(3);
nnodest = header(4);
fseek(fid, 4, 'cof'); % skip tail info

% verify ouptut
disp(['n1 = ', num2str(n1)]);
disp(['n2 = ', num2str(n2)]);
disp(['n3 = ', num2str(n3)]);
disp(['nnodest = ', num2str(nnodest)]);

% 3x3 matrix AL
fseek(fid, 4, 'cof'); % skip head
AL_raw = fread(fid, 9, 'float64'); % 9 real*8 vector
AL = reshape(AL_raw, [3, 3])'; % converted as matrix
fseek(fid, 4, 'cof'); % skip tail

% verify AL
disp('AL matrix:');
disp(AL);

% compute bulk size in I-D-E-A-L case
nr = n1 * n2 * n3;
nr_n = nr / nnodest;

% allocate memory
rho = zeros(n1, n2, n3); % initialize rho
fhead=zeros(nnodest); % head-info of bytes of bulk
nrtmp=zeros(nnodest); % actual bulk size!
ftail=zeros(nnodest); % tail-info of bytes of bulk, should be same with head
% stream read unformatted file
for iread = 1:nnodest

%    fseek(fid, 4, 'cof'); % DO NOT SKIP HEAD AS BEFORE ! IT IS IMPORTANT !
     fhead(iread)=fread(fid,1,'int32');
     disp(fhead(iread))
     nrtmp(iread)=fhead(iread)/8;
     vr_tmp = fread(fid, nrtmp(iread), 'float64');
%    fseek(fid, 4, 'cof'); % NEITHER SKIP TAIL ! IT WORKS AS A CHECK !
     ftail(iread)=fread(fid,1,'int32');
     disp(ftail(iread))    
     if(ftail(iread)~=fhead(iread))
         fprintf('iread=%d,fhead=%d,ftail=%d\n',iread,fhead(iread),ftail(iread));
         error('not consistent, check failed')
     end
    % mapping vr_tmp back to rho
    for ii = 1:nr_n
        jj = ii + (iread - 1) * nr_n;
        
        % compute 3D-indices (i, j, k)
        i = floor((jj - 1) / (n2 * n3)) + 1;
        j = floor((jj - 1 - (i - 1) * n2 * n3) / n3) + 1;
        k = jj - (i - 1) * n2 * n3 - (j - 1) * n3;
        
        % filling-up rho
        rho(i, j, k) = vr_tmp(ii);

        % check if falls into 1e-308 and 1e+308 range
        if(abs(rho(i,j,k))<1e-307 && abs(rho(i,j,k))>0)
            fprintf('iread = %d\n',iread);
            fprintf('ii = %d\n',ii);
            fprintf('jj = %d\n',jj);
            fprintf('i,j,k=%d,%d,%d\n',i,j,k);
            fprintf('rho(i,j,k)=%e\n',rho(i,j,k));
            error('1e-308 error met, stop')
        end
        if(abs(rho(i,j,k))>1e+307)
            fprintf('iread = %d\n',iread);
            fprintf('ii = %d\n',ii);
            fprintf('jj = %d\n',jj);
            fprintf('i,j,k=%d,%d,%d\n',i,j,k);
            fprintf('rho(i,j,k)=%e\n',rho(i,j,k));
            error('1e+308 error met, stop')
        end
    end
end

fclose(fid);


% verify output
disp('rho 1st layer (3x3):');
disp(rho(1:3, 1:3, 1));


out.AL=AL;
out.rho=rho;
out.dim=header;

end