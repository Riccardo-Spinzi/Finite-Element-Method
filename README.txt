# Finite-Element-Method
F.E.M. repository ~ Concluded

This code comes as a really basic algorithm to evaluate displacements and forces in a 2D structure 
modeled with Truss or Euler-Bernoulli beam elements. Each element is made up of 2 nodes, which 
means linear functions are used to get the displacement results. To use the program open the 
Input_model.m file and write the specific structure's properties. To modify the scale of the 
displacements and the vibration modes figures open the "plot_..." .m files and change the n_visual 
parameter. 

Implemented features:

~ Solve problems with different types of elements (both trusses and beams);

~ Implemented the possibility of having different properties on each element;

~ Calculate every force or moment on each node;

~ Solve systems where some node displacements are imposed as boundary conditions;

~ Implement the possibility of having varying properties on one single element (only for TRUSS elements);

~ Model correctly the presence of concentrated springs as constraints with specific structural properties;

Future aims:

~ Develop a Matlab script to study the behaviour of Non-linear strcutures;

~ Implement a simpler code and refine the model with second order elements;

~ Implement a way to compute the stiffness matrix with varying parameters for Euler-Bernoulli beam elements too;

~ Implement a method to compute the discretization of continous loads on the structure automatically;

Changelog:

----28-11 RELEASED v1.0

~ Released first version of F.E.M.;

----02-12 RELEASED v1.1

~ Corrected a bug where having a different number of elements and nodes built singular stiffness matrices;

----09-12 RELEASED v1.3 

~ Corrected bugs where the vibration modes of a full-beam structure weren't displayed properly;

~ Implemented a generic method to evaluate matrices K and M for a mixed-elements structure;

~ Implemented a way to input more than one material properties (A,E,J) in the model;
 
----16-12 RELEASED v1.4
 
~ Implemented a method to evaluate imposed node displacements;
 
~ Modified the force_recovery.m code to get every force or moment on each element;
 
~ Added a FEM_setup.txt file to explain better how to set up the model in order to run the code;
 
~ Added an example of input_model.m file at the bottom of the FEM_setup.txt file;
 
----17-01 RELEASED v1.5

~ Corrected a bug where truss problems where not evaluated correctly;

~ Added the possibility to model concentrated springs in the structure;

~ Implemented the possibility of having varying properties ( EA(x) ) on one single element (only for TRUSS elements);

~ Updated both FEM_setup.txt to show how to use the new implemented features;

~ Added an auxiliary function called 'Integrate_NS' which is able to separate distributed loads in concentrated loads;

~ Added example #2 in the FEM_setup.txt file;

~ Project concluded -> Future aims shifted to next project.

