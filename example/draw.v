import tcl
import tcl.tk

fn main() {
	script := [
		'wm title . "Draw"',
		'',
		'proc doodle {w {color black}} {',
		"   bind \$w <1>         [list doodle'start %W %x %y \$color]",
		"   bind \$w <B1-Motion> {doodle'move %W %x %y}",
		'}',
		"proc doodle'start {w x y color} {",
		'   set ::_id [\$w create line \$x \$y \$x \$y -fill \$color]',
		'}',
		"proc doodle'move {w x y} {",
		'	\$w coords \$::_id [concat [\$w coords \$::_id] \$x \$y]',
		'}',
		'pack [canvas .c -bg white] -fill both -expand 1',
		'doodle       .c',
		'bind .c <Double-3> {%W delete all}',
	]
	interp := tcl.create_interp()
	tcl.init(interp)
	tk.init(interp)
	if tcl.eval(interp, script.join('\n')) == C.TCL_ERROR {
		panic(tcl.get_string_result(interp))
	}
	tk.main_loop()
	tcl.delete_interp(interp)
}
