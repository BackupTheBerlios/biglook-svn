(define (make-command path)
   (lambda (e)
      (instantiate::file-selector
	 (path path)
	 (ok-command (lambda (e)
			(let ((w (event-widget e)))
			   (print "file: " (file-selector-file w)))))
	 (cancel-command (lambda (e)
			    (destroy (event-widget e)))))))
   
(let* ((win (instantiate::window
	       (title "A file entry")
	       (padding 2)))
       (grid (instantiate::grid
		(parent win)
		(border-width 2)
		(rows 3)
		(row-spacing 5)
		(column-spacing 5)
		(columns 3)))
       (but/ (instantiate::button
		(parent grid)
		(text "/")
		(command (make-command "/"))))
       (but. (instantiate::button
		(parent grid)
		(text ".")
		(command (make-command "."))))
       (but$ (instantiate::button
		(parent grid)
		(text "$HOME")
		(command (make-command (getenv "HOME")))))
       (leg (instantiate::label
	       (parent `(,grid :width 3))
	       (text "[TAB] to expand, [TAB][TAB] to pop a file sector.")))
       (lbl (instantiate::label
	       (parent grid)
	       (text "File: ")))
       (entry (instantiate::file-entry
		 (parent `(,grid :width 2))
		 (command (lambda (e)
			     (let ((widget (event-widget e)))
				(print "file: " (entry-text widget)))))))
       (hdl (entry-event entry))
       (old-key (event-handler-key hdl)))
   (event-handler-key-set! hdl (lambda (e)
				  (with-access::event e (char modifiers)
				     (if (and (char=? char #\q)
					      (memq 'control modifiers))
					 (exit 0)
					 (old-key e)))))
   (entry-event-set! entry hdl)
   (print "entry: " entry))
