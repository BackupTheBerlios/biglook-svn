;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_combobox.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon Jul 23 13:43:06 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Combobox implementation.                           */
;*    definition: @path ../../../biglook/Lwidget/combobox.scm@         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%combobox
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static  (class %combobox::%peer))
   
   (export  (%make-%combobox ::%bglk-object)

	    (%combobox-text ::%bglk-object)
	    (%combobox-text-set! ::%bglk-object ::bstring)
	    
	    (%combobox-width::int ::%bglk-object)
	    (%combobox-width-set! ::%bglk-object ::int)
	    
	    (%combobox-active?::bool ::%bglk-object)
	    (%combobox-active?-set! ::%bglk-object ::bool)
	    
	    (%combobox-editable?::bool ::%bglk-object)
	    (%combobox-editable?-set! ::%bglk-object ::bool)
	    
	    (%combobox-items ::%bglk-object)
	    (%combobox-items-set! ::%bglk-object ::pair-nil)))

;*---------------------------------------------------------------------*/
;*    %make-%combobox ...                                              */
;*---------------------------------------------------------------------*/
(define (%make-%combobox o::%bglk-object)
   (not-implemented o "%make-%combobox"))

;*---------------------------------------------------------------------*/
;*    %combobox-text ...                                               */
;*---------------------------------------------------------------------*/
(define (%combobox-text o::%bglk-object)
   (not-implemented o "%combobox-text"))

;*---------------------------------------------------------------------*/
;*    %combobox-text-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%combobox-text-set! o::%bglk-object v::bstring)
   (not-implemented o "%combobox-text-set!"))

;*---------------------------------------------------------------------*/
;*    %combobox-width ...                                              */
;*---------------------------------------------------------------------*/
(define (%combobox-width o::%bglk-object)
   (not-implemented o "%combobox-width"))

;*---------------------------------------------------------------------*/
;*    %combobox-width-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%combobox-width-set! o::%bglk-object v::int)
   (not-implemented o "%combobox-width-set!"))

;*---------------------------------------------------------------------*/
;*    %combobox-active? ...                                            */
;*---------------------------------------------------------------------*/
(define (%combobox-active? o::%bglk-object)
   (not-implemented o "%combobox-active?"))

;*---------------------------------------------------------------------*/
;*    %combobox-active?-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%combobox-active?-set! o::%bglk-object v::bool)
   (not-implemented o "%combobox-active?-set!"))

;*---------------------------------------------------------------------*/
;*    %combobox-editable? ...                                          */
;*---------------------------------------------------------------------*/
(define (%combobox-editable? o::%bglk-object)
   (not-implemented o "%combobox-editable?"))

;*---------------------------------------------------------------------*/
;*    %combobox-editable?-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%combobox-editable?-set! o::%bglk-object v::bool)
   (not-implemented o "%combobox-editable?-set!"))

;*---------------------------------------------------------------------*/
;*    %combobox-items ...                                              */
;*---------------------------------------------------------------------*/
(define (%combobox-items o::%bglk-object)
   (not-implemented o "%combobox-items"))

;*---------------------------------------------------------------------*/
;*    %combobox-items-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%combobox-items-set! o::%bglk-object v::pair-nil)
   (not-implemented o "%combobox-items-set!"))

