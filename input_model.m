function INPUT = input_model

% --- Input
% INPUT.elements                : [ node_A node_B ID_prop ]
% INPUT.nodes                   : [ ID_node x_coord y_coord ]
% INPUT.E                       : Young's modulus        
% INPUT.A                       : Section of the beam  
% INPUT.section_prop            : [ E*A E*J ] 
%                                 set J = 0 for truss
% INPUT.mass                    : [ ID_node component magn]
% INPUT.load                    : [ ID_node component magn ]
% INPUT.solution                : 'static' or 'eigenmodes'
% INPUT.mod                     : selected vibration mode 
% INPUT.spc                     : [ ID_node component ] 

% -- Init
INPUT = struct();

% -- Elements
INPUT.elements = [  1 4 1
                    1 3 1
                    3 4 1
                    3 6 1
                    4 5 1
                    4 6 1 
                    3 5 1 
                    5 6 1 
                    5 8 1 
                    6 7 1
                    6 8 1 
                    5 7 1 
                    7 8 1 
                    8 2 1 
                    7 2 1];

% -- Nodes
INPUT.nodes = [ 1   0         0
                2   10160     0
                3   2540      0
                4   2540      3810
                5   5080      0
                6   5080      5080
                7   7620      0
                8   7620      3810];

% -- Section properties
E = 200000;                % [MPa]
A = 10;                    % [mm^2]
J = 0;
INPUT.E = E;
INPUT.A = A;
INPUT.J = J;
INPUT.section_prop = [ E*A E*J ];

% -- Concentrated mass
m = 1e-4 ;                  % [t]
INPUT.mass = [1 1 m
              1 2 m
              2 1 m
              2 2 m
              3 1 m
              3 2 m
              4 1 m
              4 2 m
              5 1 m
              5 2 m
              6 1 m
              6 2 m
              7 1 m
              7 2 m
              8 1 m
              8 2 m];

% -- Loading conditions
INPUT.load = [ 4 2 -35
               6 2 -35
               8 2 -35];

% --- type of solution
INPUT.solution = 'eigenmodes';

% --- Vibration mode
INPUT.mode = 4;

% -- Boundary conditions
INPUT.spc = [ 1 1
              1 2 
              2 1 
              2 2 ];         
                          




return