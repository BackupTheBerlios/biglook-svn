;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/canvas.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Thu Jul 12 06:50:58 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Canvas widget                                            */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/canvas.texi@                               */
;*       @node Canvas@                                                 */
;*    Examples:                                                        */
;*       @path ../../examples/canvas/canvas.scm@                       */
;*    -------------------------------------------------------------    */
;*    Implementation: @label canvas@                                   */
;*    null: @path ../../peer/null/Lwidget/_canvas.scm@                 */
;*    gtk: @path ../../peer/gtk/Lwidget/_canvas.scm@                   */
;*    swing: @path ../../peer/swing/Lwidget/_canvas.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_canvas
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget)
   
   (export  (class canvas::container
	       ;; width
	       (width::int
		(get %canvas-width)
		(set %canvas-width-set!))
	       ;; height
	       (height::int
		(get %canvas-height)
		(set %canvas-height-set!))
	       ;; scroll-x
	       (scroll-x::int
		(get %canvas-scroll-x)
		(set %canvas-scroll-x-set!))
	       ;; scroll-y
	       (scroll-y::int
		(get %canvas-scroll-y)
		(set %canvas-scroll-y-set!))
	       ;; scroll-width
	       (scroll-width::int
		(get %canvas-scroll-width)
		(set %canvas-scroll-width-set!))
	       ;; scroll-height
	       (scroll-height::int
		(get %canvas-scroll-height)
		(set %canvas-scroll-height-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::canvas ...                                    */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::canvas)
   (with-access::canvas o (%peer)
      (set! %peer (%make-%canvas o))
      ;; the layout initialization
      (call-next-method)
      ;; we are done
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::canvas ...                                      */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::canvas widget . options)
   (error "container-add!(canvas)"
	  "Can't add widget to a canvas"
	  container))

;*---------------------------------------------------------------------*/
;*    container-remove! ::canvas ...                                   */
;*---------------------------------------------------------------------*/
(define-method (container-remove! container::canvas widget)
   (error "container-remove!(canvas)"
	  "Can't remove widget from a canvas (destroy the item instead)"
	  container))




