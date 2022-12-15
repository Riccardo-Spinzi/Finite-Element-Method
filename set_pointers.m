function ELEMENTS = set_pointers( ELEMENTS, NODES, n_els )

       % % --------------- FUNCTION INFO ---------------- % %

% set_pointers fills the ELEMENTS.ptrs vector for each element composing 
% the structure. The pointers are the numbers of the degree of freedom 
% associated to each node adjacent to the same element.   
%
%           ELEMENTS = set_pointers( ELEMENTS, NODES, n_els )
%
% -------------------------------------------------------------------------
% Input arguments:
% ELEMENTS            [struct]      ELEMENTS structure              [multi] 
% NODES               [struct]      NODES structure                 [multi] 
% n_els               [1x1 double]  number of structure's elements  [-]
%
% -------------------------------------------------------------------------
% Output arguments:
% ELEMENTS            [struct]      vector of structs containing      
%                                   the ELEMENTS of the structure   [multi]
% -------------------------------------------------------------------------
  
for i = 1 : n_els
    if strcmp(ELEMENTS(i).type,'beam') == 1
        for j = 1 : 2 
            ELEMENTS(i).ptrs = [ELEMENTS(i).ptrs, NODES(ELEMENTS(i).nodes(j)).ass_dof ];
        end   
    else
        for j = 1 : 2 
            ELEMENTS(i).ptrs = [ELEMENTS(i).ptrs, NODES(ELEMENTS(i).nodes(j)).ass_dof(1:2) ];
        end
    end
end


return