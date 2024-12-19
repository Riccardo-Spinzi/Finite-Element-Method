function ELEMENTS = element_mass( ELEMENTS, n_els )

       % % --------------- FUNCTION INFO ---------------- % %

% element_mass computes local mass matrices for the dynamics, depending on 
% the kind of element chosen, and gives back the local mass matrix 
%
%          ELEMENTS = element_stiffness( ELEMENTS, NODES, n_els )
%
% -------------------------------------------------------------------------
% Input arguments:
% ELEMENTS            [struct]      ELEMENTS structure              [multi] 
% n_els               [1x1 double]  number of structure's elements  [-]
%
% -------------------------------------------------------------------------
% Output arguments:
% ELEMENTS            [struct]      vector of structs containing      
%                                   the ELEMENTS of the structure   [multi]
% -------------------------------------------------------------------------

for i = 1 : n_els

    % Build local mass matrix
    if strcmp( ELEMENTS(i).type, 'truss') == 1  
        
        % % Transformation matrix
        % T = ELEMENTS(i).T;
        
        error("WIP")
        
    elseif strcmp( ELEMENTS(i).type, 'beam') == 1

        if ELEMENTS(i).EJ == 0
            error("J = 0 for the beam. You can set it in the input_model.m file ")
        end
        % Transformation matrix
        T = ELEMENTS(i).T;

        % Properties and mass matrix
        l = ELEMENTS(i).l;
        rho = ELEMENTS(i).rho;
        A = ELEMENTS(i).A;

        M_aa = [ 140   0       0;
                 0     156     22*l;
                 0     22*l    4*l^2];

        M_ab = [70    0       0;
                0     54     -13*l;
                0    -13*l   -3*l^2];

        M_bb = [ 140    0        0;
                 0      156     -22*l;
                 0     -22*l     4*l^2];

        ELEMENTS(i).M_el_loc = rho*A*l/420 .* [M_aa M_ab; M_ab' M_bb];
    end
        % Rotate mass matrix
        ELEMENTS(i).M_el = T' * ELEMENTS(i).M_el_loc * T;

end

return

