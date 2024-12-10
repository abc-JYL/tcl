import tcl
import tcl.tk

import time

fn update_time(client_data voidptr, interp &C.Tcl_Interp, objc int, objv &&C.Tcl_Obj) int {
	t := time.now()
	tcl.eval(interp, '.label configure -text "$t"\nafter 500 update_time')
	return C.TCL_OK
}

fn main() {
	script := ('
		wm title . "Clock"
		label .label -font "Helvetica 36 bold" -bg black -fg white -padx 20 -pady 20
		pack .label
		update_time
	')
	interp := tcl.createinterp()
	tcl.init(interp)
	tk.init(interp)
	tcl.createobjcommand(interp, "update_time", update_time, unsafe { nil }, unsafe { nil })
	if tcl.eval(interp, script) == C.TCL_ERROR {
		panic(tcl.getstringresult(interp))
	}
	tk.mainloop()
	tcl.deleteinterp(interp)
}
