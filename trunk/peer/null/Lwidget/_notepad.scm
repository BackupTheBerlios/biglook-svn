;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/%notepad.scm      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon May  7 15:23:07 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Label implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/notepad.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%notepad
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object)
   
   (export (%make-%notepad ::%bglk-object)

	   (%notepad-position::symbol ::%bglk-object)
	   (%notepad-position-set! ::%bglk-object ::symbol)
	   
	   (%notepad-selected-page::%bglk-object ::%bglk-object)
	   (%notepad-selected-page-set! ::%bglk-object ::%bglk-object)
	   
	   (%notepad-add! ::%bglk-object ::%bglk-object ::obj ::obj)
	   (%notepad-remove! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%notepad ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%notepad o::%bglk-object)
   (not-implemented o "%make-%notepad"))

;*---------------------------------------------------------------------*/
;*    %notepad-position ...                                            */
;*---------------------------------------------------------------------*/
(define (%notepad-position o::%bglk-object)
   (not-implemented o "%notepad-position"))

;*---------------------------------------------------------------------*/
;*    %notepad-position-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%notepad-position-set! o::%bglk-object v)
   (not-implemented o "%notepad-position-set!"))

;*---------------------------------------------------------------------*/
;*    %notepad-selected-page ...                                       */
;*---------------------------------------------------------------------*/
(define (%notepad-selected-page o::%bglk-object)
   (not-implemented o "%notepad-selected-page"))

;*---------------------------------------------------------------------*/
;*    %notepad-selected-page-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%notepad-selected-page-set! o::%bglk-object v)
   (not-implemented o "%notepad-selected-page-set!"))

;*---------------------------------------------------------------------*/
;*    %notepad-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%notepad-add! c::%bglk-object w::%bglk-object title image)
   (not-implemented c "%notepad-add!"))

;*---------------------------------------------------------------------*/
;*    %notepad-remove! ...                                             */
;*---------------------------------------------------------------------*/
(define (%notepad-remove! c::%bglk-object w::%bglk-object)
   (not-implemented c "%notepad-remove!"))
