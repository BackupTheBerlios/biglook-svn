;*=====================================================================*/
;*    swt/Llib/_event.scm                                              */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:44:41 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer event implementation.                             */
;*    definition: @path ../../../biglook/Llib/event.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%event
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer
	   __biglook_%bglk-object)
   
   (export (class %event
	      %event
	      type
	      (%widget (default #f)))
	   
	   (%initialize-events! ::%event ::%event ::%event ::%event)
	   
;	   (%event-type::symbol ::%event)
	   (%event-time::int ::%event)
	   (%event-x::int ::%event)
	   (%event-y::int ::%event)
	   (%event-width::int ::%event)
	   (%event-height::int ::%event)
	   
	   (%event-mouse-time::int ::%event)
	   (%event-mouse-button::int ::%event)
	   (%event-mouse-modifiers::pair-nil ::%event)
	   
	   (%event-key-time::int ::%event)
	   (%event-key-modifiers::pair-nil ::%event)
	   (%event-key-keyval::int ::%event)
	   (%event-key-char::char ::%event)
	   
	   (wrap-event-descriptor ::obj ::obj)
	   (wrap-mouse-descriptor ::%awt-inputevent ::obj)
	   (wrap-key-descriptor ::%awt-inputevent ::obj)))
	   
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
;(define (%event-type::symbol ev::%event)
;   (let ((%ev (%event-%event ev)))
;      (cond
; 	 ((%swt-shellevent? %ev)
;	  'destroy)
;	 (else
;	  (string->symbol (find-runtime-type ev))))))

;*---------------------------------------------------------------------*/
;*    %event-time ...                                                  */
;*---------------------------------------------------------------------*/
(define (%event-time::int ev::%event)
   (let ((evt (%event-%event ev)))
      (if (%awt-event? ev)
	  (%bglk-input-event-time (%event-%event ev))
	  -1)))

;*---------------------------------------------------------------------*/
;*    %event-x ...                                                     */
;*---------------------------------------------------------------------*/
(define (%event-x::int ev::%event)
   '(let ((evt (%event-%event ev)))
      (cond
	 ((%awt-mouseevent? evt)
	  (%awt-mouseevent-x evt))
	 ((%swing-listselectionevent? evt)
	  -1)
	 (else
	  -1)))
   -1)

;*---------------------------------------------------------------------*/
;*    %event-y ...                                                     */
;*---------------------------------------------------------------------*/
(define (%event-y::int ev::%event)
   '(let ((evt (%event-%event ev)))
      (cond
	 ((%awt-mouseevent? evt)
	  (%awt-mouseevent-y evt))
	 ((%swing-listselectionevent? evt)
	  (%bglk-listselectionevent-selection evt))
	 (else
	  -1)))
   -1)

;*---------------------------------------------------------------------*/
;*    %event-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%event-width::int ev::%event)
   '(let ((evt (%event-%event ev)))
      (if (%awt-mouseevent? evt)
	  (%awt-mouseevent-x evt)
	  -1))
   -1)

;*---------------------------------------------------------------------*/
;*    %event-height ...                                                */
;*---------------------------------------------------------------------*/
(define (%event-height::int ev::%event)
   '(let ((evt (%event-%event ev)))
      (if (%awt-mouseevent? evt)
	  (%awt-mouseevent-y evt)
	  -1))
   -1)

;*---------------------------------------------------------------------*/
;*    %event-mouse-time ...                                            */
;*---------------------------------------------------------------------*/
(define (%event-mouse-time::int ev::%event)
   '(%bglk-input-event-time (%event-%event ev))
   -1)

;*---------------------------------------------------------------------*/
;*    %event-mouse-button ...                                          */
;*---------------------------------------------------------------------*/
(define (%event-mouse-button::int ev::%event)
   '(let ((mod (%awt-inputevent-modifiers (%event-%event ev))))
      (cond
	 ((=fx %awt-inputevent-button1
	       (bit-and mod %awt-inputevent-button1))
	  1)
	 ((=fx %awt-inputevent-button2
	       (bit-and mod %awt-inputevent-button2))
	  2)
	 ((=fx %awt-inputevent-button3
	       (bit-and mod %awt-inputevent-button3))
	  3)
	 (else
	  0)))
   -1)

