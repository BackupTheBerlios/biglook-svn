;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/entry.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Sun Jul 22 11:15:45 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Entry widget                                             */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/entry.texi@                                */
;*       @node Entry@                                                  */
;*    Examples:                                                        */
;*       @path ../../examples/entry/entry.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label entry@                                    */
;*    null: @path ../../peer/null/Lwidget/_entry.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_entry.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_entry.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_entry
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_widget)
   
   (export  (class entry::widget
	       ;; command (special callback)
	       (command
		(get %entry-command)
		(set (lambda (o v)
			(cond
			   ((not v)
			    (%entry-command-set! o v))
			   ((procedure? v)
			    (if (not (correct-arity? v 1))
				(error "entry-command-set!"
				       "Illegal command arity"
				       v)
				(%entry-command-set! o v)))
			   (else
			    (error "entry-command-set!"
				   "Illegal command value (should be #f or a procedure)"
				   v))))))
	       ;; entry text
	       (text
		(get %entry-text)
		(set %entry-text-set!))
	       ;; active
	       (active::bool
		(get %entry-active?)
		(set %entry-active?-set!))
	       ;; width
	       (width::int
		(get %entry-width)
		(set %entry-width-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::entry ...                                     */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::entry)
   (with-access::entry o (%peer)
      (if (eq? %peer #unspecified)
	  (set! %peer (%make-%entry o)))
      (call-next-method)
      o))
