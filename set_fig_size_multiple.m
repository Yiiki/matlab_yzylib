% 定义数据
x = linspace(0, 2*pi, 100); % x 数据
y1 = sin(x); % 第一个曲线函数
y2 = cos(x); % 第二个曲线函数

% 设置总图像的尺寸 (单位为 cm)
figureWidth = 8.5; % 整个图宽度
figureHeight = 6.5; % 整个图高度

% 设置第一个轴的边距和大小 (单位为 cm)
leftMargin1 = 1;    % 左边距
bottomMargin1 = 1.2; % 下边距
axesWidth1 = 6;      % 轴宽度
axesHeight1 = 4;     % 轴高度

% 设置第二个轴的边距和大小 (单位为 cm)
leftMargin2 = 1;    % 左边距
bottomMargin2 = 0.5; % 下边距
axesWidth2 = 6;      % 轴宽度
axesHeight2 = 1.5;   % 轴高度

% 转换尺寸为像素（假设屏幕每英寸有 96 像素，1 inch = 2.54 cm）
cmToPixel = @(cm) cm * (96 / 2.54);

% 创建 figure 并设置尺寸
fig = figure('Units', 'pixels', 'Position', [100, 100, cmToPixel(figureWidth), cmToPixel(figureHeight)]);

% 创建第一个轴并设置位置
ax1 = axes(fig, 'Units', 'pixels', 'Position', ...
           [cmToPixel(leftMargin1), cmToPixel(bottomMargin1), cmToPixel(axesWidth1), cmToPixel(axesHeight1)]);

% 绘制第一个曲线
plot(ax1, x, y1, 'b', 'LineWidth', 2); % 绘制第一条曲线
title(ax1, 'First Plot');
xlabel(ax1, 'x');
ylabel(ax1, 'sin(x)');
grid(ax1, 'on');

% 创建第二个轴并设置位置
ax2 = axes(fig, 'Units', 'pixels', 'Position', ...
           [cmToPixel(leftMargin2), cmToPixel(bottomMargin2), cmToPixel(axesWidth2), cmToPixel(axesHeight2)]);

% 绘制第二个曲线
plot(ax2, x, y2, 'r', 'LineWidth', 2); % 绘制第二条曲线
title(ax2, 'Second Plot');
xlabel(ax2, 'x');
ylabel(ax2, 'cos(x)');
grid(ax2, 'on');
