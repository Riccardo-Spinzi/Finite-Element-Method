clear
close all
clc
%% NOTE
% risolvere bug per calcolare strutture con u=u_bar
% togliere caso matrice truss alpha che non serve a nulla

%% F.E. METHOD
    
% --- 1. Pre-process
INPUT = input_model;

% --- 2. Solution
[ ELEMENTS, NODES, MODEL ] = analyze_structure( INPUT );
 
%--- 3.a  Post-process: recovery of forces
ELEMENTS = force_recovery( MODEL, ELEMENTS );

%--- 3.b  Post-process: plot deformed shapes
plot_deformed_shapes( MODEL, ELEMENTS, NODES );

%--- 3.c  Post-process: plot vibration modes
if strcmp(INPUT.solution,'eigenmodes') == 1
    plot_vibration_mode( MODEL, ELEMENTS, NODES );
end