;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_toolbar.scm      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun May 20 11:12:45 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Tool implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/toolbar.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%toolbar
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error)
   
   (export (%make-%toolbar ::%bglk-object ::bool)
	   
	   (%toolbar-shadow::symbol ::%bglk-object)
	   (%toolbar-shadow-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-relief::symbol ::%bglk-object)
	   (%toolbar-relief-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-orientation::symbol ::%bglk-object)
	   (%toolbar-orientation-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-space-size::int ::%bglk-object)
	   (%toolbar-space-size-set! ::%bglk-object ::int)
	   
	   (%toolbar-add! ::%bglk-object ::%bglk-object ::obj ::obj)
	   (%toolbar-item-add! ::%bglk-object ::obj ::obj ::obj ::obj ::obj)))

;*---------------------------------------------------------------------*/
;*    %make-%toolbar ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%toolbar o::%bglk-object floating)
   (not-implemented o "%make-%menu"))

;*---------------------------------------------------------------------*/
;*    %toolbar-shadow ...                                              */
;*---------------------------------------------------------------------*/
(define (%toolbar-shadow::symbol o::%bglk-object)
   (not-implemented o "%toolbar-shadow"))

;*---------------------------------------------------------------------*/
;*    %toolbar-shadow-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-shadow-set! o::%bglk-object v::symbol)
   (not-implemented o "%toolbar-shadow-set!"))

;*---------------------------------------------------------------------*/
;*    %toolbar-relief ...                                              */
;*---------------------------------------------------------------------*/
(define (%toolbar-relief::symbol o::%bglk-object)
   (not-implemented o "%toolbar-relief"))

;*---------------------------------------------------------------------*/
;*    %toolbar-relief-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-relief-set! o::%bglk-object v::symbol)
   (not-implemented o "%toolbar-relief-set!"))

;*---------------------------------------------------------------------*/
;*    %toolbar-orientation ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-orientation::symbol o::%bglk-object)
   (not-implemented o "%toolbar-orientation"))

;*---------------------------------------------------------------------*/
;*    %toolbar-orientation-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%toolbar-orientation-set! o::%bglk-object v::symbol)
   (not-implemented o "%toolbar-orientation-set!"))

;*---------------------------------------------------------------------*/
;*    %toolbar-space-size ...                                          */
;*---------------------------------------------------------------------*/
(define (%toolbar-space-size::int o::%bglk-object)
   (not-implemented o "%toolbar-space-size"))

;*---------------------------------------------------------------------*/
;*    %toolbar-space-size-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%toolbar-space-size-set! o::%bglk-object v::int)
   (not-implemented o "%toolbar-space-size-set!"))

;*---------------------------------------------------------------------*/
;*    %toolbar-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%toolbar-add! c::%bglk-object w::%bglk-object space tip)
   (not-implemented c "%toolbar-add!"))
   
;*---------------------------------------------------------------------*/
;*    %toolbar-item-add! ...                                           */
;*---------------------------------------------------------------------*/
(define (%toolbar-item-add! c::%bglk-object text icon space tooltips cmd)
   (not-implemented c "%toolbar-item-add!"))

