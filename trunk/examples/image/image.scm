(let* ((p (instantiate::window
	     (title "Image")))
       (i1 (instantiate::file-image
	      (parent p)
	      (file "linux.gif")))
       (i2 (instantiate::button
	      (parent p)
	      (border-width 5)
	      (image (string->image "/* XPM */
static char * Daemon_xpm[] = {
\"45 43 16 1\",
\"       c None\",
\".      c #6185208128A2\",
\"X      c #A69924922081\",
\"o      c #8E3824921861\",
\"O      c #4103249230C2\",
\"+      c #79E728A22081\",
\"@      c #38E3249230C2\",
\"#      c #A69914511040\",
\"$      c #DF7DE79DEFBE\",
\"%      c #6185208130C2\",
\"&      c #4924186128A2\",
\"*      c #186114511040\",
\"=      c #69A62CB230C2\",
\"-      c #B6DAB2CAB6DA\",
\";      c #79E769A679E7\",
\":      c #492430C230C2\",
\"                   .X                        \",
\"                 oO            +             \",
\"                +@.            ++            \",
\"               X.@X X+.+        o+           \",
\"              +X.O.+o++O@@.     +oO          \",
\"              oo.++oo+.@O@OO   X.oO          \",
\"              #+X$$Xo+X.++.%@X.XoO%O         \",
\"              ooX$XX$$oo+++.+XXo.%%          \",
\"              .$$$o$$$$oo++++++@&%           \",
\"              .$$oX$$$$oo++.@.O%&&           \",
\"             ..@%.XX$$$ooo+O%&&@%            \",
\"             ..%O%X@$$$Xo+.O%&%@             \",
\"            +oo@.%@@$$XXo+.O%%O              \",
\"       XX   ##+#o.@%$$XXo+.O%@O              \",
\"        OX  #o+#o..XX@oo++.O%%O              \",
\"      X  X@ oo++...#####++.%&@               \",
\"      o@  @ .o+oooo##X#o..O%%.               \",
\"   .X   @@O    ..ooo....%O%%.                \",
\"    @o   @O X+o ........@%%X                 \",
\"     OO.@@OO##o  .+o+@@@%&%                  \",
\"           ...O  X+ooooo+@O                  \",
\"           +o+%O..oX#oo#o@%                  \",
\"           ..O.%Oo##+++.+@@                  \",
\"            ++.@Oo##oo@@+%%                  \",
\"            +.O@@o###o+@%%&X                 \",
\"               ..oo+.%%&@@%o                 \",
\"               X@...%O%&%%%                  \",
\"               o#.@%&O%OOO%                  \",
\"               +#o.O%OOO&&%                  \",
\"               Xo##+++.%OOOX                 \",
\"                .ooo+.%&%OO&                 \",
\"                 ...O%&&OO%O.                \",
\"                 +o..+.O%@O@%O               \",
\"               *+=-$;**+:@@*%@@              \",
\"   ;-$$$$$-;;=*=.*-=**..;;*  ..%%%OX         \",
\"   $;$$$$--*$$$OO*-***..*:@     O@@O@@X      \",
\"   =;$$$-O$$$$$--;=====@@@@@         X...@   \",
\"     @**@*$;:;-;;:@:@@@@@;;;            Xo.  \",
\"          -$---;;@;@;;;;;@;*             o+@ \",
\"                *****               oo     %*\",
\"                                 ooXooo.@O***\",
\"                                    o.****** \",
\"                                    o        \"};"))))
       (i3 (instantiate::data-image
	      (parent p)
	      (data "/* XPM */
static char * dir_xpm[] = {
\"16 16 5 1\",
\" 	c None\",
\".	c #eeeeee\",
\"X	s goldenrod1\",
\"o	s white\",
\"O	s grey4\",
\"                \",
\"  .....         \",
\" .XXXXX.        \",
\".XXXXXXX......  \",
\".oooooooooooo.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\"..............O \",
\" OOOOOOOOOOOOOO \",
\"                \",
\"                \"};"))))
   (print "xpm:" i2)
   (print "gif:" i1))
   
