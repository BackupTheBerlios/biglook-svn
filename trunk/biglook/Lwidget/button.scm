;*=====================================================================*/
;*    biglook/Lwidget/button.scm                                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Tue Apr 27 14:40:51 2004 (dciabrin)               */
;*    Copyright   :  2000-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Button widget                                            */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/button.texi@                               */
;*       @node Button@                                                 */
;*    Examples:                                                        */
;*       @path ../../examples/button/button.scm@                       */
;*    -------------------------------------------------------------    */
;*    Implementation: @label button@                                   */
;*    null: @path ../../peer/null/Lwidget/_button.scm@                 */
;*    gtk: @path ../../peer/gtk/Lwidget/_button.scm@                   */
;*    swing: @path ../../peer/swing/Lwidget/_button.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_button
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event)
   
   (export  (class button::container
	       ;; command (special callback)
	       (command
		(get %button-command)
		(set (lambda (o v)
			(cond
			   ((not v)
			    (%button-command-set! o v))
			   ((procedure? v)
			    (if (not (correct-arity? v 1))
				(error "button-command-set!"
				       "Illegal command arity"
				       v)
				(%button-command-set! o v)))
			   (else
			    (error "button-command-set!"
				   "Illegal command value (should be #f or a procedure)"
				   v))))))
	       ;; button text
	       (text
		(get %button-text)
		(set %button-text-set!))
	       ;; button image
	       (image
		(get %button-image)
		(set (lambda (o v::image)
			(with-access::image v (parent)
			   (if (bglk-object? parent)
			       (error "buttom-image-set!"
				      "Image already used"
				      v)
			       (%button-image-set! o v))))))
	       ;; border-width
	       (border-width::int
		(get %button-border-width)
		(set %button-border-width-set!))
	       ;; relief
	       (relief::symbol
		(get %button-relief)
		(set %button-relief-set!))
	       ;; active
	       (active::bool
		(get %widget-active?)
		(set %widget-active?-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::button ...                                    */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::button)
   (with-access::button o (%peer)
      (if (eq? %peer #unspecified)
	  ;; if %peer is not #unspecified, then, we are entering this
	  ;; method by a call-next-method from a sub classe a button
	  ;; such a check-button or radio-button
	  (set! %peer (%make-%button o)))
      (call-next-method)
      o))
