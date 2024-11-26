%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：QP_Free
%% 程序功能：无约束二次规划示例
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 程序初始化，清空工作空间，缓存，
clear all;
close all;
clc;

% 定义二次规划问题的H和f
H = [1 0; 0 1];
f = [1; 1];

% 求解二次规划问题
u = -inverse(H)*f;

figure(1, 'position',[150 150 1500 500]);

% 绘制二次规划问题的可行域和最优解点（3D图）
[U1,U2] = meshgrid(-2:0.1:0);
J = 0.5*(U1.^2 + U2.^2)+U1+U2;
subplot(1,2,1);
surf(U1,U2,J,'FaceAlpha', 0.1);
hold on;
plot3(u(1), u(2), 0.5*(u(1)^2 + u(2)^2)+u(1)+u(2), 'r^', 'MarkerSize', 20,'MarkerFaceColor', 'red');
xlabel('u1');
ylabel('u2');
zlabel('J(u1,u2)');
xlim([-2 0]);
ylim([-2 0]);
zlim([-1.05 0]);
set(gca,'FontSize',20);

% 绘制等高线图
subplot(1,2,2);
contour(U1,U2,J,30);
hold on;
plot(u(1), u(2), 'r*', 'MarkerSize', 10);
xlabel('u1');
ylabel('u2');
set(gca,'FontSize',20);
sgtitle('二次规划问题');

