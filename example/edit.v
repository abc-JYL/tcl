import tcl
import tcl.tk
import os

fn C.Tcl_SetVar(&C.Tcl_Interp, &char, &char, int) &char

pub fn setvar(interp &C.Tcl_Interp, name string, new_val string, flag int) string {
	return unsafe { cstring_to_vstring(C.Tcl_SetVar(interp, name.str, new_val.str, flag)) }
}

fn open(client_data voidptr, interp &C.Tcl_Interp, objc int, objv &&C.Tcl_Obj) int {
	tcl.eval(interp, 'tk_getOpenFile -initialdir .')
	setvar(interp, 'data', os.read_file(tcl.getstringresult(interp)) or {
		panic('Failed to open file! $')
	}, C.TCL_GLOBAL_ONLY)
	tcl.eval(interp, '.t delete 0.0 end\n.t insert end \$data')
	return C.TCL_OK
}

fn save(client_data voidptr, interp &C.Tcl_Interp, objc int, objv &&C.Tcl_Obj) int {
	tcl.eval(interp, '.t get 1.0 {end -1c}')
	data := tcl.getstringresult(interp)
	tcl.eval(interp, 'tk_getSaveFile -initialdir .')
	path := tcl.getstringresult(interp)
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
	interp := tcl.createinterp()
	tcl.init(interp)
	tk.init(interp)
	tcl.createobjcommand(interp, 'save', save, unsafe { nil }, unsafe { nil })
	tcl.createobjcommand(interp, 'open', open, unsafe { nil }, unsafe { nil })
	if tcl.eval(interp, script) == C.TCL_ERROR {
		panic(tcl.getstringresult(interp))
	}
	tk.mainloop()
	tcl.deleteinterp(interp)
}