(define tp (instantiate::window
              (title "Radio buttons")))

(define radio1 (instantiate::radio
                  (parent tp)
		  (title "Radio1")
                  (orientation 'horizontal)
                  (texts '("toto" "tutu" "titi" "tata"))
                  (tooltips "A stupid tooltip")
                  (border-width 2)
                  (value "tata")
                  (command (lambda (e)
                              (print "radio1: "
                                     (radio-value radio1))))))

(define box (instantiate::box
	       (orientation 'horizontal)
	       (parent tp)))

(define radio2 (instantiate::radio
                  (parent box)
		  (title "Radio2")
                  (texts '("foo" "bar" "gee" "hux"))
                  (tooltips "Another stupid tooltip")
                  (shadow 'etched-in)
                  (border-width 2)
                  (orientation 'vertical)
                  (value "bar")
                  (command (let ((n 0))
                              (lambda (e)
				 (let ((w (event-widget e)))
				    (set! n (+ 1 n))
				    (print "radio2: " n " "
					   (button-text w))))))))

(define vbox (instantiate::box
		(parent box)))

(define Read (instantiate::button
	       (parent vbox)
	       (text "Show radio2")
	       (command (lambda (e)
			   (print "radio2: " (radio-value radio2))))))
(define set (instantiate::button
	       (parent vbox)
	       (text "set radio2")
	       (command (let ((l (reverse (radio-texts radio2))))
			   (set-cdr! (last-pair l) l)
			   (lambda (e)
			      (set! l (cdr l))
			      (radio-value-set! radio2 (car l)))))))

(print "Radio1: " radio1)
(print "Radio2: " radio2)
