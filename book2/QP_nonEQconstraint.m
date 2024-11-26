%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：QP_nonEQconstraint
%% 程序功能：不等式约束二次规划示例
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 程序初始化，清空工作空间，缓存，
clear all;
close all;
clc;
% 读取Octave优化数据库（注：如使用Matlab，可删除或注释掉本行代码）
pkg load optim;

% 定义二次规划问题的H和f
H = [1 0; 0 1];
f = [1; 1];

% 定义不等式约束的A和b
A = [-1 1; 1 1];
b = [1; 2];

% 定义变量的边界条件
lb = [0; 0];
ub = [1; 2];

% 求解二次规划问题
options = optimset('Display','off');
[u, J] = quadprog(H, f, A, b, [], [], lb, ub, [], options);

% 绘制等高线图和可行域
figure('position',[150 150 800 600]);

% 绘制等高线图
subplot(1,1,1);
[U1, U2] = meshgrid(-1:0.1:2);
J = 0.5*(U1.^2 + U2.^2) + U1 + U2;
contour(U1, U2, J, 60);
hold on;

% 绘制可行域
plot([-0.5, 1], [0.5, 2], 'k', 'LineWidth', 1.5);
hold on;
plot([0, 1.5], [2, 0.5], 'k', 'LineWidth', 1.5);
plot([0, 0], [-1, 2], 'k', 'LineWidth', 1.5);
plot([-0.5, 1.5], [0, 0], 'k', 'LineWidth', 1.5);
plot([1, 1], [-1, 2], 'k', 'LineWidth', 1.5);
fill([0, 0.5, 1], [1, 1.5, 1], 'green', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
fill([0, 0, 1, 1], [0, 1, 1, 0], 'green', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
% 绘制最优解点
plot(u(1), u(2), 'r^', 'MarkerSize', 20,'MarkerFaceColor', 'red');

% 添加坐标轴标签和图标题
xlabel('u1');
ylabel('u2');
xlim([-0.5 1.5]);
ylim([-0.5 2]);


set(gca, 'FontSize', 20);

