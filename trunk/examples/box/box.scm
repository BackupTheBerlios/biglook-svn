(let* ((win (instantiate::window
	       (title "Box Layout Example")
	       (layout (instantiate::area))))
       (v1 (instantiate::box
	      (orientation 'vertical)
	      (parent `(,win :zone center))))
       (h1 (instantiate::box
	      (orientation 'horizontal)
	      (parent `(,v1 :expand #t :fill #t))))
       (b1 (instantiate::button
	      (text "button1")
	      (parent h1)))
       (b2 (instantiate::button
	      (text "button2")
	      (parent `(,h1 :expand #t :fill #f :padding 10))))
       (v2 (instantiate::box
	      (orientation 'vertical)
	      (parent h1)))
       (b3 (instantiate::button
	      (text "button3")
	      (parent v2)))
       (b4 (instantiate::button
	      (text "button4")
	      (parent `(,v2 :padding 10))))
       (b5 (instantiate::button
	      (text "button5")
	      (parent v1)))
       (b6 (instantiate::button
	      (text "button6")
	      (parent `(,v1 :expand #t :fill #t))))
       )
   (widget-visible-set! win #t))
