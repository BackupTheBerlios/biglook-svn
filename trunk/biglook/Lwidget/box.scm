;*=====================================================================*/
;*    biglook/Lwidget/box.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Sep 19 11:52:32 2000                          */
;*    Last change :  Sun Apr 25 15:59:15 2004 (braun)                  */
;*    Copyright   :  2000-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook containers                                               */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/box.texi@                                  */
;*       @node Box@                                                    */
;*    Examples:                                                        */
;*       @path ../../examples/window/window.scm@                       */
;*    -------------------------------------------------------------    */
;*    Implementation: @label box@                                      */
;*    null: @path ../../peer/null/Lwidget/_box.scm@                    */
;*    gtk: @path ../../peer/gtk/Lwidget/_box.scm@                      */
;*    swing: @path ../../peer/swing/Lwidget/_box.scm@                  */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_box
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget)
   
   (export (class box::container
	      (orientation::symbol read-only (default 'vertical))
	      (expand::bool (default #f))
 	      (fill::bool (default #f))
	      (padding::int (default 0))
	      (homogeneous::bool
	       (get %box-homogenous)
	       (set %box-homogenous-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::box ...                                       */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::box)
   (with-access::box o (%peer orientation)
      (case orientation
	 ((vertical)
	  (set! %peer (%make-%vbox o)))
	 ((horizontal)
	  (set! %peer (%make-%hbox o)))
	 (else
	  (error "make-box"
		 "Illegal orientation (should be VERTICAL or HORIZONTAL)"
		 orientation)))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::box ...                                         */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::box widget . options)
   (with-access::box container (orientation padx pady expand fill padding)
      (let-options options ((:expand expand)
			    (:fill fill)
			    (:padding padding)
			    (:end #f)
			    (error-proc: "container-add!(vbox)"))
	 (if (eq? orientation 'vertical)
	     (%vbox-add! container widget expand fill padding (not end))
	     (%hbox-add! container widget expand fill padding (not end))))))

;(define-method (container-remove! container::box widget)
;   (print "iuouiouiou")
;   '(%container-remove! box widget))