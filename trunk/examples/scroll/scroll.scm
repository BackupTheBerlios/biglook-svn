(let ((w (instantiate::window
	    (width 150)
	    (height 300))))
   (make-scroll-frame w)
   (make-scroll-canvas w)
   (widget-visible-set! w #t))

(define (make-scroll-canvas w)
   (let* ((s (instantiate::scroll
		(parent `(,w :expand #t :fill #t))
		(hside 'bottom)
		(height 200)
		(vside 'right)
		(hpolicy 'automatic)
		(vpolicy 'automatic)))
	  (c (instantiate::canvas
		(parent `(,s :expand #t :fill #t))
		(width 500)
		(height 500)))
	  (l (instantiate::canvas-line
		(canvas c)
		(points '(0 0 500 500))))
	  (t (instantiate::canvas-text
		(canvas c)
		(text "A text")
		(x 250)
		(y 250))))
      (scroll-vfraction-set! s 0.1)
      (scroll-hfraction-set! s 0.1)
      (instantiate::button
	 (parent w)
	 (text "scroll...")
	 (command (lambda (e)
		     (let ((frac (/fl (exact->inexact (random 100)) 100.)))
			(print "old-vfraction: " (scroll-vfraction s))
			(print "new-vfraction: " frac)
			(print "old-hfraction: " (scroll-hfraction s))
			(print "new-hfraction: " frac)
			(newline)
			(scroll-vfraction-set! s frac)
			(scroll-hfraction-set! s frac)))))
      (print "scroll: " s)
      (print "children: " (map find-runtime-type (container-children s)))))
		      
(define (make-scroll-frame w)
   (let* ((p (instantiate::frame
		(parent w)
		(title "An scrollframe")))
	  (s (instantiate::scroll
		(parent p)
		(hpolicy 'always)
		(vpolicy 'automatic)))
	  (sf (instantiate::frame
		 (parent s)))
	  (ltop (instantiate::label
		   (parent sf)
		   (text "top")))
	  (hbox (instantiate::box
		   (orientation 'horizontal)
		   (parent sf)))
	  (bleft (instantiate::button
		    (parent hbox)
		    (border-width 5)
		    (image (string->image "/* XPM */
static char *magick[] = {
/* columns rows colors chars-per-pixel */
\"48 57 11 1\",
\"  c #040303\",
\". c #473b26\",
\"X c #655f53\",
\"o c #996d13\",
\"O c #b69122\",
\"+ c #998d77\",
\"@ c #e8b311\",
\"# c #eec71c\",
\"$ c #b7b5b0\",
\"% c #f6f4f4\",
\"& c None\",
/* pixels */
\"&&&&&&&&&&&&&&&&&&&&&X    .&&&&&&&&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&&&&X        .&&&&&&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&&&.           X&&&&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&&.         XX  X&&&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&X          XX   &&&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&.               X&&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&.                &&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&                 X&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&         .X..    X&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&  X$X   .$$$X    X&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&& .$$%.  $%+$$    .&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&.X..$&  %X X%.   .&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&.X. X&  $.  $X   .&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&. $ o@@OOo .%.   .&&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&. +O@#####@&&     &&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&X oO@########     &&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&X.O@@#####@OO     X&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&X o@@###@OOOO  .  X&&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&X +oOOOooOOO&. X&  &&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&X $+oOOOOO$$$$  X  .&&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&&  $$+oooO&$%%%.     X&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&X .%$$$$$$$%%%%$     .&&&&&&&&&&&\",
\"&&&&&&&&&&&&&&&  $%%$$$$%%%%%%%.     X&&&&&&&&&&\",
\"&&&&&&&&&&&&&&  X%%%%$%%%%%%%%%$      &&&&&&&&&&\",
\"&&&&&&&&&&&&&.  %%%%%%%%%%%%%%%%      .&&&&&&&&&\",
\"&&&&&&&&&&&&X  X%%%%%%%%%%%%%%%%.      .&&&&&&&&\",
\"&&&&&&&&&&&X   &$%%%%%%%%%%$$$$$+       X&&&&&&&\",
\"&&&&&&&&&&&.   $$%%%%%%%%%%%$$$$%.       &&&&&&&\",
\"&&&&&&&&&&&   .$%%%%%%%%%%%%%%%$$+       X&&&&&&\",
\"&&&&&&&&&&X   $%%%%%%%%%%%%%%%%%%$        &&&&&&\",
\"&&&&&&&&&&   X%%%%%%%%%%%%%%%%%%%%& .     X&&&&&\",
\"&&&&&&&&&X   $%%%%%%%%%%%%%%%%%%%%$   .   .&&&&&\",
\"&&&&&&&&&.  X%%%%%%%%%%%%%%%%%%%%%%        &&&&&\",
\"&&&&&&&&&   $%%%%%%%%%%%%%%%%%%%%%%.       X&&&&\",
\"&&&&&&&&X   %%%%%%%%%%%%%%%%%%%%%%%.       X&&&&\",
\"&&&&&&&&    %%%%%%%%%%%%%%%%%%%%%%%X       .&&&&\",
\"&&&&&&&.   .%%%%%%%%%%%%%%%%%%%%%%%X        &&&&\",
\"&&&&&&&   ..%%%%%%%%%%%%%%%%%%%%%%%&        &&&&\",
\"&&&&&&&   .X%%%%%%%%%%%%%%%%%%%%%%%X       .&&&&\",
\"&&&&&&& oo X%%%%%%%%%%%%%%%%%%%%%%%X     . .&&&&\",
\"&&&&&&&O@@@ $%%%%%%%%%%%%%%%%%%%%##X     . X&&&&\",
\"&&&&&&OO@@@O +%%%%%%%%%%%%%%%%%%$@#O      oO&&&&\",
\"&&&&&+OO@@@@o .%%%%%%%%%%%%%%%%%$@@o     o##&&&&\",
\"&&&+oOO@##@@#. .%%%%%%%%%%%%%%%%&@@o.   o@@@&&&&\",
\"+OOOO@@@@@@@@O  .%%%%%%%%%%%%%%$&@OOooooO@@@+&&&\",
\"OO@@@@@@@@@@##o   $%%%%%%%%%%%%$&O@OOOOO@@#@@+&&\",
\"+@@#@@@@@#@@@@@   X%%%%%%%%%%%%%$O@@@@O@@@@@@@&&\",
\"+O@#@@@@@#@@@@#o  X%%%%%%%%%%%%%oO@@@@@@@@@@@@@+\",
\"+O@@@@@@@@@#@@@#o$%%%%%%%%%%%%$ .O@@@@@@@#@@@@@@\",
\"+O@@@@@@@@#@@@@@@$%%%%%%%%%%%$  XO@@#@@@@@@@#@#@\",
\"+O@@@@@@@@@@@@#@@o%%%%%%%%%%X   oO@@@#@@@#@@@@@O\",
\"OO@@@@@@@#@@@@@@@o.&$$$$+X.     oO@@@@@@@@@@@O+&\",
\"OOOO@@@@@@@@#@@@Oo.             oO@@#@@@@@@O+&&&\",
\"+ooOOOOOOO@@@@@@OoX             oOO@@@@@OOX&&&&&\",
\"&&&XXoooooOOOOOOoo.   ........  XoOOOOOOoX&&&&&&\",
\"&&&&&&&XXoooooooo..X&&&&&&&&&&&&.ooooooo+&&&&&&&\",
\"&&&&&&&&&&XXoooo.X&&&&&&&&&&&&&&X.ooooX&&&&&&&&&\"
};"))))
	  (bright (instantiate::button
		     (parent hbox)
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
	  (lbottom (instantiate::label
		      (parent sf)
		      (text "bottom"))))
      (print "scroll: " s)
      (print "children: " (map find-runtime-type (container-children s)))))


