function INPUT = input_model 

       % % --------------- FUNCTION INFO ---------------- % %

% input_model is the function which loads all the data of the structure in
% an organized way, in order to set up the problem correctly.
%
%                         INPUT = input_model
%
% -------------------------------------------------------------------------
% Input arguments:
% Detailed informations on how to modify this file and an example are 
% displayed in the FEM_setup.txt file.
% 
%
% -------------------------------------------------------------------------
% Output arguments:
% INPUT            [struct]      INPUT structure     [multi] 
% 
% -------------------------------------------------------------------------

% -- Init
INPUT = struct();

% -- Elements
N_mesh = 50;
l = 100;        % [mm]
INPUT.elements = [(1:N_mesh)',(2:N_mesh+1)',2*ones(N_mesh,1), ones(N_mesh,1)];

% -- Nodes
nodes = linspace(0,l,N_mesh+1)';
num = length(nodes);
coords = [(1:num)', nodes, zeros(num,1)];
INPUT.nodes = coords;

% -- Section properties
% INPUT.E = 1;                         % [MPa]
% INPUT.A = 1;                         % [mm^2]
% INPUT.J = 1;
INPUT.E = 72;                       % [MPa]
INPUT.A = 5^2;                         % [mm^2]
INPUT.J = 5^4/12;
INPUT.section_prop = [ INPUT.E*INPUT.A INPUT.E*INPUT.J];


% node_idx = find(coords(:,2) == 0.02);
% -- Loading conditions
% INPUT.load = [ node_idx 2 -0];
INPUT.load = [];

% -- Boundary conditions
INPUT.spc = [ 1 1 0
              1 2 0
              INPUT.nodes(end,1) 2 0]; % look for last node automatically

% --- Concentrated springs
INPUT.springs = [ ];

% --- Parameters varying with section (EA/EJ functions of x)
INPUT.EA = @(x) 0*x;

% --- type of solution
INPUT.solution = 'eigenmodes';

% --- Vibration mode
INPUT.mode = 3;
        
% -- Density of each element
INPUT.rho = 2700e-9;             % [kg/mm^3]
% INPUT.rho = 1;

% -- Time integration vector
tfin = 1;                                   % [s] Final integration time
N_steps = 1000;                             % [-] Number of time steps
INPUT.time = linspace(0, tfin, N_steps-1);    % [s] Vector of times
INPUT.freq = 1;                             % [Hz] Force frequency of oscillation

return