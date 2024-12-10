module tcl

pub fn tk_init(interp &C.Tcl_Interp) int {
	return C.Tk_Init(interp)
}

pub fn tk_mainloop() {
	C.Tk_MainLoop()
}
