(define-method (object-display e::event . port)
   (with-access::event e (x y button modifiers type)
      (print "type  : " type)
      (print "button: " button)
      (print "x     : " x)
      (print "y     : " y)
      (print "mods  : " modifiers)))

(let* ((win (instantiate::window
	       (padding 10)
	       (x 100)
	       (y 50)
	       (title "Events...")
	       (event (instantiate::event-handler
;			 (destroy (lambda (e)
;				     (let ((w (event-widget e)))
;					(print "Destroy: " (window-title w)))))
			 (iconify (lambda (e)
				     (let ((w (event-widget e)))
					(print "iconify: " e)
					(print (window-title w)))))
			 (deiconify (lambda (e)
				       (let ((w (event-widget e)))
					  (print "deiconify: " e)
					  (print (window-title w)))))
			 (configure (lambda (e)
				       (let ((w (event-widget e)))
					  (print "configure: " e)
					  (print (window-title w)
						 " x: " (event-x e)
						 " y: " (event-y e)
						 " width: " (event-width e)
						 " height: " (event-height e)))))))))
       (b1 (instantiate::button
	      (parent win)
	      (event (instantiate::event-handler
			(enter (let ((enter-num 0))
				  (lambda (e)
				     (print "enter: " e)
				     (set! enter-num (+fx 1 enter-num))
				     (print "enter-num: " enter-num))))
			(leave (lambda (e)
				  (print "leave: " e)))))
	      (text "Mouse Enter/Leave")))
       (b2 (instantiate::button
	      (parent win)
	      (text "Mouse Press/Release")
	      (event (instantiate::event-handler
			(press (lambda (e)
				  (print "press: " e)))
			(release (lambda (e)
				    (print "release: " e)))))
	      (relief 'ridge)))
       (b3 (instantiate::button
	      (parent win) 
	      (text "Command")
	      (command (let ((click-num 0))
			  (lambda (e)
			     (set! click-num (+fx 1 click-num))
			     (print "click-num: " click-num)
			     (print "command: " e))))
	      (relief 'ridge)))
       (b4 (instantiate::button
	      (parent win)
	      (text "Mouse Moves")
	      (event (instantiate::event-handler
			(motion (lambda (e)
				   (print "motion: " e))))))))
   (with-access::event-handler (button-event b1) (enter press leave)
      (print "callback(press): " press)
      (print "callback(leave): " leave)
      (let ((new (instantiate::event-handler
		    (enter (lambda (e)
			      (print "Wrapped handler>>>")
			      (enter e)
			      (print "Wrapped handler<<<")))
		    (leave (lambda (e)
			      (print "Replaced leave: " e))))))
	 (button-event-set! b1 new)))
   (widget-visible-set! win #t)
   (print "Events set..."))

