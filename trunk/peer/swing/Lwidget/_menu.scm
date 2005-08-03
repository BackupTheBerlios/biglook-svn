;*=====================================================================*/
;*    swing/Lwidget/_menu.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Apr  3 20:43:23 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Menu implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/menu.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%menu
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%container
	   __biglook_%swing-misc
	   __biglook_%callback)

   (static (class %menubar::%container)

	   (class %popup-menu::%container)
	   
	   (class %menu::%container
	      (%justify::symbol read-only)
	      (%tearoff::bool (default #f)))
	   
	   (class %menu-separator::%peer)
	   
	   (abstract-class %menu-item::%peer
	      (%command (default #f)))
	   
	   (class %menu-label::%menu-item)
	   (class %menu-check-button::%menu-item)
	   (class %menu-radio::%menu-item
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
      (%builtin (%swing-jmenubar-new))))

;*---------------------------------------------------------------------*/
;*    %make-%popup-menu ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%popup-menu o::%bglk-object)
   (instantiate::%popup-menu
      (%bglk-object o)
      (%builtin (%swing-jpopupmenu-new))))

;*---------------------------------------------------------------------*/
;*    %make-%menu ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%menu o::%bglk-object title::bstring justify)
   (let ((menu (%swing-jmenu-new (%bglk-bstring->jstring title))))
      (%swing-jmenu-delay-set! menu 0)
      (instantiate::%menu
	 (%bglk-object o)
	 (%justify justify)
	 (%builtin menu))))

;*---------------------------------------------------------------------*/
;*    %make-%menu-separator ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%menu-separator o::%bglk-object)
   (instantiate::%menu-separator
      (%bglk-object o)
      (%builtin (%swing-jseparator-new))))

;*---------------------------------------------------------------------*/
;*    %make-%menu-label ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%menu-label o::%bglk-object text::bstring)
   (instantiate::%menu-label
      (%bglk-object o)
      (%builtin (%swing-jmenuitem-new (%bglk-bstring->jstring text)))))
   
;*---------------------------------------------------------------------*/
;*    %make-%menu-check-button ...                                     */
;*---------------------------------------------------------------------*/
(define (%make-%menu-check-button o::%bglk-object text::bstring)
   (instantiate::%menu-check-button
      (%bglk-object o)
      (%builtin (%swing-jcheckboxmenuitem-new (%bglk-bstring->jstring text)))))

;*---------------------------------------------------------------------*/
;*    %make-%menu-radio ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%menu-radio o::%bglk-object texts::pair)
   (let* ((group (%swing-buttongroup-new))
	  (%radios (map (lambda (t)
			  (let ((b (%swing-jradiobuttonmenuitem-new
				    (%bglk-bstring->jstring t))))
			     (%swing-buttongroup-add! group b)
			     b))
		       texts))
	  (radios (map (lambda (r)
			  (instantiate::%menu-radio-button
			     (%bglk-object o)
			     (%builtin r)))
		       %radios)))
      ;; by default select the first radio
      (%swing-abstractbutton-selected?-set! (car %radios) #t)
      ;; allocates the menu radio
      (instantiate::%menu-radio
	 (%bglk-object o)
	 (%builtin (car %radios))
	 (%radios radios))))

;*---------------------------------------------------------------------*/
;*    %menubar-shadow ...                                              */
;*---------------------------------------------------------------------*/
(define (%menubar-shadow::symbol o::%bglk-object)
   (%jcomponent-shadow o))

;*---------------------------------------------------------------------*/
;*    %menubar-shadow-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%menubar-shadow-set! o::%bglk-object v::symbol)
   (%jcomponent-shadow-set! o v))

