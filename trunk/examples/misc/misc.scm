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
	       (title "Misc")))
       (b1 (instantiate::button
	      (parent win)
	      (text "Iconify...")
	      (command (lambda (e)
			  (print e)
			  (iconify win)))))
       (b2 (instantiate::button
	      (parent win)
	      (text "Close...")
	      (command (lambda (e)
			  (print e)
			  (destroy win)))))
       (b3 (instantiate::button
	      (parent win)
	      (text "Erase me...")
	      (command (lambda (e)
			  (print e)
			  (destroy (event-widget e))))))
       (e1 (instantiate::entry
	      (parent win)
	      (text "An entry")
	      (event (instantiate::event-handler
			(focus-in (lambda (e)
				     (print e)))
			(focus-out (lambda (e)
				      (print e))))))))
   (print "Ready..."))

