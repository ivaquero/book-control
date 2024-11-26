  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：Extended_KalmanFilter.m
%% 程序功能：扩展卡尔曼滤波器案例（6.5.2节案例）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 程序初始化，清空工作空间，缓存，
clear all;
close all;
clc;
% 离散时间步长
Ts = 0.01;

%%%%%%%%%%%%%%%%%参数设计%%%%%%%%%%%%%%%%%%%%%
% 定义过程噪声协方差矩阵
Q = [0.01 0; 0 0.01];
% 定义测量噪声协方差矩阵
R_c = [0.1 0; 0 0.1];
% 定义重力加速度
g=10;
% 定义连杆长度
l=0.5;

%%%%%%%%%%%%%%%%%系统初始化%%%%%%%%%%%%%%%%%%%%
% 初始化系统状态
x0 = [pi/4; 0];
% 初始化状态赋值
x = x0;
% 初始化测量值
z0 = [0; 0];
% 初始化测量值赋值
z = z0;
% 初始化先验估计
x_hat_minus0 = [0; 0];
% 初始化先验估计赋值
x_hat_minus = x_hat_minus0;
% 初始化后验估计
x_hat0 = [pi/4; 0];
% 初始化后验估计赋值
x_hat = x_hat0;
% 初始化后验估计误差协方差矩阵
P0 = [1 0;0 1];
% 初始后验估计误差协方差矩阵赋值
P = P0;
% 计算变量维度
n = size (x,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义系统运行步数
k_steps = 200;
% 定义x_history零矩阵，用于储存系统状态结果，维度n x k_steps
x_history = zeros(n,k_steps);
% 定义x_hat_history零矩阵，用于储存后验估计结果，维度n x k_steps
x_hat_history = zeros(n,k_steps);
% 定义x_hat_minus_history零矩阵，用于储存先验估计结果，维度n x k_steps
x_hat_minus_history = zeros(n,k_steps);
% 定义z_history零矩阵，用于测量结果，维度n x k_steps
z_history = zeros(n,k_steps);

%%%%%%%%%%%%%生成过程与测量噪声%%%%%%%%%%%%%%%%%%
Q_a = [0.01 0; 0 0.01];
% 定义真实的测量噪声协方差矩阵
R_a = [0.1 0; 0 0.1];
% 随机生成过程噪声
w = chol(Q_a)* randn(2,k_steps);
% 随机生成测量噪声
v = sqrt(R_a)* randn(2,k_steps);

%% Kalman Filter

for k = 1:k_steps
    % 系统状态空间方程，计算实际状态变量x1
    x(1) = x(1) + x(2)*Ts + w(1,k);
    % 系统状态空间方程，计算实际状态变量x2
    x(2) = x(2) - g/l*sin(x(1))*Ts + w(2,k);
    % 计算实际测量值，在实际应用中，这一项来自传感器测量
    z(1) = x(1) + v(1,k);
    z(2) = x(2) + v(2,k);

    %%%%%%%%%%%%%%%%%%扩展卡尔曼滤波器%%%%%%%%%%%%%%%%%
    % 计算先验状态估计
    x_hat_minus(1) = x_hat(1) + x_hat(2)*Ts;
    x_hat_minus(2) = x_hat(2) -g/l*sin(x_hat(1))*Ts;
    % 计算更新雅可比矩阵
    A = [1 Ts ; -g/l*cos(x_hat(1))*Ts,1];
    W = [1 0; 0 1];
    H_m = [1 0; 0 1];
    V = [1 0; 0 1];
    %% 计算先验估计误差协方差矩阵
    P_minus = A*P*transpose(A) + transpose(W)*Q*W;
    %% 计算卡尔曼增益
    K =  P_minus*transpose(H_m)/(H_m*P_minus*transpose(H_m)+ V *R_c*transpose(V) );
    %% 更新后验估计
    x_hat = x_hat_minus + K*(z-x_hat_minus);
    %% 后验估计误差协方差矩阵
    P = (eye(n)- K*H_m)*P_minus;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % 保存系统状态到预先定义矩阵的相应位置
    x_history (:,k+1) =  x;
    % 保存测量值到预先定义矩阵的相应位置
    z_history (:,k+1) =  z;
    % 保存先验估计到预先定义矩阵的相应位置
    x_hat_minus_history (:,k+1) = x_hat_minus;
    % 保存后验估计到预先定义矩阵的相应位置
    x_hat_history (:,k+1) = x_hat;
end


%%%%%%%%%%%%%%%%%结果%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position',[150 150 1500 500]);
% x1真实结果
plot (0:length(x_history)-1,x_history(1,:),'--','LineWidth',2);
hold on
% x1测量值
plot ( 0:length(z_history)-1,z_history(1,:),'*','MarkerSize',8)
ylim([-3 3]);
% x1先验估计值
plot (0:length(x_hat_minus_history)-1,x_hat_minus_history(1,:),'o','MarkerSize',8);
% x1后验估计值
plot ( 0:length(x_hat_history)-1,x_hat_history(1,:),'LineWidth',2);
legend(' 真实值 ',' 测量值 ',' 先验估计值 ',' 后验估计值 ')
set(legend, 'Location', 'southeast','FontSize', 20);
hold off;
grid on
% 计算Ems 均方误差
Ems= (x_hat_history(1,:)-x_history(1,:))*(x_hat_history(1,:)-x_history(1,:))'/k_steps


