;*=====================================================================*/
;*    biglook/Lwidget/text.scm                                         */
;*    -------------------------------------------------------------    */
;*    Authors     :  Manuel Serrano, Damien Ciabrini                   */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Tue Mar 23 08:44:36 2004 (dciabrin)               */
;*    Copyright   :  2000-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Text widget                                              */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/text.texi@                                 */
;*       @node Text@                                                   */
;*    Examples:                                                        */
;*       @path ../../examples/text/text.scm@                           */
;*    -------------------------------------------------------------    */
;*    Implementation: @label text@                                     */
;*    null: @path ../../peer/null/Lwidget/_text.scm@                   */
;*    gtk: @path ../../peer/gtk/Lwidget/_text.scm@                     */
;*    swing: @path ../../peer/swing/Lwidget/_text.scm@                 */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_text
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget)
   
   (export  (class text::container
	       (background
		(get (lambda (x) '()))
		(set %text-background-set!))
	       (text::bstring
		(get %text-text)
		(set %text-text-set!))
	       (font
		(get %text-font)
		(set %text-font-set!))
	       (editable?::bool
		(get %text-editable?)
		(set %text-editable?-set!))
	       (caret-pos
		(get %text-caret-pos)
		(set %text-caret-pos-set!))
	       )

;	    (class text-properties
;	       ::%text-properties
;	       (text-properties-init)
;	       props)
	    
	    (text-pixels-coords->caret-location::int ::text ::pair)
	    (text-caret->line/column::pair ::text ::int)
	    (text-insert-string ::text ::bstring)
	    (text-put-props! ::text ::int ::int ::pair-nil)
	    ))

(define-method (bglk-object-init o::text)
   (with-access::text o (%peer)
      (set! %peer (%make-%text o))
      (call-next-method)
      o))

(define (text-pixels-coords->caret-location::int t::text coords::pair)
   (%text-pixels-coords->caret-location t coords))

(define (text-caret->line/column::pair t::text caret::int)
   (%text-caret->line/column t caret))

(define (text-insert-string t::text str::bstring)
   (%text-insert-string t str))

(define (text-put-props! t::text start::int end::int props::pair-nil)
   (%text-put-props! t start end props))
