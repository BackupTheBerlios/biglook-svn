;*---------------------------------------------------------------------*/
;*    label-fraction ...                                               */
;*---------------------------------------------------------------------*/
(define (label-fraction fraction)
   (string-append "Fraction: " (number->string fraction)))

;*---------------------------------------------------------------------*/
;*    Top level                                                        */
;*---------------------------------------------------------------------*/
(let* ((win (instantiate::window
	       (title "Pane example")
	       (height 300)
	       (width 450)))
       (frac 0.6)
       (lbl (instantiate::label
	       (parent win)
	       (text (label-fraction frac))))
       (pane (instantiate::paned
		(orientation 'horizontal)
		(parent win)
		(fraction frac)
		(event (instantiate::event-handler
			  (configure (lambda (e)
					(let ((p (event-widget e)))
					   (label-text-set!
					    lbl
					    (label-fraction (paned-fraction p))))))))))
       (canvas-handler (instantiate::event-handler
			  (configure (lambda (e)
					(configure-canvas (event-widget e))))))
       (f1 (instantiate::frame
	      (parent pane)
	      (title "Left")))
       (b1 (instantiate::button
	      (parent f1)
	      (text "-->")
	      (command (lambda (e)
			  (with-access::paned pane (fraction)
			     (if (<=fl fraction 0.9)
				 (set! fraction (+fl fraction 0.1)))
			     (label-text-set! lbl (label-fraction fraction)))))))
       (f (instantiate::frame
	     (parent `(,f1 :expand #t :fill #t))
	     (border-width 2)
	     (shadow 'etched-out)))
       (c1 (instantiate::canvas
	      (parent `(,f :expand #t :fill #t))
	      (event canvas-handler)))
       (f2 (instantiate::frame
	      (parent pane)
	      (title "Right")))
       (b2 (instantiate::button
	      (parent f2)
	      (text "<--")
	      (command (lambda (e)
			  (with-access::paned pane (fraction)
			     (if (>=fl fraction 0.1)
				 (set! fraction (-fl fraction 0.1)))
			     (label-text-set! lbl (label-fraction fraction)))))))
       (f (instantiate::frame
	     (parent `(,f2 :expand #t :fill #t))
	     (border-width 2)
	     (shadow 'etched-out)))
       (c2 (instantiate::canvas
	      (parent `(,f :expand #t :fill #t))
	      (event canvas-handler))))
   (widget-visible-set! win #t)
   (print "pane: " pane))

;*---------------------------------------------------------------------*/
;*    configure-canvas ...                                             */
;*---------------------------------------------------------------------*/
(define (configure-canvas canvas::canvas)
   (with-access::canvas canvas (width height children parent scroll-width)
      (for-each destroy children)
      (set! scroll-width width)
      (instantiate::canvas-line
	 (canvas canvas)
	 (points (list 0 (/fx height 2) width (/fx height 2)))
	 (arrow '<->)
	 (arrow-shape '(8 12 4))
	 (thickness 2))
      (instantiate::canvas-line
	 (canvas canvas)
	 (points (list (/fx width 2) 0 (/fx width 2) height))
	 (arrow '<->)
	 (arrow-shape '(8 12 4))
	 (thickness 2))))
	 
