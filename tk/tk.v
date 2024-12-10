module tk

pub struct C.Tcl_Interp {}

pub fn init(interp &C.Tcl_Interp) int {
	return C.Tk_Init(interp)
}

pub fn mainloop() {
	C.Tk_MainLoop()
}
