%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 《控制之美-卷二》 代码
%% 作者：王天威，黄军魁
%% 清华大学出版社
%% 程序名称：System_discretization
%% 程序功能：系统离散化与比较
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 程序初始化，清空工作空间，缓存，
clear all;
close all;
clc;
% 读取Octave控制数据库（注：如使用Matlab，可删除或注释掉本行代码）
pkg load control;
%%%%%%%%%%%%%%%%%%%%%%%%%%
% 构建系统矩阵A
A = [0 1 ; -2 -3];
% 构建输入矩阵B
B = [0 ; 1];
%定义两组采样时间
Ts_1 = 0.2;
Ts_2 = 1;
%根据公式计算；
Fd_1 = expm(A*Ts_1);
Gd_1 = inverse(A)*(Fd_1-eye(size(A,1)))*B;
Fd_2 = expm(A*Ts_2);
Gd_2 = inverse(A)*(Fd_2-eye(size(A,1)))*B;
% 连续系统转离散系统
sys_d_1 = c2d(ss(A,B), Ts_1);
sys_d_2 = c2d(ss(A,B), Ts_2);
% 连续系统的单位阶跃响应
step (ss(A,B),'r');
hold on;
% 两组不同采样时间的离散系统的单位阶跃响应
step (sys_d_1,'b');
step (sys_d_2);
