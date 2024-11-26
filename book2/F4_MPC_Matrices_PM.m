%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：F4_MPC_Matrices_PM %% [F4]性能指标矩阵转换模块
%% 模块功能：
%%        求解模型预测控制中二次规划所需矩阵F，H
%%        求解模型预测控制一系列中间过程矩阵Phi，Gamma，Omega，Psi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 输入：系统矩阵 A，B； 权重矩阵 Q，R，S； 预测区间：N_P
%% 输出：二次规划矩阵F，H 中间过程矩阵Phi，Gamma，Omega，Psi
function  [Phi,Gamma,Omega,Psi,F,H]= F4_MPC_Matrices_PM(A,B,Q,R,S,N_P)

% 计算系统矩阵维度，n
n = size(A,1);
% 计算输入矩阵维度，p
p = size(B,2);

% 初始化Phi矩阵并定义维度
Phi = zeros(N_P*n,n);
% 初始化Gamma矩阵并定义维度
Gamma = zeros(N_P*n,N_P*p);
% 定义临时对角单位矩阵
tmp = eye(n); % Create a n x n "I" matrix
% 定义for循环行向量
rows = 1:n;
% for循环，用于构建Phi和Gamma矩阵
for i = 1:N_P
% 构建Phi矩阵，参考式（5.3.5b）
    Phi((i-1)*n+1:i*n,:) = A^i;
% 构建Gamma矩阵，参考式（5.3.5b）
    Gamma(rows,:) = [tmp*B,Gamma(max(1,rows-n), 1:end-p)];
% Gamma矩阵行数更新，由于Gamma矩阵是由一系列“小”矩阵组成的，因此下一个循环要更新n行
    rows =i*n+(1:n);
% 构建临时矩阵用于矩阵A的幂计算
    tmp= A*tmp;
end

% 构建Omega矩阵，包含Q矩阵的部分
Omega = kron(eye(N_P-1),Q);
% 构建最终Omega矩阵，包含S矩阵
Omega = blkdiag(Omega,S);
% 构建Psi矩阵，其为R矩阵组成的对角阵
Psi = kron(eye(N_P),R);

% 计算二次规划矩阵F
F = Gamma'*Omega*Phi;
% 计算二次规划矩阵H
H = Psi+Gamma'*Omega*Gamma;

end
