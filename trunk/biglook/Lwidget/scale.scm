;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/scale.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Mar 22 06:57:26 2001                          */
;*    Last change :  Sat Jul 14 15:31:05 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Biglook scale class                                          */
;*    -------------------------------------------------------------    */
;*    Implementation: @label scale@                                    */
;*    null: @path ../../peer/null/Lwidget/_scale.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_scale.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_scale.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_scale

   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event)

   (export  (class scale::widget
	       ;; orientation
	       (orientation::symbol read-only (default 'vertical))
	       ;; scale command
	       (command
		(get %scale-command)
		(set (lambda (o v)
			(cond
			   ((not v)
			    (%scale-command-set! o v))
			   ((procedure? v)
			    (if (not (correct-arity? v 1))
				(error "scale-command-set!"
				       "Illegal command arity v"
				       v)
				(%scale-command-set! o v)))
			   (else
			    (error "scale-command-set!"
				   "Illegal command (should be #f or a procedure)"
				   v))))))
	       ;; value
	       (value::int
		(get %scale-value)
		(set %scale-value-set!))
	       ;; show ticks
	       (show-value?::bool
		(get %scale-show-value?)
		(set %scale-show-value?-set!))
	       ;; from
	       (from::int
		(get %scale-from)
		(set %scale-from-set!))
	       ;; to
	       (to::int
		(get %scale-to)
		(set %scale-to-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::scale ...                                     */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::scale)
   (with-access::scale o (%peer orientation)
      (case orientation
	 ((vertical)
	  (set! %peer (%make-%vscale o)))
	 ((horizontal)
	  (set! %peer (%make-%hscale o)))
	 (else
	  (error "make-scale"
		 "Illegal orientation (should be VERTICAL or HORIZONTAL)"
		 orientation)))
      (call-next-method)
      o))
