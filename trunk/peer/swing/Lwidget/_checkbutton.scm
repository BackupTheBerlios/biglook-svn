;*=====================================================================*/
;*    .../project/biglook/peer/swing/Lwidget/%check-button.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun May  6 06:15:52 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Check Button implementation.                       */
;*    definition: @path ../../../biglook/Lwidget/check-button.scm@     */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%check-button
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   ;__biglook_%cursor
	   __biglook_%button)
   
   (export (class %check-button::%button)
	   (%make-%check-button ::%bglk-object)
	   
	   (%check-button-active?::bool ::%bglk-object)
	   (%check-button-active?-set! ::%bglk-object ::bool)
	   
	   (%check-button-on?::bool ::%bglk-object)
	   (%check-button-on?-set! ::%bglk-object ::bool)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%check-button ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-%check-button o::%bglk-object)
   (let ((b (%swing-jcheckbox-new)))
      (%swing-jcomponent-alignment-x-set! b 0.5)
      (instantiate::%check-button
	 (%bglk-object o)
	 (%builtin b))))

;*---------------------------------------------------------------------*/
;*    %check-button-active? ...                                        */
;*---------------------------------------------------------------------*/
(define (%check-button-active? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%awt-component-enabled? (%peer-%builtin %peer))))

;*---------------------------------------------------------------------*/
;*    %check-button-active?-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%check-button-active?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (%awt-component-enabled?-set! (%peer-%builtin %peer) v)
      o))

;*---------------------------------------------------------------------*/
;*    %check-button-on? ...                                            */
;*---------------------------------------------------------------------*/
(define (%check-button-on? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%swing-abstractbutton-selected? (%peer-%builtin %peer))))

;*---------------------------------------------------------------------*/
;*    %check-button-on?-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%check-button-on?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (%swing-abstractbutton-selected?-set! (%peer-%builtin %peer) v)
      #unspecified))
