;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/frame.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Apr  9 17:06:53 2001                          */
;*    Last change :  Thu Jun 14 17:14:49 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The frame layout manager                                         */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/window.texi@                               */
;*       @node Frame@                                                  */
;*    Examples:                                                        */
;*       @path ../../examples/frame/frame.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label widget@                                   */
;*    null: @path ../../peer/null/Lwidget/_frame.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_frame.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_frame.scm@                */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_frame
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_layout
	    __biglook_box)
   
   (export  (class frame::layout
	       ;; title
	       (title
		(get %frame-title)
		(set %frame-title-set!))
	       ;; justify
	       (title-justify
		(get %frame-title-justify)
		(set %frame-title-justify-set!))
	       ;; shadow
	       (shadow::symbol
		(get %frame-shadow)
		(set %frame-shadow-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::frame ...                                     */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::frame)
   (with-access::frame o (%peer layout)
      (if (eq? %peer #unspecified)
	  (set! %peer (%make-%frame o)))
      ;; the layout initialization
      (call-next-method)
      ;; we are done
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::frame ...                                       */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::frame widget . options)
   (with-access::frame container (layout)
      (if (or (not (bglk-object? layout)) (eq? widget layout))
	  (%frame-add! container widget)
	  (apply container-add! layout widget options))))


