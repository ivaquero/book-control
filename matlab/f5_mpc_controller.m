%% 输入：二次规划矩阵 F，H； 系统控制量维度 p； 系统状态：x
%% 输出：系统控制（输入） U，u

function [U, u] = f5_mpc_controller(x, F, H, p)
    % 选取最优化求解模式
    options = optimset('MaxIter', 200);
    % 利用二次规划求解系统控制（输入）
    [U, ~, ~, ~, ~] = quadprog(H, F * x, [], [], [], [], [], [], [], options);
    % 根据模型预测控制的策略，仅选取所得输入的第一项
    u = U(1:p, 1);
end
