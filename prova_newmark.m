% Newmark Method for FEM Transient Dynamics
clc;
clear;

% Input parameters
M = [2 0; 0 1];               % Mass matrix
C = [0.1 0; 0 0.1];           % Damping matrix
K = [4 -2; -2 4];             % Stiffness matrix
F = @(t) [10*sin(t); 5*cos(t)]; % Force vector as a function of time

% Newmark parameters
beta = 1/4;                   % Default for average acceleration method
gamma = 1/2;

% Time parameters
t_start = 0;
t_end = 10;
dt = 0.01;                    % Time step
n_steps = round((t_end - t_start) / dt);

% Initial conditions
u0 = [0; 0];                  % Initial displacement
v0 = [0; 0];                  % Initial velocity
a0 = M \ (F(t_start) - C*v0 - K*u0); % Initial acceleration

% Preallocate arrays
u = zeros(2, n_steps);        % Displacement matrix
v = zeros(2, n_steps);        % Velocity matrix
a = zeros(2, n_steps);        % Acceleration matrix
time = linspace(t_start, t_end, n_steps);

% Initial conditions
u(:, 1) = u0;
v(:, 1) = v0;
a(:, 1) = a0;

% Effective stiffness matrix
K_eff = M / (beta * dt^2) + gamma * C / (beta * dt) + K;

% Time integration loop
for i = 1:n_steps-1
    % Effective force vector
    t = time(i);
    F_eff = F(t) + M * ((1 / (beta * dt^2)) * u(:, i) + ...
             (1 / (beta * dt)) * v(:, i) + (1 / (2 * beta) - 1) * a(:, i)) + ...
             C * ((gamma / (beta * dt)) * u(:, i) + ...
             (gamma / beta - 1) * v(:, i) + dt * (gamma / (2 * beta) - 1) * a(:, i));
    
    % Solve for displacement
    u(:, i+1) = K_eff \ F_eff;
    
    % Update acceleration and velocity
    a(:, i+1) = (1 / (beta * dt^2)) * (u(:, i+1) - u(:, i)) - ...
                (1 / (beta * dt)) * v(:, i) - ...
                (1 / (2 * beta)) * a(:, i);
    v(:, i+1) = v(:, i) + dt * ((1 - gamma) * a(:, i) + gamma * a(:, i+1));
end

% Plot results
figure;
subplot(3,1,1);
plot(time, u(1,:), 'r', time, u(2,:), 'b');
xlabel('Time (s)');
ylabel('Displacement');
legend('u_1', 'u_2');
title('Displacement vs Time');

subplot(3,1,2);
plot(time, v(1,:), 'r', time, v(2,:), 'b');
xlabel('Time (s)');
ylabel('Velocity');
legend('v_1', 'v_2');
title('Velocity vs Time');

subplot(3,1,3);
plot(time, a(1,:), 'r', time, a(2,:), 'b');
xlabel('Time (s)');
ylabel('Acceleration');
legend('a_1', 'a_2');
title('Acceleration vs Time');
