;*=====================================================================*/
;*    swt/Lwidget/_window.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 23:13:33 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Jvm peer Window implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/window.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%window
   
   (import
    __biglook_%awt
	   __biglook_%swt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%error
	   __biglook_%color
	   __biglook_%callback)
   
   (static (class %window::%container))
   
   (export (%make-%window ::%bglk-object ::bool ::bool ::bool)
	   (%make-%applet ::%bglk-object)
	    
	   (%window-add! ::%bglk-object ::%bglk-object)
	   (%applet-add! ::%bglk-object ::%bglk-object)
	   
	   (%update ::pair-nil)
	   (%deiconify ::%bglk-object)
	   (%iconify ::%bglk-object)
	   
	   (%window-x::int ::%bglk-object)
	   (%window-x-set! ::%bglk-object ::int)
	   (%window-y::int ::%bglk-object)
	   (%window-y-set! ::%bglk-object ::int)
	   (%window-title ::%bglk-object)
	   (%window-title-set! ::%bglk-object ::bstring)))

;*---------------------------------------------------------------------*/
;*    %peer-init ...                                                   */
;*---------------------------------------------------------------------*/
(define-method (%peer-init peer::%window)
;   (print "Dans le %peer-init")
;   peer)
   ;; prevent native widget to be made visible
   ;; windows has to be set visible explicitely by the user
   (let ((tmp (%peer-%builtin peer)))
      (%peer-%builtin-set! peer #unspecified)
      (call-next-method)
      (%peer-%builtin-set! peer tmp))

   (if (%swt-shell? (%peer-%builtin peer))
       (let ((shell::%swt-shell (%peer-%builtin peer)))
	  (%swt-shell-size-set! shell 200 160)
	  ;(%swt-shell-open shell)
	  peer)
       peer))

;*---------------------------------------------------------------------*/
;*    %make-%window ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%window o::%bglk-object transient auto-resize modal)
   (if transient
       (%make-transient-%window o modal)
       (%make-titled-%window o auto-resize modal)))

;*---------------------------------------------------------------------*/
;*    %make-transient-%window ...                                      */
;*---------------------------------------------------------------------*/
(define (%make-transient-%window o::%bglk-object modal)
   (let ((win (instantiate::%window
;		 (%builtin (if modal
;			       (%swing-jdialog-new)
;			       (%swing-jwindow-new)))
		 (%builtin (%swt-shell-new %bglk-swt-display))
		 (%bglk-object o))))
;      (register-window! win)
      (print "weijoiowefjiowfe")
      win))

;*---------------------------------------------------------------------*/
;*    %make-titled-%window ...                                         */
;*---------------------------------------------------------------------*/
(define (%make-titled-%window o::%bglk-object auto-resize? modal)
;   (let ((frame::%awt-window (if modal
;				 (%swing-jdialog-new)
;				 (%swing-jframe-new))))
;      (%swing-jframe-close-set! frame
;				%swing-window-constants-DO-NOTHING-ON-CLOSE)
;      (%awt-frame-resizable-set! frame auto-resize?)
;      ;; we have to register the window so that we can implement UPDATE
;      (let ((win (instantiate::%window
;		    (%builtin frame)
;		    (%bglk-object o))))
   (let ((win (instantiate::%window
		 (%builtin (%swt-shell-new/style %bglk-swt-display
						 %swt-constants-SHELL_TRIM))
		 (%bglk-object o))))
      (register-window! win)
      win))

;*---------------------------------------------------------------------*/
;*    *registered-window* ...                                          */
;*---------------------------------------------------------------------*/
(define *registered-window* '())

;*---------------------------------------------------------------------*/
;*    register-window! ...                                             */
;*---------------------------------------------------------------------*/
(define (register-window! window::%window)
   ;; collect all the top level for the GC
   (set! *registered-window* (cons window *registered-window*))
   ;; and mark then to be collectable on destruction
   (%install-window-destroy-handler! window 
				     (lambda (e)
					(unregister-window! window)
					;; if this is the last window, kill the
					;; application
					(if (null? *registered-window*)
					    (exit 0)))))
   
;*---------------------------------------------------------------------*/
;*    unregister-window! ...                                           */
;*---------------------------------------------------------------------*/
(define (unregister-window! window::%window)
   (set! *registered-window* (remq! window *registered-window*)))
   
;*---------------------------------------------------------------------*/
;*    %make-%applet ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%applet o::%bglk-object)
   (instantiate::%window
      (%builtin (%bglk-get-applet))
      (%bglk-object o)))

;*---------------------------------------------------------------------*/
;*    %window-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%window-add! o::%bglk-object w::%bglk-object)
   (print "add: " (find-runtime-type w))
   '(with-access::%bglk-object o (%peer)
      (let* ((window::%awt-container (%peer-%builtin %peer))
	     (pane::%awt-container (cond
				      ((%swing-jframe? window)
				       (%swing-jframe-contentpane window))
				      ((%swing-jwindow? window)
				       (%swing-jwindow-contentpane window))
				      (else
				       (error "%window-add!"
					      "Illegal peer window"
					      window)))))
	 (%container-awt-add! pane w))))
 
