;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_menu.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jul 15 17:43:14 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Menu implementation.                                */
;*    definition: @path ../../../biglook/Lwidget/menu.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%menu
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%container
	   __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%radio
	   __biglook_%callback)
   
   (extern (macro %%gtk-menubar-new::gtkwidget* ()
		  "gtk_menu_bar_new")
	   (macro %%gtk-menu-new::gtkwidget* ()
		  "gtk_menu_new")
	   (macro %%gtk-menu-label-new::gtkwidget* (::string)
		  "gtk_menu_item_new_with_label")
	   (macro %%gtk-menu-check-button-new::gtkwidget* (::string)
		  "gtk_check_menu_item_new_with_label")
	   (macro %%gtk-menu-radio-button-new::gtkwidget* (::gslist* ::string)
		  "gtk_radio_menu_item_new_with_label")
	   (macro %%gtk-menu-tearoff-new::gtkwidget* ()
		  "gtk_tearoff_menu_item_new")
	   (macro %%gtk-menu-separator-new::gtkwidget* ()
		  "gtk_menu_item_new")
	   
	   (macro %%gtk-menu-item-set-submenu::void (::gtkmenuitem*
						     ::gtkwidget*)
		  "gtk_menu_item_set_submenu")
	   (macro %%gtk-menu-item-right-justify::void (::gtkmenuitem*)
		  "gtk_menu_item_right_justify")
	   
	   (macro %%gtk-check-menu-item-set-active::void (::gtkcheckmenuitem*
							  ::bool)
		  "gtk_check_menu_item_set_active")
	   (macro %%gtk-check-menu-item-set-show-toggle::void (::gtkcheckmenuitem*
							       ::bool)
		  "gtk_check_menu_item_set_show_toggle")
	   (macro %%bglk-gtk-check-menu-item-active::bool (::gtkcheckmenuitem*)
		  "BGLK_CHECK_MENU_ITEM_ACTIVE")
	   
	   (macro %%gtk-menu-radio-button-group::gslist* (::gtkradiomenuitem*)
		  "gtk_radio_menu_item_group")
	   (macro %%gtk-menu-radio-set-group::void (::gtkradiomenuitem*
						    ::gslist*)
		  "gtk_radio_menu_item_set_group")
	   
	   (macro %%gtk-menubar-append::void (::gtkmenubar* ::gtkwidget*)
		  "gtk_menu_bar_append")
	   (macro %%gtk-menu-title-set!::void (::gtkmenu* ::string)
		  "gtk_menu_set_title")
	   
	   (macro %%gtk-menu-append::void (::gtkmenu* ::gtkwidget*)
		  "gtk_menu_append")
	   (macro %%gtk-menu-prepend::void (::gtkmenu* ::gtkwidget*)
		  "gtk_menu_prepend")

	   (macro %bglk-menu-popup::void (::gtkmenu*)
		  "bglk_menu_popup"))
   
   (static (class %menubar::%container)
	   
	   (class %menu::%container
	      (%justify::symbol read-only)
	      (%title::%menu-label read-only)
	      (%menu::gtkobject* read-only)
	      (%tearoff::bool (default #f)))
	   
	   (class %popup-menu::%menu)

	   (class %menu-separator::%peer)
	   
	   (abstract-class %menu-item::%peer
	      (%command (default #f)))
	   
	   (class %menu-label::%menu-item)
	   (class %menu-check-button::%menu-item)
	   (class %menu-radio::%menu-item
	      %texts::pair
	      %radios::pair)
	   (class %menu-radio-button::%peer))
   
   (export (%make-%menubar ::%bglk-object)
	   (%make-%popup-menu ::%bglk-object)
	   
	   (%make-%menu ::%bglk-object ::bstring ::symbol)
	   (%make-%menu-separator ::%bglk-object)
	   (%make-%menu-label ::%bglk-object ::bstring)
	   (%make-%menu-check-button ::%bglk-object ::bstring)
	   (%make-%menu-radio ::%bglk-object ::pair)
	   
	   (%menubar-shadow::symbol ::%bglk-object)
	   (%menubar-shadow-set! ::%bglk-object ::symbol)
	   
	   (%menubar-add! ::%bglk-object ::%bglk-object ::symbol)
	   (%popup-menu-add! ::%bglk-object ::%bglk-object ::symbol)
	   (%menu-add! ::%bglk-object ::%bglk-object ::pair-nil)
	   
	   (%menu-item-command ::%bglk-object)
	   (%menu-item-command-set! ::%bglk-object ::obj)
	   
	   (%menu-tearoff::bool ::%bglk-object)
	   (%menu-tearoff-set! ::%bglk-object ::bool)

	   (%menu-check-button-on?::bool ::%bglk-object)
	   (%menu-check-button-on?-set! ::%bglk-object ::bool)
	   
	   (%menu-radio-value::bstring ::%bglk-object)
	   (%menu-radio-value-set! ::%bglk-object ::bstring)

	   (%popup-menu-show! ::%bglk-object ::%bglk-object ::pair)
	   ))
;*---------------------------------------------------------------------*/
;*    %make-%menubar ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%menubar o::%bglk-object)
   (instantiate::%menubar
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-menubar-new)))))

