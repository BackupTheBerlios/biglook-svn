(let* ((win (instantiate::window
	       (title "Grid")))
       (grid (instantiate::grid
		(parent `(,win :expand #t :fill #t))
		(rows 5)
		(columns 4)))
       (l1 (instantiate::button
	      (parent grid)
	      (text "0x0")))
       (l2 (instantiate::button
	      (parent grid)
	      (text "1x0")))
       (l3 (instantiate::button
	      (parent grid)
	      (text "2x0")))
       (l4 (instantiate::button
	      (parent grid)
	      (text "3x0")))
       (l5 (instantiate::button
	      (parent grid)
	      (text "0x1")))
       (l6 (instantiate::button
	      (parent grid)
	      (text "1x1")))
       (l7 (instantiate::button
	      (text "0x2 -> 3x2"))) 
       (l8 (instantiate::button
	      (text "0x3 -> 0x4")))
       (l9 (instantiate::button
	      (text "1x3 -> 3x4"))))
   (container-add! grid l7 :x 0 :width 4 :y 2)
   (container-add! grid l8 :x 0 :y 3 :height 2)
   (container-add! grid l9 :x 1 :width 3 :y 3 :height 1)
   (print "grid:" grid))
