% 示例 HEX code（8 字节）
hex_code = '00E0E5970E4EBF3F';
% 'A1FE155A755E173F';
% 将 HEX 字符串转换为字节数组
byte_array = uint8(sscanf(hex_code, '%2x'));

% 将字节数组转换为 real*8 (double)
real_value = typecast(byte_array, 'double');

% 显示结果
disp('Converted real*8 value:');
disp(real_value);
