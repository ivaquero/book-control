%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：F2_InputAugmentMatrix_SS_U %% [F2]稳态非零控制矩阵转化模块
%% 模块功能：计算系统增广矩阵Aa，Ba，Qa，Sa，R以及稳态控制输入ud
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 输入：系统矩阵 A，B； 权重矩阵： Q，R，S；  稳态目标状态： xd
%% 输出：增广矩阵Aa，Ba，Sa，Qa，权重矩阵R，稳态控制输入ud
function  [Aa,Ba,Qa,Sa,R,ud] = F2_InputAugmentMatrix_SS_U(A,B,Q,R,S,xd);

% 计算系统矩阵维度，n
n=size(A,1);
% 计算输入矩阵维度，p
p=size(B,2);
% 构建增广矩阵Ca，参考式（4.5.17）
Ca =[eye(n) -eye(n)];
% 构建增广矩阵Aa，参考式（4.5.16b）
Aa = [A eye(n)-A;zeros(n) eye(n)];
% 构建增广矩阵Ba，参考式（4.5.16b）
Ba = [B;zeros(n,p)];
% 构建增广矩阵Qa，参考式（4.5.18）
Qa = transpose(Ca)*Q*Ca;
% 构建增广矩阵Sa，参考式（4.5.18）
Sa = transpose(Ca)*S*Ca;
% 设计权重矩阵R（这里R不变）
R = R;
% 计算稳态控制输入ud
ud = mldivide(B,(eye(n)-A)*xd);
end
