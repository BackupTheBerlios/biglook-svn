(let* ((win (instantiate::window
	       (title "An example of listbox")))
       (box1 (instantiate::listbox
		(parent win)
		(select-mode 'multiple)
		(selection '(1 2 3))
		(width 100)
		(items '("one" "two" "three" "four" "five" "six" "seven"
			       "eight" "nine" "ten"))))
       (but (instantiate::button
	       (parent win)
	       (text "Done")
	       (relief 'ridge)
	       (command (lambda (b)
			   (print "box1: " (listbox-selection box1))
			   (exit 0))))))
   (widget-visible-set! win #t)
   '(print "listbox: " box1))
