%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：KalmanFilter_UAV_ConstantInput
%% 程序功能：线性卡尔曼滤波器案例（6.4.2节，无人机高度预测）
%% 所用模块：
%%      [F8]线性卡尔曼滤波器
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 程序初始化，清空工作空间，缓存，
clear all;
close all;
clc;
% 读取Octave控制数据库（注：如使用Matlab，可删除或注释掉本行代码）
pkg load control;
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%系统定义%%%%%%%%%%%%%%%%%%%%%
% 构建系统矩阵A，n x n
A = [0 1 0; 0 0 1 ;0 0 0];
% 计算A矩阵维度
n = size (A,1);
% 构建输入矩阵B，n x p
B = [0; 1; 0];
% 计算输入矩阵维度
p = size(B,2);
% 定义测量矩阵H_m, n x n
H_m = [1 0 0; 0 1 0; 0 0 1];
% 重力加速度常数
g = 10;

%%%%%%%%%%%%%%%%%%系统离散%%%%%%%%%%%%%%%%%%%%
% 离散时间步长
Ts = 0.1;
% 连续系统转离散系统
sys_d = c2d(ss(A,B),Ts);
% 提取离散系统A矩阵
A = sys_d.a;
% 提取离散系统B矩阵
B = sys_d.b;

%%%%%%%%%%%%%%%%%参数设计%%%%%%%%%%%%%%%%%%%%%
% 定义过程噪声协方差矩阵
Q_c = [0.01 0 0; 0 0.01 0; 0 0 0];
% 定义测量噪声协方差矩阵
R_c = [1 0 0; 0 1 0; 0 0 0];

%%%%%%%%%%%%%%%%%系统初始化%%%%%%%%%%%%%%%%%%%%
% 初始化系统状态
x0 = [0; 1 ; -10];
% 初始化状态赋值
x = x0;
% 系统输入初始化
u0 = g;
% 初始输入赋值
u = u0;
% 初始化后验估计
x_hat0 = [0; 1; -10];
% 初始化后验估计赋值
x_hat = x_hat0;
% 初始化后验估计误差协方差矩阵
P0 = [1 0 0;0 1 0; 0 0 0];
% 初始后验估计误差协方差矩阵赋值
P = P0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义系统运行步数
k_steps = 100;
% 定义x_history零矩阵，用于储存系统状态结果，维度n x k_steps
x_history = zeros(n,k_steps);
% 定义u_history零矩阵，用于储存系统输入结果，维度p x k_steps
u_history = zeros(p,k_steps);
% 定义x_hat_history零矩阵，用于储存后验估计结果，维度n x k_steps
x_hat_history = zeros(n,k_steps);
% 定义x_hat_minus_history零矩阵，用于储存先验估计结果，维度n x k_steps
x_hat_minus_history = zeros(n,k_steps);
% 定义z_historyy零矩阵，用于测量结果，维度n x k_steps
z_history = zeros(n,k_steps);


%%%%%%%%%%%%%%%定义仿真环境%%%%%%%%%%%%%%%%%%%%
% 定义过程噪声矩阵W，维度n x k_steps
w = zeros (n,k_steps);
% 定义测量噪声矩阵V，维度n x k_steps
v = zeros (n,k_steps);
% 从文件NoiseData.csv中读取数据
% 数据来自于系统随机生成，保存为文件可以方便进行多组实验之间的对比
w = csvread('NoiseData.csv')(2:4,:);
v = csvread('NoiseData.csv')(6:8,:);
%%%%%%%%%%%%%生成过程与测量噪声%%%%%%%%%%%%%%%%%%
% 使用以下代码生成随机噪声，之后保存在NoiseData.csv中，方便下次读取。%%%%%%

% 定义真实的过程噪声协方差矩阵
%Q_ca = [0.05 0; 0 0.05];
% 定义真实的测量噪声协方差矩阵
%R_ca = [1 0; 0 1];
% 随机生成过程噪声
%w(1:2,:) = chol(Q_ca)* randn(2,k_steps);
% 随机生成测量噪声
%v(1:2,:) = chol(R_ca)* randn(2,k_steps);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 仿真开始，建立for循环
for k = 1:k_steps
% 系统状态空间方程，计算实际状态变量
    x = A * x + B*u + w(:,k);
% 计算实际测量值，在实际应用中，这一项来自传感器测量
    z = H_m * x + v(:,k);
% 使用卡尔曼滤波器
    [x_hat,x_hat_minus, P]= F8_LinearKalmanFilter(A,B,Q_c,R_c,H_m,z,x_hat,P,u);
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
ylim([-2 12]);
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
