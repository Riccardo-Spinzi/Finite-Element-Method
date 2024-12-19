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
INPUT.elements = [  1 4 2 2
                    1 3 2 1
                    3 4 2 2
                    3 6 2 2
                    4 5 2 2
                    4 6 2 2
                    3 5 2 1
                    5 6 2 2
                    5 8 2 2
                    6 7 2 2
                    6 8 2 2
                    5 7 2 1
                    7 8 2 2
                    8 2 2 2
                    7 2 2 1];

% -- Nodes
INPUT.nodes = [ 1   0         0
                2   10160     0
                3   2540      0
                4   2540      3810
                5   5080      0
                6   5080      5080
                7   7620      0
                8   7620      3810 ];

% -- Section properties
INPUT.E = 2;                            % [MPa]
INPUT.A = 1000;                         % [mm^2]
INPUT.J = 1000;
INPUT.section_prop = [ INPUT.E*INPUT.A INPUT.E*INPUT.J 
                       2*INPUT.E*INPUT.A 2*INPUT.E*INPUT.J ];



% -- Loading conditions
INPUT.load = [  4 2 -35
                6 2 -35
                8 2 -35];

% -- Boundary conditions
INPUT.spc = [ 1 1 0
              1 2 -50
              2 1 0
              2 2 -50]; 

% --- Concentrated springs
INPUT.springs = [ ];

% --- Parameters varying with section (EA/EJ functions of x)
INPUT.EA = @(x) 0*x;

% --- type of solution
INPUT.solution = 'eigenmodes';

% --- Vibration mode
INPUT.mode = 3;
        
% -- Density of each element
INPUT.rho = 2.7;             % [kg/m^3]

% -- Time integration vector
tfin = 1;                                   % [s] Final integration time
N_steps = 1000;                             % [-] Number of time steps
INPUT.time = linspace(0, tfin, N_steps);    % [s] Vector of times

return