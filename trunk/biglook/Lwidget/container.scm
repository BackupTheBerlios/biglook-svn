;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/container.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Sep 19 11:52:32 2000                          */
;*    Last change :  Sat Jun  9 07:19:04 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook containers                                               */
;*    -------------------------------------------------------------    */
;*    Implementation: @label container@                                */
;*    null: @path ../../peer/null/Lwidget/_container.scm@              */
;*    gtk: @path ../../peer/gtk/Lwidget/_container.scm@                */
;*    swing: @path ../../peer/swing/Lwidget/_container.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_container
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_widget)
   
   (export (abstract-class container::widget
	      ;; the contained widgets
	      (children::pair-nil
	       (get %container-children)
	       read-only)
	      ;; default pading
	      (padx::int
	       (default 0))
	      (pady::int
	       (default 0))
	      ;; border-width
	      (border-width::int
	       (get %container-border-width)
	       (set %container-border-width-set!)))
	   
	   (generic container-add! ::container ::widget . options)
	   (generic container-remove! ::container ::widget)
	   (generic container-remove-all! ::container)))

;*---------------------------------------------------------------------*/
;*    container-add! ...                                               */
;*    -------------------------------------------------------------    */
;*    Add new children to a container.                                 */
;*---------------------------------------------------------------------*/
(define-generic (container-add! container::container widget::widget . options))

;*---------------------------------------------------------------------*/
;*    container-remove! ...                                            */
;*---------------------------------------------------------------------*/
(define-generic (container-remove! container::container widget::widget)
   (%container-remove! container widget))

;*---------------------------------------------------------------------*/
;*    container-remove-all! ...                                        */
;*---------------------------------------------------------------------*/
(define-generic (container-remove-all! container::container)
   (for-each (lambda (widget)
		(container-remove! container widget))
	     (container-children container)))


   

