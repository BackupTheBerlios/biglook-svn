;*---------------------------------------------------------------------*/
;*    GUI                                                              */
;*---------------------------------------------------------------------*/
(let* ((win (instantiate::window
	       (x 200)
	       (y 200)
	       (title "Biglook Canvas")))
       (canvas (instantiate::canvas
		  (width 400)
		  (tooltips "Foo, Bar ?")
		  (parent `(,win :expand #t :fill #t))))
       (drag-handler (make-drag-event-handler)))
   (widget-visible-set! win #t)
   ;(setup-widgets canvas)
   (setup-texts canvas drag-handler)
   (setup-lines canvas drag-handler)
   ;(setup-shapes canvas drag-handler)
   ;(setup-images canvas drag-handler)
   )

;*---------------------------------------------------------------------*/
;*    setup-widgets ...                                                */
;*---------------------------------------------------------------------*/
(define (setup-widgets canvas)
   (let* ((but (instantiate::button
		  (text "A button in a canvas")
		  (tooltips "A button tooltip...")
		  (command (lambda (e)
			      (print "A click")))))
	  (grid (instantiate::grid
		   (width 60)
		   (height 20)
		   (columns 3)
		   (rows 1)))
	  (rad (instantiate::radio
		  (texts '("1" "2" "3" "4"))
		  (shadow 'etched-in)
		  (orientation 'vertical)
		  (command (lambda (e)
			      (print "A click: "
				     (button-text (event-widget e))))))))
      (instantiate::label
	 (parent grid)
	 (text "1.1"))
      (instantiate::label
	 (parent grid)
	 (text "1.2"))
      (instantiate::label
	 (parent grid)
	 (text "1.3"))
      (instantiate::canvas-widget
	 (canvas canvas)
	 (widget but)
	 (x 140)
	 (y 170))
      (instantiate::canvas-widget
	 (canvas canvas)
	 (widget rad)
	 (x 350)
	 (y 5))
      (instantiate::canvas-widget
	 (canvas canvas)
	 (widget grid)
	 (width 60)
	 (height 30)
	 (x 10)
	 (y 1))))
	    
;*---------------------------------------------------------------------*/
;*    setup-texts ...                                                  */
;*---------------------------------------------------------------------*/
(define (setup-texts canvas drag-handler)
   (instantiate::canvas-text
      (canvas canvas)
      (x 100)
      (y 10)
      (anchor 'w)
      (event drag-handler)
      (text "West anchor"))
   (instantiate::canvas-text
      (canvas canvas)
      (x 100)
      (y 30)
      (anchor 'center)
      (font (instantiate::font
	       (family "courier")
	       (size 14)))
      (event drag-handler)
      (text "Center anchor"))
   (instantiate::canvas-text
      (canvas canvas)
      (x 100)
      (y 50)
      (anchor 'e)
      (color (instantiate::rgb-color
		(red 200)
		(green 20)
		(blue 30)))
      (text "East anchor")))

;*---------------------------------------------------------------------*/
;*    setup-lines ...                                                  */
;*---------------------------------------------------------------------*/
(define (setup-lines canvas drag-handler)
   (define x (instantiate::canvas-line
      (canvas canvas)
      (style 'dashed)
      (points '(10 150 200 160))))

   (print (canvas-line-thickness x))
   (instantiate::canvas-line
      (canvas canvas)
      (points '(10 100 30 140 50 120 45 150))
      (arrow '<->)
      (arrow-shape '(18 12 14))
      (thickness 3)
      (event drag-handler))
   
   (instantiate::canvas-line
      (canvas canvas)
      (color (instantiate::rgb-color (red 0) (green 0) (blue 255)))
      (arrow '->)
      (style 'dotted)
      (arrow-shape '(20 12 10))
      (points '(10 150 200 100)))
   
   )

;*---------------------------------------------------------------------*/
;*    setup-shapes ...                                                 */
;*---------------------------------------------------------------------*/
(define (setup-shapes canvas drag-handler)
   (instantiate::canvas-rectangle
      (canvas canvas)
      (x 300)
      (y 30)
      (width 40)
      (height 20)
      (outline (instantiate::rgb-color
		  (red 145)
		  (blue 132)))
      (color (instantiate::rgb-color))
      (tooltips "A tooltips...")
      (event drag-handler))
   (instantiate::canvas-ellipse
      (canvas canvas)
      (x 300)
      (y 100)
      (width 40)
      (height 30)
      (outline (instantiate::rgb-color
		  (blue 132)
		  (red 145)))
      (color (instantiate::rgb-color))
      (tooltips "A tooltips...")
      (event drag-handler)))

;*---------------------------------------------------------------------*/
;*    setup-images ...                                                 */
;*---------------------------------------------------------------------*/
(define (setup-images canvas drag-handler)
   (let ((image (string->image "/* XPM */
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
};")))
      (instantiate::canvas-image
	 (canvas canvas)
	 (event drag-handler)
	 (x (-fx 100 (inexact->exact (/ (image-width image) 2))))
	 (y (+fx 100 (inexact->exact (/ (image-height image) 2))))
	 (image image)))
   (instantiate::canvas-image
      (canvas canvas)
      (event drag-handler)
      (x 150)
      (y 100)
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
\"                                    o        \"};")))
   (instantiate::canvas-image
      (canvas canvas)
      (event drag-handler)
      (x 200)
      (y 100)
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
\"                                    o        \"};"))
      (height 20)
      (width 100)))

;*---------------------------------------------------------------------*/
;*    make-drag-event-handler ...                                      */
;*---------------------------------------------------------------------*/
(define (make-drag-event-handler)
   (let* ((in-color (instantiate::rgb-color
		       (red 0)
		       (green 0)
		       (blue 150)))
	  (out-color (name->color "black"))
	  (move-x 0)
	  (move-y 0))
      (instantiate::event-handler
	 (enter (lambda (e)
		   (let ((l (event-widget e)))
		      (canvas-item-color-set! l in-color))))
	 (leave (lambda (e)
		   (let ((l (event-widget e)))
		      (canvas-item-color-set! l out-color))))
	 (press (lambda (e)
		   (with-access::event e (x y)
		      (set! move-x x)
		      (set! move-y y))))
	 (motion (lambda (e)
		    (with-access::event e (widget x y button)
		       (if (=fx button 1)
			   (begin
			      (canvas-item-move widget
						(-fx x move-x)
						(-fx y move-y))
			      (set! move-x x)
			      (set! move-y y)))))))))

