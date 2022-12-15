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
INPUT.elements = [ ];

% -- Nodes
INPUT.nodes = [ ];

% -- Section properties
E = ;                            % [MPa]
A = ;                            % [mm^2]
J = ;
INPUT.section_prop = [ ];

% -- Lumped mass on each node
m = ;                            % [tons]
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
INPUT.load = [  ];

% --- type of solution
INPUT.solution = 'eigenmodes';

% --- Vibration mode
INPUT.mode = ;

% -- Boundary conditions
INPUT.spc = [ ];         
          


return