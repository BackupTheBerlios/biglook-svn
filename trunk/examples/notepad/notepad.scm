(let* ((win (instantiate::window
	       (title "An notepad demo")))
       (notepad (instantiate::notepad
		   (parent win)
		   (width 450)
		   (height 150))))
   (container-add! notepad (make-tab1) :title "host1")
   (container-add! notepad (make-tab1) :title "host2")
   (container-add! notepad (make-tab2) :title #"Multi-line\ntitle")
   (container-add! notepad (make-tab3 "A pixmap for label")
		   :image (string->image (pixmap1)))
   (container-add! notepad (make-tab3 "A pixmap and a text for label")
		   :image (string->image (pixmap2)) :title "image + text")
   (container-add! notepad (make-position notepad))
   (widget-visible-set! win #t))

(define (make-tab1)
   (define (make-labeled-entry parent title)
      (let ((hbox (instantiate::box
		     (orientation 'horizontal)
		     (parent parent)
		     (padding 2))))
	 (instantiate::label
	    (text title)
	    (width 70)
	    (parent hbox))
	 (instantiate::entry
	    (parent hbox)
	    (width 300))))
   (let* ((f (instantiate::frame
		(border-width 3)
		(padding 5)
		(shadow 'etched-in)))
	  (e1 (make-labeled-entry f "Host: "))
	  (e2 (make-labeled-entry f "Port: ")))
      f))

(define (make-tab2)
   (instantiate::label
      (justify 'center)
      (text "This is a simple demonstration.")))

(define (make-tab3 msg)
   (let* ((frame (instantiate::frame
		    (border-width 3)
		    (shadow 'in)
		    (title "Another tab")))
	  (lbl (instantiate::label
		  (parent frame)
		  (text msg))))
      frame))

(define (make-position notepad)
   (letrec ((radio (instantiate::radio
		      (title "Tabs position")
		      (orientation 'horizontal)
		      (texts '("Top" "Right" "Bottom" "Left"))
		      (command (lambda (e)
				  (let ((s (string->symbol
					    (string-downcase
					     (radio-value
					      radio)))))
				     (notepad-position-set! notepad s)))))))
      radio))

(define (pixmap1)
   "/* XPM */
static char * image_name[] = {
\"33 33 12 1\",
\" 	c #F7F7F3F3F7F7\",
\".	c None\",
\"X	c #B6B6B6B6B6B6\",
\"o	c #000000001010\",
\"O	c #A6A6A2A2A6A6\",
\"+	c #969692929696\",
\"@	c #717182829696\",
\"#	c #000000000000\",
\"$	c #A6A69E9EA6A6\",
\"%	c #696971718E8E\",
\"&	c #AEAEA6A6AEAE\",
\"*	c #FFFF14144141\",
\".................................\",
\".................................\",
\".................................\",
\".@.@@@@@.@..###################..\",
\"...........###################...\",
\"...........###################...\",
\".@@@@@....##################.....\",
\"..........#################......\",
\".@@@@....###################.....\",
\".........########..#########.....\",
\"........########....#######......\",
\"........########...########......\",
\"..@@@%@@########..########.......\",
\"....&..###################.......\",
\"......########..###.#####........\",
\".%@@..########...########........\",
\".&...#######...#########.........\",
\".....########. #########.........\",
\".@@.########..#########..........\",
\"....###############...##.........\",
\"...###############.....#.####....\",
\"..........#..#....###.####**##...\",
\".....####..#..#.....#.###**#..#..\",
\"....#X#*####..#.....##..#*.#X.o..\",
\"..@.#.**#.....#.@@.#...#*.o..X#..\",
\"....#X***#...#.....#..#..#X. #...\",
\"....o.**#####.......##.##..##....\",
\".@@..#.***#....@@.@@.##.X.oX.....\",
\".....oX.***#.........#.Xo#.......\",
\".....##X.**#....@@@@@.#o.........\",
\"..@@..#oX.*#.....................\",
\".......#o##......................\",
\".................................\",
};")

(define (pixmap2)
   "/* XPM */
static char *foo[] = {
/* width height num_colors chars_per_pixel */
\"    28    28        2            1\",
/* colors */
\"_ c None\",
\"# c #000000\",
/* pixels */
\"____________________________\",
\"____________________________\",
\"____________________________\",
\"____________________________\",
\"________##########__________\",
\"_______##_#_#_#_#_#_________\",
\"______##_#_#_#_#_#_#________\",
\"_____##_#_#######_#_#_______\",
\"_____#_#_#########_#_#______\",
\"_____##_###########_#_______\",
\"_____#_#_###_#_###_#_#______\",
\"_____##_#####_#####_#_#_____\",
\"_____#_#_###_#_###_#_#_#____\",
\"_____##_#_#_#_#####_#_#_#___\",
\"_____#_#_#_#_#####_#_####___\",
\"_____##_#_#_#####_#_#_______\",
\"______##_#_#####_#_#_#______\",
\"_______##_#_###_#_#_#_______\",
\"________##_#####_#_#________\",
\"_________##_#_#_#_#_#_______\",
\"_________#_#_#_#_#_#________\",
\"_________##_###_#___________\",
\"_________#_#####_#__________\",
\"_________##_###_#___________\",
\"________##_#_#_#_#__________\",
\"________#_#_#_#_#_#_________\",
\"____________________________\",
\"____________________________\"
};")
