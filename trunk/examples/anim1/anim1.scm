(let* ((window (instantiate::window
		  (transient #f)
		  (x 100)
		  (y 100)))
       (frame (instantiate::frame
		 (parent window)
		 (shadow 'etched)
		 (border-width 10)))
       (but (instantiate::button
	       (parent frame)
	       (tooltips "Click to exit")
	       (relief 'flat)
	       (border-width 0)
	       (command (lambda (_)
			   (exit 0))))))
   (let ((images (map (lambda (i)
			 (file->image (string-append "pinguin"
						     (integer->string i)
						     ".xpm")))
		      '(1 2 3 4 5 6 7))))
      (set-cdr! (last-pair images) images)
      (timeout 100
	       (lambda ()
		  (button-image-set! but (car images))
		  (set! images (cdr images))
		  #t)))
   (widget-visible-set! window #t))

							   
       
