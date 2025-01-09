clear
close all
clc

% generate beam to input the FEM automatically
N_mesh = 50; % number of mesh elements
l = 0.1; % [m]

% beam elements
elements = [(1:N_mesh)',(2:N_mesh+1)',2*ones(N_mesh,1), ones(N_mesh,1)];

disp(elements)

% beam nodes
nodes = linspace(0,l,N_mesh+1)';
num = length(nodes);
coords = [(1:num)', nodes, zeros(num,1)];

disp(coords)