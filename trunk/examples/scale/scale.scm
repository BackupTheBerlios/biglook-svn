(let* ((win (instantiate::window
	       (width 300)
	       (height 300)))
       (hs (instantiate::scale
	      (orientation 'horizontal)
	      (parent win)
	      (from 6)
	      (to 12)
	      (show-value? #t)
	      (tooltips "A tooltip")
	      (command (lambda (e)
			  (print "hscale: "
				 (scale-value (event-widget e)))))))
       (vs (instantiate::scale
	      (orientation 'vertical)
	      (parent win)
	      (to 100)
	      (from 1)
	      (show-value? #t)
	      (command (lambda (e)
			  (print "vscale: "
				 (scale-value (event-widget e))))))))
   (print "horizontal scale: " hs)
   (print "vertical scale: " vs))
