function MODEL = solve_structure( MODEL )

       % % --------------- FUNCTION INFO ---------------- % %

% solve_structure computes the solution of the structural problem by
% solving the linear system K*u = F.
%
%                    MODEL = solve_structure( MODEL )
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

% Store unconstrained K and F
MODEL.K_unc = MODEL.K;
MODEL.F_unc = MODEL.F;

% if a prescribed displacement is introduced K and F are modified accordingly 
if sum(abs(MODEL.U_bar)) > 0
    K_try = MODEL.K;
    K_try( find(abs(MODEL.U_bar) > 0) , : ) = 0;
    F_imposed = - K_try( : , abs(MODEL.U_bar) > 0 ) * MODEL.U_bar(abs(MODEL.U_bar) > 0);
    MODEL.F = MODEL.F + F_imposed;
end

% Impose constraints
MODEL.K( constr_dofs, : ) = [];
MODEL.K( :, constr_dofs ) = [];
MODEL.F( constr_dofs ) = [];

% Solve problem
MODEL.U = MODEL.K \ MODEL.F;    % [mm]

% Expand displacements to the global vector
MODEL.U_unc = zeros( MODEL.ndof, 1);
MODEL.U_unc( MODEL.free_dofs ) = MODEL.U;
MODEL.U_unc = MODEL.U_unc + MODEL.U_bar;

return