;*---------------------------------------------------------------------*/
;*    %event-mouse-modifiers ...                                       */
;*---------------------------------------------------------------------*/
(define (%event-mouse-modifiers::pair-nil ev::%event)
   '(let ((mod (%awt-inputevent-modifiers (%event-%event ev)))
	 (res '()))
      (if (=fx %awt-inputevent-alt-graph
	       (bit-and %awt-inputevent-alt-graph mod))
	  (set! res (cons 'mod2 res)))
      (if (=fx %awt-inputevent-alt
	       (bit-and %awt-inputevent-alt mod))
	  (set! res (cons 'alt res)))
      (if (=fx %awt-inputevent-ctrl
	       (bit-and %awt-inputevent-ctrl mod))
	  (set! res (cons 'control res)))
      (if (=fx %awt-inputevent-meta
	       (bit-and %awt-inputevent-meta mod))
	  (set! res (cons 'meta res)))
      (if (=fx %awt-inputevent-shift
	       (bit-and %awt-inputevent-shift mod))
	  (set! res (cons 'shift res)))
      res))

;*---------------------------------------------------------------------*/
;*    %event-key-time ...                                              */
;*---------------------------------------------------------------------*/
(define (%event-key-time::int ev::%event)
   '(%bglk-input-event-time (%event-%event ev))
   -1)

;*---------------------------------------------------------------------*/
;*    %event-key-modifiers ...                                         */
;*---------------------------------------------------------------------*/
(define (%event-key-modifiers::pair-nil ev::%event)
   '(let ((mod (%awt-inputevent-modifiers (%event-%event ev)))
	 (res '()))
      (if (=fx %awt-inputevent-alt-graph
	       (bit-and %awt-inputevent-alt-graph mod))
	  (set! res (cons 'mod2 res)))
      (if (=fx %awt-inputevent-alt
	       (bit-and %awt-inputevent-alt mod))
	  (set! res (cons 'alt res)))
      (if (=fx %awt-inputevent-ctrl
	       (bit-and %awt-inputevent-ctrl mod))
	  (set! res (cons 'control res)))
      (if (=fx %awt-inputevent-meta
	       (bit-and %awt-inputevent-meta mod))
	  (set! res (cons 'meta res)))
      (if (=fx %awt-inputevent-shift
	       (bit-and %awt-inputevent-shift mod))
	  (set! res (cons 'shift res)))
      res)
   -1)

;*---------------------------------------------------------------------*/
;*    %event-key-keyval ...                                            */
;*---------------------------------------------------------------------*/
(define (%event-key-keyval::int ev::%event)
   '(%awt-keyevent-keycode (%event-%event ev))
   -1)

;*---------------------------------------------------------------------*/
;*    %event-key-char ...                                              */
;*---------------------------------------------------------------------*/
(define (%event-key-char::char ev::%event)
   '(let ((i (ucs2->integer (%awt-keyevent-keychar (%event-%event ev))))
	 (m (%awt-inputevent-modifiers (%event-%event ev))))
      (if (<fx i 256)
	  (if (=fx %awt-inputevent-ctrl (bit-and %awt-inputevent-ctrl m))
	      ;; this is a control char
	      (integer->char (-fx (+fx i (char->integer #\a)) 1))
	      ;; this is a plain char
	      (integer->char i))
	  #a000))
   -1)

;*---------------------------------------------------------------------*/
;*    wrap-event-descriptor ...                                        */
;*---------------------------------------------------------------------*/
(define (wrap-event-descriptor event t) ;; receiver
   (with-access::%event *widget-event* (%event type %widget)
      (set! %event event)
      (set! type t)
;      (set! %widget receiver)
      *widget-event*))
   
;*---------------------------------------------------------------------*/
;*    wrap-mouse-descriptor ...                                        */
;*---------------------------------------------------------------------*/
(define (wrap-mouse-descriptor event::%awt-inputevent receiver)
   (with-access::%event *mouse-event* (%event %widget)
      (set! %event event)
      (set! %widget receiver)
      *mouse-event*))
   
;*---------------------------------------------------------------------*/
;*    wrap-key-descriptor ...                                          */
;*---------------------------------------------------------------------*/
(define (wrap-key-descriptor event::%awt-inputevent receiver)
   (with-access::%event *key-event* (%event %widget)
      (set! %event event)
      (set! %widget receiver)
      *key-event*))

