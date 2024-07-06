%% 输入：系统矩阵 A，B； 权重矩阵 Q，R，S
%% 输出：反馈增益矩阵F

function [F] = f1_lqr_gain(A, B, Q, R, S)

    % 计算系统矩阵维度，n
    n = size(A, 1);
    % 计算输入矩阵维度，p
    % p = size(B, 2);
    % 系统终值代价权重矩阵，定义为P0
    P0 = S;
    % 定义最大迭代次数，用于限制程序运行时间
    max_iter = 200;
    % 初始化矩阵P为0矩阵，后续用于存放计算得到的一系列矩阵P[k]
    P = zeros(n, n * max_iter);
    % 初始化矩阵P的第一个位置为P0
    P(:, 1:n) = P0;
    % 定义P[k-1]的初值为P0，即当k=1时，参考式（4.4.23）与（4.4.24）
    P_k_min_1 = P0;
    % 定义系统稳态误差阈值，用于判断系统是否到达稳态
    tol = 1e-3;
    % 初始化系统误差为无穷
    diff = Inf;
    % 初始化系统反馈增益为无穷
    F_N_min_k = Inf;
    % 初始化系统迭代步
    k = 1;

    % 判断系统是否达到稳态，即相邻步的增益差是否小于预设阈值，如达到稳态跳出while循环
    while diff > tol
        % 将系统增益F[N-k]赋值给Fpre[N-k]，此步骤用于判断系统是否达到稳态
        F_N_min_k_pre = F_N_min_k;
        % 计算F[N-k],参考式（4.4.23b）
        F_N_min_k = (R + B' * P_k_min_1 * B) \ B' * P_k_min_1 * A;
        % 计算P[k]，参考式（4.4.24b）
        P_k = (A - B * F_N_min_k)' * P_k_min_1 * (A - B * F_N_min_k) + (F_N_min_k)' * R * (F_N_min_k) + Q;
        % 将P[k]矩阵存入P矩阵的相应位置
        P(:, n * k - n + 1:n * k) = P_k;
        % 更新P[k-1],用于下一次迭代
        P_k_min_1 = P_k;
        % 计算系统相邻步增益差值
        diff = abs(max(F_N_min_k - F_N_min_k_pre));
        % 迭代步加 1
        k = k + 1;
        % 如程序超过预设最大迭代步，则报错
        if k > max_iter
            error('Maximum Number of Iterations Exceeded');
        end

    end

    % 输出系统迭代步
    fprintf('No. of Interation is %d \n', k);
    % 模块输出：系统增益F
    F = F_N_min_k;
end
