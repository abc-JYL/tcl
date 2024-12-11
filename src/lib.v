module tcl

pub fn create_interp() &C.Tcl_Interp {
	return C.Tcl_CreateInterp()
}

pub fn init(interp &C.Tcl_Interp) int {
	return C.Tcl_Init(interp)
}

pub fn eval(interp &C.Tcl_Interp, code string) int {
	return C.Tcl_Eval(interp, code.str)
}

pub fn get_string_result(interp &C.Tcl_Interp) string {
	return unsafe { cstring_to_vstring(C.Tcl_GetStringResult(interp)) }
}

pub fn delete_interp(interp &C.Tcl_Interp) {
	C.Tcl_DeleteInterp(interp)
}

pub fn create_obj_command(interp &C.Tcl_Interp, name string, function voidptr, clientdata voidptr, deleteproc voidptr) voidptr {
	return C.Tcl_CreateObjCommand(interp, name.str, function, clientdata, deleteproc)
}

pub fn set_var(interp &C.Tcl_Interp, name string, new_val string, flag int) string {
	return unsafe { cstring_to_vstring(C.Tcl_SetVar(interp, name.str, new_val.str, flag)) }
}

pub fn new_string_obj(s string, length int) &C.Tcl_Obj {
	return C.Tcl_NewStringObj(s.str, length)
}

pub fn set_obj_result(interp &C.Tcl_Interp, obj &C.Tcl_Obj) {
	C.Tcl_SetObjResult(interp, obj)
}
