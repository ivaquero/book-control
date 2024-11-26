%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：F8_KalmanFilter %% [F8]线性卡尔曼滤波器
%% 模块功能：求解卡尔曼滤波最优估计值
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 输入：系统矩阵 A，B； 协方差矩阵 Q_c，R_c； 测量矩阵 H；
%%     第k-1次的： 测量值 z； 后验估计误差协方差矩阵 P； 后验估计值 x_hat； 输入 u；
%% 输出：第k次的： 后验估计值: x_hat； 后验估计误差协方差矩阵 P;
function [x_hat, x_hat_minus, P]= F8_LinearKalmanFilter(A,B,Q_c,R_c,H,z,x_hat,P,u)
%% 计算先验状态估计
    x_hat_minus = A*x_hat + B*u;
%% 计算先验估计误差协方差矩阵
    P_minus = A*P*transpose(A) + Q_c;
%% 计算卡尔曼增益
    K =  P_minus*transpose(H)/(H*P_minus*transpose(H)+R_c);
%% 更新后验估计
    x_hat = x_hat_minus + K*(z-H*x_hat_minus);
%% 后验估计误差协方差矩阵
    P = (eye(size(A,1)) - K*H)*P_minus;
end
