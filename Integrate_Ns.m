        % % --------------- FUNCTION INFO ---------------- % %

% Integrate_NS decomposes a distributed load into its components on the two
% nodes of one element. Remember that in Euler-Bernoulli beam elements, a
% clockwise moment is a positive moment.
% if the load is constant DO NOT REMOVE the term 0*x, simply add the 
% constant part
% -------------------------------------------------------------------------
% Input arguments:
% len_el       [1x1 double]      length of the element                  [m] 
% q            [function]        function for the distribute load   [multi] 
%
% -------------------------------------------------------------------------
% Output arguments:
%
% -------------------------------------------------------------------------

% Data
len_el = 0;
q = @(x) 0*x; 

% Useful functions 
N1 = @(x,l) 1 - 3*(x/l).^2 + 2 * (x/l).^3;
N2 = @(x,l) - (x) .* (1 - x/l).^2;
N3 = @(x,l) 3*(x/l).^2 - 2*(x/l).^3;
N4 = @(x,l) -(x).*((x/l).^2 - (x/l));

% orthogonal force node 1 
integral(@(x) N1(x,len_el).*q(x), 0, len_el)

% momentum node 1 
integral(@(x) N2(x,len_el).*q(x), 0, len_el)

% orthogonal force node 2
integral(@(x) N3(x,len_el).*q(x), 0, len_el)

% momentum node 2
integral(@(x) N4(x,len_el).*q(x), 0, len_el)
