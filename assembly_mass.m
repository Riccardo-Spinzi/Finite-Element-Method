function MODEL = assembly_mass( MODEL, mass)

MODEL.M = diag(mass);

return