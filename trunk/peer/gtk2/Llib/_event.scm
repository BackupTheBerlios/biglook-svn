;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Llib/_event.scm            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri Dec 13 15:47:26 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Gtk peer event implementation.                               */
;*    definition: @path ../../../biglook/Llib/event.scm@               */
;*                                                                     */
;*    Callbacks are defined in:                                        */
;*    definition: @path _callback.scm@                                 */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%event
   
   (import __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object)
   
   (extern  (%%bglk-event-type::symbol (::gdkevent*) "bglk_event_type")
	    (%%bglk-event-modifiers::obj (::gdkevent*) "bglk_event_modifiers")
	    (%%bglk-event-time::int (::gdkevent*) "bglk_event_time")
	    (%%bglk-event-button::int (::gdkevent*) "bglk_event_button")
	    (%%bglk-event-click-count::int (::gdkevent*) "bglk_event_click_count")
	    (%%bglk-event-keyval::int (::gdkevent*) "bglk_event_keyval")
	    (%%bglk-event-char::char (::gdkevent*) "bglk_event_char")
	    (%%bglk-event-x::int (::gdkevent*) "bglk_event_x")
	    (%%bglk-event-y::int (::gdkevent*) "bglk_event_y")
	    (%%bglk-event-width::int (::gdkevent*) "bglk_event_width")
	    (%%bglk-event-height::int (::gdkevent*) "bglk_event_height")
	    
	    (macro %%GDK-BUTTON-PRESS::int "GDK_BUTTON_PRESS")
	    (macro %%GDK-2BUTTON-PRESS::int "GDK_2BUTTON_PRESS")
	    (macro %%GDK-3BUTTON-PRESS::int "GDK_3BUTTON_PRESS")
	    (macro %%GDK-BUTTON-RELEASE::int "GDK_BUTTON_RELEASE")
	    (macro %%GDK-ENTER-NOTIFY::int "GDK_ENTER_NOTIFY")
	    (macro %%GDK-LEAVE-NOTIFY::int "GDK_LEAVE_NOTIFY")
	    (macro %%GDK-MOTION-NOTIFY::int "GDK_MOTION_NOTIFY")
	    (macro %%GDK-KEY-PRESS::int "GDK_KEY_PRESS")
	    
	    (macro %%event-null::gdkevent* "0L")
	    
	    (export *null-event* "bglk_null_event_descriptor")
	    (export *widget-event* "bglk_widget_event_descriptor")
	    (export *mouse-event* "bglk_mouse_event_descriptor")
	    (export *key-event* "bglk_key_event_descriptor"))
   
   (export (class %event
	      %event::gdkevent*
	      (%widget (default #f)))
	   
	   (%initialize-events! ::%event ::%event ::%event ::%event)
	   
	   *null-event*
	   *widget-event*
	   *mouse-event*
	   *key-event*
	   
	   (%event-type::symbol ::%event)
	   (%event-time::int ::%event)
	   (%event-x::int ::%event)
	   (%event-y::int ::%event)
	   (%event-width::int ::%event)
	   (%event-height::int ::%event)
	   
	   (%event-mouse-time::int ::%event)
	   (%event-mouse-button::int ::%event)
	   (%event-mouse-click-count::int ::%event)
	   (%event-mouse-modifiers::pair-nil ::%event)
	   
	   (%event-key-time::int ::%event)
	   (%event-key-modifiers::pair-nil ::%event)
	   (%event-key-keyval::int ::%event)
	   (%event-key-char::char ::%event)))

;*---------------------------------------------------------------------*/
;*    Event descriptors ...                                            */
;*---------------------------------------------------------------------*/
(define *null-event* #unspecified)
(define *widget-event* #unspecified)
(define *mouse-event* #unspecified)
(define *key-event* #unspecified)

;*---------------------------------------------------------------------*/
;*    %initialize-events! ...                                          */
;*---------------------------------------------------------------------*/
(define (%initialize-events! null-event widget-event mouse-event key-event)
   (set! *null-event* null-event)
   (set! *widget-event* widget-event)
   (set! *mouse-event* mouse-event)
   (set! *key-event* key-event))

;*---------------------------------------------------------------------*/
;*    %event-type ...                                                  */
;*---------------------------------------------------------------------*/
(define (%event-type::symbol ev::%event)
   (%%bglk-event-type (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-time ...                                                  */
;*---------------------------------------------------------------------*/
(define (%event-time::int ev::%event)
   (%%bglk-event-time (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-x ...                                                     */
;*---------------------------------------------------------------------*/
(define (%event-x::int ev::%event)
   (%%bglk-event-x (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-y ...                                                     */
;*---------------------------------------------------------------------*/
(define (%event-y::int ev::%event)
   (%%bglk-event-y (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%event-width::int ev::%event)
   (%%bglk-event-width (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-height ...                                                */
;*---------------------------------------------------------------------*/
(define (%event-height::int ev::%event)
   (%%bglk-event-height (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-mouse-time ...                                            */
;*---------------------------------------------------------------------*/
(define (%event-mouse-time::int ev::%event)
   (%%bglk-event-time (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-mouse-button ...                                          */
;*---------------------------------------------------------------------*/
(define (%event-mouse-button::int ev::%event)
   (%%bglk-event-button (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-mouse-click-count ...                                     */
;*---------------------------------------------------------------------*/
(define (%event-mouse-click-count::int ev::%event)
   (%%bglk-event-click-count (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-mouse-modifiers ...                                       */
;*---------------------------------------------------------------------*/
(define (%event-mouse-modifiers::pair-nil ev::%event)
   (%%bglk-event-modifiers (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-key-time ...                                              */
;*---------------------------------------------------------------------*/
(define (%event-key-time::int ev::%event)
   (%%bglk-event-time (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-key-modifiers ...                                         */
;*---------------------------------------------------------------------*/
(define (%event-key-modifiers::pair-nil ev::%event)
   (%%bglk-event-modifiers (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-key-keyval ...                                            */
;*---------------------------------------------------------------------*/
(define (%event-key-keyval::int ev::%event)
   (%%bglk-event-keyval (%event-%event ev)))

;*---------------------------------------------------------------------*/
;*    %event-key-char ...                                              */
;*---------------------------------------------------------------------*/
(define (%event-key-char::char ev::%event)
   (%%bglk-event-char (%event-%event ev)))
