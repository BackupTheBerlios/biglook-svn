;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/toolbar.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Sat Jun  2 09:00:46 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Menu widget                                              */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/menu.texi@                                 */
;*       @node Menu@                                                   */
;*    Examples:                                                        */
;*       @path ../../examples/toolbar/toolbar.scm@                     */
;*    -------------------------------------------------------------    */
;*    Implementation: @label toolbar@                                  */
;*    null: @path ../../peer/null/Lwidget/_toolbar.scm@                */
;*    gtk: @path ../../peer/gtk/Lwidget/_toolbar.scm@                  */
;*    swing: @path ../../peer/swing/Lwidget/_toolbar.scm@              */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*---------------------------------------------------------------------*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_toolbar
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image)
   
   (export  (class toolbar::container
	       ;; floating toolbar
	       (floating::bool
		(default #t))
	       ;; shadow of the toolbar
	       (shadow::symbol
		(get %toolbar-shadow)
		(set %toolbar-shadow-set!))
	       ;; relief of the toolbar buttons
	       (relief::symbol
		(get %toolbar-relief)
		(set %toolbar-relief-set!))
	       ;; orientation
	       (orientation::symbol
		(get %toolbar-orientation)
		(set %toolbar-orientation-set!))
	       ;; space size
	       (space-size::int
		(get %toolbar-space-size)
		(set %toolbar-space-size-set!))
	       ;; easy shortcut to construct the toolbar
	       (easy
		(get (lambda (o)
			#unspecified))
		(set (lambda (o v)
			(%toolbar-easy-set! o v)))))

	    (toolbar-add! ::toolbar . options)))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::toolbar ...                                   */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::toolbar)
   (with-access::toolbar o (%peer floating)
      (set! %peer (%make-%toolbar o floating))
      ;; the layout initialization
      (call-next-method)
      ;; we are done
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::toolbar ...                                     */
;*---------------------------------------------------------------------*/
(define-method (container-add! c::toolbar w . options)
   (let-options options ((:space #f)
			 (:tooltips #f))
      (%toolbar-add! c w space tooltips)))

;*---------------------------------------------------------------------*/
;*    toolbar-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (toolbar-add! c::toolbar . options)
   (let-options options ((:space #f)
			 (:tooltips #f)
			 (:text #f)
			 (:icon #f)
			 (:command (lambda (_) #f)))
      (if (and (not (string? text))
	       (not (string? icon))
	       (not (bglk-object? icon)))
	  (error "toolbar-add!" "Text or icon shouldn't be #f" options)
	  (let ((image (if (string? icon)
			   (if (image-exists? icon)
			       (file->image icon)
			       (string->image icon))
			   icon)))
	     (%toolbar-item-add! c text image space tooltips command)))))
		      
;*---------------------------------------------------------------------*/
;*    toolbar-easy-set! ...                                            */
;*    -------------------------------------------------------------    */
;*    This function allocates a toolbar from a list specification.     */
;*---------------------------------------------------------------------*/
(define (%toolbar-easy-set! parent::toolbar items::pair-nil)
   (define (toolbar-add-space! parent)
      (%toolbar-item-add! parent #f #f #t #f #f))
   (for-each (lambda (item)
		(match-case item
		   (:space
		    (toolbar-add-space! parent))
		   ((:space . ?-)
		    (toolbar-add-space! parent))
		   ((:icon . ?-)
		    (apply toolbar-add! parent item))
		   ((:text . ?-)
		    (apply toolbar-add! parent item))
		   (else
		    (error "toolbar-easy-set!" "Illegal item" item))))
	     items))

;*---------------------------------------------------------------------*/
;*    easy-toolbar ...                                                 */
;*---------------------------------------------------------------------*/
(define (easy-toolbar parent::toolbar items::pair-nil)
   #unspecified)
      
