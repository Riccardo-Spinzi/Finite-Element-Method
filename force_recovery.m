function ELEMENTS = force_recovery( MODEL, ELEMENTS )

        % % --------------- FUNCTION INFO ---------------- % %

% force recovery computes the forces and the moment acting on each node
% composing the strucure and adds the information to the ELEMENTS struct.
%
%              ELEMENTS = force_recovery( MODEL, ELEMENTS )
%
% -------------------------------------------------------------------------
% Input arguments:
% MODEL               [struct]      MODEL structure                 [multi] 
% ELEMENTS            [struct]      ELEMENTS structure              [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
% ELEMENTS            [struct]      vector of structs containing      
%                                   the ELEMENTS of the structure   [multi]
% -------------------------------------------------------------------------

% --- Force recovery
for i = 1 : MODEL.nels
    
    T = ELEMENTS(i).T;
    ptrs = ELEMENTS(i).ptrs;
    U_el_loc = T * MODEL.U_unc( ptrs );

    % calculate forces 
    nodal_forces = ELEMENTS(i).K_el_loc * U_el_loc; 

    % assign all forces and momentums 
    ELEMENTS(i).nodal_forces = nodal_forces; 
end

return