;*---------------------------------------------------------------------*/
;*    %make-%popup-menu ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%popup-menu o::%bglk-object)
  (%make-%menu o "popup" 'left))

;*---------------------------------------------------------------------*/
;*    %make-%menu ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%menu o::%bglk-object title::bstring justify::symbol)
   (let* ((menu (%%gtk-menu-new))
	  (title (%make-%menu-label o title))
	  (%title (%menu-label-%builtin title)))
      (%%gtk-menu-item-set-submenu (gtkmenuitem %title) menu)
      (instantiate::%menu
	 (%justify justify)
	 (%bglk-object o)
	 (%builtin %title)
	 (%title title)
	 (%menu (gtkobject menu)))))

;*---------------------------------------------------------------------*/
;*    %make-%menu-separator ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%menu-separator o::%bglk-object)
   (instantiate::%menu-separator
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-menu-separator-new)))))

;*---------------------------------------------------------------------*/
;*    %make-%menu-label ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%menu-label o::%bglk-object text::bstring)
   (instantiate::%menu-label
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-menu-label-new text)))))

;*---------------------------------------------------------------------*/
;*    %make-%menu-check-button ...                                     */
;*---------------------------------------------------------------------*/
(define (%make-%menu-check-button o::%bglk-object text::bstring)
   (let ((check (gtkobject (%%gtk-menu-check-button-new text))))
      (%%gtk-check-menu-item-set-active (gtkcheckmenuitem check) #f)
      (%%gtk-check-menu-item-set-show-toggle (gtkcheckmenuitem check) #t)
      (instantiate::%menu-check-button
	 (%bglk-object o)
	 (%builtin check))))

;*---------------------------------------------------------------------*/
;*    %make-%menu-radio ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%menu-radio o::%bglk-object texts::pair)
   (let loop ((tts texts)
	      (radios '())
	      (group::gslist* %%gtk-emply-radio-button-group))
      (if (null? tts)
	  (let ((rradios (reverse radios)))
	     (instantiate::%menu-radio
		(%bglk-object o)
		(%builtin (%peer-%builtin (car rradios)))
		(%radios rradios)
		(%texts texts)))
	  (let* ((text (car tts))
		 (%radio (gtkobject (%%gtk-menu-radio-button-new group text)))
		 (radio (instantiate::%menu-radio-button
			   (%bglk-object o)
			   (%builtin %radio))))
	     ;; connect the radio to the Bigloo object so that GTK activate
	     ;; event will be correctly handled
	     (%bglk-g-property-type-set! (gobject %radio) "user-data" o G-TYPE-POINTER)
	     (%%widget-show (gtkwidget %radio))
	     (%%gtk-check-menu-item-set-show-toggle (gtkcheckmenuitem %radio)
						    #t)
	     (%%gtk-menu-radio-set-group (gtkradiomenuitem %radio) group)
	     (loop (cdr tts)
		   (cons radio radios)
		   (%%gtk-menu-radio-button-group
		    (gtkradiomenuitem %radio)))))))

;*---------------------------------------------------------------------*/
;*    %menubar-shadow ...                                              */
;*---------------------------------------------------------------------*/
(define (%menubar-shadow::symbol o::%bglk-object)
   (gtk-shadow->biglook (g-property-get o "shadow")))

;*---------------------------------------------------------------------*/
;*    %menubar-shadow-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%menubar-shadow-set! o::%bglk-object v::symbol)
   (g-property-type-set! o "shadow" (biglook-shadow->gtk v) GTK-TYPE-SHADOW-TYPE))

