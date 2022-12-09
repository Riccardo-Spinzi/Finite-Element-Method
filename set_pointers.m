function ELEMENTS = set_pointers( ELEMENTS, NODES, n_els )

for i = 1 : n_els
    if strcmp(ELEMENTS(i).type,'beam') == 1
        for j = 1 : 2 
            ELEMENTS(i).ptrs = [ELEMENTS(i).ptrs, NODES(ELEMENTS(i).nodes(j)).ass_dof ];
        end   
    else
        for j = 1 : 2 
            ELEMENTS(i).ptrs = [ELEMENTS(i).ptrs, NODES(ELEMENTS(i).nodes(j)).ass_dof(1:2) ];
        end
    end
end


return