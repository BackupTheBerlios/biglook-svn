(let* ((win (instantiate::window
	       (x 100)
	       (y 100)
	       (title "Area")))
       (area (instantiate::area
		(parent `(,win :expand #t :fill 'both))))
       (l1 (instantiate::button
	      (parent area)
	      (text "North")))
       (l2 (instantiate::button
	      (parent area)
	      (text "West")))
       (l3 (instantiate::button
	      (parent area)
	      (text "Center")))
       (l4 (instantiate::button
	      (text "South")))
       (l5 (instantiate::label
	      (text "East"))))
   (container-add! area l4 :zone 'south)
   (container-add! area l5 :zone 'east)
   (print "area:" area))
