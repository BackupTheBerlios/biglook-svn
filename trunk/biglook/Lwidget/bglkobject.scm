;*=====================================================================*/
;*    biglook/Lwidget/bglkobject.scm                                   */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:16:28 2000                          */
;*    Last change :  Tue May 11 14:16:09 2004 (dciabrin)               */
;*    Copyright   :  2000-04 Manuel Serrano                            */
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
	    (generic raise ::bglk-object)
	    (generic lower ::bglk-object)))

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
(define-generic (raise widget::bglk-object))

;*---------------------------------------------------------------------*/
;*    lower ::bglk-object ...                                          */
;*---------------------------------------------------------------------*/
(define-generic (lower widget::bglk-object))
		       
