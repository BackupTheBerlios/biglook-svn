;*=====================================================================*/
;*    null/Lwidget/_listbox.scm                                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue May 18 17:20:20 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Listbox implementation.                            */
;*    definition: @path ../../../biglook/Lwidget/listbox.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%listbox
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static  (class %listbox::%peer))
   
   (export  (%make-%listbox ::%bglk-object)

	    (%listbox-active?::bool ::%bglk-object)
	    (%listbox-active?-set! ::%bglk-object ::bool)
	    
	    (%listbox-items::pair-nil ::%bglk-object)
	    (%listbox-items-set! ::%bglk-object ::pair-nil)
	    
	    (%listbox-select-mode::symbol ::%bglk-object)
	    (%listbox-select-mode-set! ::%bglk-object ::symbol)
	    
	    (%listbox-selection ::%bglk-object)
	    (%listbox-selection-set! ::%bglk-object ::obj)

	    (%listbox-coords->row::int ::%bglk-object ::int ::int)
	    ))
	    
	    
;*---------------------------------------------------------------------*/
;*    %make-%listbox ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%listbox o)
   (not-implemented o "%make-%listbox"))

;*---------------------------------------------------------------------*/
;*    %listbox-active? ...                                             */
;*---------------------------------------------------------------------*/
(define (%listbox-active? o::%bglk-object)
   (not-implemented o "%listbox-active?"))
   
;*---------------------------------------------------------------------*/
;*    %listbox-active?-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%listbox-active?-set! o::%bglk-object v)
   (not-implemented o "%listbox-active?-set!"))
   
;*---------------------------------------------------------------------*/
;*    %listbox-items ...                                               */
;*---------------------------------------------------------------------*/
(define (%listbox-items o::%bglk-object)
   (not-implemented o "%listbox-items"))
   
;*---------------------------------------------------------------------*/
;*    %listbox-items-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%listbox-items-set! o::%bglk-object v)
   (not-implemented o "%listbox-items-set!"))
   
;*---------------------------------------------------------------------*/
;*    %listbox-select-mode ...                                         */
;*---------------------------------------------------------------------*/
(define (%listbox-select-mode o::%bglk-object)
   (not-implemented o "%listbox-select-mode"))

;*---------------------------------------------------------------------*/
;*    %listbox-select-mode-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%listbox-select-mode-set! o::%bglk-object v)
   (not-implemented o "%listbox-select-mode-set!"))

;*---------------------------------------------------------------------*/
;*    %listbox-selection ...                                           */
;*---------------------------------------------------------------------*/
(define (%listbox-selection o::%bglk-object)
   (not-implemented o "%listbox-selection"))

;*---------------------------------------------------------------------*/
;*    %listbox-selection-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%listbox-selection-set! o::%bglk-object v)
   (not-implemented o "%listbox-selection-set!"))

;*---------------------------------------------------------------------*/
;*    %listbox-coords->row ...                                         */
;*---------------------------------------------------------------------*/
(define (%listbox-coords->row::int o::%bglk-object x::int y::int)
   (not-implemented o "%listbox-coords->row"))