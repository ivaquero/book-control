%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：F3_InputAugmentMatrix_Delta_U %% [F3]输入增量控制矩阵转换模块
%% 模块功能：计算系统增广矩阵Aa，Ba，Qa，Sa，R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 输入：系统矩阵 A，B； 权重矩阵： Q，R，S；  目标转移矩阵： AD
%% 输出：增广矩阵Aa，Ba，Sa，Qa，权重矩阵R
function  [Aa,Ba,Qa,Sa,R] = F3_InputAugmentMatrix_Delta_U(A,B,Q,R,S,AD);

% 计算系统矩阵维度，n
n=size(A,1);
% 计算输入矩阵维度，p
p=size(B,2);
% 构建增广矩阵Ca，参考式（4.5.25）
Ca =[eye(n) -eye(n) zeros(n,p)];
% 构建增广矩阵Aa，参考式（4.5.24b）
Aa = [A zeros(n) B;zeros(n) AD zeros(n,p);zeros(p,n) zeros(p,n) eye(p,p)];
% 构建增广矩阵Ba，参考式（4.5.24b）
Ba = [B;zeros(n,p);eye(p)];
% 构建增广矩阵Qa，参考式（4.5.26）
Qa = transpose(Ca)*Q*Ca;
% 构建增广矩阵Sa，参考式（4.5.26）
Sa = transpose(Ca)*S*Ca;
% 设计权重矩阵R（这里R不变）
R = R;
end
