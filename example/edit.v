import tcl
import tcl.tk
import os

fn open(client_data voidptr, interp &C.Tcl_Interp, objc int, objv &&C.Tcl_Obj) int {
	tcl.eval(interp, 'tk_getOpenFile -initialdir .')
	tcl.set_var(interp, 'data', os.read_file(tcl.get_string_result(interp)) or {
		panic('Failed to open file! $')
	}, C.TCL_GLOBAL_ONLY)
	tcl.eval(interp, '.t delete 0.0 end\n.t insert end \$data')
	return C.TCL_OK
}

fn save(client_data voidptr, interp &C.Tcl_Interp, objc int, objv &&C.Tcl_Obj) int {
	tcl.eval(interp, '.t get 1.0 {end -1c}')
	data := tcl.get_string_result(interp)
	tcl.eval(interp, 'tk_getSaveFile -initialdir .')
	path := tcl.get_string_result(interp)
	os.write_file(path, data) or { panic('Failed to save file!') }
	return C.TCL_OK
}

fn main() {
	script := ('
		option add *tearOff 0

		wm title . "Edit"
		pack [scrollbar .sbar -orient vertical -command {.t yview}] -side right -fill y
		pack [text .t -yscrollcommand {.sbar set}] -fill both -expand 1

		menu .menuBar

		menu .menuBar.file
		.menuBar add cascade -label "File" -menu .menuBar.file
		.menuBar.file add command -label "Open" -command { open }
		.menuBar.file add command -label "Save" -command { save }
		.menuBar.file add separator
		.menuBar.file add command -label "Exit" -command { exit }

		menu .menuBar.help
		.menuBar add cascade -label "Help" -menu .menuBar.help
		.menuBar.help add command -label "About" -command { tk_messageBox -type ok -message "This is a simple Tk/Tcl menu bar example." }

		. configure -menu .menuBar
	')
	interp := tcl.create_interp()
	tcl.init(interp)
	tk.init(interp)
	tcl.create_obj_command(interp, 'save', save, unsafe { nil }, unsafe { nil })
	tcl.create_obj_command(interp, 'open', open, unsafe { nil }, unsafe { nil })
	if tcl.eval(interp, script) == C.TCL_ERROR {
		panic(tcl.get_string_result(interp))
	}
	tk.main_loop()
	tcl.delete_interp(interp)
}
