(let* ((win (instantiate::window
	       (title "Frame")))
       (frame1 (instantiate::frame
		  (parent win)
		  (shadow 'shadow-in)
		  (border-width 2)))
       (label1 (instantiate::label
		  (parent frame1)
		  (text "in")))
       (frame2 (instantiate::frame
		  (parent win)
		  (title "Center")
		  (title-justify 'center)
		  (shadow 'shadow-out)
		  (border-width 2)))
       (label2 (instantiate::label
		  (parent frame2)
		  (text "out")))
       (frame3 (instantiate::frame
		  (parent win)
		  (title "Right")
		  (title-justify 'right)
		  (shadow 'etched-in)
		  (border-width 2)))
       (label3 (instantiate::label
		  (parent frame3)
		  (text "etched-in")))
       (frame4 (instantiate::frame
		  (parent win)
		  (title "Left")
		  (title-justify 'left)
		  (shadow 'none)
		  (border-width 2)))
       (label4 (instantiate::label
		  (parent frame4)
		  (text "no shadow"))))
   (widget-visible-set! win #t)
   (print "win:" win))