;*---------------------------------------------------------------------*/
;*    %menubar-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%menubar-add! c::%bglk-object w::%bglk-object justify)
   (with-access::%bglk-object c (%peer)
      (with-access::%menubar %peer (%builtin)
	 (let ((%w (%peer-%builtin (%bglk-object-%peer w))))
	    ;; justify to the right on demand
	    (if (or (eq? justify 'right)
		    (and (%menu? (%bglk-object-%peer w))
			 (eq? (%menu-%justify (%bglk-object-%peer w)) 'right)))
		(begin
		   (%awt-container-add! %builtin (%swing-box-horizontal-glue))
		   %w))
	    ;; add the menu to the menubar
	    (%container-add! c w)))))

;*---------------------------------------------------------------------*/
;*    %popup-menu-add! ...                                             */
;*---------------------------------------------------------------------*/
(define (%popup-menu-add! c::%bglk-object w::%bglk-object justify)
   ;; add the menu to the menubar
   (%container-add! c w))

;*---------------------------------------------------------------------*/
;*    %menu-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%menu-add! c::%bglk-object w::%bglk-object options)
   (with-access::%bglk-object c (%peer)
      (with-access::%menu %peer (%builtin)
	 (define (add-menu-item! builtin)
	    (%awt-container-add! %builtin builtin)
	    builtin)
	 (let ((pw (%bglk-object-%peer w)))
	    (if (%menu-radio? pw)
		(with-access::%menu-radio pw (%radios)
		   (for-each (lambda (r)
				(add-menu-item! (%peer-%builtin r)))
			     %radios))
		(add-menu-item! (%peer-%builtin pw)))))))
   
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
	 (%install-menu-item-callback! o 'release v)
	 (set! %command v))))
   
;*---------------------------------------------------------------------*/
;*    %menu-tearoff ...                                                */
;*---------------------------------------------------------------------*/
(define (%menu-tearoff o::%bglk-object)
   ;; swing does not implement tearoff menu yet
   #f)

;*---------------------------------------------------------------------*/
;*    %menu-tearoff-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%menu-tearoff-set! o::%bglk-object v::bool)
   ;; swing does not implement tearoff menu yet
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %menu-check-button-on? ...                                       */
;*---------------------------------------------------------------------*/
(define (%menu-check-button-on? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%swing-abstractbutton-selected? (%peer-%builtin %peer))))

;*---------------------------------------------------------------------*/
;*    %menu-check-button-on?-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%menu-check-button-on?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (%swing-abstractbutton-selected?-set! (%peer-%builtin %peer) v)
      #unspecified))

;*---------------------------------------------------------------------*/
;*    %menu-radio-value ...                                            */
;*---------------------------------------------------------------------*/
(define (%menu-radio-value o::%bglk-object)
   (with-access::%menu-radio (%bglk-object-%peer o) (%radios)
      (let loop ((buttons %radios))
	 (cond
	    ((null? buttons)
	     "")
	    ((%swing-abstractbutton-selected? (%peer-%builtin (car buttons)))
	     (%bglk-jstring->bstring (%swing-abstractbutton-text
				      (%peer-%builtin (car buttons)))))
	    (else
	     (loop (cdr buttons)))))))

;*---------------------------------------------------------------------*/
;*    %menu-radio-value-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%menu-radio-value-set! o::%bglk-object v)
   (with-access::%menu-radio (%bglk-object-%peer o) (%radios)
      (for-each (lambda (b)
		   (let ((on? (string=?
			       (%bglk-jstring->bstring
				(%swing-abstractbutton-text
				 (%peer-%builtin b)))
			       v)))
		      (%swing-abstractbutton-selected?-set! (%peer-%builtin b)
							    on?)
		      b))
		%radios)))

;*---------------------------------------------------------------------*/
;*    %connect-menu-item-callback! ::%menu-radio ...                   */
;*    -------------------------------------------------------------    */
;*    Install event handler on menu-radio is different that for        */
;*    other objects because we have to install the handler on each     */
;*    Gtk radio.                                                       */
;*---------------------------------------------------------------------*/
(define-method (%connect-menu-item-callback! %p::%menu-radio e v)
   (with-access::%menu-radio %p (%radios)
      (for-each (lambda (r)
		   (%connect-menu-item-callback! r e v))
		%radios)))

;*---------------------------------------------------------------------*/
;*    %popup-menu-show! ...                                            */
;*---------------------------------------------------------------------*/
(define (%popup-menu-show! o::%bglk-object caller::%bglk-object pos::pair)
   (let ((builtin (%peer-%builtin (%bglk-object-%peer o)))
	 (%caller (%peer-%builtin (%bglk-object-%peer caller))))
      (%swing-jpopupmenu-show! builtin %caller (car pos) (cdr pos))
      o))
