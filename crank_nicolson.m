function sol = crank_nicolson( MODEL )

       % % --------------- FUNCTION INFO ---------------- % %

% crank_nicolson computes the solution of the dynamic structural problem
% by solving the ODE M*u_dot_dot + K*u = F.
%
%                   sol = crank_nicolson( MODEL )
%
% -------------------------------------------------------------------------
% Input arguments:
% MODEL               [struct]      MODEL structure                 [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
% sol          [2*nfree_dofs        time integral of the solution   [multi]
%                 x N_steps double]                                                          
% -------------------------------------------------------------------------

% get parameters from MODEL struct
nfree_dofs  = MODEL.nfree_dofs;
t = MODEL.time_vector;
y0 = MODEL.IC;
M = MODEL.M;
D = MODEL.D;
K = MODEL.K;
F = MODEL.F_dyn;

% compute dt for numerical integration
dt = (t(end)-t(1))/(length(t)-1);

% define useful matrices only once
M_inv= M\eye(nfree_dofs);
A = [zeros(nfree_dofs,nfree_dofs), eye(nfree_dofs);
     - M_inv * K                   , - M_inv * D];
b = [zeros(nfree_dofs,length(t));
     M_inv*F];
M_LHS = eye(2*nfree_dofs) - dt/2 * A;
M_RHS = eye(2*nfree_dofs) + dt/2 * A;

sol = zeros(2*nfree_dofs, length(t));
sol(1:nfree_dofs,1) = y0;

% Turn off the warning
% warning('on', 'MATLAB:nearlySingularMatrix');

% % cicle over the time vector to integrate in time
for i = 1 : length(t) - 1 
    c = M_RHS * sol(:,i) + dt/2 * (b(:,i) + b(:,i+1));
    sol(:,i+1) =  M_LHS \ c;
end

return

