;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_frame.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jun 24 13:47:33 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Frame implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/frame.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%frame
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%swing-misc
	   __biglook_%container)
   
   (static (class %frame::%container))

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
   (let ((jpanel::%swing-jpanel (%swing-jpanel-new)))
      (instantiate::%frame
	 (%bglk-object o)
	 (%builtin jpanel))))

;*---------------------------------------------------------------------*/
;*    %frame-add! ...                                                  */
;*---------------------------------------------------------------------*/
(define (%frame-add! c::%bglk-object w::%bglk-object)
   (%container-add! c w))

;*---------------------------------------------------------------------*/
;*    %frame-title ...                                                 */
;*---------------------------------------------------------------------*/
(define (%frame-title o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (let ((border (%swing-jcomponent-border (%peer-%builtin %peer))))
	 (if (%bglk-border? border)
	     (%bglk-jstring->bstring (%bglk-border-title border))
	     #f))))

;*---------------------------------------------------------------------*/
;*    %frame-title-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%frame-title-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (let ((border (%swing-jcomponent-border (%peer-%builtin %peer)))
	    (jv (%bglk-bstring->jstring v)))
	 (if (%bglk-border? border)
	     (begin
		(%bglk-border-title-set! border jv)
		o)
	     (begin
		(%swing-jcomponent-border-set! (%peer-%builtin %peer)
					       (%bglk-border-new border jv))
		o)))))

;*---------------------------------------------------------------------*/
;*    %frame-title-justify ...                                         */
;*---------------------------------------------------------------------*/
(define (%frame-title-justify::symbol o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (let ((bd (%swing-jcomponent-border (%peer-%builtin %peer))))
	 (if (%bglk-border? bd)
	     (swing-title-justify->biglook (%bglk-border-justification bd))
	     'clenter))))

;*---------------------------------------------------------------------*/
;*    %frame-title-justify-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%frame-title-justify-set! o::%bglk-object v::symbol)
   (with-access::%bglk-object o (%peer)
      (let ((bd (%swing-jcomponent-border (%peer-%builtin %peer))))
	 (if (%bglk-border? bd)
	     (let ((ju (biglook-title-justify->swing v)))
		(%bglk-border-justification-set! bd ju)
		o)))))

;*---------------------------------------------------------------------*/
;*    %frame-shadow ...                                                */
;*---------------------------------------------------------------------*/
(define (%frame-shadow::symbol o::%bglk-object)
   (%jcomponent-shadow o))

;*---------------------------------------------------------------------*/
;*    %frame-shadow-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%frame-shadow-set! o::%bglk-object v::symbol)
   (%jcomponent-shadow-set! o v))


   
