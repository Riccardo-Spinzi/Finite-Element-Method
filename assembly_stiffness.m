function MODEL = assembly_stiffness( ELEMENTS, MODEL )

% --- Assembly stiffness matrix
for i = 1 : MODEL.nels
    ptrs = ELEMENTS( i ).ptrs;
    K_el = ELEMENTS( i ).K_el;
    MODEL.K( ptrs, ptrs ) = MODEL.K( ptrs, ptrs ) + K_el;
end

return