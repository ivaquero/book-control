%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：LQR_UAV_tracking_SS_U
%% 程序功能：无人机上升目标高度最短用时控制-动态规划数值方法 （4.2节案例）
%% 理论基础：贝尔曼最优化理论
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 程序初始化，清空工作空间，缓存
clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%系统初始化%%%%%%%%%%%%%%%%%%%%
% 无人机高度初始化
h_init = 0 ;
% 无人机速度初始化
v_init = 0 ;

%%%%%%%%%%%%%%%%%系统终值定义%%%%%%%%%%%%%%%%%%
% 无人机终点高度
h_final = 10;
% 无人机终点速度
v_final = 0;

%%%%%%%%%%%%%%%%%边界条件定义%%%%%%%%%%%%%%%%%%
% 高度下限
h_min = 0;
% 高度上限
h_max = 10;
% 高度离散数
N_h = 100;
% 速度下限
v_min = 0;
% 速度上限
v_max = 3;
% 速度离散数
N_v = 500;

%%%%%%%%%%%%%%%%%创建离散向量%%%%%%%%%%%%%%%%%%
% 高度向量
Hd = h_min : (h_max - h_min)/N_h: h_max;
% 速度向量
Vd = v_min: (v_max - v_min)/N_v : v_max;

% 无人机加速度上下限设置
u_min = -3; u_max = 2;
% 定义初始剩余代价矩阵
J_costtogo = zeros(N_h + 1, N_v + 1);
% 定义系统输入矩阵
Input_acc = zeros(N_h + 1, N_v + 1);

%%%%%%%%%%%%%%%计算最后一级的情况%%%%%%%%%%%%%%%
% 计算最后一级至上一级间平均速度矩阵
v_avg = 0.5 * (v_final + Vd);
% 计算最后一级至上一级间用时矩阵
T_delta = (h_max - h_min)./(N_h * v_avg);
% 计算最后一级至上一级间加速度矩阵
acc = (v_final - Vd)./T_delta;
% 将用时存入代价矩阵
J_temp = T_delta;
% 筛选超限的系统输入（加速度需满足上下限）
[acc_x,acc_y] = find(acc < u_min | acc > u_max);
% 通过线性检索命令找到加速度超限的位置
Ind_lin_acc = sub2ind (size(acc),acc_x,acc_y);
% 将加速度超限位置的系统代价人为赋值为无穷大
J_temp (Ind_lin_acc) = inf;
% 将更新的代价存入相应的剩余代价矩阵的对应元素的位置
J_costtogo(2,:) = J_temp;
% 将对应的加速度存入系统输入矩阵的相应位置
Input_acc (2,:) = acc;

%%%%%%%%%%%%%%%倒数第二级至第二级的情况%%%%%%%%%%%%%%%
% 设计for循环进行逆向级间的更新 （参考图4.2.7）
for k = 3 : 1 : N_h
% 构建速度方阵，代表相邻两级间速度的所有组合
[Vd_x, Vd_y] = meshgrid(Vd , Vd);
% 计算级间平均速度矩阵
v_avg = 0.5 * (Vd_x + Vd_y);
% 计算级间用时矩阵，这也是级间代价矩阵
T_delta = (h_max - h_min)./(N_h * v_avg);
% 计算级间加速度矩阵
acc = (Vd_y - Vd_x)./T_delta;
% 将级间用时赋值代价矩阵
J_temp = T_delta;
% 筛选超限的系统输入（加速度需满足上下限）
[acc_x, acc_y] = find(acc < u_min | acc > u_max);
% 通过线性检索命令找到加速度超限的位置
Ind_lin_acc = sub2ind (size(acc),acc_x,acc_y);
% 将加速度超限位置的系统代价人为赋值为无穷大
J_temp (Ind_lin_acc) = inf;
%%%%%%%%%%%%%%%%%% 重要的步骤! %%%%%%%%%%%%%%%%%%%
% 生成代价矩阵，注意需要将临时代价与上一步的剩余代价结合
J_temp = J_temp + meshgrid(J_costtogo(k-1,:))';
% 提取剩余代价矩阵的最小值
[J_costtogo(k,:), l] = min(J_temp) ;
% 线性索引找到最小值的位置
Ind_lin_acc = sub2ind (size(J_temp), l, 1:length(l));
% 保存相应的系统输入
Input_acc (k,:) = acc(Ind_lin_acc) ;
end

