(define win (instantiate::window
	       (padding 10)
	       (x 100)
	       (y 50)
	       (title "Event testing...")))

(define evt (instantiate::event-handler
	       (click (lambda (e)
			 (print "click: "
				(find-runtime-type (event-widget e)))))
	       (release (lambda (e)
			   (error "release" "Shouldn't be here" "evt")))))

(let ((but1 (instantiate::button
	       (parent win)
	       (text "Button 1")
	       (command (lambda (e)
			   (print "command(button 1)")))))
      (but2 (instantiate::button
	       (parent win)
	       (text "Button 2")
	       (command (lambda (e)
			   (error "command" "Shouldn't be here" "button 2")))
	       (event evt)))
      (but3 (instantiate::button
	       (parent win)
	       (text "Button 3")
	       (command (lambda (e)
			   (print "command(button 3)")))
	       (event evt)))
      (but4 (instantiate::button
	       (parent win)
	       (event evt))))
   (destroy but4)
   (with-access::button but2 (command)
      (set! command (lambda (e) (print "command(button 2)"))))
   (with-access::button but3 (command)
      (let ((old-command command))
	 (set! command (lambda (e)
			  (print "new command(button 3)")
			  (old-command e)
			  (print "---------")))))
   (with-access::event-handler evt (release press)
      (set! release (lambda (e)
		       (print "release: "
			      (find-runtime-type (event-widget e)))))
      (set! press (lambda (e)
		     (print "press: "
			    (find-runtime-type (event-widget e)))))) 
   (widget-visible-set! win #t)
   #unspecified)
				
