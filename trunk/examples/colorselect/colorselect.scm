(let* ((win (instantiate::window
	       (title "A color selector")))
       (fr (instantiate::frame
	      (title "Color selector")
	      (parent win)))
       (cs (instantiate::color-selector
		 (parent fr)))
       (co (instantiate::box
	      (orientation 'horizontal)
	      (parent win)))
       (but (instantiate::button
	       (parent co)
	       (text "Accept!")
	       (command (lambda (b)
			   (let ((c (color-selector-color cs)))
			      (print "color: " c)
			      (print "     : " (color->name c)))))))
       (but2 (instantiate::button
		(parent co)
		(text "Cancel!")
		(command (lambda (b)
			    (print "Cancel...")
			    (exit 0))))))
   (print "color selector: " cs))


