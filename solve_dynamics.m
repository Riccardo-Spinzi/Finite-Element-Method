function MODEL = solve_dynamics( MODEL, mode )

M = MODEL.M;
K = MODEL.K_unc;

% the dofs associated to constrains, rotations, and the unused ones will be
% removed for simplicity
rot_dofs = [3*MODEL.nnods:-3:3];
tot_constr_dofs = [MODEL.constr_dofs MODEL.pointer rot_dofs];
M(:,tot_constr_dofs) = [];
M(tot_constr_dofs,:) = [];
K(:,tot_constr_dofs) = [];
K(tot_constr_dofs,:) = [];

% --- Solve the eigenvalue problem
A = M \ K;

[E_vec, w_i_squared] = eig(A);

% --- Get Natural frequencies of the simplified structure
MODEL.w_i = sort(sqrt(diag(w_i_squared)));

% kill rotational free_dofs 
for i = 1 : length(rot_dofs)  
    for j = 1 : length(MODEL.free_dofs)
        if MODEL.free_dofs(j) == rot_dofs(i)
            MODEL.free_dofs(j) = 0; 
        end
    end
end
idx = MODEL.free_dofs == 0;
MODEL.free_dofs(idx) = [];

% --- Get vibration modes as for a pure-truss-elements problem
MODEL.vib_mode( MODEL.free_dofs ) = E_vec(:,mode);

return