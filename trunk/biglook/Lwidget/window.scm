;*=====================================================================*/
;*    biglook/Lwidget/window.scm                                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Fri Apr 23 14:01:30 2004 (dciabrin)               */
;*    Copyright   :  2000-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Window widget                                            */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/window.texi@                               */
;*       @node Window@                                                 */
;*    Examples:                                                        */
;*       @path ../../examples/window/window.scm@                       */
;*    -------------------------------------------------------------    */
;*    Implementation: @label window@                                   */
;*    null: @path ../../peer/null/Lwidget/_window.scm@                 */
;*    gtk: @path ../../peer/gtk/Lwidget/_window.scm@                   */
;*    swing: @path ../../peer/swing/Lwidget/_window.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_window
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_canvas
	    __biglook_container
	    __biglook_widget
	    __biglook_layout
	    __biglook_menu
	    __biglook_box)
   
   (export  (class window::layout
	       ;; title
	       (title
		(get %window-title)
		(set %window-title-set!)
		(default "Biglook Window"))
	       ;; transient
	       (transient::bool (default #f))
	       ;; resizable
	       (resizable::bool (default #t))
	       ;; modal
	       (modal::bool read-only (default #f))
	       ;; x
	       (x::int
		(get %window-x)
		(set %window-x-set!))
	       ;; y
	       (y::int
		(get %window-y)
		(set %window-y-set!)))
	    
	    (class applet::container)

	    (update . args)
	    (deiconify ::window)
	    (iconify ::window)))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::window ...                                    */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::window)
   (with-access::window o (%peer layout transient resizable modal)
      (if (not (bglk-object? %peer))
	  (set! %peer (%make-%window o transient resizable modal)))
      ;; the layout initialization
      (call-next-method)
      ;; we are done
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::applet ...                                    */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::applet)
   (with-access::applet o (%peer)
      (set! %peer (%make-%applet o))
      ;; the layout initialization
      (call-next-method)
      ;; we are done
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::window ...                                      */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::window widget . options)
   (with-access::window container (layout)
      (cond
	 ((menubar? widget)
	  (%window-add! container widget))
	 ((or (not (bglk-object? layout)) (eq? widget layout))
	  (%window-add! container widget))
	 (else
	  (apply container-add! layout widget options)))))

;*---------------------------------------------------------------------*/
;*    container-add! ::applet ...                                      */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::applet widget . options)
   (%applet-add! container widget))

;*---------------------------------------------------------------------*/
;*    update ...                                                       */
;*---------------------------------------------------------------------*/
(define (update . windows)
   (%update windows))

;*---------------------------------------------------------------------*/
;*    deiconify ...                                                    */
;*---------------------------------------------------------------------*/
(define (deiconify self::window)
   (%deiconify self))

;*---------------------------------------------------------------------*/
;*    iconify ...                                                      */
;*---------------------------------------------------------------------*/
(define (iconify self::window)
   (%iconify self))

	       
