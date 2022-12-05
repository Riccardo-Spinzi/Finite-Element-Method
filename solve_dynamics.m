function MODEL = solve_dynamics( MODEL, mode )

M = MODEL.M;
K = MODEL.K;

% --- Solve the eigenvalue problem
A = M \ K;

[E_vec, w_i_squared] = eig(A);

% --- Get values of interest
MODEL.w_i = sort(sqrt(diag(w_i_squared)));

% associare 0 ai termini fissi
MODEL.vib_mode( MODEL.free_dofs ) = E_vec(:,mode);

return