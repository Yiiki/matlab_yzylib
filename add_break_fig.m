% 定义数据
x1 = linspace(0, 2, 100); % 第一个区间
y1 = sin(x1); % 第一部分曲线

x2 = linspace(4, 6, 100); % 第二个区间
y2 = sin(x2); % 第二部分曲线

% 设置总图像的尺寸 (单位为 cm)
figureWidth = 8.5; % 整个图宽度
figureHeight = 6.5; % 整个图高度

% 设置第一个轴的边距和大小 (单位为 cm)
leftMargin1 = 1;    % 左边距
bottomMargin1 = 1.2; % 下边距
axesWidth1 = 6;      % 轴宽度
axesHeight1 = 4;     % 轴高度

% 转换尺寸为像素（假设屏幕每英寸有 96 像素，1 inch = 2.54 cm）
cmToPixel = @(cm) cm * (96 / 2.54);

% 创建 figure 并设置尺寸
fig = figure('Units', 'pixels', 'Position', [100, 100, cmToPixel(figureWidth), cmToPixel(figureHeight)]);

% 创建主轴并隐藏
mainAx = axes(fig, 'Units', 'pixels', 'Position', ...
              [cmToPixel(leftMargin1), cmToPixel(bottomMargin1), cmToPixel(axesWidth1), cmToPixel(axesHeight1)]);
set(mainAx, 'Visible', 'off'); % 隐藏主轴

% 创建第一个子轴（左部分曲线）
ax1 = axes(fig, 'Units', 'pixels', 'Position', ...
           [cmToPixel(leftMargin1), cmToPixel(bottomMargin1), cmToPixel(axesWidth1 / 2 - 0.5), cmToPixel(axesHeight1)]);
plot(ax1, x1, y1, 'b', 'LineWidth', 2); % 绘制第一条曲线
title(ax1, 'Plot with X-axis Break');
xlabel(ax1, 'x');
ylabel(ax1, 'y');
grid(ax1, 'on');
xlim(ax1, [0, 2]);

% 创建第二个子轴（右部分曲线）
ax2 = axes(fig, 'Units', 'pixels', 'Position', ...
           [cmToPixel(leftMargin1 + axesWidth1 / 2 + 0.5), cmToPixel(bottomMargin1), cmToPixel(axesWidth1 / 2 - 0.5), cmToPixel(axesHeight1)]);
plot(ax2, x2, y2, 'r', 'LineWidth', 2); % 绘制第二条曲线
xlabel(ax2, 'x');
grid(ax2, 'on');
xlim(ax2, [4, 6]);

% 删除右轴和左轴的多余刻度
set(ax1, 'YTickLabel', []);
set(ax2, 'YTickLabel', []);

% 在断点处添加装饰（可选）
annotation(fig, 'line', ...
           [cmToPixel(leftMargin1 + axesWidth1 / 2) / cmToPixel(figureWidth), ...
            cmToPixel(leftMargin1 + axesWidth1 / 2 + 0.5) / cmToPixel(figureWidth)], ...
           [0.5, 0.5], 'LineWidth', 2, 'LineStyle', '--');
