(let* ((tp (instantiate::window
	      (title "Entry example")))
       (entry (instantiate::entry
		 (parent `(,tp :fill #f :expand #f))
                 (text "This is an entry")
		 (width 60)
		 (active #t)
		 (tooltips "^Q to exit")
		 (command (lambda (e)
			     (with-access::event e (widget)
				(print "Entry value: "
				       (entry-text widget)))))
		 (event (instantiate::event-handler
			   (key (lambda (e)
				   (with-access::event e (char modifiers)
				      (if (and (char=? char #\q)
					       (memq 'control modifiers))
					  (exit 0))))))))))
   (widget-visible-set! tp #t)
   (print "entry: " entry))


