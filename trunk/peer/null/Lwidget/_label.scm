;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/%label.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sat Apr 28 14:52:58 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Label implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/label.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%label
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static (class %label::%peer))
	   
   (export (%make-%label ::%bglk-object)
	   
	   (%label-text::bstring ::%bglk-object)
	   (%label-text-set! ::%bglk-object ::bstring)
	   
	   (%label-justify::symbol ::%bglk-object)
	   (%label-justify-set! ::%bglk-object ::symbol)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%label ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%label o::%bglk-object)
   (not-implemented o "%peer-init(label)"))

;*---------------------------------------------------------------------*/
;*    %label-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%label-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%label-text")))

;*---------------------------------------------------------------------*/
;*    %label-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%label-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%label-text-set!")))

;*---------------------------------------------------------------------*/
;*    %label-justify ...                                               */
;*---------------------------------------------------------------------*/
(define (%label-justify o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%label-justify")))

;*---------------------------------------------------------------------*/
;*    %label-justify-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%label-justify-set! o::%bglk-object v::symbol)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%label-justify-set!")))
