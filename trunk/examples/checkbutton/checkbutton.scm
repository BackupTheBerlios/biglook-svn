(let* ((win (instantiate::window
	       (title "A Biglook checkbutton")))
       (frame (instantiate::frame
		 (parent win)))
       (bc (instantiate::check-button
	      (parent frame)
	      (text "An example of checkbutton")
	      (tooltips "With a tooltip")
	      (relief 'raised)
	      (command (lambda (e)
			  (with-access::check-button (event-widget e) (on)
			     (print "on: " on)))))))
   (widget-visible-set! win #t))

