%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：QP_EQconstraint
%% 程序功能：等式约束二次规划示例
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 程序初始化，清空工作空间，缓存，
clear all;
close all;
clc;

% 定义二次规划问题的H,f,Meq
H = [1 0; 0 1];
f = [1; 1];
n = size(H,1);
% 定义等式约束的Meq和beq
Meq = [1 -1];
beq =1;
m = size(Meq,1);
% 定义二次规划问题的u和lamda
u = zeros(n,1);
lamda = zeros(m,1);
% 求解二次规划问题
u_lamda = inverse([H,Meq';Meq,zeros(m,m)])*[-f;beq];
u = u_lamda(1:n,:);
figure(1, 'position',[150 150 1500 500]);
% 绘制二次规划问题的可行域和最优解点（3D图）
[U1,U2] = meshgrid(-2:0.1:0);
J = 0.5*(U1.^2 + U2.^2)+U1+U2;
subplot(1,2,1);
surf(U1,U2,J,'FaceAlpha', 0.1);
hold on;
u1_proj = -2:0.1:0;
u2_proj =  u1_proj - 1;
J_proj = 0.5 * (u1_proj .^ 2 + u2_proj .^ 2) + u1_proj + u2_proj;
plot3(u1_proj, u2_proj, J_proj, 'b', 'LineWidth', 5);
plot3(u(1), u(2), 0.5*(u(1)^2 + u(2)^2)+u(1)+u(2), 'r^', 'MarkerSize', 20,'MarkerFaceColor', 'red');
[J_proj, U1_proj] = meshgrid(-1:0.1:0, u1_proj);
U2_proj = U1_proj - 1;
surf(U1_proj, U2_proj, J_proj, 'FaceColor','blue','FaceAlpha', 0.2,'EdgeColor', 'none');

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
u1_con = -2:0.1:2;
u2_con = u1_con - 1;
plot(u1_con, u2_con, 'k', 'LineWidth', 2);
xlabel('u1');
ylabel('u2');
set(gca,'FontSize',20);
sgtitle('二次规划问题');
