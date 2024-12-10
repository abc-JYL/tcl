module main

import tcl
import tk

fn greet(client_data voidptr, interp &C.Tcl_Interp, objc int, objv &&C.Tcl_Obj) int {
	println('Hello')
	return C.TCL_OK
}

fn main() {
	interp := tcl.tcl_createinterp()
	tcl.tcl_init(interp)
	tk.tk_init(interp)
	tcl.tcl_createobjcommand(interp, 'greet', greet, unsafe { nil }, unsafe { nil })
	if tcl.tcl_eval(interp, 'wm title . hello; pack [button .h -text "Hello, World!" -command greet]') == C.TCL_ERROR {
		panic(unsafe { tcl.tcl_getstringresult(interp) })
	}
	tk.tk_mainloop()
	tcl.tcl_deleteinterp(interp)
}
