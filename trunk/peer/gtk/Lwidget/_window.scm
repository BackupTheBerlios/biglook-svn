;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_window.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Dec 15 07:57:03 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The GTk peer Window implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/window.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%window
   
   (import __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%event
	   __biglook_%callback
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%color)
   
   (extern (macro %%gtk-window-new::gtkwidget* (::long)
		  "gtk_window_new")
	   (macro %%gtk-window-set-default-size::void (::gtkwindow* ::int ::int)
		  "gtk_window_set_default_size")
	   (macro %%gtk-widget-unmap::void (::gtkwidget*)
		  "gtk_widget_unmap")
	   (macro %%gtk-widget-map::void (::gtkwidget*)
		  "gtk_widget_map")
	   (macro %%gtk-widget-realize::void (::gtkwidget*)
		  "gtk_widget_realize")
	   (macro %%gtk-widget-hide::void (::gtkwidget*)
		  "gtk_widget_hide")
	   (macro %%gtk-widget-unrealize::void (::gtkwidget*)
		  "gtk_widget_unrealize")
	   (macro %%gtk-main-iteration-do::void (::bool)
		  "gtk_main_iteration_do"))
   
   (static (class %window::%container
	      (destroy-command (default #f))))
   
   (export (%make-%window ::%bglk-object ::bool ::bool ::bool)
	   (%make-%applet ::%bglk-object)
	   
	   (%window-add! ::%bglk-object ::%bglk-object)
	   (%applet-add! ::%bglk-object ::%bglk-object)
	   
	   (%deiconify ::%bglk-object)
	   (%iconify ::%bglk-object)
	   (%update ::pair-nil)
	   
	   (%window-x::int ::%bglk-object)
	   (%window-x-set! ::%bglk-object ::int)
	   (%window-y::int ::%bglk-object)
	   (%window-y-set! ::%bglk-object ::int)
	   (%window-title ::%bglk-object)
	   (%window-title-set! ::%bglk-object ::bstring)))

;*---------------------------------------------------------------------*/
;*    %make-%window ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%window o::%bglk-object transient resizable modal)
   ;; we allocate a gtk window
   (let* ((gtk-window (if transient
			  (%%gtk-window-new %%gtk-window-popup)
			  (%%gtk-window-new %%gtk-window-toplevel)))
	  (%win (instantiate::%window
		   (%bglk-object o)
		   (%builtin (gtkobject gtk-window)))))
      ;; we have to register the window so that its Biglook object
      ;; won't ever been collected
      (register-window! %win)
      ;; resize policy
      (with-access::%window %win (%builtin)
	 (if resizable
	     (begin
		(%bglk-gtk-arg-set! %builtin "allow_grow" #t)
		(%bglk-gtk-arg-set! %builtin "allow_shrink" #t)
		(%bglk-gtk-arg-set! %builtin "auto_shrink" #t))
	     (begin
		(%bglk-gtk-arg-set! %builtin "allow_grow" #f)
		(%bglk-gtk-arg-set! %builtin "allow_shrink" #f)
		(%bglk-gtk-arg-set! %builtin "auto_shrink" #t)))
	 ;; modal
	 (%bglk-gtk-arg-set! %builtin "modal" modal))
      ;; we are done
      %win))
   
;*---------------------------------------------------------------------*/
;*    %make-%applet ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%applet o::%bglk-object)
   ;; we allocate a gtk window
   (let* ((gtk-window (%%gtk-window-new %%gtk-window-toplevel))
	  (%win (instantiate::%window
		   (%bglk-object o)
		   (%builtin (gtkobject gtk-window)))))
      ;; we have to register the window so that its Biglook object
      ;; won't ever been collected
      (register-window! %win)
      %win))

;*---------------------------------------------------------------------*/
;*    bglkwindow ...                                                   */
;*---------------------------------------------------------------------*/
(define (bglkwindow o::%peer)
   (with-access::%peer o (%builtin)
      (gtkwindow %builtin)))
 
;*---------------------------------------------------------------------*/
;*    *registered-window* ...                                          */
;*---------------------------------------------------------------------*/
(define *registered-window* '())

;*---------------------------------------------------------------------*/
;*    destroy-callback ...                                             */
;*---------------------------------------------------------------------*/
(define (destroy-callback e)
   (let ((window (%event-%widget e)))
      (unregister-window! (%bglk-object-%peer window))
      (if (null? *registered-window*)
	  (exit 0))))
      
;*---------------------------------------------------------------------*/
;*    register-window! ...                                             */
;*---------------------------------------------------------------------*/
(define (register-window! window::%window)
   ;; collect all the top level for the GC
   (set! *registered-window* (cons window *registered-window*))
   ;; the callback that specifies what to do when this window will be destroyed
   (%connect-widget-callback! (%window-%builtin window)
			      'destroy
			      destroy-callback))
   
;*---------------------------------------------------------------------*/
;*    unregister-window! ...                                           */
;*---------------------------------------------------------------------*/
(define (unregister-window! window::%window)
   (set! *registered-window* (remq! window *registered-window*)))
   
;*---------------------------------------------------------------------*/
;*    %window-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%window-add! o::%bglk-object w::%bglk-object)
   (%container-add! o w))

;*---------------------------------------------------------------------*/
;*    %applet-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%applet-add! o::%bglk-object w::%bglk-object)
   (not-implemented o "%applet-add!"))

;*---------------------------------------------------------------------*/
;*    %window-x ...                                                    */
;*---------------------------------------------------------------------*/
(define (%window-x::int o::%bglk-object)
   (gtk-arg-get o "x"))

;*---------------------------------------------------------------------*/
;*    %window-x-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%window-x-set! o::%bglk-object v::int)
   (gtk-arg-type-set! o "x" v GTK-TYPE-INT))

;*---------------------------------------------------------------------*/
;*    %window-y ...                                                    */
;*---------------------------------------------------------------------*/
(define (%window-y::int o::%bglk-object)
   (gtk-arg-get o "y"))

;*---------------------------------------------------------------------*/
;*    %window-y-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%window-y-set! o::%bglk-object v::int)
   (gtk-arg-type-set! o "y" v GTK-TYPE-INT))

;*---------------------------------------------------------------------*/
;*    %window-title ...                                                */
;*---------------------------------------------------------------------*/
(define (%window-title o::%bglk-object)
   (gtk-arg-get o "title"))

;*---------------------------------------------------------------------*/
;*    %window-title-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%window-title-set! o::%bglk-object v::bstring)
   (gtk-arg-set! o "title" v))

;*---------------------------------------------------------------------*/
;*    %deiconify ...                                                   */
;*---------------------------------------------------------------------*/
(define (%deiconify o::%bglk-object)
   (%%gtk-widget-unrealize (gtkwidget (%peer-%builtin (%bglk-object-%peer o))))
   o)
   
;*---------------------------------------------------------------------*/
;*    %iconify ...                                                     */
;*---------------------------------------------------------------------*/
(define (%iconify o::%bglk-object)
   (%%gtk-widget-unmap (gtkwidget (%peer-%builtin (%bglk-object-%peer o))))
   o)
   
;*---------------------------------------------------------------------*/
;*    %update ...                                                      */
;*---------------------------------------------------------------------*/
(define (%update o::pair-nil)
   (%%gtk-main-iteration-do #f)
   o)

 
   
   
