(let* ((window (instantiate::window
		  (title "An example of MenuBar")
		  (width 400)))
       (menubar (instantiate::menubar
		   (parent window)
		   (shadow 'shadow-out)
		   (border-width 2)))
       (menu1 (instantiate::menu
		 (parent menubar)
		 (title "menu1")))
       (lcommand (lambda (e)
		    (print (menu-label-text (event-widget e)))))
       (ccommand (lambda (e)
		    (let ((c (event-widget e)))
		       (print (menu-check-button-text c) ": "
			      (menu-check-button-on c)))))
       (rcommand (lambda (e)
		    (let ((c (event-widget e)))
		       (print "value: " (menu-radio-value c)))))
       (menu-label1 (instantiate::menu-label
		       (parent menu1)
		       (text "label1.1")
		       (command lcommand)))
       (sep (instantiate::menu-separator
	       (parent menu1)))
       (menu-radio1 (instantiate::menu-radio
		       (parent menu1)
		       (texts '("Radio.1" "Radio.2" "Radio.3" "Radio.4"))
		       (command rcommand)))
       (menu2 (instantiate::menu
		 (tearoff #t)
		 (parent menubar)
		 (title "menu2")))
       (menu-label (instantiate::menu-label
		      (parent menu2)
		      (text "label1.2")
		      (command lcommand)))
       (menu1.2 (instantiate::menu
		   (parent menu2)
		   (title "menu2.2")))
       (menu-label2 (instantiate::menu-label
		       (parent menu1.2)
		       (text "label1.2.2")
		       (command lcommand)))
       (menu3 (instantiate::menu
		 (justify 'right)
		 (title "menu3")
		 (parent menubar)))
       (menu-check1.3 (instantiate::menu-check-button
			 (parent menu3)
			 (text "check1.3")
			 (command ccommand)))
       (menu-check2.3 (instantiate::menu-check-button
			 (parent menu3)
			 (text "check2.3")
			 (on #t)
			 (command ccommand)))
       (menu-check3.3 (instantiate::menu-check-button
			 (parent menu3)
			 (text "check3.3")
			 (active #f)
			 (command ccommand))))
   (print "menubar: " menubar))

(let* ((window (instantiate::window
		  (title "An example of Easy MenuBar")
		  (width 400)))
       (lcommand (lambda (e)
		    (print (menu-label-text (event-widget e)))))
       (ccommand (lambda (e)
		    (let ((c (event-widget e)))
		       (print (menu-check-button-text c) ": "
			      (menu-check-button-on c)))))
       (rcommand (lambda (e)
		    (let ((c (event-widget e)))
		       (print "value: " (menu-radio-value c)))))
       (menubar (instantiate::menubar
		   (parent window)
		   (shadow 'shadow-out)
		   (border-width 2)
		   (easy `((:menu "menu1"
				  (:label "label1.1" :command ,lcommand)
				  :separator
				  (:radio "Radio.1" "Radio.2" "Radio.3" "Radio.4"
					  :command ,rcommand))
			   (:menu "menu2"
				  (:label "label1.2" :command ,lcommand)
				  (:menu "menu2.2"
					 (:label "label1.2.2"
						 :command ,lcommand)))
			   :fill
			   (:menu "menu3"
				  (:check "check1.3" :command ,ccommand)
				  (:check "check2.3" :on #t
					  :command ,ccommand)
				  (:check "check3.3" :active #f
					  :command ,ccommand)))))))
   (print "easy menubar: " menubar))

(let* ((window (instantiate::window
		  (title "An example of Easy MenuBar")
		  (width 400)))
       (menubar (instantiate::menubar
		   (parent window)
		   (shadow 'shadow-out)
		   (border-width 2)
		   (easy `(:fill
			   (:menu "Quit"
				  (:label "Quit" :command ,(lambda (_)
							      (exit 0)))))))))
   (print "easy menubar: " menubar))

