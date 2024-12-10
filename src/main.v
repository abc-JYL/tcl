module main

fn greet(client_data voidptr, interp &C.Tcl_Interp, objc int, objv &&C.Tcl_Obj) int {
	println('Hello')
	return C.TCL_OK
}

fn main() {
	interp := C.Tcl_CreateInterp()
	C.Tcl_Init(interp)
	C.Tk_Init(interp)
	C.Tcl_CreateObjCommand(interp, c'greet', greet, unsafe { nil }, unsafe { nil })
	if C.Tcl_Eval(interp, c'wm title . hello; pack [button .h -text "Hello, World!" -command greet]') == C.TCL_ERROR {
		panic(unsafe { cstring_to_vstring(C.Tcl_GetStringResult(interp)) })
	}
	C.Tk_MainLoop()
	C.Tcl_DeleteInterp(interp)
}
