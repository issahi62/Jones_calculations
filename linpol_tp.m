function M=linpol_tp(t,px,py)
M=rotM(-t)*linpol_p(px,py)*rotM(t);