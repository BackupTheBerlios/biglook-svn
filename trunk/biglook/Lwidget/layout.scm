;*=====================================================================*/
;*    biglook/Lwidget/layout.scm                                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sun Apr 15 18:09:57 2001                          */
;*    Last change :  Fri Apr 23 14:07:05 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The abstract class layout. A layout is a container with a        */
;*    specific layout. The two subclasses of layout in the standard    */
;*    library are: window and frame.                                   */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_layout
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_box)
   
   (export  (abstract-class layout::container
	       ;; private fields
	       (layout (default #unspecified))
	       ;; the contained widgets
	       (children::pair-nil
		(get (lambda (o)
			(with-access::layout o (layout)
			   (if (not (bglk-object? layout))
			       (%container-children o)
			       (%container-children layout)))))
		read-only)
	       ;; expand
	       (expand::bool
		(get (lambda (o)
			(with-access::layout o (layout)
			   (if (box? layout)
			       (box-expand layout)
			       #f))))
		(set (lambda (o v)
			(with-access::layout o (layout)
			   (if (box? layout)
			       (box-expand-set! layout v)
			       #f)))))
	       ;; fill
	       (fill::bool
		(get (lambda (o)
			(with-access::layout o (layout)
			   (if (box? layout)
			       (box-fill layout)
			       #f))))
		(set (lambda (o v)
			(with-access::layout o (layout)
			   (if (box? layout)
			       (box-fill-set! layout v)
			       #f)))))
	       ;; padding
	       (padding::int
		(get (lambda (o)
			(with-access::layout o (layout)
			   (if (box? layout)
			       (box-padding layout)
			       -1))))
		(set (lambda (o v)
			(with-access::layout o (layout)
 			   (if (box? layout)
			       (box-padding-set! layout v)
			       -1))))))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::layout ...                                    */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::layout)
   (call-next-method)
   (with-access::layout o (layout)
      (cond
       ((eq? layout #unspecified)
	  ;; if the user has not specified its own layout or #f (which
	  ;; means no layout), then we allocate a vertical box container
	  ;; inside the layout
	 (set! layout (instantiate::box
			 (orientation 'vertical)
			 (parent o)
			 (fill #f)
			 (expand #f) 
			 (homogeneous #f))))
       ((container? layout)
	(container-parent-set! layout o)))))

;*---------------------------------------------------------------------*/
;*    container-remove! ::layout ...                                   */
;*---------------------------------------------------------------------*/
(define-method (container-remove! container::layout widget)
   (with-access::layout container (layout)
      (if (or (not (bglk-object? layout)) (eq? widget layout))
	  (call-next-method)
	  (container-remove! layout widget))))


	       
