;*=====================================================================*/
;*    null/Llib/_event.scm                                             */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri May  7 00:33:15 2004 (braun)                  */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer event: implementation.                             */
;*    definition: @path ../../../biglook/Llib/event.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%event
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object)
   
   (export (class %event
	      (%event (default #f))
	      (%widget (default #f)))
	   
	   (%initialize-events! ::%event ::%event ::%event ::%event)
	   
	   (%event-type::symbol ::%event)
	   (%event-time::int ::%event)
	   (%event-x::int ::%event)
	   (%event-y::int ::%event)
	   (%event-width::int ::%event)
	   (%event-height::int ::%event)
	   
	   (%event-mouse-time::int ::%event)
	   (%event-mouse-click-count::int ::%event)
	   (%event-mouse-button::int ::%event)
	   (%event-mouse-modifiers::pair-nil ::%event)
	   
	   (%event-key-time::int ::%event)
	   (%event-key-modifiers::pair-nil ::%event)
	   (%event-key-keyval::int ::%event)
	   (%event-key-char::char ::%event)))

;*---------------------------------------------------------------------*/
;*    %initialize-events! ...                                          */
;*---------------------------------------------------------------------*/
(define (%initialize-events! null-event widget-event mouse-event key-event)
   (not-implemented null-event "%initialize-events"))

;*---------------------------------------------------------------------*/
;*    %event-type ...                                                  */
;*---------------------------------------------------------------------*/
(define (%event-type::symbol ev::%event)
   (not-implemented ev "%event-type"))

;*---------------------------------------------------------------------*/
;*    %event-time ...                                                  */
;*---------------------------------------------------------------------*/
(define (%event-time::int ev::%event)
   (not-implemented ev "%event-time"))

;*---------------------------------------------------------------------*/
;*    %event-x ...                                                     */
;*---------------------------------------------------------------------*/
(define (%event-x::int ev::%event)
   (not-implemented ev "%event-x"))

;*---------------------------------------------------------------------*/
;*    %event-y ...                                                     */
;*---------------------------------------------------------------------*/
(define (%event-y::int ev::%event)
   (not-implemented ev "%event-y"))

;*---------------------------------------------------------------------*/
;*    %event-height ...                                                */
;*---------------------------------------------------------------------*/
(define (%event-height::int ev::%event)
   (not-implemented ev "%event-height"))

;*---------------------------------------------------------------------*/
;*    %event-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%event-width::int ev::%event)
   (not-implemented ev "%event-width"))

;*---------------------------------------------------------------------*/
;*    %event-mouse-time ...                                            */
;*---------------------------------------------------------------------*/
(define (%event-mouse-time::int ev::%event)
   (not-implemented ev "%event-mouse-time"))

;*---------------------------------------------------------------------*/
;*    %event-click-count ...                                           */
;*---------------------------------------------------------------------*/
(define (%event-mouse-click-count::int ev::%event)
   (not-implemented ev "%event-click-count"))

;*---------------------------------------------------------------------*/
;*    %event-mouse-button ...                                          */
;*---------------------------------------------------------------------*/
(define (%event-mouse-button::int ev::%event)
   (not-implemented ev "%event-mouse-button"))

;*---------------------------------------------------------------------*/
;*    %event-mouse-modifiers ...                                       */
;*---------------------------------------------------------------------*/
(define (%event-mouse-modifiers::pair-nil ev::%event)
   (not-implemented ev "%event-mouse-modifiers"))

;*---------------------------------------------------------------------*/
;*    %event-key-time ...                                              */
;*---------------------------------------------------------------------*/
(define (%event-key-time::int ev::%event)
   (not-implemented ev "%event-key-time"))

;*---------------------------------------------------------------------*/
;*    %event-key-modifiers ...                                         */
;*---------------------------------------------------------------------*/
(define (%event-key-modifiers::pair-nil ev::%event)
   (not-implemented ev "%event-key-modifiers"))

;*---------------------------------------------------------------------*/
;*    %event-key-keyval ...                                            */
;*---------------------------------------------------------------------*/
(define (%event-key-keyval::int ev::%event)
   (not-implemented ev "%event-key-keyval"))

;*---------------------------------------------------------------------*/
;*    %event-key-char ...                                              */
;*---------------------------------------------------------------------*/
(define (%event-key-char::char ev::%event)
   (not-implemented ev "%event-key-char"))

