%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：MPC_UAV
%% 程序功能：无人机高度速度模型预测控制（5.6.1节案例）
%% 所用模块：
%%        [F2]稳态非零控制矩阵转化模块
%%        [F4]性能指标矩阵转换模块
%%        [F6]约束条件矩阵转换模块
%%        [F7]含约束二次规划求解模块
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 程序初始化，清空工作空间，缓存，
clear all;
close all;
clc;
% 读取Octave控制数据库（注：如使用Matlab，可删除或注释掉本行代码）
pkg load control;
% 读取Octave优化求解器数据库（注：如使用Matlab，可删除或注释掉本行代码）
pkg load optim;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 定义系统参数
% 定义无人机质量
m = 1;
% 定义重力加速度常数
g = 10;

%%%%%%%%%%%%%%%%%系统定义%%%%%%%%%%%%%%%%%%%%%
% 构建系统矩阵A，n x n
A = [0 1 0; 0 0 1 ;0 0 0];
% 计算A矩阵维度
n= size (A,1);
% 构建输入矩阵B，n x p
B = [0; 1/m; 0];
% 计算输入矩阵维度
p = size(B,2);

%%%%%%%%%%%%%%%%%%系统离散%%%%%%%%%%%%%%%%%%%%
% 离散时间步长
Ts = 0.1;
% 连续系统转离散系统
sys_d = c2d(ss(A,B),Ts);
% 提取离散系统A矩阵
A = sys_d.a;
% 提取离散系统B矩阵
B = sys_d.b;

%%%%%%%%%%%%%%%%%权重设计%%%%%%%%%%%%%%%%%%%%%
% 设计状态权重系数矩阵, n x n
Q=[1 0 0; 0 1 0; 0 0 0];
% 设计终值权重系数矩阵, n x n
S=[1 0 0; 0 1 0; 0 0 0];
% 设计输入权重系数矩阵, p x p
R= 0.1;

%%%%%%%%%%%%%%%%%系统参考值%%%%%%%%%%%%%%%%%%%%
% 系统状态参考值
xd = [10 ; 0 ; -g];
% 构建目标转移矩阵
AD = eye(n);
% 计算目标输入
ud = mldivide(B,(eye(n)-A)*xd);

%%%%%%%%%%%%%%%%%系统初始化%%%%%%%%%%%%%%%%%%%%
% 初始化系统状态
x0 = [0; 0; -g ]; x = x0;
% 初始化增广状态矩阵
xa = [x; xd];
% 初始化系统输入
u0 = 0; u = u0;

%%%%%%%%%%%%%%系统约束定义%%%%%%%%%%%%%%%%%%%%%
% 输入下限
u_low = -3;
% 输入上限
u_high = 2;
% 状态下限
x_low = [0;0;-g];
% 状态上限
x_high = [10;3;-g];
% 增广状态下限
xa_low = [x_low;-inf;-inf;-inf];
% 增广状态上限
xa_high = [x_high;inf;inf;inf];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义系统运行步数
k_steps = 100;
% 定义x_history零矩阵，用于储存系统状态结果，维度n x k_step
x_history = zeros(n,k_steps);
% 定义u_history零矩阵，用于储存系统输入结果，维度p x k_step
u_history = zeros(p,k_steps);

% 定义预测区间
N_P = 20;

% 调用模块[F2]，计算系统增广矩阵Aa，Ba，Qa，Sa，R以及目标输入ud
[Aa,Ba,Qa,Sa,R,ud] = F2_InputAugmentMatrix_SS_U(A,B,Q,R,S,xd);

% 调用模块[F4]计算二次规划需用到的矩阵
[Phi,Gamma,Omega,Psi,F,H]= F4_MPC_Matrices_PM(Aa,Ba,Qa,R,Sa,N_P);

% 调用模块[F6]计算含约束二次规划需用到的矩阵
[M,Beta_bar,b]= F6_MPC_Matrices_Constraints(xa_low,xa_high,u_low,u_high,N_P,Phi,Gamma);

% for循环开始仿真
for k = 1 : k_steps
% 调用模块[F7]计算系统系统控制（输入增量）
[delta_U, delta_u]= F7_MPC_Controller_withConstriants(xa,F,H,M,Beta_bar,b,p);
% 根据输入增量计算系统输入
u = delta_u+ud;
% 系统输入代入系统方程，计算系统响应
x = A * x + B * u;
% 更新增广矩阵xa
xa = [x; xd];
% 保存系统状态到预先定义矩阵的相应位置
x_history (:,k+1) =  x;
% 保存系统输入到预先定义矩阵的相应位置
u_history (:,k) = u ;
end

%%%%%%%%%%%%%%%%%结果%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position',[150 150 500 500]);
% 状态变量结果图
subplot  (2, 1, 1);
hold;
% 无人机高度
plot (0:length(x_history)-1,x_history(1,:));
% 无人机速度
plot (0:length(x_history)-1,x_history(2,:),'--');
grid on
legend("x1","x2")
hold off;
xlim([0 k_steps]);
ylim([0 10.2]);
% 系统输入
subplot (2, 1, 2);
hold;
stairs (0:length(u_history)-1,u_history(1,:));
legend("u")
grid on
xlim([0 k_steps]);
ylim([7 12]);