%%%%%%%%%%%%%%%%第二级至第一级的情况%%%%%%%%%%%%%%%%%
% 计算级间平均速度矩阵
v_avg = 0.5 * (Vd + v_init);
% 计算级间用时矩阵
T_delta = (h_max - h_min)./(N_h * v_avg);
% 计算级间加速度矩阵
acc = (Vd - v_init)./T_delta;
% 级间用时存入临时代价矩阵
J_temp = T_delta;
% 筛选超限的系统输入（加速度需满足上下限）
[acc_x, acc_y] = find(acc < u_min | acc > u_max);
% 通过线性检索命令找到加速度超限的位置
Ind_lin_acc = sub2ind (size(acc),acc_x,acc_y);
% 将加速度超限位置的系统代价人为赋值为无穷大
J_temp (Ind_lin_acc) = inf; % Let certain elements to infitiy
%%%%%%%%%%%%%%%%%% 重要的步骤! %%%%%%%%%%%%%%%%%%%
% 生成代价矩阵，注意需要将临时代价与上一步的剩余代价结合
J_temp = J_temp + J_costtogo(N_h,:);
% 提取剩余代价矩阵的最小值
[J_costtogo(N_h+1,1), l] = min(J_temp);
% 线性索引找到最小值的位置
Ind_lin_acc = sub2ind (size(J_temp), l);
% 保存相应的系统输入
Input_acc (N_h+1,1) = acc(Ind_lin_acc);

%%%%%%%%%%%%%%%%%结果（画图）%%%%%%%%%%%%%%%%%%%%%
% 初始化高度
h_plot_init = 0;
% 初始化速度
v_plot_init = 0;
% 初始化时间
t_plot_init = 0;

% 定义加速度结果维度
acc_plot = zeros(length(Hd),1);
% 定义速度结果维度
v_plot = zeros(length(Hd),1);
% 定义高度结果维度
h_plot = zeros(length(Hd),1);
% 定义时间维度
t_plot  = zeros(length(Hd),1);

% 定义高度初值
h_plot (1) = h_plot_init;
% 定义速度初值
v_plot (1) = v_plot_init;
% 定义时间初值
t_plot (1) = t_plot_init;

%% 查表确定最优路线
for k = 1 : 1 : N_h
% 确认高度最优索引
[min_h,h_plot_index] = min(abs(h_plot(k) - Hd));
% 群人速度最优索引
[min_v,v_plot_index] = min(abs(v_plot(k) - Vd));
% 查表确定最优系统输入位置
acc_index = sub2ind(size(Input_acc), N_h+2-h_plot_index, v_plot_index);
% 将最优系统输入存入表格
acc_plot (k) = Input_acc(acc_index);
% 计算无人机速度
v_plot (k + 1) = sqrt((2 * (h_max - h_min)/N_h * acc_plot(k))+ v_plot (k)^2); % Calculate speed and height
% 计算无人机高度
h_plot (k + 1) = h_plot(k) + (h_max - h_min)/N_h;
% 计算系统相应时刻
t_plot (k + 1) = t_plot (k)+2*(h_plot (k + 1) - h_plot(k))/(v_plot (k + 1) + v_plot (k));
end

%%绘制视图%%
% 绘制速度vs.高度视图
subplot(3,2,1);
plot(v_plot,h_plot,'--o'),grid on;
ylabel('h(m)');
xlabel('v(m/s)');

% 绘制加速度vs.高度视图
subplot(3,2,2);
plot(acc_plot,h_plot,'--o'),grid on;
ylabel('h(m)');
xlabel('a(m/s^2)');

% 绘制速度vs.时间视图
subplot(3,2,3);
plot(t_plot,v_plot,'--o'),grid on;
ylabel('v(m/s)');
xlabel('t(s)');

% 绘制高度vs.时间视图
subplot(3,2,4);
plot(t_plot,h_plot,'--o'),grid on;
ylabel('h(m)');
xlabel('t');

% 绘制加速度vs.时间视图
subplot(3,2,5);
plot(t_plot,acc_plot,'--o'),grid on;
ylabel('a(m/s^2)');
xlabel('t');
