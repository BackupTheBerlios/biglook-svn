;*=====================================================================*/
;*    .../prgm/project/biglook/peer/null/Lwidget/%check-button.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun May  6 06:21:06 2001 (serrano)                */
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
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static (class %check-button::%peer))
	   
   (export (%make-%check-button ::%bglk-object)
	   
	   (%check-button-active?::bool ::%bglk-object)
	   (%check-button-active?-set! ::%bglk-object ::bool)
	   
	   (%check-button-on?::bool ::%bglk-object)
	   (%check-button-on?-set! ::%bglk-object ::bool)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%check-button ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-%check-button o::%bglk-object)
   (not-implemented o "%make-%check-button"))

;*---------------------------------------------------------------------*/
;*    %check-button-active? ...                                        */
;*---------------------------------------------------------------------*/
(define (%check-button-active? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%check-button-active?")))

;*---------------------------------------------------------------------*/
;*    %check-button-active?-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%check-button-active?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%check-button-active?-set!")))

;*---------------------------------------------------------------------*/
;*    %check-button-on? ...                                            */
;*---------------------------------------------------------------------*/
(define (%check-button-on? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%check-button-on?")))

;*---------------------------------------------------------------------*/
;*    %check-button-on?-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%check-button-on?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%check-button-on?-set!")))
