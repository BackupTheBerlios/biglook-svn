(let* ((win (instantiate::window
	       (title "Toolbars example")
	       (width 200)
	       (height 200)))
       (win2 (instantiate::window
	       (title "Toolbars example")
	       (width 200)
	       (height 200)))
       (area (instantiate::area
		(parent win)))
       (toolbar1 (instantiate::toolbar
		    (parent area)
		    (floating #f)
		    (shadow 'none)
		    (relief 'none)
		    (easy `((:text "about" :command ,print)
			    (:text "info" :command ,print)
			    :space
			    (:text "help" :command ,print)))))
       (toolbar2 (instantiate::toolbar
		    (parent `(,area :zone east))
		    (shadow 'in)
		    (space-size 20)
		    (easy `(:space
			    (:text "load defaults"
				   :tooltips "Load rc file"
				   :command ,print)
			    :space
			    (:icon "close.xpm"
				   :tooltips "Quit"
				   :text "quit"
				   :command ,(lambda (-) (exit 0)))))))
       (hbox (instantiate::box
	       (orientation 'horizontal)
	       (parent win)))
       (toolbar3 (instantiate::toolbar
		    (parent hbox)
		    (shadow 'out)
		    (relief 'raised)
		    (orientation 'vertical)
		    (easy `((:icon "footprint.xpm" :command ,print)
			    (:icon "memory.xpm" :command ,print)))))
       (can (instantiate::canvas
	       (parent hbox)
	       (width 200)
	       (height 100))))
   (widget-visible-set! win #t)
   (widget-visible-set! win2 #t)
   )
   ;(print "toolbar1: " toolbar1)
   ;(print "toolbar2: " toolbar2)
   ;(print "toolbar3: " toolbar3))


   
