function [ ELEMENTS, NODES, MODEL ] = set_model( INPUT )

       % % --------------- FUNCTION INFO ---------------- % %

% set_model orders the input data in 3 structures: ELEMENTS, NODES and 
% MODEL. MODEL may contain more information if the INPUT.solution
% parameter is set to 'eigenmodes'.
%
%           [ ELEMENTS, NODES, MODEL ] = set_model( INPUT )
%
% -------------------------------------------------------------------------
% Input arguments:
% INPUT               [struct]      INPUT structure                 [multi] 
% 
%
% -------------------------------------------------------------------------
% Output arguments:
% ELEMENTS            [struct]      vector of structs containing      
%                                   the ELEMENTS of the structure   [multi]
% NODES               [struct]      vector of structs containing      
%                                   the NODES of the structure      [multi]
% MODEL               [struct]      struct containing parameters     
%                                   for the MODEL of the structure  [multi]
% -------------------------------------------------------------------------
    
% --- initialization
ELEMENTS = struct();
NODES = struct();
MODEL = struct();

% --- useful dimension parameters 
[N,~] = size (INPUT.elements);
[Q,~] = size (INPUT.nodes);
[O,~] = size (INPUT.spc);
[dim1,~] = size (INPUT.load);
[dim3,~] = size (INPUT.springs);

% --- define structure for ELEMENTS
for i =  1 : N
    ELEMENTS(i).nodes = INPUT.elements(i,[1,2]);
    ELEMENTS(i).A = INPUT.A;
    ELEMENTS(i).rho = INPUT.rho;
    % control if E and A are constant or variable parameters
    if INPUT.elements(i,4) ~= 0
        ELEMENTS(i).EA = INPUT.section_prop(INPUT.elements(i,4),1); 
        ELEMENTS(i).param = 'constant';
    else
        ELEMENTS(i).EA =@(x) INPUT.EA(x);
        ELEMENTS(i).param = 'variable';
    end
    % get other useful parameters in the structure
    if INPUT.elements(i,3) == 1
        ELEMENTS(i).EJ = 0; 
        ELEMENTS(i).type = 'truss';
        ELEMENTS(i).dofs = 4;      
    else
        ELEMENTS(i).EJ = INPUT.section_prop(INPUT.elements(i,4),2); 
        ELEMENTS(i).type = 'beam';
        ELEMENTS(i).dofs = 6;
    end
    ELEMENTS(i).ptrs = [];
end

% --- define structure for NODES
for i = 1 : Q
    NODES(i).coord_x = INPUT.nodes(i,2);
    NODES(i).coord_y = INPUT.nodes(i,3);  
    NODES(i).ass_dof = (i-1)*3 + (1:3);
end

% --- define structure for MODEL

MODEL.nels = N;
MODEL.nnods = Q;
MODEL.ndof = 0;

% set the number of dofs as if the elements were all beams
MODEL.ndof = MODEL.nnods * 3; 

MODEL.free_dofs = 1:MODEL.ndof;

for i = 1 : O
   MODEL.constr_dofs(i) = (INPUT.spc(i,1)-1)*MODEL.ndof/MODEL.nnods +  INPUT.spc(i,2); 
   for j = 1 : MODEL.ndof
       if MODEL.constr_dofs(i) == MODEL.free_dofs(j)
           MODEL.free_dofs(j) = 0;
       end
   end
end
Idx_null = MODEL.free_dofs == 0; % finding X indices corresponding to 0 elements
MODEL.free_dofs(Idx_null) = [];  % removing elements using [] operator
MODEL.nfree_dofs = length(MODEL.free_dofs);

% get time vector for time integration
MODEL.time_vector = INPUT.time;

% initialize M, K and f
MODEL.M = zeros(MODEL.ndof);
MODEL.K = zeros(MODEL.ndof);
MODEL.F = zeros(MODEL.ndof,1);
MODEL.F_dyn = zeros (MODEL.ndof, length(MODEL.time_vector));

% insert concentrated springs in K if there is any
for i = 1 : dim3
    if ~isempty(INPUT.springs)
        punt = (INPUT.springs(i,1)-1)*3 + INPUT.springs(i,2);
        MODEL.K(punt,punt) = MODEL.K(punt,punt) + INPUT.springs(i,3);
    end
end

MODEL.U_bar = zeros(MODEL.ndof,1);
% get constraints and prescribed displacements 
for i = 1 : O
   punt = (INPUT.spc(i,1)-1)*MODEL.ndof/MODEL.nnods +  INPUT.spc(i,2);
   MODEL.U_bar(punt,1) = INPUT.spc(i,3); 
end

% build force vector (static and dynamic)
for i = 1 : dim1
   punt = (INPUT.load(i,1)-1)*3 + INPUT.load(i,2);
   MODEL.F(punt) = INPUT.load(i,3);
   MODEL.F_dyn(punt,:) = INPUT.load(i,3)*cos(2*pi*1*MODEL.time_vector); % 1 Hz oscillation
end

% get vector of initial conditions
MODEL.IC = zeros(2*MODEL.nfree_dofs,1);

% --- define useful parameters for dynamics
if strcmp(INPUT.solution,'eigenmodes') == 1
    MODEL.vib_mode = zeros(MODEL.ndof,1);
    if length(INPUT.mode) > 1
        error('only one mode at a time can be computed')
    end
    MODEL.mode_num = INPUT.mode;
end


return