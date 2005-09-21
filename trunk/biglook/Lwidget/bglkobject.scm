;*=====================================================================*/
;*    biglook/Lwidget/bglkobject.scm                                   */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:16:28 2000                          */
;*    Last change :  Wed Sep 21 22:23:10 2005 (dciabrin)               */
;*    Copyright   :  2000-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Biglook bglk-object class                                    */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_bglk-object

   (library biglook_peer)

   ;; This is the only module that *must* import _biglook_app. That last
   ;; module has to be imported once in order to executed its toplevel
   ;; expressions
   (import  __biglook_app)
   
   (export  (class bglk-object::%bglk-object
	       ;; constructor
	       (bglk-object-init))
	   
	    (generic bglk-object-init ::bglk-object)

	    (generic destroy ::bglk-object)
	    (generic widget-repaint! ::bglk-object)
	    (generic widget-raise! ::bglk-object)
	    (generic widget-lower! ::bglk-object)))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ...                                             */
;*---------------------------------------------------------------------*/
(define-generic (bglk-object-init bglk-object::bglk-object)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    object-display ::bglk-object ...                                 */
;*---------------------------------------------------------------------*/
(define-method (object-display w::bglk-object . port)
   (apply write-circle w port))
	       
;*---------------------------------------------------------------------*/
;*    object-write ::bglk-object ...                                   */
;*---------------------------------------------------------------------*/
(define-method (object-write w::bglk-object . port)
   (apply write-circle w port))

;*---------------------------------------------------------------------*/
;*    destroy ::bglk-object ...                                        */
;*---------------------------------------------------------------------*/
(define-generic (destroy widget::bglk-object))

;*---------------------------------------------------------------------*/
;*    widget-repaint! ::bglk-object ...                                */
;*---------------------------------------------------------------------*/
(define-generic (widget-repaint! widget::bglk-object))

;*---------------------------------------------------------------------*/
;*    raise ::bglk-object ...                                          */
;*---------------------------------------------------------------------*/
(define-generic (widget-raise! widget::bglk-object))

;*---------------------------------------------------------------------*/
;*    lower ::bglk-object ...                                          */
;*---------------------------------------------------------------------*/
(define-generic (widget-lower! widget::bglk-object))
		       
