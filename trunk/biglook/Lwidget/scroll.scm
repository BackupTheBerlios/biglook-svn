;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/scroll.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Apr  9 17:06:53 2001                          */
;*    Last change :  Thu Jul 26 15:34:03 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The scroll layout manager                                        */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/scroll.texi@                               */
;*       @node Scroll@                                                 */
;*    Examples:                                                        */
;*       @path ../../examples/scroll/scroll.scm@                       */
;*    -------------------------------------------------------------    */
;*    Implementation: @label widget@                                   */
;*    null: @path ../../peer/null/Lwidget/_scroll.scm@                 */
;*    gtk: @path ../../peer/gtk/Lwidget/_scroll.scm@                   */
;*    swing: @path ../../peer/swing/Lwidget/_scroll.scm@               */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_scroll
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_widget
	    __biglook_container)
   
   (export  (class scroll::container
	       (hfraction::double
		(get %scroll-hfraction)
		(set %scroll-hfraction-set!))
	       (vfraction::double
		(get %scroll-vfraction)
		(set %scroll-vfraction-set!))
	       (hside::symbol
		(get %scroll-hside)
		(set %scroll-hside-set!))
	       (vside::symbol
		(get %scroll-vside)
		(set %scroll-vside-set!))
	       (hpolicy::symbol
		(get %scroll-hpolicy)
		(set %scroll-hpolicy-set!))
	       (vpolicy::symbol
		(get %scroll-vpolicy)
		(set %scroll-vpolicy-set!))
	       (hpage-size::int
		read-only
		(get %scroll-hpage-size))
	       (vpage-size::int
		read-only
		(get %scroll-vpage-size)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::scroll ...                                    */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::scroll)
   (with-access::scroll o (%peer)
      (set! %peer (%make-%scroll o))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::scroll ...                                      */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::scroll widget . options)
   (if (pair? (container-children container))
       (container-remove-all! container))
   (%scroll-add! container widget))
	  
