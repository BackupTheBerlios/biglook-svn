;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Llib/_port.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Aug 16 09:29:21 2001                          */
;*    Last change :  Fri Aug 17 09:28:06 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Swing port for Biglook file handling                             */
;*    definition: @path ../../../biglook/Llib/port.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%port
   
   (import __biglook_%error)

   (java   (class %bglk-port
	      (method static when-char-ready::void
		      (::input-port ::procedure)
		      "when_char_ready")
	      (method static stop-char-ready::void
		      (::input-port)
		      "stop_char_ready")
	      "BJPort"))
   
   (export (%when-char-ready ::input-port ::obj)
	   (%nonblocking ::input-port)))

;*---------------------------------------------------------------------*/
;*    %when-char-ready ...                                             */
;*---------------------------------------------------------------------*/
(define (%when-char-ready port proc)
   (if (procedure? proc)
       (begin
	  (%bglk-port-when-char-ready port proc)
	  #unspecified)
       (begin
	  (%bglk-port-stop-char-ready port)
	  #unspecified)))

;*---------------------------------------------------------------------*/
;*    %nonblocking ...                                                 */
;*---------------------------------------------------------------------*/
(define (%nonblocking port)
   #unspecified)
   
