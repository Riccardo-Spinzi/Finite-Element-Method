function plot_vibration_mode( MODEL, ELEMENTS, NODES )

        % % --------------- FUNCTION INFO ---------------- % %

% plot_vibration_modes draws the figure containing the original structure
% and the vibration mode associated to a specific natural frequency. This 
% natural frequency is the one specified in the MODEL.mode_num parameter.
%
%              plot_vibration_mode( MODEL, ELEMENTS, NODES )
%
% -------------------------------------------------------------------------
% Input arguments:
% MODEL               [struct]      MODEL structure                 [multi] 
% ELEMENTS            [struct]      ELEMENTS structure              [multi] 
% NODES               [struct]      NODES structure                 [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
%
% -------------------------------------------------------------------------

MODE = MODEL.vib_mode;
[M,N] = size(ELEMENTS);

% re-scale the displacements to see them better in the plots
n_visual = 1000;

ndof = 3; % all elements are treated as beams
U_new = reshape(MODE.*n_visual , ndof, length(MODE)/ndof)';

figure
hold on
for i = 1 : N 

    % boundary nodes for each element
    nod_1 = ELEMENTS(i).nodes(1);
    nod_2 = ELEMENTS(i).nodes(2);

    % nodes coordinates
    plot_x_nod_1 = NODES(nod_1).coord_x;
    plot_y_nod_1 = NODES(nod_1).coord_y;

    plot_x_nod_2 = NODES(nod_2).coord_x;
    plot_y_nod_2 = NODES(nod_2).coord_y;
    
    % nodes plot
    plot([plot_x_nod_1,plot_x_nod_2],[plot_y_nod_1,plot_y_nod_2],'--b')

    % nodes coordinates with calculated displacement 
    plot_x_nod_1 = NODES(nod_1).coord_x + U_new(nod_1,1);
    plot_y_nod_1 = NODES(nod_1).coord_y + U_new(nod_1,2);

    plot_x_nod_2 = NODES(nod_2).coord_x + U_new(nod_2,1);
    plot_y_nod_2 = NODES(nod_2).coord_y + U_new(nod_2,2);

    % deformed nodes plot
    plot([plot_x_nod_1,plot_x_nod_2],[plot_y_nod_1,plot_y_nod_2],'r')
end

axis([-inf, inf, -inf, inf])
xlabel('x [mm]')
ylabel('y [mm]')
title(strcat('Eigenmode:', num2str(MODEL.mode_num),' (', num2str(n_visual),':1)'))

end