;*---------------------------------------------------------------------*/
;*    %menubar-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%menubar-add! c::%bglk-object w::%bglk-object justify)
   (with-access::%bglk-object c (%peer)
      (with-access::%menubar %peer (%builtin %gc-children)
	 (set! %gc-children (cons w %gc-children))
	 (let ((%w (%peer-%builtin (%bglk-object-%peer w))))
	    ;; justify to the right on demand
	    (if (or (eq? justify 'right)
		    (and (%menu? (%bglk-object-%peer w))
			 (eq? (%menu-%justify (%bglk-object-%peer w)) 'right)))
		(begin
		   (%%gtk-menu-item-right-justify (gtkmenuitem %w))
		   %w))
	    ;; add the menu to the menubar
	    (%%gtk-menubar-append (gtkmenubar %builtin) (gtkwidget %w))
	    c))))

;*---------------------------------------------------------------------*/
;*    %popup-menu-add! ...                                             */
;*---------------------------------------------------------------------*/
(define (%popup-menu-add! c::%bglk-object w::%bglk-object justify)
  (%menu-add! c w (list justify)))

;*---------------------------------------------------------------------*/
;*    %menu-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%menu-add! c::%bglk-object w::%bglk-object options)
   (with-access::%bglk-object c (%peer)
      (with-access::%menu %peer (%menu %gc-children)
	 (define (add-menu-item! builtin)
	    (%%gtk-menu-append (gtkmenu %menu) (gtkwidget builtin))
	    builtin)
	 (let ((pw (%bglk-object-%peer w)))
	    (set! %gc-children (cons w %gc-children))
	    (if (%menu-radio? pw)
		(with-access::%menu-radio pw (%radios)
		   (for-each (lambda (r)
				(add-menu-item! (%peer-%builtin r)))
			     %radios))
		(add-menu-item! (%peer-%builtin pw)))))))
   
;*---------------------------------------------------------------------*/
;*    %%container-children ::%menu ...                                 */
;*---------------------------------------------------------------------*/
(define-method (%%container-children::obj c::%menu)
   (with-access::%menu c (%menu %tearoff)
      (let ((children (%%bglk-gtk-container-children (gtkcontainer %menu))))
	 (if %tearoff
	     ;; because a tearoff is a plain menuitem we have to skip the
	     ;; first menuitem (the tearoff) when computing the children list
	     (cdr children)
	     children))))

;*---------------------------------------------------------------------*/
;*    %menu-item-command ...                                           */
;*---------------------------------------------------------------------*/
(define (%menu-item-command o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%menu-item %peer (%command)
	 %command)))
   
