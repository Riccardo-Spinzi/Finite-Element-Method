function plot_dynamics( MODEL, NODES )

 % % --------------- FUNCTION INFO ---------------- % %

% plot_dynamics draws the surf plot of displacement and energy variation of
% the beam over space-time. This is written ad hoc for a 1D beam structure.
%
%                   plot_deformed_shapes( MODEL, NODES )
%
% -------------------------------------------------------------------------
% Input arguments:
% MODEL               [struct]      MODEL structure                 [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
%
% -------------------------------------------------------------------------
x = [NODES.coord_x];
y = MODEL.time_vector;
[X,Y] = meshgrid(x,y);
Z = MODEL.U_unc_time(2:3:end,:)';

figure
surf(X,Y,Z,'EdgeColor', 'none')
xlabel('beam axis [m]')
ylabel('time [s]')
colorbar

idx = x == 20;
find(idx)

figure
plot(y, Z(:,idx))
grid on
xlabel("Time [s]")
ylabel("Displacement [mm]")
title("Evolution in time of displacement at x = IAP")


