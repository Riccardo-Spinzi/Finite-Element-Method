function INPUT = input_model

% --- Input
% INPUT.elements                : [ node_A node_B ID_prop ID_material ]
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
INPUT.elements = [  1 2 2 1
                    2 3 2 2
                    3 4 1 1];

% -- Nodes
INPUT.nodes = [ 1 0  1;
                2 1  1;
                3 3  1;
                4 3  0;];

% -- Section properties
E = 1;                % [MPa]
A = 1000;                            % [mm^2]
J = 1000;
INPUT.section_prop = [ E*A E*J
                       E*A 2*E*J];

% -- Lumped mass on each node
m = 1e-4 ;                    % [t]
[N,M] = size(INPUT.nodes);
for i = 1 : 3 * N
    if i == 1 | k == 4
        k=1;
    end
    INPUT.mass(i,1) = i;
    INPUT.mass(i,2) = k;
    INPUT.mass(i,3) = m;
    k=k+1;
end

% -- Loading conditions
INPUT.load = [ 2 2 100
               3 2 200];

% --- type of solution
INPUT.solution = 'static';

% --- Vibration mode
INPUT.mode = 3;

% -- Boundary conditions
INPUT.spc = [ 1 1
              1 2
              1 3
              4 1 
              4 2
              4 3];         
                          




return