;*=====================================================================*/
;*    .../prgm/project/biglook/biglook/Lwidget/fileselector.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Apr  9 17:06:53 2001                          */
;*    Last change :  Thu Jul 26 15:24:05 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The file-selector widget                                         */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/fileselector.texi@                         */
;*       @node File-Selector@                                          */
;*    Examples:                                                        */
;*       @path ../../examples/fileselect/fileselect.scm@               */
;*    -------------------------------------------------------------    */
;*    Implementation: @label widget@                                   */
;*    null: @path ../../peer/null/Lwidget/_fileselector.scm@           */
;*    gtk: @path ../../peer/gtk/Lwidget/_fileselector.scm@             */
;*    swing: @path ../../peer/swing/Lwidget/_fileselector.scm@         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_file-selector
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_widget
	    __biglook_entry
	    __biglook_event
	    __biglook_container
	    __biglook_layout
	    __biglook_window)
   
   (export  (class file-selector::widget
	       ;; title of the window
	       (title::bstring read-only (default "Select a file"))
	       ;; the selected file
	       (file
		(get %file-selector-file)
		(set %file-selector-file-set!))
	       ;; the default path
	       (path
		(get %file-selector-path)
		(set %file-selector-path-set!))
	       ;; the action to execute on a selection
	       (ok-command
		(get %file-selector-ok-command)
		(set (lambda (o v)
			(if (or (not v) (not (correct-arity? v 1)))
			    (error "file-selector-ok-command-set!"
				   "Illegal command arity v"
				   v)
			    (%file-selector-ok-command-set! o v)))))
	       ;; the action to execute when canceling
	       (cancel-command
		(get %file-selector-cancel-command)
		(set (lambda (o v)
			(if (or (not v) (not (correct-arity? v 1)))
			    (error "file-selector-cancel-command-set!"
				   "Illegal command arity v"
				   v)
			    (%file-selector-cancel-command-set! o v))))))

	    (class file-entry::entry
	       (%command (default #f))
	       (command
		(get (lambda (o) (file-entry-%command o)))
		(set (lambda (o v) (file-entry-%command-set! o v)))))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::file-selector ...                             */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::file-selector)
   (with-access::file-selector o (%peer title)
      (set! %peer (%make-%file-selector o title))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::file-entry ...                                */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::file-entry)
   ;; a file-entry is a regular entry with specific bindings on
   ;; [tab] and [tab-tab]
   (call-next-method)
   (entry-event-set! o (instantiate::event-handler
			  (key (make-tab-event-handler)))))

;*---------------------------------------------------------------------*/
;*    make-tab-event-handler ...                                       */
;*---------------------------------------------------------------------*/
(define (make-tab-event-handler)
   (let ((armed? #f))
      (lambda (e)
	 (with-access::event e (char widget)
	    (with-access::file-entry widget (text command)
	       (case char
		  ((#\tab)
		   (if armed?
		       (begin
			  (set! armed? #f)
			  ;; two consecutive tabs means that we have to popup
			  ;; a file-selector window
			  (instantiate::file-selector
			     (file text)
			     (ok-command (lambda (e2)
					    (let* ((w (event-widget e2))
						   (f (file-selector-file w)))
					       (set! text f)
					       (if (procedure? command)
						   (command e))
					       (destroy w))))
			     (cancel-command (lambda (e2)
						(let ((w (event-widget e2)))
						   (destroy w))))))
		       (let ((expand (expand-file-name text)))
			  (if (string? expand)
			      (begin
				 (set! armed? #f)
				 (set! text expand))
			      (set! armed? #t)))))
		  ((#\Newline)
		   (set! armed? #f)
		   (if (procedure? command)
		       (command e)))
		  (else
		   (set! armed? #f))))))))

;*---------------------------------------------------------------------*/
;*    expand-file-name ...                                             */
;*---------------------------------------------------------------------*/
(define (expand-file-name name)
   (define (common-prefix s1 s2)
      (let ((l1 (string-length s1))
	    (l2 (string-length s2)))
	 (let loop ((i 0))
	    (cond
	       ((=fx i l1)
		s1)
	       ((=fx i l2)
		s2)
	       ((char=? (string-ref s1 i) (string-ref s2 i))
		(loop (+fx i 1)))
	       (else
		(substring s1 0 i))))))
   (let ((len (string-length name)))
      (if (=fx len 0)
	  #f
	  (if (char=? (string-ref name 0) #\~)
	      (cond
		 ((=fx len 1)
		  #f)
		 ((char=? (string-ref name 1) #\/)
		  (string-append (getenv "HOME") (substring name 1 len)))
		 (else
		  (string-append (dirname (getenv "HOME"))
				 "/"
				 (substring name 1 len))))
	      (let ((dir (dirname name)))
		 (if (and (file-exists? dir) (directory? dir))
		     (let loop ((files (directory->list dir))
				(matches '()))
			(cond
			   ((null? files)
			    (cond
			       ((null? matches)
				;; no match
				#f)
			       ((null? (cdr matches))
				;; exact match
				(if (string=? name (car matches))
				    #f
				    (car matches)))
			       (else
				;; find the longest prefix
				(let loop ((matches (cddr matches))
					   (p (common-prefix (car matches)
							     (cadr matches))))
				   (if (null? matches)
				       (if (string=? name p)
					   #f
					   p)
				       (loop (cdr matches)
					     (common-prefix (car matches)
							    p)))))))
			   ((substring=? name (car files) len)
			    (loop (cdr files) (cons (car files) matches)))
			   (else
			    (loop (cdr files) matches))))
		     #f))))))
