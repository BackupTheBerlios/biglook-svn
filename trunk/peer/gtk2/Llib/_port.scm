;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Llib/_port.scm             */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Aug 16 09:29:21 2001                          */
;*    Last change :  Fri Aug 31 09:11:43 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Gtk port for Biglook file handling                               */
;*    definition: @path ../../../biglook/Llib/port.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%port
   
   (import __biglook_%peer
	   __biglook_%bglk-object)

   (extern (macro %%bglk-add-input-port-events!::void
		  (::input-port)
		  "bglk_add_input_port_events")
	   (macro %%bglk-add-input-port-handler!::int
		  (::input-port ::int ::pair)
		  "bglk_add_input_port_handler")
	   (macro %%gdk-input-remove::void (::int)
		  "gdk_input_remove")
	   
	   (macro %%bglk-readable-event::int "BIGLOOK_READABLE")

	   (export unregister-port-callback! "bglk_unregister_port_callback"))
   
   (export (%when-char-ready ::input-port ::obj)
	   (%nonblocking ::input-port)
	   (unregister-port-callback! ::input-port)))
   
;*---------------------------------------------------------------------*/
;*    %when-char-ready ...                                             */
;*---------------------------------------------------------------------*/
(define (%when-char-ready port proc)
   (unregister-port-callback! port)
   (if (procedure? proc)
       (let ((u (cons port proc)))
	  (register-user-callback! u)
	  (let ((g (cons port
			 (%%bglk-add-input-port-handler! port
							 %%bglk-readable-event
							 u))))
	     (register-gtk-callback! g)
	     port))))

;*---------------------------------------------------------------------*/
;*    %nonblocking ...                                                 */
;*---------------------------------------------------------------------*/
(define (%nonblocking port)
   (%%bglk-add-input-port-events! port)
   port)

;*---------------------------------------------------------------------*/
;*    Callbacks ...                                                    */
;*---------------------------------------------------------------------*/
(define *user-callbacks* '())
(define *gtk-callbacks* '())

;*---------------------------------------------------------------------*/
;*    register-user-callback! ...                                      */
;*---------------------------------------------------------------------*/
(define (register-user-callback! cb)
   (set! *user-callbacks* (cons cb *user-callbacks*)))

;*---------------------------------------------------------------------*/
;*    register-gtk-callback! ...                                       */
;*---------------------------------------------------------------------*/
(define (register-gtk-callback! cb)
   (set! *gtk-callbacks* (cons cb *gtk-callbacks*)))

;*---------------------------------------------------------------------*/
;*    unregister-port-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define (unregister-port-callback! port)
   (let ((u (assq port *user-callbacks*))
	 (g (assq port *gtk-callbacks*)))
      (if (pair? u)
	  (set! *user-callbacks* (remq! u *user-callbacks*)))
      (if (pair? g)
	  (begin
	     (%%gdk-input-remove (cdr g))
	     (set! *gtk-callbacks* (remq! u *gtk-callbacks*))))))


