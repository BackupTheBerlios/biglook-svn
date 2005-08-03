;*=====================================================================*/
;*    swt/Lwidget/_label.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:41:13 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Label implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/label.scm@            */
;*    jvm       : @path ../Jlib/BglkLabel.java@                        */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%label
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
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
   (instantiate::%label
      (%bglk-object o)
      (%builtin (%swing-jlabel-new))))

;*---------------------------------------------------------------------*/
;*    %label-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%label-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%bglk-jstring->bstring (%swing-jlabel-text (%peer-%builtin %peer)))))

;*---------------------------------------------------------------------*/
;*    %label-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%label-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (%swing-jlabel-text-set! (%peer-%builtin %peer)
			       (%bglk-bstring->jstring v))
      o))

;*---------------------------------------------------------------------*/
;*    %label-justify ...                                               */
;*---------------------------------------------------------------------*/
(define (%label-justify o::%bglk-object)
   'center)

;*---------------------------------------------------------------------*/
;*    %label-justify-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%label-justify-set! o::%bglk-object v::symbol)
   o)
