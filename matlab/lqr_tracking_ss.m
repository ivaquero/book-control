%% 程序初始化，清空工作空间，缓存
clear;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 定义系统参数
% 定义无人机质量
m = 1;
% 定义重力加速度常数
g = 10;

%%%%%%%%%%%%%%%%%系统定义%%%%%%%%%%%%%%%%%%%%%
% 构建系统矩阵A，n x n
A = [0 1 0; 0 0 1; 0 0 0];
% 计算A矩阵维度
n = size (A, 1);
% 构建输入矩阵B，n x p
B = [0; 1 / m; 0];
% 构建输出矩阵C，p x n
C = [0 0; 0 0];
% 构建输入矩阵D，p x p
D = [0; 0];
% 计算输入矩阵维度
p = size(B, 2);

%%%%%%%%%%%%%%%%%%系统离散%%%%%%%%%%%%%%%%%%%%
% 离散时间步长
Ts = 0.1;
% 连续系统转离散系统
sys_d = c2d(ss(A, B, C, D), Ts);
% 提取离散系统A矩阵
A = sys_d.a;
% 提取离散系统B矩阵
B = sys_d.b;

%%%%%%%%%%%%%%%%%权重设计%%%%%%%%%%%%%%%%%%%%%
% 设计状态权重系数矩阵, n x n
Q = [1 0 0; 0 1 0; 0 0 0];
% 设计终值权重系数矩阵, n x n
S = [1 0 0; 0 1 0; 0 0 0];
% 设计输入权重系数矩阵, p x p
R = 1;

%%%%%%%%%%%%%%%%%系统参考值%%%%%%%%%%%%%%%%%%%%
% 系统状态参考值
xd = [10; 0; -10];
% 构建目标转移矩阵
AD = eye(n);

%%%%%%%%%%%%%%%%%系统初始化%%%%%%%%%%%%%%%%%%%%
% 初始化系统状态
x0 = [0; 0; -10]; x = x0;
% 初始化增广状态矩阵
xa = [x; xd];
% 初始化系统输入
u0 = 0; u = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义系统运行步数
k_steps = 100;
% 定义x_history零矩阵，用于储存系统状态结果，维度n x k_step
x_history = zeros(n, k_steps);
% 定义u_history零矩阵，用于储存系统输入结果，维度p x k_step
u_history = zeros(p, k_steps);

% 调用模块[F2]，计算系统增广矩阵Aa，Ba，Qa，Sa，R以及目标输入ud
[Aa, Ba, Qa, Sa, R, ud] = F2_InputAugmentMatrix_SS_U(A, B, Q, R, S, xd);

% 调用模块[F1]，计算系统反馈增益，F
[F] = F1_LQR_Gain(Aa, Ba, Qa, R, Sa);

% 仿真开始，建立for循环
for k = 1:k_steps
    % 计算系统输入
    u = -F * (xa) + ud;
    % 系统输入代入系统方程，计算系统响应
    x = A * x + B * u;
    % 更新增广矩阵xa
    xa = [x; xd];
    % 保存系统状态到预先定义矩阵的相应位置
    x_history (:, k + 1) = x;
    % 保存系统输入到预先定义矩阵的相应位置
    u_history (:, k) = u;
end

%%%%%%%%%%%%%%%%%结果%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [150 150 500 500]);
% 状态变量结果图
subplot (2, 1, 1);
hold;
% 无人机高度
plot (0:length(x_history) - 1, x_history(1, :));
% 无人机速度
plot (0:length(x_history) - 1, x_history(2, :), '--');
grid on
legend("x1", "x2")
hold off;
xlim([0 k_steps]);
ylim([0 10.2]);
subplot (2, 1, 2);
hold;
% 系统输入
stairs (0:length(u_history) - 1, u_history(1, :));
legend("u")
grid on
xlim([0 k_steps]);
ylim([0 35]);
