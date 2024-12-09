module main

fn main() {
	interp := C.Tcl_CreateInterp()
	C.Tcl_Init(interp)
	C.Tk_Init(interp)
	C.Tcl_Eval(interp, c'wm title . hello')
	C.Tcl_Eval(interp, c'pack [button .h -text "Hello, World!" -command exit]')
	C.Tk_MainLoop()
	C.Tcl_DeleteInterp(interp)
}
