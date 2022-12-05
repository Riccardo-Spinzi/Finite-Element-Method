function ELEMENTS = set_pointers( ELEMENTS, NODES, n_els )
for i = 1 : n_els
    if strcmp(ELEMENTS(i).type,'truss') == 1
        n_dof = 2;
    else 
        n_dof = 3;
    end
	for j = 1 : length(ELEMENTS(i).nodes)
        for k = 1 : n_dof
		    ELEMENTS(i).ptrs =[ELEMENTS(i).ptrs, (ELEMENTS(i).nodes(j)-1)*n_dof + k];
        end
	end
end


return