;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Llib/port.scm               */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Aug 16 09:16:47 2001                          */
;*    Last change :  Fri Aug 17 07:56:44 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Biglook file handling                                            */
;*    -------------------------------------------------------------    */
;*    Implementation: @label port@                                     */
;*    null: @path ../../peer/null/Llib/_port.scm@                      */
;*    gtk: @path ../../peer/gtk/Llib/_port.scm@                        */
;*    swing: @path ../../peer/swing/Llib/_port.scm@                    */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_port

   (library biglook_peer)

   (export  (when-char-ready ::input-port ::obj)
	    (nonblocking ::input-port)))

;*---------------------------------------------------------------------*/
;*    when-char-ready ...                                              */
;*---------------------------------------------------------------------*/
(define (when-char-ready port v)
   (cond
      ((or (not v) (and (procedure? v) (correct-arity? v 1)))
       (%when-char-ready port v))
      (else
       (error "when-char-ready" "Illegal callback" v))))

;*---------------------------------------------------------------------*/
;*    nonblocking ...                                                  */
;*---------------------------------------------------------------------*/
(define (nonblocking port)
   (%nonblocking port))
      
	    
