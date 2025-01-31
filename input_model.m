function INPUT = input_model( N )

       % % --------------- FUNCTION INFO ---------------- % %

% input_model is the function which loads all the data of the structure in
% an organized way, in order to set up the problem correctly.
%
%                      INPUT = input_model ( N ) 
%
% -------------------------------------------------------------------------
% Input arguments:
% Detailed informations on how to modify this file and an example are 
% displayed in the FEM_setup.txt file.
% 
%
% -------------------------------------------------------------------------
% Output arguments:
% INPUT            [struct]         INPUT structure                 [multi] 
% N                [1x1 double]     Number of structure elements      
% -------------------------------------------------------------------------

% -- Init
INPUT = struct();

% -- Elements
N_mesh = N;
l = 100;        % [mm]
INPUT.elements = [(1:N_mesh)',(2:N_mesh+1)',2*ones(N_mesh,1), ones(N_mesh,1)];

% -- Nodes
nodes = linspace(0,l,N_mesh+1)';
num = length(nodes);
coords = [(1:num)', nodes, zeros(num,1)];
INPUT.nodes = coords;

% -- Section properties
INPUT.E = 72;                       % [MPa]
INPUT.A = 5^2;                         % [mm^2]
INPUT.J = 5^4/12;
INPUT.section_prop = [ INPUT.E*INPUT.A INPUT.E*INPUT.J];

% -- Loading conditions
node_idx = find(coords(:,2) == 20);
INPUT.load = [ node_idx 2 0];

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

% -- Damping factor for lumped damping matrix
INPUT.eta = 0.05;
% INPUT.eta = 0;

% -- Time integration vector
tfin = 3;                                   % [s] Final integration time
N_steps = 1000;                             % [-] Number of time steps
INPUT.time = linspace(0, tfin, N_steps-1);    % [s] Vector of times
INPUT.freq = 1;                             % [Hz] Force frequency of oscillation
INPUT.sine = true;
return