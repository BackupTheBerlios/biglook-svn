;*=====================================================================*/
;*    null/Lwidget/_widget.scm                                         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue May 11 14:17:48 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Widget implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/widget.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%widget
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%color
   	   __biglook_%cursor
	   )
   
   (export (class %widget::%peer)
	   
	   (%widget-parent ::%bglk-object)
	   
	   (%widget-width::int ::%bglk-object)
	   (%widget-width-set! ::%bglk-object ::int)
	   
	   (%widget-event::obj ::%bglk-object)
	   (%widget-event-set! ::%bglk-object ::obj)
	   
	   (%widget-height::int ::%bglk-object)
	   (%widget-height-set! ::%bglk-object ::int)
	   
	   (%widget-tooltips::obj ::%bglk-object)
	   (%widget-tooltips-set! ::%bglk-object ::obj)

	   (%widget-active?::bool ::%bglk-object)
	   (%widget-active?-set! ::%bglk-object ::bool)

	   (%widget-name::bstring ::%bglk-object)
	   (%widget-name-set! ::%bglk-object ::bstring)

	   (%widget-visible::bool ::%bglk-object)
	   (%widget-visible-set! ::%bglk-object ::bool)

	   (%widget-enabled::bool ::%bglk-object)
	   (%widget-enabled-set! ::%bglk-object ::bool)

	   (%widget-can-focus?::bool ::%bglk-object)
	   (%widget-can-focus?-set! ::%bglk-object ::bool)

	   (%widget-cursor ::%bglk-object)
	   (%widget-cursor-set! ::%bglk-object ::obj)

	   (%repaint-widget ::%bglk-object)
	   (%destroy-widget ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %widget-parent ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-parent o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%widget-parent")))

;*---------------------------------------------------------------------*/
;*    %widget-event ...                                                */
;*---------------------------------------------------------------------*/
(define (%widget-event o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%widget-event")))

;*---------------------------------------------------------------------*/
;*    %widget-event-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-event-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%widget-event-set!")))

;*---------------------------------------------------------------------*/
;*    %widget-width ...                                                */
;*---------------------------------------------------------------------*/
(define (%widget-width::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%widget-width")))

;*---------------------------------------------------------------------*/
;*    %widget-width-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-width-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%widget-width-set!")))

;*---------------------------------------------------------------------*/
;*    %widget-height ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-height::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%widget-height")))

;*---------------------------------------------------------------------*/
;*    %widget-height-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%widget-height-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%widget-height-set!")))

;*---------------------------------------------------------------------*/
;*    %widget-tooltips ...                                             */
;*---------------------------------------------------------------------*/
(define (%widget-tooltips o::%bglk-object)
   (not-implemented o "%widget-tooltips"))

;*---------------------------------------------------------------------*/
;*    %widget-tooltips-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%widget-tooltips-set! o::%bglk-object v)
   (not-implemented o "%widget-tooltips-set!"))

;*---------------------------------------------------------------------*/
;*    %widget-active? ...                                              */
;*---------------------------------------------------------------------*/
(define (%widget-active? o::%bglk-object)
   (not-implemented o "%widget-active?"))

;*---------------------------------------------------------------------*/
;*    %widget-active?-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-active?-set! o::%bglk-object v)
   (not-implemented o "%widget-active?-set!"))

;*---------------------------------------------------------------------*/
;*    %widget-name ...                                                 */
;*---------------------------------------------------------------------*/
(define (%widget-name o::%bglk-object)
   (not-implemented o "%widget-name"))

;*---------------------------------------------------------------------*/
;*    %widget-name-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%widget-name-set! o::%bglk-object v)
   (not-implemented o "%widget-name-set!"))

;*---------------------------------------------------------------------*/
;*    %widget-visible ...                                              */
;*---------------------------------------------------------------------*/
(define-generic (%widget-visible o::%bglk-object)
   (not-implemented o "%widget-visible"))

;*---------------------------------------------------------------------*/
;*    %widget-visible-set! ...                                         */
;*---------------------------------------------------------------------*/
(define-generic (%widget-visible-set! o::%bglk-object v)
   (not-implemented o "%widget-visible-set!"))

;*---------------------------------------------------------------------*/
;*    %widget-visible ...                                              */
;*---------------------------------------------------------------------*/
(define (%widget-enabled o::%bglk-object)
   (not-implemented o "%widget-enabled"))

;*---------------------------------------------------------------------*/
;*    %widget-enabled-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-enabled-set! o::%bglk-object v)
   (not-implemented o "%widget-enabled-set!"))

;*---------------------------------------------------------------------*/
;*    %widget-can-focus? ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-can-focus?::bool o::%bglk-object)
   (not-implemented o "can_focus"))

;*---------------------------------------------------------------------*/
;*    %widget-can-focus?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%widget-can-focus?-set! o::%bglk-object v::bool)
   (not-implemented o "can_focus"))

;*---------------------------------------------------------------------*/
;*    %destroy-widget ...                                              */
;*---------------------------------------------------------------------*/
(define (%destroy-widget o::%bglk-object)
   (not-implemented o "%destroy-widget"))

;*---------------------------------------------------------------------*/
;*    %repaint-widget ...                                              */
;*---------------------------------------------------------------------*/
(define (%repaint-widget o::%bglk-object)
   (not-implemented o "%destroy-widget"))

;*---------------------------------------------------------------------*/
;*    %widget-cursor ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-cursor o::%bglk-object)
   (not-implemented o "%widget-cursor"))

;*---------------------------------------------------------------------*/
;*    %widget-can-focus?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%widget-cursor-set! o::%bglk-object v::obj)
   (not-implemented o "%widget_cursor-set!"))
