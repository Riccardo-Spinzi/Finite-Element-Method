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
[N,M] = size (INPUT.elements);
[Q,P] = size (INPUT.nodes);
[O,R] = size (INPUT.spc);
[dim1,dim2] = size (INPUT.load);

% --- define structure for ELEMENTS
for i =  1 : N
    ELEMENTS(i).nodes = INPUT.elements(i,[1,2]);
    ELEMENTS(i).EA = INPUT.section_prop(INPUT.elements(i,4),1); 
    if INPUT.elements(i,3) == 1
        ELEMENTS(i).EJ = INPUT.section_prop(INPUT.elements(i,4),2); 
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
    NODES(i).ass_dof = (i-1)*3 + [1:3];
end

% --- define structure for MODEL

MODEL.nels = N;
MODEL.nnods = Q;
MODEL.ndof = 0;

% set the number of dofs as if the elements were all beams
MODEL.ndof = MODEL.nnods * 3; 

MODEL.free_dofs = [1:MODEL.ndof];

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

% initialize K and f
MODEL.K = zeros(MODEL.ndof);
MODEL.F = zeros(MODEL.ndof,1);

% build force vector
for i = 1 : dim1
   punt = (INPUT.load(i,1)-1)*3 + INPUT.load(i,2);
   MODEL.F(punt) = INPUT.load(i,3);
end

MODEL.U_bar = zeros(MODEL.ndof,1);
% get constraints and prescribed displacements 
for i = 1 : O
   punt = (INPUT.spc(i,1)-1)*MODEL.ndof/MODEL.nnods +  INPUT.spc(i,2);
   MODEL.U_bar(punt,1) = INPUT.spc(i,3); 
end

% --- define useful parameters for dynamics
if strcmp(INPUT.solution,'eigenmodes') == 1
    MODEL = assembly_mass( MODEL, INPUT.mass(:,3));
    MODEL.vib_mode = zeros(MODEL.ndof,1);
    if length(INPUT.mode)>1
        error('only one mode at a time can be computed')
    end
    MODEL.mode_num = INPUT.mode;
end


return