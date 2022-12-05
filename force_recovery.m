function ELEMENTS = force_recovery( MODEL, ELEMENTS )

% --- Force recovery
for i = 1 : MODEL.nels
    T = ELEMENTS(i).T;
    ptrs = ELEMENTS(i).ptrs;
    U_el_loc = T * MODEL.U_unc( ptrs );
    nodal_forces = ELEMENTS(i).K_el_loc * U_el_loc; 
    %(take force in node 2: >0 in traction)
    ELEMENTS(i).nodal_forces = nodal_forces(2); 
end

return