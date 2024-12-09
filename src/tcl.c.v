module tcl

#flag -ltcl
#include <tcl.h>

pub struct C.Tcl_Interp {}

pub struct C.ClientData {}

pub struct C.Tcl_Obj {}

pub struct C.Tcl_Command {}

pub struct C.Tcl_CmdInfo {}

fn C.Tcl_CreateInterp() &C.Tcl_Interp
fn C.Tcl_Init(&C.Tcl_Interp) int
fn C.Tcl_Eval(&C.Tcl_Interp, &char) int
fn C.Tcl_GetStringResult(&C.Tcl_Interp) &char
fn C.Tcl_DeleteInterp(&C.Tcl_Interp)
