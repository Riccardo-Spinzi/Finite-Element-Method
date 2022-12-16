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
INPUT.elements = [ 1 2 2 1
                   2 3 2 2
                   3 4 1 1];

% -- Nodes
INPUT.nodes = [ 1 0 1
                2 1 1
                3 3 1
                4 3 0];

% -- Section properties
E = 1;                               % [MPa]
A = 1000;                            % [mm^2]
J = 1000;
INPUT.section_prop = [ 1000 1000
                       1000 2000];

% -- Lumped mass on each node
m = 0;                            % [tons]
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
INPUT.load = [ 2 2 90];

% --- type of solution
INPUT.solution = 'static';

% --- Vibration mode
INPUT.mode = 0;

% -- Boundary conditions
INPUT.spc = [ 1 1 0
              1 2 0
              1 3 0
              3 2 0.2
              4 1 0
              4 2 0
              4 3 0];         
          


return