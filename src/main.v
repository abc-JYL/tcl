import tcl
import tk

fn greet(client_data voidptr, interp &C.Tcl_Interp, objc int, objv &&C.Tcl_Obj) int {
	tcl.set_obj_result(interp, tcl.new_string_obj('Hello World!', -1))
	return C.TCL_OK
}

fn main() {
	interp := tcl.create_interp()
	tcl.init(interp)
	tk.init(interp)
	tcl.create_obj_command(interp, 'greet', greet, unsafe { nil }, unsafe { nil })
	if tcl.eval(interp, 'wm title . hello; pack [button .h -text "Hello, World!" -command {puts [greet]}]') == C.TCL_ERROR {
		panic(tcl.get_string_result(interp))
	}
	tk.main_loop()
	tcl.delete_interp(interp)
}
