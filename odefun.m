function res = odefun(time,y,M_ext,K_ext,F_ext)

res = M_ext\(K_ext*y+F_ext*cos(time));