;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/paned.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Sun Jun 10 10:05:54 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Paned widget                                             */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/paned.texi@                                */
;*       @node Paned@                                                  */
;*    Examples:                                                        */
;*       @path ../../examples/paned/paned.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label paned@                                    */
;*    null: @path ../../peer/null/Lwidget/_paned.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_paned.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_paned.scm@                */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_paned
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event
	    __biglook_frame
	    __biglook_layout)
   
   (export  (class paned::container
	       ;; private variable for deciding in which frame we
	       ;; add a new widget
	       (%last-frame::int (default 2))
	       ;; orientation
	       (orientation::symbol read-only (default 'vertical))
	       ;; container configuration
	       (expand::bool (default #t))
	       (shrink::bool (default #t))
	       ;; fraction
	       (fraction::double
		(get (lambda (o)
			(if (eq? (paned-orientation o) 'vertical)
			    (%vpaned-fraction o)
			    (%hpaned-fraction o))))
		(set (lambda (o v)
			(if (eq? (paned-orientation o) 'vertical)
			    (%vpaned-fraction-set! o v)
			    (%hpaned-fraction-set! o v))))))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::paned ...                                     */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::paned)
   (with-access::paned o (%peer orientation)
      (case orientation
	 ((vertical)
	  (set! %peer (%make-%vpaned o)))
	 ((horizontal)
	  (set! %peer (%make-%hpaned o)))
	 (else
	  (error "make-scale"
		 "Illegal orientation (should be VERTICAL or HORIZONTAL)"
		 orientation)))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::paned ...                                       */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::paned w . options)
   (with-access::paned container (expand shrink %last-frame orientation)
      (let-options options ((:expand expand)
			    (:shrink #t)
			    (:frame (if (=fx %last-frame 1)
					2
					1))
			    (error-proc: "container-add!(paned)"))
	 (set! %last-frame frame)
	 (%paned-add! container w
		      (eq? orientation 'horizontal)
		      expand shrink frame))))

;*---------------------------------------------------------------------*/
;*    container-remove-all! ::paned ...                                */
;*---------------------------------------------------------------------*/
(define-method (container-remove-all! container::paned)
   (with-access::paned container (%last-frame)
      (set! %last-frame 2)
      (call-next-method)))
