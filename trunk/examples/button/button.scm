(let* ((win (instantiate::window
	       (padding 10)
	       (x 100)
	       (y 50)
	       (title "Buttons")))
       (v1 (instantiate::box
            (orientation 'vertical)
            (parent `(,win :zone center))))
       (b1 (instantiate::button
	      (parent v1)
	      (text "Plain")))
       (b2 (instantiate::button
	      (parent v1)
	      (text "Ridge...")
	      (relief 'ridge)))
       (b3 (instantiate::button
	      (parent v1)
	      (text "Flat")
	      (relief 'flat)))
       (b4 (instantiate::button
	      (parent v1)
	      (text "Solid")
	      (relief 'solid)))
       (b5 (instantiate::button
	      (parent v1)
	      (text "Tooltips")
	      (tooltips #"A tooltips: This is a very long tooltips, to show that some line splitting occurs. In consequence, introducing a #\\Newline in a tooltips introduces one blank lines (useful for multiple-buttons tooltips)")))
       (b6 (instantiate::button
	      (parent v1)
	      (text "Multi-button tooltips")
	      (tooltips "toto"))))
   (print "a window: " win)
   (print "first button: " b1)
   (print "second button: " b2)
   (print "third button: " b3)
   (print "fourth button: " b4)
   (print "fifth button: " b5)
   (print "sixth button: " b6)
   (widget-visible-set! win #t))
