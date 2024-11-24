% 示例 HEX code (4 字节)
hex_code ='287E2D00';
% 'FFFFFFFF'; % 示例：-1 的 int32 表示

% 将 HEX 字符串转换为 uint8 字节数组
byte_array = uint8(sscanf(hex_code, '%2x'));

% 将字节数组转换为 int32
int_value = typecast(byte_array, 'int32');

% 显示结果
disp('Converted int32 value:');
disp(int_value);
