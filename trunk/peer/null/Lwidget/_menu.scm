;*=====================================================================*/
;*    null/Lwidget/_menu.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri Nov 21 17:32:24 2003 (dciabrin)               */
;*    Copyright   :  2001-03 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Menu implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/menu.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%menu
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error)

   (export (%make-%menubar ::%bglk-object)
	   (%make-%popup-menu ::%bglk-object)
	   
	   (%make-%menu ::%bglk-object ::bstring ::symbol)
	   (%make-%menu-separator ::%bglk-object)
	   (%make-%menu-label ::%bglk-object ::bstring)
	   (%make-%menu-check-button ::%bglk-object ::bstring)
	   (%make-%menu-radio ::%bglk-object ::pair)

	   (%menubar-shadow::symbol ::%bglk-object)
	   (%menubar-shadow-set! ::%bglk-object ::symbol)

	   (%menubar-add! ::%bglk-object ::%bglk-object ::symbol)
	   (%popup-menu-add! ::%bglk-object ::%bglk-object ::symbol)
	   (%menu-add! ::%bglk-object ::%bglk-object ::pair-nil)

	   (%menu-item-command ::%bglk-object)
	   (%menu-item-command-set! ::%bglk-object ::obj)
	   
	   (%menu-tearoff::bool ::%bglk-object)
	   (%menu-tearoff-set! ::%bglk-object ::bool)

	   (%menu-check-button-on?::bool ::%bglk-object)
	   (%menu-check-button-on?-set! ::%bglk-object ::bool)

	   (%menu-radio-value::bstring ::%bglk-object)
	   (%menu-radio-value-set! ::%bglk-object ::bstring)

	   (%popup-menu-show! ::%bglk-object ::%bglk-object ::pair)
	   ))

;*---------------------------------------------------------------------*/
;*    %make-%menubar ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%menubar o::%bglk-object)
   (not-implemented o "%make-%menu"))

;*---------------------------------------------------------------------*/
;*    %make-%popup-menu ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%popup-menu o::%bglk-object)
   (not-implemented o "%make-%popup-menu"))

;*---------------------------------------------------------------------*/
;*    %make-%menu ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%menu c::%bglk-object title::bstring justify)
   (not-implemented c "%make-%menu"))

;*---------------------------------------------------------------------*/
;*    %make-%menu-separator ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%menu-separator c::%bglk-object)
   (not-implemented c "%make-%menu-separator"))

;*---------------------------------------------------------------------*/
;*    %make-%menu-label ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%menu-label c::%bglk-object text::bstring)
   (not-implemented c "%make-%menu-label"))

;*---------------------------------------------------------------------*/
;*    %make-%menu-check-button ...                                     */
;*---------------------------------------------------------------------*/
(define (%make-%menu-check-button c::%bglk-object text::bstring)
   (not-implemented c "%make-%menu-check-button"))

;*---------------------------------------------------------------------*/
;*    %make-%menu-radio ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%menu-radio c::%bglk-object texts::pair)
   (not-implemented c "%make-%menu-radio"))

;*---------------------------------------------------------------------*/
;*    %menubar-shadow ...                                              */
;*---------------------------------------------------------------------*/
(define (%menubar-shadow::symbol o::%bglk-object)
   (not-implemented o "%menubar-shadow"))

;*---------------------------------------------------------------------*/
;*    %menubar-shadow-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%menubar-shadow-set! o::%bglk-object v::symbol)
   (not-implemented o "%menubar-shadow-set!"))

;*---------------------------------------------------------------------*/
;*    %menubar-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%menubar-add! c::%bglk-object w::%bglk-object justify)
   (not-implemented c "%menubar-add!"))

;*---------------------------------------------------------------------*/
;*    %popup-menu-add! ...                                             */
;*---------------------------------------------------------------------*/
(define (%popup-menu-add! c::%bglk-object w::%bglk-object justify)
   (not-implemented c "%popup-menu-add!"))
   
;*---------------------------------------------------------------------*/
;*    %menu-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%menu-add! c::%bglk-object w::%bglk-object options)
   (not-implemented c "%menu-add!"))

;*---------------------------------------------------------------------*/
;*    %menu-item-command ...                                           */
;*---------------------------------------------------------------------*/
(define (%menu-item-command o::%bglk-object)
   (not-implemented o "%menu-item-command"))
   
;*---------------------------------------------------------------------*/
;*    %menu-item-command-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%menu-item-command-set! o::%bglk-object v)
   (not-implemented o "%menu-item-command-set!"))
   
;*---------------------------------------------------------------------*/
;*    %menu-tearoff ...                                                */
;*---------------------------------------------------------------------*/
(define (%menu-tearoff o::%bglk-object)
   (not-implemented o "%menu-add!"))

;*---------------------------------------------------------------------*/
;*    %menu-tearoff-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%menu-tearoff-set! o::%bglk-object v::bool)
   (not-implemented o "%menu-add!"))

;*---------------------------------------------------------------------*/
;*    %menu-check-button-on? ...                                       */
;*---------------------------------------------------------------------*/
(define (%menu-check-button-on? o::%bglk-object)
   (not-implemented o "%menu-check-button-on?"))

;*---------------------------------------------------------------------*/
;*    %menu-check-button-on?-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%menu-check-button-on?-set! o::%bglk-object v)
   (not-implemented o "%menu-check-button-on?-set!"))

;*---------------------------------------------------------------------*/
;*    %menu-radio-value ...                                            */
;*---------------------------------------------------------------------*/
(define (%menu-radio-value o::%bglk-object)
   (not-implemented o "%menu-radio-value"))

;*---------------------------------------------------------------------*/
;*    %menu-radio-value-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%menu-radio-value-set! o::%bglk-object v)
   (not-implemented o "%menu-radio-value-set!"))

;*---------------------------------------------------------------------*/
;*    %popup-menu-show! ...                                            */
;*---------------------------------------------------------------------*/
(define (%popup-menu-show! o::%bglk-object caller::%bglk-object pos::pair)
   (not-implemented o "%popup-menu-show!"))
