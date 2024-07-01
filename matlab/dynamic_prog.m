clear; close all;clc;
% Define, h: height, v: velocity
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
input_acc = zeros(N_h + 1, N_v + 1);

%%%%%%%%%%%%%%%% From 10m to 8m %%%%%%%%%%%%%%%%%
% Calculate average speed
v_avg = 0.5 * (v_final + Vd);
% Calculate travel time, this is the cost
T_delta = (h_max - h_min) ./ (N_h * v_avg);
% Calculate acceleration
acc = (v_final - Vd) ./ T_delta;
% Assign delta T to cost to go
J_temp = T_delta;
% Find which acc is over the limit
[acc_x, acc_y] = find(acc < u_min | acc > u_max);
% Find linear index
ind_lin_acc = sub2ind(size(acc), acc_x, acc_y);
% Let certain elements to infinity
J_temp(ind_lin_acc) = inf;
% Save to cost to go matrix
J_costtogo(2, :) = J_temp;
% Save to acceleration matrix
input_acc(2, :) = acc;

%%%%%%%%%%%%%%%% From 8m to 2m %%%%%%%%%%%%%%%%%
for k = 3:1:N_h
    % Prepare the matrix
    [Vd_x, Vd_y] = meshgrid(Vd, Vd);
    % Calculate average time
    v_avg = 0.5 * (Vd_x + Vd_y);
    % Calculate travel time, this is thecost
    T_delta = (h_max - h_min) ./ (N_h * v_avg);
    % Calculate acceleration
    acc = (Vd_y - Vd_x) ./ T_delta;
    % Assign delta T to cost to go
    J_temp = T_delta;
    % Find which acc is over thelimit
    [acc_x, acc_y] = find(acc < u_min | acc > u_max);
    % Find linear index
    ind_lin_acc = sub2ind(size(acc), acc_x, acc_y);
    % Let certain elements to infinity
    J_temp(ind_lin_acc) = inf;

    %%%%%%% Very Important Step! %%%%%%%%%%%%%%%%%%%
    % Add last cost to go
    J_temp = J_temp + meshgrid(J_costtogo(k - 1, :))';
    % Save to cost to go matrix
    [J_costtogo(k, :), l] = min(J_temp);
    % Find linear index
    ind_lin_acc = sub2ind(size(J_temp), l, 1:length(l));
    % Save to acceleration matrix
    input_acc(k, :) = acc(ind_lin_acc);
end

%%%%%%%%%%%%%%%% From 2m to 0m %%%%%%%%%%%%%%%%%
% Calculate average time
v_avg = 0.5 * (Vd + v_init);
% Calculate travel time, this is thecost
T_delta = (h_max - h_min) ./ (N_h * v_avg);
% Calculate acceleration
acc = (Vd - v_init) ./ T_delta;
% Assign delta T to cost to go
J_temp = T_delta;
% Find which acc is over thelimit
[acc_x, acc_y] = find(acc < u_min | acc > u_max);
% Fine linear index
ind_lin_acc = sub2ind(size(acc), acc_x, acc_y);
% Let certain elements to infitiy
J_temp(ind_lin_acc) = inf;

%%%%%%% Very Important Step! %%%%%%%%%%%%%%%%%%%
% Add last cost to go
J_temp = J_temp + J_costtogo(N_h, :);
% Save to cost to go matrix
[J_costtogo(N_h + 1, 1), l] = min(J_temp);
% Find linear index
ind_lin_acc = sub2ind(size(J_temp), l);
% Save to acceleration matrix
input_acc(N_h + 1, 1) = acc(ind_lin_acc);

%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%
% Initial height
h_plot_init = 0;
% Initial velocity
v_plot_init = 0;
% Define acc plot array
acc_plot = zeros(length(Hd), 1);
% Define velocity plot array
v_plot = zeros(length(Hd), 1);
% Define height plot array
h_plot = zeros(length(Hd), 1);
% First value
h_plot(1) = h_plot_init;
% First value
v_plot(1) = v_plot_init;

for k = 1:1:N_h
    % Table look up
    [min_h, h_plot_index] = min(abs(h_plot(k) - Hd));
    % Table look up
    [min_v, v_plot_index] = min(abs(v_plot(k) - Vd));
    % Find control input / acceleration
    acc_index = sub2ind(size(input_acc), N_h + 2 - h_plot_index, v_plot_index);
    % Save acceleration to the matrix
    acc_plot(k) = input_acc(acc_index);
    % Calculate speed and height
    v_plot(k + 1) = sqrt((2 * (h_max - h_min) / N_h * acc_plot(k)) + v_plot(k) ^ 2);
    h_plot(k + 1) = h_plot(k) + (h_max - h_min) / N_h;
end

% Plot
subplot(2, 1, 1);
plot(v_plot, h_plot, '--^'); grid on;
ylabel('h(m)'); xlabel('a(m/s^2)');
subplot(2, 1, 2);
plot(acc_plot, h_plot, '^'); grid on;
ylabel('h(m)'); xlabel('v(m/s)');
