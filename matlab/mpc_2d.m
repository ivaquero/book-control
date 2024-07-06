%% 程序初始化，清空工作空间，缓存
clear;close all;clc;
%%%%%%%%%%%%%%%%%系统定义%%%%%%%%%%%%%%%%%%%%%
% 构建系统矩阵A，n x n
A = [1 0.1; 0 -2];
% 计算A矩阵维度
n = size (A, 1);
% 构建输入矩阵B，n x p
B = [0 0.2; -0.1 0.5];
% 构建输出矩阵C，p x n
C = [0 0; 0 0];
% 构建输入矩阵D，p x p
D = [0; 0];
% 计算输入矩阵维度
p = size (B, 2);

%%%%%%%%%%%%%%%%%权重设计%%%%%%%%%%%%%%%%%%%%%
% 设计状态权重系数矩阵, n x n
Q = [1 0; 0 1];
% 设计终值权重系数矩阵, n x n
S = [1 0; 0 1];
% 设计输入权重系数矩阵, p x p
R = [0.1 0; 0 0.1];

%%%%%%%%%%%%%%%%%系统初始化%%%%%%%%%%%%%%%%%%%%
% 状态初值
x_0 = [1; -1];
x = x_0;

%%%%%%%%%%%%%%系统约束定义%%%%%%%%%%%%%%%%%%%%%
% 定义系统状态下限
x_low = [-inf; -inf];
% 定义系统约束上限
x_high = [inf; 0];
% 定义输入下限
u_low = [-inf; -3];
% 定义输入上限
u_high = [inf; inf];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义系统运行步数
k_steps = 10;
% 定义x_history零矩阵，用于储存系统状态结果，维度n x k_steps
x_history = zeros(n, k_steps);
% 初始状态存入状态向量第一个位置
x_history (:, 1) = x;
% 定义u_history零矩阵，用于储存系统输入结果，维度p x k_steps
u_history = zeros(p, k_steps);

% 定义预测区间，预测区间要小于系统运行步数
N_P = 2;

% 调用模块[F4]计算二次规划需用到的矩阵
[Phi, Gamma, Omega, Psi, F, H] = f4_mpc_matrices_pm(A, B, Q, R, S, N_P);

% 调用模块[F6]计算含约束二次规划需用到的矩阵
[M, Beta_bar, b] = f6_mpc_matrices_constraints(x_low, x_high, u_low, u_high, N_P, Phi, Gamma);

% for循环，仿真开始
for k = 1:k_steps
    % 调用模块[F7]计算系统系统控制（输入）
    [U, u] = f7_mpc_controller_constriants(x, F, H, M, Beta_bar, b, p);
    % 系统输入代入系统方程，计算系统响应
    x = A * x + B * u;
    % 保存系统状态到预先定义矩阵的相应位置
    x_history (:, k + 1) = x;
    % 保存系统输入到预先定义矩阵的相应位置
    u_history (:, k) = u;
end

%%%%%%%%%%%%%%%%%结果%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('position', [150 150 500 500]);
% 系统状态结果视图
subplot (2, 1, 1);
hold;
% 系统状态x1
plot (0:length(x_history) - 1, x_history(1, :));
% 系统状态x2
plot (0:length(x_history) - 1, x_history(2, :), '--');
legend('x1', 'x2');
grid on
hold off;
xlim([0 k_steps - 1]);
ylim([-1 1]);
% 系统输入结果视图
subplot (2, 1, 2);
hold;
% 系统输入u1
stairs (0:length(u_history) - 1, u_history(1, :));
% 系统输入u2
stairs (0:length(u_history) - 1, u_history(2, :), '--');
legend('u1', 'u2');
grid on
xlim([0 k_steps - 1]);
ylim([-4 6]);
