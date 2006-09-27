;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Misc/options.sch            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Apr 10 09:52:57 2001                          */
;*    Last change :  Thu Feb 23 02:55:44 2006 (serrano)                */
;*    Copyright   :  2001-06 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The implementation of the LET-OPTIONS macro.                     */
;*                                                                     */
;*    syntax:                                                          */
;*       LET-OPTIONS ::= (let-options <expr> (<BINDING>+) <expr>+)     */
;*       BINDING     ::= (<keyword> <expr>)                            */
;*                     | (error-proc: <expr>)                          */
;*                     | (error-msg: <expr>)                           */
;*                     | (<symbol> <expr>)                             */
;*                                                                     */
;*    example:                                                         */
;*       (let-options options ((:padx 0)                               */
;*    			 (:pady 0)                                     */
;*    			 (children '()))                               */
;*          (cons* padx pady children))                                */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    let-options ...                                                  */
;*---------------------------------------------------------------------*/
(define-macro (let-options options bindings . body)
   (multiple-value-bind (bdg kbdgs err-proc err-msg)
      (let loop ((bindings bindings)
		 (bdgs '())
		 (kbdgs '())
		 (err-proc "let-options")
		 (err-msg "Unknown option"))
	 (if (null? bindings)
	     (cond
		((null? bdgs)
		 (values '() (reverse! kbdgs) err-proc err-msg))
		((pair? (cdr bdgs))
		 (error "let-options"
			"Illegal number of default arguments"
			bindings))
		(else
		 (values bdgs (reverse! kbdgs) err-proc err-msg)))
	     (match-case (car bindings)
		(((? keyword?) ?val)
		 (case (car bindings)
		    ((error-proc:)
		     (loop (cdr bindings)
			   bdgs
			   kbdgs
			   val
			   err-msg))
		    ((error-msg:)
		     (loop (cdr bindings)
			   bdgs
			   kbdgs
			   err-proc
			   val))
		    (else
		     (loop (cdr bindings)
			   bdgs
			   (cons (car bindings) kbdgs)
			   err-proc
			   err-msg))))
		(else
		 (loop (cdr bindings)
		       (cons (car bindings) bdgs)
		       kbdgs
		       err-proc
		       err-msg)))))
      (let* ((loop   (gensym 'loop))
	     (expr   (gensym 'expr))
	     (kvars  (map (lambda (kbinding)
			     (cond-expand
				((or bigloo2.5 bigloo2.6 bigloo2.7)
				 (let ((str (keyword->string (car kbinding))))
				    (string->symbol
				     (substring str 1 (string-length str)))))
				(else
				 (keyword->symbol (car kbinding)))))
			  kbdgs))
	     (kinits (map (lambda (var binding)
			     (list var (cadr binding)))
			  kvars kbdgs))
	     (tests (map (lambda (var binding)
			    `((,(car binding))
			      (set! ,var (cadr ,expr))
			      (,loop (cddr ,expr))))
			 kvars kbdgs)))
	 `(let (,@bdg ,@kinits)
	     (let ,loop ((,expr ,options))
		  (if (null? ,expr)
		      (begin ,@body)
		      (if (keyword? (car ,expr))
			  (case (car ,expr)
			     ,@tests
			     (else
			      (error ,err-proc ,err-msg (car ,expr))))
			  ,(if (pair? bdg)
			       `(begin
				   (set! ,(caar bdg) (cons (car ,expr)
							   ,(caar bdg)))
				   (,loop (cdr ,expr)))
			       `(error ,err-proc ,err-msg (car ,expr))))))))))
	    
			
			  
      
	 
