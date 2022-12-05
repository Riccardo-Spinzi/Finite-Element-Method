function plot_deformed_shapes( MODEL, ELEMENTS, NODES )

[M,N] = size(ELEMENTS);

% riscalo lo spostamento per visualizzarlo tramite n_visual
n_visual = 1500;

ndof = NODES(1).ndof; % suppongo che tutti gli elementi abbiamo nodi dello stesso tipo
U_new = reshape(MODEL.U_unc.*n_visual , ndof, length(MODEL.U_unc)/ndof)';

figure
hold on
for i = 1 : N 
    %ricavo i nodi da cui passa ogni elemento
    nod_1 = ELEMENTS(i).nodes(1);
    nod_2 = ELEMENTS(i).nodes(2);
    %ottengo le coordinate dei nodi
    plot_x_nod_1 = NODES(nod_1).coord_x;
    plot_y_nod_1 = NODES(nod_1).coord_y;

    plot_x_nod_2 = NODES(nod_2).coord_x;
    plot_y_nod_2 = NODES(nod_2).coord_y;
    
    % plotto i nodi
    plot([plot_x_nod_1,plot_x_nod_2],[plot_y_nod_1,plot_y_nod_2],'--b')

    %ottengo le coordinate dei nodi deformate
    plot_x_nod_1 = NODES(nod_1).coord_x + U_new(nod_1,1);
    plot_y_nod_1 = NODES(nod_1).coord_y + U_new(nod_1,2);

    plot_x_nod_2 = NODES(nod_2).coord_x + U_new(nod_2,1);
    plot_y_nod_2 = NODES(nod_2).coord_y + U_new(nod_2,2);

    % plotto i nodi deformati
    plot([plot_x_nod_1,plot_x_nod_2],[plot_y_nod_1,plot_y_nod_2],'r')
end
axis([-inf, inf, -inf, inf])
xlabel('x [mm]')
ylabel('y [mm]')
title(strcat('Deformed shape of the structure (', num2str(n_visual),':1)'))
return

end