%% 输入：二次规划矩阵 F，H； 系统控制量维度 p； 系统状态：x 约束条件矩阵 M,Beta_bar,b
%% 输出：系统控制（输入） U，u
function [U, u] = f7_mpc_controller_constriants(x, F, H, M, Beta_bar, b, p)
    % 利用二次规划求解系统控制（输入）
    U = quadprog(H, F * x, M, Beta_bar + b * x, [], [], [], []);
    % 根据模型预测控制的策略，仅选取所得输入的第一项
    u = U(1:p, 1);
end
