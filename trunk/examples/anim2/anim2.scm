(define *runner-image-list*
   (let ((images (map (lambda (i)
			 (file->image (string-append "runner"
						     (integer->string i)
						     ".xpm")))
		      '(1 2 3 4 5 6))))
      (set-cdr! (last-pair images) images)
      images))

(define (go-command ground pace message)
   (lambda (_)
      (let ((num 1)
	    (runner (instantiate::runner
		       (x 10)
		       (y (-fx 20
			       (image-height
				(car *runner-image-list*))))
		       (canvas ground))))
	 (define (go)
	    (with-access::runner runner (x image images speed number)
	       (if (< x 140)
		   (begin
		      (set! x (+fx 1 x))
		      (set! image (car images))
		      (set! images (cdr images))
		      (after (+ speed (-fx 50 (scale-value pace))) go))
		   (begin
		      (message "Runner: " number " arrived")
		      (destroy runner)))))
	 (message "Runner: " (runner-number runner) " started")
	 (go))))

(define (demo)
   (let* ((win (instantiate::window
		  (title "Biglook example")))
	  (hbox (instantiate::box
		   (orientation 'horizontal)
		   (parent win)
		   (padding 2)))
	  (left (instantiate::box
		   (parent hbox)))
	  (right (instantiate::box
		    (parent hbox)))
	  (msg (instantiate::label
		  (parent right)
		  (width 200)))
	  (pace (instantiate::scale
		   (orientation 'horizontal)
		   (parent right)
		   (value 25)
		   (from 0)
		   (to 50)))
	  (ground (instantiate::canvas
		     (parent left)
		     (height 30)
		     (width  150))))
      (define (message . l)
	 (label-text-set! msg (apply string-append l)))
      ;; draw the horizontal line
      (instantiate::canvas-line
	 (canvas ground)
	 (points '(10 20 140 20))
	 (color (instantiate::rgb-color (blue 150))))
      ;; draw the go button
      (instantiate::button
	 (text "Go!")
	 (parent left)
	 (command (go-command ground pace message)))
      (message "Nobody's running")
      (widget-visible-set! win #t) ))

(demo)



	  
