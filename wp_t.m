function M=wp_t(t,ret)
M=rotM(-t)*wp(ret)*rotM(t);