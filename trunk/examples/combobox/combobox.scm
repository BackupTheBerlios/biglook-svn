(let* ((win (instantiate::window
	       (title "Biglook Combobox")
	       (expand #f)
	       (fill #f)))
       (hbox (instantiate::box
		(orientation 'horizontal)
		(parent win)
		(padding 2)
		(fill #f)
		(expand #f)))
       (l1 (instantiate::label (parent hbox) (text "Font:")))
       (c1    (instantiate::combobox
		 (parent hbox)))
       (l2 (instantiate::label (parent hbox) (text "Size:")))
       (c2    (instantiate::combobox
		 (parent hbox)
		 (text "10")
		 (active #t)
		 (items '("8" "10" "12" "14" "16" "20" "24" "36"))
		 (width 40)))
       (b (instantiate::button
	     (parent win)
	     (text "Done!")
	     (relief 'ridge)
	     (command (lambda (b)
			 (print "font: " (combobox-text c1))
			 (print "size: " (combobox-text c2)))))))
   ;; reconfigure the c1 combobox
   (combobox-items-set! c1 '("plain" "italic" "bold"))
   (combobox-text-set! c1 "plain")
   (print "c1: " c1)
   (print "c2: " c2)
   (widget-visible-set! win #t))

