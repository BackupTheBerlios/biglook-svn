;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_frame.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue May 22 14:31:59 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Frame implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/frame.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%frame
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error)
   
   (static (class %frame::%peer))

   (export (%make-%frame ::%bglk-object)

	   (%frame-add! ::%bglk-object ::%bglk-object)
	   
	   (%frame-title ::%bglk-object)
	   (%frame-title-set! ::%bglk-object ::bstring)
	   
	   (%frame-title-justify::symbol ::%bglk-object)
	   (%frame-title-justify-set! ::%bglk-object ::symbol)
	   
	   (%frame-shadow::symbol ::%bglk-object)
	   (%frame-shadow-set! ::%bglk-object ::symbol)))

;*---------------------------------------------------------------------*/
;*    %make-%frame ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%frame o::%bglk-object)
   (not-implemented o "%make-%frame"))

;*---------------------------------------------------------------------*/
;*    %frame-add! ...                                                  */
;*---------------------------------------------------------------------*/
(define (%frame-add! o::%bglk-object w::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%frame-add!")))

;*---------------------------------------------------------------------*/
;*    %frame-title ...                                                 */
;*---------------------------------------------------------------------*/
(define (%frame-title o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%frame-title")))

;*---------------------------------------------------------------------*/
;*    %frame-title-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%frame-title-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%frame-title-set!")))

;*---------------------------------------------------------------------*/
;*    %frame-title-justify ...                                         */
;*---------------------------------------------------------------------*/
(define (%frame-title-justify::symbol o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%frame-title-justify")))

;*---------------------------------------------------------------------*/
;*    %frame-title-justify-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%frame-title-justify-set! o::%bglk-object v::symbol)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%frame-title-justify-set!")))

;*---------------------------------------------------------------------*/
;*    %frame-shadow ...                                                */
;*---------------------------------------------------------------------*/
(define (%frame-shadow::symbol o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%frame-shadow")))

;*---------------------------------------------------------------------*/
;*    %frame-shadow-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%frame-shadow-set! o::%bglk-object v::symbol)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%frame-shadow-set!")))
   
