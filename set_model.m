function [ ELEMENTS, NODES, MODEL ] = set_model( INPUT )

%---------------------------------------------------------------------------------
% ELEMENTS                              [1 × nels] struct array with fields:
% nodes                                 ID of nodes composing the element
% EA                                    axial stiffness
% EJ                                    bending stiffness
% type                                  'truss' or 'beam'
% dofs                                  number of element dofs (4: truss; 6: beams)
% ptrs                                  vector of pointers
% K_el_loc                              element stiffness matrix (local system)
% K_el                                  element stiffness matrix (global system)
% l                                     element length
% alpha                                 element orientation
% T                                     element transformation matrix
% nodal_forces                          element nodal forces
%
% ---------------------------------------------------------------------------------
% NODES                                 [1 × nnodes] struct array with fields:
% coord_x                               node x coordinate
% coord_y                               node y coordinate
% ass_dof                               dofs associated to the node
%----------------------------------------------------------------------------------
% MODEL                                 struct with fields:
% ndof                                  tot number of dofs for the unconstr system
% nels                                  total number of elements
% nnodes                                total number of nodes
% K: [nfree_dofs × nfree_dofs double]   stiffness matrix of constr structure
% F: [nfree_dofs × 1 double]            load vector of constr structure
% constr_dofs                           position of constrained dofs
% free_dofs                             position of free dofs
% nfree_dofs: length(free_dofs)         number of free dofs
% K_unc: [ndof × ndof]                  stiffness matrix of unconstr structure
% F_unc: [ndof × 1 double]              load vector of unconstr struct
% U: [nfree_dofs × 1 double]            displacement vector (only free dofs)
% U_unc: [ndof × 1 double]              displacement vector (all dofs)
% M: [ndof x ndof double]               mass matrix

% --- initialization
ELEMENTS = struct();
NODES = struct();
MODEL = struct();

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
MODEL.K = zeros(MODEL.ndof);
MODEL.F = zeros(MODEL.ndof,1);

for i = 1 : dim1
   punt = (INPUT.load(i,1)-1)*3 + INPUT.load(i,2);
   MODEL.F(punt) = INPUT.load(i,3);
end

if strcmp(INPUT.solution,'eigenmodes') == 1
    MODEL = assembly_mass( MODEL, INPUT.mass(:,3));
    MODEL.vib_mode = zeros(MODEL.ndof,1);
    MODEL.mode_num = INPUT.mode;
end


return