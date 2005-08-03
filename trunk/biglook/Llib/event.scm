;*=====================================================================*/
;*    biglook/Llib/event.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Fri Apr 20 09:50:41 2001                          */
;*    Last change :  Tue Aug  2 21:45:40 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Biglook event handling                                       */
;*    -------------------------------------------------------------    */
;*    Implementation: @label Event@                                    */
;*      null: @path ../../peer/null/Llib/_event.scm@                   */
;*      gtk: @path ../../peer/gtk/Llib/_event.scm@                     */
;*      swing: @path ../../peer/swing/Llib/_event.scm@                 */
;*                                                                     */
;*    The callback handling is implemnted in:                          */
;*      null: @path ../../peer/null/Llib/_callback.scm@                */
;*      gtk: @path ../../peer/gtk/Llib/_callback.scm@                  */
;*      swing: @path ../../peer/swing/Llib/_callback.scm@              */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_event
   
   (library biglook_peer)

   (export (class event-handler
	      ;; widget associated to that event-handler
	      (%widgets::pair-nil (default '()))
	      (widgets::pair-nil
	       read-only
	       (get (lambda (o)
		       ;; we have to allocate a fresh list
		       (reverse
			(event-handler-%widgets o)))))
	      ;; destroy event
	      (%destroy (default #f))
	      (destroy
	       (get (lambda (o)
		       (event-handler-%destroy o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%destroy o)))
			  (event-handler-%destroy-set! o v)
			  (connect-callback! o v oldv 'destroy)))))
	      ;; iconify
	      (%iconify (default #f))
	      (iconify
	       (get (lambda (o)
		       (event-handler-%iconify o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%iconify o)))
			  (event-handler-%iconify-set! o v)
			  (connect-callback! o v oldv 'iconify)))))
	      ;; deiconify
	      (%deiconify (default #f))
	      (deiconify
	       (get (lambda (o)
		       (event-handler-%deiconify o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%deiconify o)))
			  (event-handler-%deiconify-set! o v)
			  (connect-callback! o v oldv 'deiconify)))))
	      ;; press event
	      (%press (default #f))
	      (press
	       (get (lambda (o)
		       (event-handler-%press o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%press o)))
			  (event-handler-%press-set! o v)
			  (connect-callback! o v oldv 'press)))))
	      ;; release
	      (%release (default #f))
	      (release
	       (get (lambda (o)
		       (event-handler-%release o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%release o)))
			  (event-handler-%release-set! o v)
			  (connect-callback! o v oldv 'release)))))
	      ;; click
	      (%click (default #f))
	      (click
	       (get (lambda (o)
		       (event-handler-%click o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%click o)))
			  (event-handler-%click-set! o v)
			  (connect-callback! o v oldv 'click)))))
	      ;; enter
	      (%enter (default #f))
	      (enter
	       (get (lambda (o)
		       (event-handler-%enter o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%enter o)))
			  (event-handler-%enter-set! o v)
			  (connect-callback! o v oldv 'enter)))))
	      ;; leave
	      (%leave (default #f))
	      (leave
	       (get (lambda (o)
		       (event-handler-%leave o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%leave o)))
			  (event-handler-%leave-set! o v)
			  (connect-callback! o v oldv 'leave)))))
	      ;; motion
	      (%motion (default #f))
	      (motion
	       (get (lambda (o)
		       (event-handler-%motion o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%motion o)))
			  (event-handler-%motion-set! o v)
			  (connect-callback! o v oldv 'motion)))))
	      ;; key
	      (%key (default #f))
	      (key
	       (get (lambda (o)
		       (event-handler-%key o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%key o)))
			  (event-handler-%key-set! o v)
			  (connect-callback! o v oldv 'key)))))
	      ;; focus-in
	      (%focus-in (default #f))
	      (focus-in
	       (get (lambda (o)
		       (event-handler-%focus-in o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%focus-in o)))
			  (event-handler-%focus-in-set! o v)
			  (connect-callback! o v oldv 'focus-in)))))
	      ;; focus-out
	      (%focus-out (default #f))
	      (focus-out
	       (get (lambda (o)
		       (event-handler-%focus-out o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%focus-out o)))
			  (event-handler-%focus-out-set! o v)
			  (connect-callback! o v oldv 'focus-out)))))
	      ;; configure
	      (%configure (default #f))
	      (configure
	       (get (lambda (o)
		       (event-handler-%configure o)))
	       (set (lambda (o v)
		       (let ((oldv (event-handler-%configure o)))
			  (event-handler-%configure-set! o v)
			  (connect-callback! o v oldv 'configure))))))
	    
	    ;; event  
	    (class event::%event
	       (widget read-only (get %event-%widget))
	       (type::symbol read-only (get (lambda (o) (%event-type o))))
	       (time::int read-only (get %event-time))
	       (button::int read-only (get (lambda (o) 0)))
	       (click-count::int read-only (get (lambda (o) 0)))
	       (modifiers::pair-nil read-only (get (lambda (o) '())))
	       (x::int read-only (get %event-x))
	       (y::int read-only (get %event-y))
	       (width::int read-only (get %event-width))
	       (height::int read-only (get %event-height))
	       (keyval::int read-only (get (lambda (o) -1)))
	       (char::char read-only (get (lambda (o) #a000))))
	    
	    (initialize-events!)
	    
	    (disconnect-event-handler! ::event-handler ::object)
	    (connect-event-handler! ::event-handler ::object)
	    
	    (generic install-callback! ::obj ::symbol ::obj)
	    (generic uninstall-callback! ::obj ::symbol ::obj))
   
   ;; the following classes are only used for the redefinition of
   ;; the implementation of their virtual slots. They are not exported
   ;; to user applications.
   (static  (class event-mouse::event
	       (type::symbol read-only (get %event-type))
	       (time::int read-only (get %event-mouse-time))
	       (button::int read-only (get %event-mouse-button))
	       (click-count::int read-only (get %event-mouse-click-count))
	       (modifiers::pair-nil read-only (get %event-mouse-modifiers)))
	    
	    ;; event canvas item
	    (class event-canvas-item::event-mouse)
	    
	    ;; keyboard events
	    (class event-key::event
	       (type::symbol read-only (get %event-type))
	       (time::int read-only (get %event-key-time))
	       (modifiers::pair-nil read-only (get %event-key-modifiers))
	       (keyval::int read-only (get %event-key-keyval))
	       (char::char read-only (get %event-key-char)))))

;*---------------------------------------------------------------------*/
;*    object-display ::event ...                                       */
;*    -------------------------------------------------------------    */
;*    We override the definition of OBJECT-DISPLAY so that we mask     */
;*    all the fields starting with a %. We don't override the          */
;*    OBJECT-WRITE generic so that a willing user is still able to     */
;*    access these fields.                                             */
;*---------------------------------------------------------------------*/
(define-method (object-display obj::event . port)
   (let ((port (if (pair? port) (car port) (current-output-port))))
      (define (class-field-write/display field)
	 (let* ((name      (class-field-name field))
		(sname     (symbol->string name))
		(get-value (class-field-accessor field)))
	    (if (not (char=? (string-ref sname 0) #\%))
		(begin
		   (display " [" port)
		   (display name port)
		   (display #\: port)
		   ;; we now print its specific fields
		   (if (not (class-field-indexed? field))
		       ;; this is not an indexed field
		       (begin
			  (display #\space port)
			  (display (get-value obj) port)
			  (display #\] port))
		       ;; this is an indexed field
		       (let* ((get-len (class-field-len-accessor field))
			      (len     (get-len obj)))
			  (let loop ((i 0))
			     (if (=fx i len)
				 (display #\] port)
				 (begin
				    (display #\space port)
				    (display (get-value obj i) port)
				    (loop (+fx i 1)))))))))))
      (let* ((class      (object-class obj))
	     (class-name (class-name class))
	     (fields     (class-fields class)))
	 (display "#{" port)
	 (display class-name port)
	 (for-each class-field-write/display fields)
	 (display #\} port))))

;*---------------------------------------------------------------------*/
;*    initialize-events! ...                                           */
;*---------------------------------------------------------------------*/
(define (initialize-events!)
   (%initialize-events! (instantiate::event)
			(instantiate::event)
			(instantiate::event-mouse)
			(instantiate::event-key)))

;*---------------------------------------------------------------------*/
;*    connect-event-handler! ::event-handler ...                       */
;*---------------------------------------------------------------------*/
(define (connect-event-handler! event::event-handler w::object)
   (with-access::event-handler event (%widgets
				      %destroy
				      %iconify
				      %deiconify
				      %press
				      %release
				      %click
				      %enter
				      %leave
				      %motion
				      %key
				      %focus-out
				      %focus-in
				      %configure)
      ;; store the widget inside the widgets list
      (if (not (memq w %widgets))
	  (set! %widgets (cons w %widgets)))
      ;; destroy
      (install-callback! w 'destroy %destroy)
      ;; iconify
      (install-callback! w 'iconify %iconify)
      ;; deiconify
      (install-callback! w 'deiconify %deiconify)
      ;; press
      (install-callback! w 'press %press)
      ;; release
      (install-callback! w 'release %release)
      ;; click
      (install-callback! w 'click %click)
      ;; enter
      (install-callback! w 'enter %enter)
      ;; leave
      (install-callback! w 'leave %leave)
      ;; motion
      (install-callback! w 'motion %motion)
      ;; key
      (install-callback! w 'key %key)
      ;; focus-in
      (install-callback! w 'focus-in %focus-in)
      ;; focus-out
      (install-callback! w 'focus-out %focus-out)
      ;; configure
      (install-callback! w 'configure %configure)))

;*---------------------------------------------------------------------*/
;*    disconnect-event-handler! ...                                    */
;*---------------------------------------------------------------------*/
(define (disconnect-event-handler! event::event-handler w::object)
   (with-access::event-handler event (%widgets
				      %destroy
				      %iconify
				      %deiconify
				      %press
				      %release
				      %click
				      %enter
				      %leave
				      %motion
				      %key
				      %focus-out
				      %focus-in
				      %configure)
      ;; unstore the widget inside the widgets list
      (set! %widgets (remq! w %widgets))
      ;; destroy
      (uninstall-callback! w 'destroy %destroy)
      ;; iconify
      (uninstall-callback! w 'iconify %iconify)
      ;; deiconify
      (uninstall-callback! w 'deiconify %deiconify)
      ;; press
      (uninstall-callback! w 'press %press)
      ;; release
      (uninstall-callback! w 'release %release)
      ;; click
      (uninstall-callback! w 'click %click)
      ;; enter
      (uninstall-callback! w 'enter %enter)
      ;; leave
      (uninstall-callback! w 'leave %leave)
      ;; motion
      (uninstall-callback! w 'motion %motion)
      ;; key
      (uninstall-callback! w 'key %key)
      ;; focus-in
      (uninstall-callback! w 'focus-in %focus-in)
      ;; focus-out
      (uninstall-callback! w 'focus-out %focus-out)
      ;; configure
      (uninstall-callback! w 'configure %configure)))

;*---------------------------------------------------------------------*/
;*    connect-callback! ...                                            */
;*---------------------------------------------------------------------*/
(define (connect-callback! evt new old event)
   (with-access::event-handler evt (widgets)
      (if (procedure? old)
	  ;; remove all the old callbacks
	  (for-each (lambda (w)
		       (uninstall-callback! w event old))
		    widgets))
      (if (procedure? new)
	  ;; connect all the new callbacks
	  (for-each (lambda (w)
		       (install-callback! w event new))
		    widgets))))
	 
;*---------------------------------------------------------------------*/
;*    install-callback! ::obj ...                                      */
;*---------------------------------------------------------------------*/
(define-generic (install-callback! w::obj evt::symbol proc)
   (if (not (or (procedure? proc) (not proc)))
       (error "install-callback!"
	      "Illegal callback (should be #f or a procedure)"
	      proc))
   #unspecified)

;*---------------------------------------------------------------------*/
;*    uninstall-callback! ::obj ...                                    */
;*---------------------------------------------------------------------*/
(define-generic (uninstall-callback! w::obj evt::symbol proc)
   #unspecified)
