clear
close all
clc

%% F.E. METHOD

N_mesh_el = 5;
python_dir = "temp";
matlab_dir = "temp";

for i = 1 : length(N_mesh_el) 
    % --- 1. Pre-process
    INPUT = input_model(N_mesh_el(i));
    
    % --- 2. Solution
    [ ELEMENTS, NODES, MODEL ] = analyze_structure( INPUT );
     
    %--- 3.a Post-process: recovery of forces
    ELEMENTS = force_recovery( MODEL, ELEMENTS );
    
    % --- 3.b  Post-process: plot deformed shapes
    % plot_deformed_shapes( MODEL, ELEMENTS, NODES );
    
    %--- 3.c Post-process: plot vibration modes
    % if strcmp(INPUT.solution,'eigenmodes') == 1
    %     plot_vibration_mode( MODEL, ELEMENTS, NODES );
    % end
    
    %--- 3.d Post-process: plot motion in time
    plot_dynamics( MODEL, NODES );
    
    %--- 4. Save data 
    % save_results( MODEL, python_dir, matlab_dir )
end