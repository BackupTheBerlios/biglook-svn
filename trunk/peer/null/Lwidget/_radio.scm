;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/%radio.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun May  6 06:17:50 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Radio Button implementation.                       */
;*    definition: @path ../../../biglook/Lwidget/radio.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%radio
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static (class %radio::%peer))
   
   (export (%make-%radio ::%bglk-object ::%bglk-object)
	   (%make-%radio-button ::%bglk-object ::%bglk-object)

	   (%radio-add! ::%bglk-object ::%bglk-object)
	   
	   ;; children
	   (%radio-children::pair-nil ::%bglk-object)
	   
	   ;; active?
	   (%radio-active?::bool ::%bglk-object)
	   (%radio-active?-set! ::%bglk-object ::bool)
	   
	   ;; value
	   (%radio-value::bstring ::%bglk-object)
	   (%radio-value-set! ::%bglk-object ::bstring)
	   
	   ;; tooltips
	   (%radio-tooltips::obj ::%bglk-object)
	   (%radio-tooltips-set! ::%bglk-object ::obj)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%radio ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%radio o::%bglk-object c::%bglk-object)
   (not-implemented o "%make-%radio"))

;*---------------------------------------------------------------------*/
;*    %make-%radio-button ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-%radio-button o::%bglk-object c::%bglk-object)
   (not-implemented o "%make-%radio-button"))

;*---------------------------------------------------------------------*/
;*    %radio-add! ...                                                  */
;*---------------------------------------------------------------------*/
(define (%radio-add! o::%bglk-object w::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%radio-add!")))

;*---------------------------------------------------------------------*/
;*    %radio-children ...                                              */
;*---------------------------------------------------------------------*/
(define (%radio-children o::%bglk-object)
   (not-implemented o "%radio-children"))

;*---------------------------------------------------------------------*/
;*    %radio-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%radio-value o::%bglk-object)
   (not-implemented o "%radio-value"))

;*---------------------------------------------------------------------*/
;*    %radio-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%radio-value-set! o::%bglk-object v::bstring)
   (not-implemented o "%radio-value-set!"))
      
;*---------------------------------------------------------------------*/
;*    %radio-active? ...                                               */
;*---------------------------------------------------------------------*/
(define (%radio-active?::bool o::%bglk-object)
   (not-implemented o "%radio-active?"))

;*---------------------------------------------------------------------*/
;*    %radio-active?-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%radio-active?-set! o::%bglk-object v::bool)
   (not-implemented o "%radio-active?-set!"))

;*---------------------------------------------------------------------*/
;*    %radio-tooltips ...                                              */
;*---------------------------------------------------------------------*/
(define (%radio-tooltips o::%bglk-object)
   (not-implemented o "%radio-tooltips"))

;*---------------------------------------------------------------------*/
;*    %radio-tooltips-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%radio-tooltips-set! o::%bglk-object v::obj)
   (not-implemented o "%radio-tooltips-set!"))

