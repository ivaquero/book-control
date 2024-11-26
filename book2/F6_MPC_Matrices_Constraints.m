%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：F6_MPC_Matrices_Constraints %% [F6]约束条件矩阵转换模块
%% 模块功能：生成MPC控制器所需的约束矩阵
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 输入：系统状态上下限x_low,x_high； 输入上下限u_low,u_high； 矩阵Phi，Gamma； 预测区间N_P
%% 输出：含约束二次规划矩阵 M,Beta_bar,b

function  [M,Beta_bar,b]= F6_MPC_Matrices_Constraints(x_low,x_high,u_low,u_high,N_P,Phi,Gamma)
% 计算系统状态维度
n = size (x_low,1);
% 计算系统输入维度
p = size (u_low,1);
% 构建M矩阵，参考式（5.5.14c）
M = [zeros(p,n);zeros(p,n);-eye(n);eye(n)];
% 构建F矩阵，参考式（5.5.14c）
F = [-eye(p);eye(p);zeros(n,p);zeros(n,p)];
% 构建Beta矩阵，参考式（5.5.14c）
Beta = [-u_low; u_high; -x_low; x_high];
% 构建M_N矩阵，参考式（5.5.14c）
M_Np = [-eye(n);eye(n)];
% 构建Beta_N矩阵，参考式（5.5.14c）
Beta_N = [-x_low; x_high];

% 构建M_bar矩阵，参考式（5.5.15b）
M_bar = zeros((2*n+2*p)*N_P+2*n,n);
M_bar (1: (2*n+2*p) , :) = M;
% 构建Beta_bar矩阵，参考式（5.5.15e），模块输出
Beta_bar = [repmat(Beta,N_P,1); Beta_N];

% 初始化M_2bar矩阵
M_2bar = M;
% 初始化F_2bar矩阵
F_2bar = F;

% for循环创建M_2bar和F_2bar矩阵
for i=1:N_P-2
   M_2bar = blkdiag(M_2bar, M);
   F_2bar = blkdiag(F_2bar, F);
end
   M_2bar = blkdiag(M_2bar,M_Np);
% 构建M_2bar矩阵最终形式（加入顶部一行的零矩阵）
   M_2bar = [zeros(2*n+2*p,n*N_P); M_2bar];
   F_2bar = blkdiag(F_2bar, F);
% 构建F_2bar矩阵最终形式（加入底部一行的零矩阵）
   F_2bar = [F_2bar; zeros(2*n,p*N_P)];
% 构建b矩阵，参考式（5.5.9）
   b = -(M_bar + M_2bar*Phi);
% 构建M矩阵，参考式（5.5.9）
   M = M_2bar*Gamma + F_2bar;
end

