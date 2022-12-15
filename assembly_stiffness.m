function MODEL = assembly_stiffness( ELEMENTS, MODEL )

         % % --------------- FUNCTION INFO ---------------- % %

% assembly_stiffness computes the system's stiffness matrix in order to
% solve the structural problem. It does so by exploiting the pointers in
% the ELEMENTS.ptrs vector for each element.
%
%             MODEL = assembly_stiffness( ELEMENTS, MODEL )
%
% -------------------------------------------------------------------------
% Input arguments:
% ELEMENTS            [struct]      ELEMENTS structure              [multi] 
% MODEL               [struct]      MODEL structure                 [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
% MODEL               [struct]      struct containing parameters     
%                                   for the MODEL of the structure  [multi]
% -------------------------------------------------------------------------
 

% --- Assembly stiffness matrix
for i = 1 : MODEL.nels
    ptrs = ELEMENTS( i ).ptrs;
    K_el = ELEMENTS( i ).K_el;
    MODEL.K( ptrs, ptrs ) = MODEL.K( ptrs, ptrs ) + K_el;
end

% check if one pointer is not used (happens when a node is only connected
% to truss elements)
dof_vect = [1 : length(MODEL.K)];
compare_dof_vector = zeros(1,length(MODEL.K));

% build a vector containing all used pointers and 0 in the position of
% non-used pointers
for i = 1 : length(ELEMENTS)
    ptrs = ELEMENTS(i).ptrs;
    compare_dof_vector(ptrs) = ptrs;
end

% find the non-used dofs 
MODEL.pointer = find(compare_dof_vector-dof_vect);


return