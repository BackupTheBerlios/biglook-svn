;*=====================================================================*/
;*    biglook/Lwidget/widget.scm                                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Mar 22 06:57:26 2001                          */
;*    Last change :  Tue May 11 14:16:58 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Biglook widget class                                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label widget@                                   */
;*    null: @path ../../peer/null/Lwidget/_widget.scm@                 */
;*    gtk: @path ../../peer/gtk/Lwidget/_widget.scm@                   */
;*    swing: @path ../../peer/swing/Lwidget/_widget.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_widget
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_event)
   
   (use     __biglook_container)
   
   (export  (class widget::bglk-object
	       ;; parent
	       (parent
		(get %widget-parent)
		(set (lambda (o v)
			;; the action of setting the parent is to
			;; add self into the parent that must be a
			;; container
			(if (pair? v)
			    (apply container-add! (car v) o (cdr v))
			    (container-add! v o)))))
	       ;; event handler
	       (event
		(get %widget-event)
		(set (lambda (o v)
			(cond
			   ((event-handler? v)
			    (let ((oldv (widget-event o)))
			       ;; we register the new event handler so that no
			       ;; callback will be reclaimed by the collector
			       (%widget-event-set! o v)
			       ;; we disconnect the old widget event to that
			       ;; if that event-handler is modified o won't
			       ;; be impacted
			       (if (event-handler? oldv)
				   (disconnect-event-handler! oldv o))
			       ;; if the new value is a legal event-handler, we
			       ;; just have to connect, all former callbacks
			       ;; will be automatically disconnected
			       (connect-event-handler! v o)))
			   ((not v)
			    #unspecified)
			   (else
			    (bigloo-type-error "widget-event-set!"
					       "event-handler"
					       v))))))
	       ;; width
	       (width::int
		(get %widget-width)
		(set %widget-width-set!))
	       ;; height
	       (height::int
		(get %widget-height)
		(set %widget-height-set!))
	       ;; tooltip
	       (tooltips
		(get %widget-tooltips)
		(set %widget-tooltips-set!))
	       ;; name
	       (name
		(get %widget-name)
		(set %widget-name-set!))
	       ;; visible
	       (visible
		(get %widget-visible)
		(set %widget-visible-set!))
	       ;; visible
	       (enabled
		(get %widget-enabled)
		(set %widget-enabled-set!))
	       ;; can focus
	       (can-focus
		(get %widget-can-focus?)
		(set %widget-can-focus?-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ...                                             */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::widget)
   (widget-name-set! o (symbol->string (class-name (object-class o))))
   #unspecified)

;*---------------------------------------------------------------------*/
;*    destroy ::widget ...                                             */
;*---------------------------------------------------------------------*/
(define-method (destroy widget::widget)
   ;; upon destruction, we have to unconnect the widget from its event-handler
   ;; otherwise we will go into troubles if new callbacks are set to that
   ;; event-handler (these callbacks will be connected to the destroyed widget).
   (let ((oldv (widget-event widget)))
      (if (event-handler? oldv)
	  (disconnect-event-handler! oldv widget)))
   ;; we can now physically destroy the widget
   (%destroy-widget widget))

;*---------------------------------------------------------------------*/
;*    widget-repaint! ::widget ...                                     */
;*---------------------------------------------------------------------*/
(define-method (widget-repaint! widget::widget)
   (%repaint-widget widget))
   
;*---------------------------------------------------------------------*/
;*    raise ::widget ...                                               */
;*---------------------------------------------------------------------*/
(define-method (raise widget::widget)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    lower ::widget ...                                               */
;*---------------------------------------------------------------------*/
(define-method (lower widget::widget)
   #unspecified)
		       
;*---------------------------------------------------------------------*/
;*    install-callback! ::widget ...                                   */
;*---------------------------------------------------------------------*/
(define-method (install-callback! w::widget evt::symbol proc)
   (cond
      ((procedure? proc)
       (%install-widget-callback! w evt proc))
      ((not proc)
       #unspecified)
      (else
       (error "install-callback!(widget)"
	      "Illegal callback (should be #f or a procedure)"
	      proc))))

;*---------------------------------------------------------------------*/
;*    uninstall-callback! ::widget ...                                 */
;*---------------------------------------------------------------------*/
(define-method (uninstall-callback! w::widget evt::symbol proc)
   ;; uninstall is not a user function, we don't have to check any error here
   (if (procedure? proc)
       (%uninstall-widget-callback! w evt proc)))

