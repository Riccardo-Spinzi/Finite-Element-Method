clear
close all
clc

%% F.E. METHOD

% --- 1. Pre-process
INPUT = input_model;

% --- 2. Solution
[ ELEMENTS, NODES, MODEL ] = analyze_structure( INPUT );
 
%--- 3.a Post-process: recovery of forces
ELEMENTS = force_recovery( MODEL, ELEMENTS );

%--- 3.b  Post-process: plot deformed shapes
% plot_deformed_shapes( MODEL, ELEMENTS, NODES );

%--- 3.c Post-process: plot vibration modes
% if strcmp(INPUT.solution,'eigenmodes') == 1
%     plot_vibration_mode( MODEL, ELEMENTS, NODES );
% end

%--- 3.d Post-process: plot motion in time
plot_dynamics( MODEL, NODES );

%--- 4. Save data 
python_dir = "C:\Users\r.spinzi\.vscode\Thesis_codes_TSEA_TLEA\BEAM\Beam_exact\Matlab_results";
save_results( MODEL, python_dir )