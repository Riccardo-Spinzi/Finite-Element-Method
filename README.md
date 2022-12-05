# Finite-Element-Method
F.E.M. depository ~ WIP

This code comes as a really basic algorithm to evaluate displacements and forces in a 2D structure 
modeled with Trusses or Euler-Bernoulli beam elements. Each element is made up of 2 nodes, which 
means a linear interpolation is used to get the displacement results. 

Future aims:

~ Solve problems with different types of elements(both trusses and beams);

~ Implement the possibility of having varying properties on one single element;

~ Calculate every force or moment on each node (up to now they must be computed separately);

~ Solve systems where some node displacements are imposed as boundary conditions;

~ Model correctly the presence of concentrated springs as constraints with specific structural properties;


28-11
v1.0 Finished 

02-12
v1.1 Corrected a bug where having a different number of elements and nodes built singular stiffness matrices

