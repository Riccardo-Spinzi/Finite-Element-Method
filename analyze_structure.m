function [ ELEMENTS, NODES, MODEL ] = analyze_structure( INPUT )

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