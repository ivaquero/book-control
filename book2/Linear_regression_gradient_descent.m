%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：Linear_Regression_gradient_descent.m
%% 程序功能：简单线性回归案例，梯度下降法 （2.4节案例）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 程序初始化，清空工作空间，缓存，
clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义z向量
z = [183; 175; 187; 185; 176; 176; 185; 191; 195; 185; 174; 180; 178; 170; 184];
% 定义x向量
x = [75; 71; 83; 74; 73; 67; 79; 73; 88; 80; 81; 78; 73; 68; 71];
% 扩展x向量
x = [ones(length(x),1) x];
% 定义y向量
y = zeros(2,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 梯度下降法%%%%%%%%%%%%%%
% 定义初始值
y = [120;1];
% 定义学习率
alpha = [0.001 0; 0 0.00001];
% 定义停止条件阈值，用于判断系统是否到达稳态
tol = 1e-4;
% 初始化函数变化
diff = Inf;
% 定义迭代次数
i = 0;
% 定义最大迭代次数，用于限制程序运行时间
max_iter = 100000;

while diff > tol
  % 保存上一次f_y
    f_y_pre = transpose (z)*z -2*transpose (z)*x*y + transpose (y)*transpose (x)*x*y;
  % 更新y
  y = y - alpha* transpose (x) * ( - z + x * y);
  % 计算当前f_y
  f_y = transpose (z)*z -2*transpose (z)*x*y + transpose (y)*transpose (x)*x*y;
  % 计算两次迭代后y的变化
  diff = abs(f_y-f_y_pre);
  % 更新迭代次数
  i = i+1;
    % 如程序超过预设最大迭代步，则报错
    if i > max_iter
         error('Maximum Number of Iterations Exceeded');
    end

end
%%%%%%%%%%%%%%%%%结果%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position',[150 150 1000 400]);
% 定义横坐标
x_draw = 65:0.1:90;
% 散点图
scatter(x(:,2),z, 80,"r");
hold on;
% 线型图
plot (x_draw, y(2)*x_draw+ y(1));
grid on;



