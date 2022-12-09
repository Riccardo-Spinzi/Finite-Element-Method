function plot_deformed_shapes( MODEL, ELEMENTS, NODES )

[M,N] = size(ELEMENTS);

% re-scale the displacements to see them better in the plots
n_visual = 15;

ndof = 3; % hypothesis: all elements are of the same type
U_new = reshape(MODEL.U_unc.*n_visual , ndof, length(MODEL.U_unc)/ndof)';

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
title(strcat('Deformed shape of the structure (', num2str(n_visual),':1)'))

end