;*---------------------------------------------------------------------*/
;*    %applet-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%applet-add! o::%bglk-object w::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (let* ((window::%awt-container (%peer-%builtin %peer))
	     (pane::%awt-container (cond
				      ((%swing-japplet? window)
				       (%swing-japplet-contentpane window))
				      (else
				       (error "%window-add!"
					      "Illegal peer window"
					      window)))))
	 (%container-awt-add! pane w))))
 
;*---------------------------------------------------------------------*/
;*    %window-x ...                                                    */
;*---------------------------------------------------------------------*/
(define (%window-x::int o::%bglk-object)
   -1)

;*---------------------------------------------------------------------*/
;*    %window-x-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%window-x-set! o::%bglk-object v::int)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %window-y ...                                                    */
;*---------------------------------------------------------------------*/
(define (%window-y::int o::%bglk-object)
   -1)

;*---------------------------------------------------------------------*/
;*    %window-y-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%window-y-set! o::%bglk-object v::int)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %window-title ...                                                */
;*---------------------------------------------------------------------*/
(define (%window-title o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (let ((shell (%peer-%builtin %peer)))
	 (if (%swt-shell? shell)
	     (%bglk-jstring->bstring (%swt-shell-title shell))
	     #f))))

;*---------------------------------------------------------------------*/
;*    %window-title-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%window-title-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (let ((shell (%peer-%builtin %peer)))
	 (if (%swt-shell? shell)
	     (begin
		(%swt-shell-title-set! (%peer-%builtin %peer)
				       (%bglk-bstring->jstring v))
		o))
	 o)))

;*---------------------------------------------------------------------*/
;*    %deiconify ...                                                   */
;*---------------------------------------------------------------------*/
(define (%deiconify o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      ;(%awt-component-visible-set! (%peer-%builtin %peer) #f)
      o))
   
;*---------------------------------------------------------------------*/
;*    %iconify ...                                                     */
;*---------------------------------------------------------------------*/
(define (%iconify o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      ;(%awt-component-visible-set! (%peer-%builtin %peer) #f)
      o))
   
;*---------------------------------------------------------------------*/
;*    %update ...                                                      */
;*---------------------------------------------------------------------*/
(define (%update windows)
   (define (doupdate peer)
      (%awt-window-pack (%peer-%builtin peer))
      (let loop ((num (-fx (%awt-container-children-number
			    (%peer-%builtin peer))
			   1)))
	 (if (>= num 0)
	     (let ((c (%awt-container-child (%peer-%builtin peer) num)))
		(if (%awt-container? c)
		    (let ((co::%awt-container c))
		       (%awt-container-repaint co)
		       #unspecified))
		(loop (-fx num 1))))))
   (if (pair? windows)
       (for-each (lambda (o)
		    (with-access::%bglk-object o (%peer)
		       (doupdate %peer)))
		 windows)
       (for-each doupdate *registered-window*)))
