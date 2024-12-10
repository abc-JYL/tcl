module tcl

#pkgconfig tcl
#flag -Wno-error=incompatible-pointer-types
#include <tcl.h>

pub struct C.Tcl_Interp {}

fn C.Tcl_CreateInterp() &C.Tcl_Interp
fn C.Tcl_Init(&C.Tcl_Interp) int
fn C.Tcl_Eval(&C.Tcl_Interp, &char) int
fn C.Tcl_GetStringResult(&C.Tcl_Interp) &char
fn C.Tcl_DeleteInterp(&C.Tcl_Interp)
fn C.Tcl_CreateObjCommand(&C.Tcl_Interp, &char, voidptr, voidptr, voidptr) voidptr