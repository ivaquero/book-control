%% 输入：系统矩阵 A，B； 权重矩阵： Q，R，S；  稳态目标状态： xd
%% 输出：增广矩阵Aa，Ba，Sa，Qa，权重矩阵R，稳态控制输入ud

function [Aa, Ba, Qa, Sa, R, ud] = f2_input_augment_matrix_ss_u(A, B, Q, R, S, xd)

    % 计算系统矩阵维度，n
    n = size(A, 1);
    % 计算输入矩阵维度，p
    p = size(B, 2);
    % 构建增广矩阵Ca
    Ca = [eye(n) -eye(n)];
    % 构建增广矩阵Aa
    Aa = [A eye(n) - A; zeros(n) eye(n)];
    % 构建增广矩阵Ba
    Ba = [B; zeros(n, p)];
    % 构建增广矩阵Qa
    Qa = transpose(Ca) * Q * Ca;
    % 构建增广矩阵Sa
    Sa = transpose(Ca) * S * Ca;
    % 设计权重矩阵R（这里R不变）
    % R = R;
    % 计算稳态控制输入ud
    ud = mldivide(B, (eye(n) - A) * xd);
end
