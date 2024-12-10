module tcl

#pkgconfig tk

#include <tk.h>

fn C.Tk_Init(&C.Tcl_Interp) int
fn C.Tk_MainLoop()
