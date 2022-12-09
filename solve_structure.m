function MODEL = solve_structure( MODEL )

constr_dofs = [MODEL.constr_dofs MODEL.pointer];

for i = 1 : length(MODEL.pointer)
    Idx_null = MODEL.free_dofs == MODEL.pointer(i); % finding X indices corresponding to pointer elements
    MODEL.free_dofs(Idx_null) = [];  % removing elements using [] operator
end

% Store unconstrained K and F
MODEL.K_unc = MODEL.K;
MODEL.F_unc = MODEL.F;

% Impose constraints
MODEL.K( constr_dofs, : ) = [];
MODEL.K( :, constr_dofs ) = [];
MODEL.F( constr_dofs ) = [];

% Solve problem
MODEL.U = MODEL.K \ MODEL.F;    % [mm]

% Expand displacements to the global vector
MODEL.U_unc = zeros( MODEL.ndof, 1);
MODEL.U_unc( MODEL.free_dofs ) = MODEL.U;


return