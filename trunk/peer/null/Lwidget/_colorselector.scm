;*=====================================================================*/
;*    .../project/biglook/peer/null/Lwidget/_colorselector.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Jul 26 16:05:47 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Colorselector implementation.                      */
;*    definition: @path ../../../biglook/Lwidget/colorselector.scm@    */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%color-selector
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static (class %color-selector::%peer))
	   
   (export (%make-%color-selector ::%bglk-object)

	   (%color-selector-color::%color ::%bglk-object ::procedure)
	   (%color-selector-color-set! ::%bglk-object ::%color)))

;*---------------------------------------------------------------------*/
;*    %make-%color-selector ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%color-selector o)
   (not-implemented o "%make-%color-selector"))

;*---------------------------------------------------------------------*/
;*    %color-selector-color ...                                        */
;*---------------------------------------------------------------------*/
(define (%color-selector-color o make-color)
   (not-implemented o "%color-selector-color"))

;*---------------------------------------------------------------------*/
;*    %color-selector-color-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%color-selector-color-set! o v)
   (not-implemented o "%color-selector-color-set!"))

