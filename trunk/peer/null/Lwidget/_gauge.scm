;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/%gauge.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sat May  5 10:03:17 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Gauge implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/gauge.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%gauge
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static  (class %gauge::%peer))
   
   (export  (%make-%gauge ::%bglk-object)

	    (%gauge-text ::%bglk-object)
	    (%gauge-text-set! ::%bglk-object ::obj)
	    
	    (%gauge-style ::%bglk-object)
	    (%gauge-style-set! ::%bglk-object ::obj)
	    
	    (%gauge-value ::%bglk-object)
	    (%gauge-value-set! ::%bglk-object ::int)))
	    
;*---------------------------------------------------------------------*/
;*    %make-%gauge ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%gauge o)
   (not-implemented o "%make-%gauge"))

;*---------------------------------------------------------------------*/
;*    %gauge-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%gauge-text o::%bglk-object)
   (not-implemented o "%gauge-text"))
   
;*---------------------------------------------------------------------*/
;*    %gauge-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%gauge-text-set! o::%bglk-object v)
   (not-implemented o "%gauge-text-set!"))
   
;*---------------------------------------------------------------------*/
;*    %gauge-style ...                                                 */
;*---------------------------------------------------------------------*/
(define (%gauge-style o::%bglk-object)
   (not-implemented o "%gauge-style"))
   
;*---------------------------------------------------------------------*/
;*    %gauge-style-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%gauge-style-set! o::%bglk-object v)
   (not-implemented o "%gauge-style-set!"))
   
;*---------------------------------------------------------------------*/
;*    %gauge-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%gauge-value o::%bglk-object)
   (not-implemented o "%gauge-value"))

;*---------------------------------------------------------------------*/
;*    %gauge-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%gauge-value-set! o::%bglk-object v::int)
   (not-implemented o "%gauge-value-set!"))

