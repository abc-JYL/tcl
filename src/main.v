module main

fn main() {
	interp := C.Tcl_CreateInterp()
	C.Tcl_Init(interp)
	C.Tk_Init(interp)
	if C.Tcl_Eval(interp, c'wm title . hello; pack [button .h -text "Hello, World!" -command exit]') == C.TCL_ERROR {
		panic(unsafe { cstring_to_vstring(C.Tcl_GetStringResult(interp)) })
	}
	C.Tk_MainLoop()
	C.Tcl_DeleteInterp(interp)
}
