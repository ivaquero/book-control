clc; clear; close all;
% Define IC, h: height, v: velocity
h_init = 0; v_init = 0;
% Final state
h_final = 10; v_final = 0;
% Boundary condition
h_min = 0; h_max = 10; N_h = 10;
v_min = 0; v_max = 3; N_v = 50;
% Create state array
Hd = h_min:(h_max - h_min) / N_h:h_max;
Vd = v_min:(v_max - v_min) / N_v:v_max;
% Input constraint, input is the system acceleration
u_min = -3; u_max = 2;
% Define cost to go matrix
J_costtogo = zeros(N_h + 1, N_v + 1);
% Define input acceleration matrix
Input_acc = zeros(N_h + 1, N_v + 1);

%%%%%%%%%%%%%%%% From 10m to 8m %%%%%%%%%%%%%%%%%
v_avg = 0.5 * (v_final + Vd); % Calculate average speed
T_delta = (h_max - h_min) ./ (N_h * v_avg); % Calculate travel time, this is thecost
acc = (v_final - Vd) ./ T_delta; % Calculate acceleration
J_temp = T_delta; % Assign delta T to cost to go
[acc_x, acc_y] = find(acc < u_min | acc > u_max); % Find which acc is over thelimit
Ind_lin_acc = sub2ind(size(acc), acc_x, acc_y); % Find linear index
J_temp(Ind_lin_acc) = inf; % Let certain elements to infinity
J_costtogo(2, :) = J_temp; % Save to cost to go matrix
Input_acc(2, :) = acc; % Save to acceleration matrix

%%%%%%%%%%%%%%%% From 8m to 2m %%%%%%%%%%%%%%%%%
for k = 3:1:N_h
    [Vd_x, Vd_y] = meshgrid(Vd, Vd); % Prepare the matrix
    v_avg = 0.5 * (Vd_x + Vd_y); % Calculate average time
    T_delta = (h_max - h_min) ./ (N_h * v_avg); % Calculate travel time, this is thecost
    acc = (Vd_y - Vd_x) ./ T_delta; % Calculate acceleration
    J_temp = T_delta; % Assign delta T to cost to go
    [acc_x, acc_y] = find(acc < u_min | acc > u_max); % Find which acc is over thelimit
    Ind_lin_acc = sub2ind(size(acc), acc_x, acc_y); % Find linear index
    J_temp(Ind_lin_acc) = inf; % Let certain elements to infinity

    %%%%%%% Very Important Step! %%%%%%%%%%%%%%%%%%%
    J_temp = J_temp + meshgrid(J_costtogo(k - 1, :))'; % Add last cost to go
    [J_costtogo(k, :), l] = min(J_temp); % Save to cost to go matrix
    Ind_lin_acc = sub2ind(size(J_temp), l, 1:length(l)); % Find linear index
    Input_acc(k, :) = acc(Ind_lin_acc); % Save to acceleration matrix
end

%%%%%%%%%%%%%%%% From 2m to 0m %%%%%%%%%%%%%%%%%
v_avg = 0.5 * (Vd + v_init); % Calculate average time
T_delta = (h_max - h_min) ./ (N_h * v_avg); % Calculate travel time, this is thecost
acc = (Vd - v_init) ./ T_delta; % Calculate acceleration
J_temp = T_delta; % Assign delta T to cost to go
[acc_x, acc_y] = find(acc < u_min | acc > u_max); % Find which acc is over thelimit
Ind_lin_acc = sub2ind(size(acc), acc_x, acc_y); % Fine linear index
J_temp(Ind_lin_acc) = inf; % Let certain elements to infitiy

%%%%%%% Very Important Step! %%%%%%%%%%%%%%%%%%%
J_temp = J_temp + J_costtogo(N_h, :); % Add last cost to go
[J_costtogo(N_h + 1, 1), l] = min(J_temp); % Save to cost to go matrix
Ind_lin_acc = sub2ind(size(J_temp), l); % Find linear index
Input_acc(N_h + 1, 1) = acc(Ind_lin_acc); % Save to acceleration matrix

%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%
h_plot_init = 0; % Initial height
v_plot_init = 0; % Initial velocity
acc_plot = zeros(length(Hd), 1); % Define acc plot array
v_plot = zeros(length(Hd), 1); % Define velocity plot array
h_plot = zeros(length(Hd), 1); % Define height plot array
h_plot(1) = h_plot_init; % First value
v_plot(1) = v_plot_init; % First value

for k = 1:1:N_h
    [min_h, h_plot_index] = min(abs(h_plot(k) - Hd)); % Table look up
    [min_v, v_plot_index] = min(abs(v_plot(k) - Vd)); % Table look up
    acc_index = sub2ind(size(Input_acc), N_h + 2 - h_plot_index, v_plot_index); % Findcontrol input /acceleration
    acc_plot(k) = Input_acc(acc_index); % Save acceleration to the matrix
    v_plot(k + 1) = sqrt((2 * (h_max - h_min) / N_h * acc_plot(k)) + v_plot(k) ^ 2); %Calculate speed and height
    h_plot(k + 1) = h_plot(k) + (h_max - h_min) / N_h;
end

% Plot
subplot(2, 1, 1);
plot(v_plot, h_plot, '--^'), grid on;
ylabel('h(m)');
xlabel('a(m/s^2)');
subplot(2, 1, 2);
plot(acc_plot, h_plot, '^'), grid on;
ylabel('h(m)'); xlabel('v(m/s)');
