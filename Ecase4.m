function Eout=Ecase4(Ein, wp_angle_sample, retardance_sample, pol_angle_sample, px_sample, py_sample, analyzer_angles, px_analyzer, py_analyzer)

      Eout = linpol_tp(analyzer_angles, px_analyzer, py_analyzer) *...
              linpol_tp(180-pol_angle_sample, px_sample, py_sample) *... 
              wp_t(180-wp_angle_sample, retardance_sample) *... 
              Ein;