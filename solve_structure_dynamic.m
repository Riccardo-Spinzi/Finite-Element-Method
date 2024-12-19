function MODEL = solve_structure_dynamic( MODEL )

       % % --------------- FUNCTION INFO ---------------- % %

% solve_structure_dynamic computes the solution of the structural problem
% by solving the linear system M*u_dot_dot + K*u = F.
%
%                 MODEL = solve_structure_dynamic( MODEL )
%
% -------------------------------------------------------------------------
% Input arguments:
% MODEL               [struct]      MODEL structure                 [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
% MODEL               [struct]      struct containing parameters     
%                                   for the MODEL of the structure  [multi]
% -------------------------------------------------------------------------

constr_dofs = sort([MODEL.constr_dofs MODEL.pointer]);

for i = 1 : length(MODEL.pointer)
    Idx_null = MODEL.free_dofs == MODEL.pointer(i); % finding X indices corresponding to pointer elements
    MODEL.free_dofs(Idx_null) = [];  % removing elements using [] operator
end

% Store unconstrained M, K and F
MODEL.M_unc = MODEL.M;

% if a prescribed displacement is introduced K and F are modified accordingly 
if sum(abs(MODEL.U_bar)) > 0
    K_try = MODEL.K;
    K_try( abs(MODEL.U_bar) > 0 , : ) = 0;
    F_imposed = - K_try( : , abs(MODEL.U_bar) > 0 ) * MODEL.U_bar(abs(MODEL.U_bar) > 0);
    MODEL.F = MODEL.F + F_imposed;
end

% Impose constraints (K already present from static)
MODEL.M( constr_dofs, : ) = [];
MODEL.M( :, constr_dofs ) = [];
MODEL.F_dyn( constr_dofs, :  ) = [];

% Solve problem
sol = crank_nicolson( MODEL );    % [mm]

MODEL.U_time = sol(1:MODEL.nfree_dofs, :);

% Expand displacements to the global vector
MODEL.U_unc_time = zeros( MODEL.ndof, length(MODEL.time_vector));
MODEL.U_unc_time( MODEL.free_dofs, : ) = MODEL.U_time;
MODEL.U_unc_time = MODEL.U_unc_time + MODEL.U_bar;

return