function ELEMENTS = element_stiffness( ELEMENTS, NODES, n_els )

       % % --------------- FUNCTION INFO ---------------- % %

% element_stiffness completes the ELEMENTS structs with more informations
% like the length of each element, their local stiffness matrix, their 
% transformation matrix T (with its relative rotation angle) and their
% properties, EA and EJ. 
%
%          ELEMENTS = element_stiffness( ELEMENTS, NODES, n_els )
%
% -------------------------------------------------------------------------
% Input arguments:
% ELEMENTS            [struct]      ELEMENTS structure              [multi] 
% NODES               [struct]      NODES structure                 [multi] 
% n_els               [1x1 double]  number of structure's elements  [-]
%
% -------------------------------------------------------------------------
% Output arguments:
% ELEMENTS            [struct]      vector of structs containing      
%                                   the ELEMENTS of the structure   [multi]
% -------------------------------------------------------------------------

for i = 1 : n_els
    el_nodes = ELEMENTS(i).nodes;

    % Determine element length
    lx = NODES(el_nodes(2)).coord_x - NODES(el_nodes(1)).coord_x;
    ly = NODES(el_nodes(2)).coord_y - NODES(el_nodes(1)).coord_y;
    l = sqrt( lx^2 + ly^2 );

    c = lx / l; % cos( alpha )
    s = ly / l; % sin( alpha )

    % Build local stiffness matrix
    if strcmp( ELEMENTS(i).type, 'truss') == 1  
        
        % Transformation matrix
        T = [c s 0 0; 0 0 c s];
        
        if strcmp(ELEMENTS(i).param,'constant') == 1 
            %Properties and stiffness matrix constant parameters
            EA = ELEMENTS(i).EA;
            ELEMENTS(i).K_el_loc = EA/l*[1 -1; -1 1];
        else
            % Properties and stiffness matrix varying with x
            EA =@(x) ELEMENTS(i).EA(x);
            ELEMENTS(i).K_el_loc = 1/l^2*[1 -1; -1 1]* integral(@(x) EA(x),0,l);
        end
    elseif strcmp( ELEMENTS(i).type, 'beam') == 1

        if ELEMENTS(i).EJ == 0
            error("J = 0 for the beam. You can set it in the input_model.m file ")
        end
        % Transformation matrix
        T_node = [c s 0; -s c 0; 0 0 1];
        T = [T_node zeros(3,3); zeros(3,3) T_node];

        % Properties and stiffness matrix
        EA = ELEMENTS(i).EA;
        EJ = ELEMENTS(i).EJ;

        K_aa = [ EA/l   0           0;
                 0      12*EJ/l^3   -6*EJ/l^2;
                 0      -6*EJ/l^2   4*EJ/l];

        K_ab = [-EA/l   0           0;
                0       -12*EJ/l^3  -6*EJ/l^2;
                0       6*EJ/l^2    2*EJ/l];

        K_bb = [EA/l 0           0;
                0    12*EJ/l^3   6*EJ/l^2;
                0    6*EJ/l^2    4*EJ/l];

        ELEMENTS(i).K_el_loc = [K_aa K_ab; K_ab' K_bb];
    end
        % Rotate stiffness matrix
        ELEMENTS(i).K_el = T' * ELEMENTS(i).K_el_loc * T;

        % Store some useful values
        ELEMENTS(i).l = l;
        ELEMENTS(i).alpha = atan2(s,c)*180/pi;
        ELEMENTS(i).T = T;
end

return

