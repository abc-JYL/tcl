module tk

#flag darwin -L/opt/X11/lib -I/opt/X11/include
#flag -ltk

#include <tk.h>

fn C.Tk_Init(&C.Tcl_Interp) int
fn C.Tk_MainLoop()
