(let* ((box (instantiate::box
	       (orientation 'vertical)
	       (homogeneous #f)))
       (win (instantiate::window
	       (title "Labels")
	       (layout box)))
       (l1 (instantiate::label
	      (parent win)
	      (text "A first label")))
       (l2 (instantiate::label
	      (parent win)
	      (text "A second label")
	      (justify 'left)))
       (l3 (instantiate::label
	      (parent win)
	      (text "A third label")
	      (justify 'right)))
       (l4 (instantiate::label
	      (text "A fourth label")
	      (parent win)
	      (justify 'fill))))
   (print "a window: " win)
   (print "first label: " l1)
   (print "second label: " l2)
   (print "third label: " l3)
   (print "fourth label: " l4)
   (widget-visible-set! win #t))
