(let* ((p1 (instantiate::window
	      (title "Plain Window (300x30)")
	      (width 300)
	      (height 30)))
       (but (instantiate::button
	       (parent p1)
	       (text "Create window")
	       (command (lambda (_)
			   (make-toplevel)))))
       (p2 (instantiate::window
	      (transient #t)
	      (x 600)
	      (y 400)
	      (width 40)
	      (height 60)))
       (but (instantiate::button
	       (parent p2)
	       (text "close")
	       (border-width 0)
	       (relief 'none)
	       (command (lambda (_)
			   (destroy p2))))))
   (print "object?: " (object? p1))
   (print "Plain window: " p1)
   (print "Transient window: " p2))

(define (make-toplevel)
   (let* ((win (instantiate::window
		  (title "Another window...")))
	  (but (instantiate::button
		  (parent win)
		  (text "Close")
		  (command (lambda (_)
			      (destroy win))))))
      win))
			   

