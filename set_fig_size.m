% 定义数据
x = linspace(0, 2*pi, 100); % x 数据
y = sin(x); % 曲线函数

% 设置总图像的尺寸 (单位为 cm)
figureWidth = 8.5; % 整个图宽度
figureHeight = 6.5; % 整个图高度

% 设置轴的边距 (单位为 cm)
leftMargin = 1;    % 左边距
bottomMargin = 1.2; % 下边距
axesWidth = 6;      % 轴宽度
axesHeight = 4;     % 轴高度

% 转换尺寸为像素（假设屏幕每英寸有 96 像素，1 inch = 2.54 cm）
cmToPixel = @(cm) cm * (96 / 2.54);

% 创建 figure 并设置尺寸
fig = figure('Units', 'pixels', 'Position', [100, 100, cmToPixel(figureWidth), cmToPixel(figureHeight)]);

% 创建 axes 并设置位置
ax = axes(fig, 'Units', 'pixels', 'Position', [cmToPixel(leftMargin), cmToPixel(bottomMargin), cmToPixel(axesWidth), cmToPixel(axesHeight)]);

% 绘制曲线
plot(ax, x, y, 'b', 'LineWidth', 2); % 绘制曲线

% 添加标题和标签
title(ax, 'Custom Plot Dimensions');
xlabel(ax, 'x');
ylabel(ax, 'y');

% 设置轴范围
axis(ax, 'tight');
grid(ax, 'on');
