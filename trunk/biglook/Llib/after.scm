;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Llib/after.scm              */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Mon May  7 20:04:44 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook after facility                                           */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/after.texi@                                */
;*       @node After@                                                  */
;*    Examples:                                                        */
;*       @path ../../examples/after/after.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label after@                                    */
;*    null: @path ../../peer/null/Llib/_after.scm@                     */
;*    gtk: @path ../../peer/gtk/Llib/_after.scm@                       */
;*    swing: @path ../../peer/swing/Llib/_after.scm@                   */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_after

   (library biglook_peer)

   (export  (after . l)
	    (timeout ::int ::procedure)))

;*---------------------------------------------------------------------*/
;*    after ...                                                        */
;*---------------------------------------------------------------------*/
(define (after . l)
   (cond
      ((null? l)
       #unspecified)
      ((fixnum? (car l))
       (if (null? (cdr l))
	   (begin
	      (warning "not implemented...")
	      #unspecified)
	   (for-each (lambda (f)
			(if (and (procedure? f)
				 (correct-arity? f 0))
			    (%after (car l) f)
			    (error "after" "Illegal callback" f)))
		     (cdr l))))
      ((eq? (car l) 'idle)
       (let ((p (lambda ()
		      (for-each (lambda (f)
				   (if (procedure? f)
				       (f)
				       (error "after" "Illegal callback" f)))
				(cdr l)))))
	  (%idle p)))
      (else
       (error "after" "Illegal argument" (car l)))))

;*---------------------------------------------------------------------*/
;*    timeout ...                                                      */
;*    -------------------------------------------------------------    */
;*    Loop forever until the callback returns #f. Waits INTERVAL       */
;*    before each iteration.                                           */
;*---------------------------------------------------------------------*/
(define (timeout interval::int proc::procedure)
   (if (correct-arity? proc 0)
       (%timeout interval proc)
       (error "timeout" "Illegal procedure" proc)))
