# Finite-Element-Method
F.E.M. depository ~ WIP

This code comes as a really basic algorithm to evaluate displacements and forces in a 2D structure 
modeled with Trusses or Euler-Bernoulli beam elements. Each element is made up of 2 nodes, which 
means a linear interpolation is used to get the displacement results. To use the program open the 
Input_model.m file and write the specific structure's properties. To modify the scale of the 
displacements and the vibration modes figures open the "plot_..." .m files and change the n_visual 
parameter. 

Implemented features:

~ Solve problems with different types of elements (both trusses and beams);

~ Implement the possibility of having varying properties on one single element;

Future aims:

~ Calculate every force or moment on each node (up to now they must be computed separately);

~ Solve systems where some node displacements are imposed as boundary conditions;

~ Model correctly the presence of concentrated springs as constraints with specific structural properties;

Changelog:

----28-11 RELEASED v1.0

~  Released first version of F.E.M.;

----02-12 RELEASED v1.1

~  Corrected a bug where having a different number of elements and nodes built singular stiffness matrices;

----09-12 RELEASED v1.3 

~ 	Corrected bugs where the vibration modes of a full-beam structure weren't displayed properly;

~ Implemented a generic method to evaluate matrices K and M for a mixed-elements structure;

~ Implemented a way to input more than one material properties (A,E,J) in the model;
 
