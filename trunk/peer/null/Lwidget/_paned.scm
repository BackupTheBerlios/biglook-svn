;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_paned.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed May 16 05:39:49 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Paned implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/paned.scm@            */
;*=====================================================================*/
 
;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%paned
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static  (class %paned::%peer))
   
   (export  (%make-%hpaned ::%bglk-object)
	    (%make-%vpaned ::%bglk-object)

	    (%hpaned-fraction ::%bglk-object)
	    (%hpaned-fraction-set! ::%bglk-object ::obj)

	    (%vpaned-fraction ::%bglk-object)
	    (%vpaned-fraction-set! ::%bglk-object ::obj)

	    (%paned-add! ::%bglk-object ::%bglk-object ::bool ::bool ::bool ::int)))
	    
;*---------------------------------------------------------------------*/
;*    %make-%hpaned ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%hpaned o)
   (not-implemented o "%make-%hpaned"))

;*---------------------------------------------------------------------*/
;*    %make-%vpaned ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%vpaned o)
   (not-implemented o "%make-%vpaned"))

;*---------------------------------------------------------------------*/
;*    %hpaned-fraction ...                                             */
;*---------------------------------------------------------------------*/
(define (%hpaned-fraction o::%bglk-object)
   (not-implemented o "%hpaned-fraction"))
   
;*---------------------------------------------------------------------*/
;*    %hpaned-fraction-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%hpaned-fraction-set! o::%bglk-object v)
   (not-implemented o "%hpaned-fraction-set!"))

;*---------------------------------------------------------------------*/
;*    %vpaned-fraction ...                                             */
;*---------------------------------------------------------------------*/
(define (%vpaned-fraction o::%bglk-object)
   (not-implemented o "%vpaned-fraction"))
   
;*---------------------------------------------------------------------*/
;*    %vpaned-fraction-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%vpaned-fraction-set! o::%bglk-object v)
   (not-implemented o "%vpaned-fraction-set!"))

;*---------------------------------------------------------------------*/
;*    %paned-add! ...                                                  */
;*---------------------------------------------------------------------*/
(define (%paned-add! c w horizontal? expand shrink number)
   (not-implemented c "%paned-add!"))
   
