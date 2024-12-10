module tcl

import tk

pub fn tcl_createinterp() &C.Tcl_Interp {
	return C.Tcl_CreateInterp()
}

pub fn tcl_init(interp &C.Tcl_Interp) int {
	return C.Tcl_Init(interp)
}

pub fn tcl_eval(interp &C.Tcl_Interp, code string) int {
	return C.Tcl_Eval(interp, code.str)
}

pub fn tcl_getstringresult(interp &C.Tcl_Interp) string {
	return unsafe { cstring_to_vstring(C.Tcl_GetStringResult(interp)) }
}

pub fn tcl_deleteinterp(interp &C.Tcl_Interp) {
	C.Tcl_DeleteInterp(interp)
}

pub fn tcl_createobjcommand(interp &C.Tcl_Interp, name string, function voidptr, clientdata voidptr, deleteproc voidptr) voidptr {
	return C.Tcl_CreateObjCommand(interp, name.str, function, clientdata, deleteproc)
}
