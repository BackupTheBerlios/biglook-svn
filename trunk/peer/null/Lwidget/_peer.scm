;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/%peer.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 31 13:34:23 2001                          */
;*    Last change :  Tue Apr 17 05:29:21 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The implementation of the peer object.                           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%peer
   
   (import __biglook_%error
	   __biglook_%bglk-object)
   
   (export (class %peer
	      ;; constructor
	      (%peer-init)
	      ;; the builtin object
	      (%builtin (default #unspecified))
	      ;; the biglook object
	      (%bglk-object
	       (get peer-%bglk-object)
	       (set peer-%bglk-object-set!)))
	   
	   (generic %peer-init ::%peer)

	   (peer-%bglk-object ::%peer)
	   (peer-%bglk-object-set! ::%peer ::%bglk-object)))
	   
;*---------------------------------------------------------------------*/
;*    %peer-init ...                                                   */
;*---------------------------------------------------------------------*/
(define-generic (%peer-init peer::%peer)
   (not-implemented %peer (find-runtime-type peer)))

;*---------------------------------------------------------------------*/
;*    peer-%bglk-object ...                                            */
;*---------------------------------------------------------------------*/
(define (peer-%bglk-object o::%peer)
   (not-implemented o "peer-%bglk-object"))

;*---------------------------------------------------------------------*/
;*    peer-%bglk-object-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (peer-%bglk-object-set! o::%peer v::%bglk-object)
   (not-implemented o "peer-%bglk-object-set!"))


	   
	      
