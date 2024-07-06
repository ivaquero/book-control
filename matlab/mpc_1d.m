%% 程序初始化，清空工作空间，缓存
clear;close all;clc;
%%%%%%%%%%%%%%%%%系统定义%%%%%%%%%%%%%%%%%%%%%
A = 1;
B = 1;
% 系统状态维度计算
n = size (A, 1);
%
p = size (B, 2);
% 状态代价权重系数
Q = 1;
% 终值代价权重系数
S = 1;
% 系统输入代价权重系数
R = 1;
% 定义系统运行步数
k_steps = 5;

%%%%%%%%%%%%%%%%初始化系统%%%%%%%%%%%%%%%%%%%
% 初始化系统状态矩阵 - 在线
x_history = zeros(n, k_steps);
% 初始化系统状态矩阵 - 离线
x_history_2 = zeros(n, k_steps);
% 初始化系统输入矩阵 - 在线
u_history = zeros(p, k_steps);
% 初始化系统输入矩阵 - 离线
u_history_2 = zeros(p, k_steps);
% 系统状态初始化，第一步
x_0 = 1;
% 系统初始状态赋值 - 在线
x = x_0;
% 系统初始状态赋值 - 离线
x2 = x_0;
% 系统初始状态存入状态矩阵的第一个位置 - 在线
x_history (:, 1) = x;
% 系统初始状态存入状态矩阵的第一个位置 - 离线
x_history_2(:, 1) = x2;

% 定义预测区间，预测区间要小于系统运行步数
N_P = 5; %Predict horizon

% 调用模块[F4]计算二次规划需用到的矩阵
[Phi, Gamma, Omega, Psi, F, H] = f4_mpc_matrices_pm(A, B, Q, R, S, N_P);

% 调用模块[F5]利用二次规划计算无约束系统的控制 - 离线
[U_offline, u_offline] = f5_mpc_controller(x, F, H, p);

for k = 1:k_steps
    % 调用模块[F5]利用二次规划计算无约束系统的控制 - 在线
    [U, u] = f5_mpc_controller(x, F, H, p);
    % 计算系统给响应 - 在线
    x = A * x + B * u;

    if k == 2
        x = x +0.2;
    end

    %% 将在线、离线系统状态以及输入保存进相应的矩阵
    % 保存系统状态 - 在线
    x_history (:, k + 1) = x;
    % 保存系统输入 - 在线
    u_history (:, k) = u;
    % 系统输入赋值 - 离线
    u_offline = U_offline(k);
    % 计算系统给响应 - 离线
    x2 = A * x2 + B * u_offline;

    if k == 2
        x2 = x2 +0.2;
    end

    % 保存系统状态 - 离线
    x_history_2 (:, k + 1) = x2;
    % 保存系统输入 - 离线
    u_history_2 (:, k) = u_offline;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%结果%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 系统状态结果视图 在线vs.离线
subplot (2, 1, 1);
hold;
plot (0:length(x_history) - 1, x_history(1, :));
plot (0:length(x_history_2) - 1, x_history_2(1, :), '--');
grid on
legend("在线   ", "离线    ")
hold off;
xlim([0 k_steps - 1]);
% 系统输入结果视图 在线vs.离线
subplot (2, 1, 2);
hold;
stairs (0:length(u_history) - 1, u_history(1, :));
stairs (0:length(u_history_2) - 1, u_history_2(1, :), '--');
legend("在线     ", "离线     ")
legend('location', 'southeast');
grid on
xlim([0 k_steps - 1]);
