%% 程序初始化，清空工作空间，缓存
clear;close all;clc;
%%%%%%%%%%%%%%%%定义系统参数%%%%%%%%%%%%%%%%%%%
% 定义质量块质量
m_sys = 1;
% 定义阻尼系数
b_sys = 0.5;
% 定义弹簧弹性系数
k_sys = 1;

%%%%%%%%%%%%%%%%%系统定义%%%%%%%%%%%%%%%%%%%%%
% 构建系统矩阵A，n x n
A = [0 1; -k_sys / m_sys -b_sys / m_sys];
% 计算A矩阵维度
n = size (A, 1);
% 构建输入矩阵B，n x p
B = [0; 1 / m_sys];
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
Q = [1 0; 0 1];
% 设计终值权重系数矩阵, n x n
S = [1 0; 0 1];
% 设计输入权重系数矩阵, p x p
R = 0.1;

%%%%%%%%%%%%%%%%%系统参考值%%%%%%%%%%%%%%%%%%%%
% 系统状态参考值
xd = [1; 0];
% 构建目标转移矩阵，参考式（4.5.4）
AD = eye(n);

%%%%%%%%%%%%%%%%%系统初始化%%%%%%%%%%%%%%%%%%%%
% 初始化系统状态
x0 = [0; 0];
% 初始化状态赋值
x = x0;
% 系统输入初始化
u0 = 0;
% 初始输入赋值
u = u0;
% 构建初始化增广状态矩阵，参考式（4.5.23）
xa = [x; xd; u];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义系统运行步数
k_steps = 100;
% 定义x_history零矩阵，用于储存系统状态结果，维度n x k_step
x_history = zeros(n, k_steps);
% 定义u_history零矩阵，用于储存系统输入结果，维度p x k_step
u_history = zeros(p, k_steps);

% 定义预测区间，预测区间要小于系统运行步数
N_P = 20;

% 调用模块[F3]，计算Aa，Ba，Qa，Sa，和R
[Aa, Ba, Qa, Sa, R] = f3_lqr_input_augment_matrix_delta_u(A, B, Q, R, S, AD);

% 调用模块[F4]计算二次规划需用到的矩阵
[Phi, Gamma, Omega, Psi, F, H] = f4_mpc_matrices_pm(Aa, Ba, Qa, R, Sa, N_P);

% for循环
for k = 1:k_steps
    % 调用模块[F5]利用二次规划计算无约束系统的控制
    [Delta_U, Delta_u] = f5_mpc_controller(xa, F, H, p)
    % 结合输入增量计算系统输入
    u = Delta_u + u;
    % 系统输入代入系统方程，计算系统响应
    x = A * x + B * u;
    % 更新系统增广状态
    xa = [x; xd; u];
    % 保存系统状态到预先定义矩阵的相应位置
    x_history (:, k + 1) = x;
    % 保存系统输入到预先定义矩阵的相应位置
    u_history (:, k) = u;
end

%%%%%%%%%%%%%%%%%结果%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('position', [150 150 500 500]);
% 状态变量结果图
subplot (2, 1, 1);
hold;
% 系统状态x1结果图，质量块位移
plot (0:length(x_history) - 1, x_history(1, :));
% 系统状态x2结果图，质量块速度
plot (0:length(x_history) - 1, x_history(2, :), '--');
grid on
legend("x1", "x2")
hold off;
xlim([0 k_steps]);
ylim([-0.2 1.2]);

% 系统输入结果图
subplot (2, 1, 2);
% 系统输入结果图，施加在质量块上的力，f
stairs (0:length(u_history) - 1, u_history(1, :));
legend("u")
grid on
xlim([0 k_steps]);
ylim([0 3]);
