%% 输入：系统矩阵 A，B； 权重矩阵： Q，R，S；  目标转移矩阵： AD
%% 输出：增广矩阵Aa，Ba，Sa，Qa，权重矩阵R
function [Aa, Ba, Qa, Sa, R] = f3_lqr_input_augment_matrix_delta_u(A, B, Q, R, S, AD)

    % 计算系统矩阵维度，n
    n = size(A, 1);
    % 计算输入矩阵维度，p
    p = size(B, 2);
    % 构建增广矩阵Ca
    Ca = [eye(n) -eye(n) zeros(n, p)];
    % 构建增广矩阵Aa
    Aa = [A zeros(n) B; zeros(n) AD zeros(n, p); zeros(p, n) zeros(p, n) eye(p, p)];
    % 构建增广矩阵Ba
    Ba = [B; zeros(n, p); eye(p)];
    % 构建增广矩阵Qa
    Qa = transpose(Ca) * Q * Ca;
    % 构建增广矩阵Sa
    Sa = transpose(Ca) * S * Ca;
end