;*---------------------------------------------------------------------*/
;*    %menu-item-command-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%menu-item-command-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%menu-item %peer (%command)
	 (if (procedure? %command)
	     (%install-menu-item-callback! o 'activate %command))
	 (if (procedure? v)
	     (%install-menu-item-callback! o 'activate v))
	 (set! %command v))))
   
;*---------------------------------------------------------------------*/
;*    %menu-tearoff ...                                                */
;*---------------------------------------------------------------------*/
(define (%menu-tearoff c::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (with-access::%menu %peer (%tearoff)
	 %tearoff)))

;*---------------------------------------------------------------------*/
;*    %menu-tearoff-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%menu-tearoff-set! c::%bglk-object v::bool)
   (with-access::%bglk-object c (%peer)
      (with-access::%menu %peer (%tearoff %menu)
	 ;; We can only add a tearoff if not already added.
	 ;; We can't remove a tearoff
	 (if (and v (not %tearoff))
	     (let ((tearoff (%%gtk-menu-tearoff-new)))
		(%%widget-show tearoff)
		(%%gtk-menu-prepend (gtkmenu %menu) tearoff)
		(set! %tearoff v))))))

;*---------------------------------------------------------------------*/
;*    %menu-check-button-on? ...                                       */
;*---------------------------------------------------------------------*/
(define (%menu-check-button-on? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%menu-check-button %peer (%builtin)
	 (%%bglk-gtk-check-menu-item-active (gtkcheckmenuitem %builtin)))))

;*---------------------------------------------------------------------*/
;*    %menu-check-button-on?-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%menu-check-button-on?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%menu-check-button %peer (%builtin)
	 (%%gtk-check-menu-item-set-active (gtkcheckmenuitem %builtin) v)
	 o)))
				       
;*---------------------------------------------------------------------*/
;*    %menu-radio-value ...                                            */
;*---------------------------------------------------------------------*/
(define (%menu-radio-value o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%menu-radio %peer (%builtin %radios %texts)
	 (let loop ((buttons %radios)
		    (texts %texts))
	    (cond
	       ((null? buttons)
		"")
	       ((%%bglk-gtk-check-menu-item-active
		 (gtkcheckmenuitem (%peer-%builtin (car buttons))))
		(car texts))
	       (else
		(loop (cdr buttons)
		      (cdr texts))))))))

;*---------------------------------------------------------------------*/
;*    %menu-radio-value-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%menu-radio-value-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%menu-radio %peer (%builtin %radios %texts)
	 (let loop ((buttons %radios)
		    (texts %texts))
	    (cond
	       ((null? buttons)
		#unspecified)
	       ((string=? (car texts) v)
		(%%gtk-check-menu-item-set-active
		 (gtkcheckmenuitem (%peer-%builtin (car buttons)))
		 #t)
		o)
	       (else
		(loop (cdr buttons)
		      (cdr texts))))))))

;*---------------------------------------------------------------------*/
;*    %peer-install-menu-item-event-handler! ::%menu-radio ...         */
;*    -------------------------------------------------------------    */
;*    Install event handler on menu-radio is different that for        */
;*    other objects because we have to install the handler on each     */
;*    Gtk radio.                                                       */
;*---------------------------------------------------------------------*/
(define-method (%connect-menu-item-callback! peer::%menu-radio builtin v)
   (with-access::%menu-radio peer (%radios)
      (for-each (lambda (r)
		   (%connect-menu-item-callback! r (%peer-%builtin r) v))
		%radios)))

;*---------------------------------------------------------------------*/
;*    %disconnect-menu-item-callback! ...                              */
;*---------------------------------------------------------------------*/
(define-method (%disconnect-menu-item-callback! peer::%menu-radio builtin v)
   (if (procedure? v)
       (with-access::%menu-radio peer (%radios)
	  (for-each (lambda (r)
		       (%disconnect-menu-item-callback! r (%peer-%builtin r) v))
		    %radios))))
   
;*---------------------------------------------------------------------*/
;*    %popup-menu-show! ...                                            */
;*---------------------------------------------------------------------*/
(define (%popup-menu-show! o::%bglk-object caller::%bglk-object pos::pair)
   (with-access::%bglk-object o (%peer)
      (with-access::%menu %peer (%menu)
     (%bglk-menu-popup (gtkmenu %menu))))
     #unspecified)