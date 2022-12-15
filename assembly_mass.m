function MODEL = assembly_mass( MODEL, mass)

         % % --------------- FUNCTION INFO ---------------- % %

% assembly_mass sets the mass matrix of the system. In our case the only
% type of mass matrix which can be built is a lumped mass matrix, that is a
% diagonal matrix.
%
%                   MODEL = assembly_mass( MODEL, mass)
%
% -------------------------------------------------------------------------
% Input arguments:
% ELEMENTS      [struct]                ELEMENTS structure          [multi] 
% mass          [3*nnodes x 1 double]   vector containing the 
%                                       lumped mass of the system   [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
% MODEL               [struct]      struct containing parameters     
%                                   for the MODEL of the structure  [multi]
% -------------------------------------------------------------------------
 
MODEL.M = diag(mass);

return