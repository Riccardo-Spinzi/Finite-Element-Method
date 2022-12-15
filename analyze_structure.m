function [ ELEMENTS, NODES, MODEL ] = analyze_structure( INPUT )

       % % --------------- FUNCTION INFO ---------------- % %

% analyze_structure is the main function composing the F.E. method. It
% builds the main structs and computes all the parameters to get the
% displacement solution MODEL.U. Then, it displays the deformed shape 
% and the vibration modes of the structure. 
%
%         [ ELEMENTS, NODES, MODEL ] = analyze_structure( INPUT )
%
% -------------------------------------------------------------------------
% Input arguments:
% INPUT               [struct]      INPUT structure                 [multi] 
% 
%
% -------------------------------------------------------------------------
% Output arguments:
% ELEMENTS            [struct]      vector of structs containing      
%                                   the ELEMENTS of the structure   [multi]
% NODES               [struct]      vector of structs containing      
%                                   the NODES of the structure      [multi]
% MODEL               [struct]      struct containing parameters     
%                                   for the MODEL of the structure  [multi]
% -------------------------------------------------------------------------
 
% --- Set model
[ ELEMENTS, NODES, MODEL ] = set_model( INPUT );

% --- Set pointers
ELEMENTS = set_pointers( ELEMENTS, NODES, MODEL.nels );

% --- Build element stiffness matrices
ELEMENTS = element_stiffness( ELEMENTS, NODES, MODEL.nels );

% --- Assembly stiffness matrix
MODEL = assembly_stiffness( ELEMENTS, MODEL );

% --- Impose constraints and solve
MODEL = solve_structure( MODEL );

% --- Calculate natural frequencies and vibration modes
if strcmp(INPUT.solution,'eigenmodes') == 1
    MODEL = solve_dynamics( MODEL, INPUT.mode );
else 
      MODEL.vib_mode = 0;
      MODEL.w_i = 0;
end

return