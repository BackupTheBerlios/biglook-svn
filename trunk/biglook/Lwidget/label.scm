;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/label.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Tue May 22 13:23:59 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Label widget                                             */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/label.texi@                                */
;*       @node Label@                                                  */
;*    Examples:                                                        */
;*       @path ../../examples/label/label.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label label@                                    */
;*    null: @path ../../peer/null/Lwidget/_label.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_label.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_label.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_label
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_widget)
   
   (export  (class label::widget
	       ;; label text
	       (text
		(get %label-text)
		(set %label-text-set!)
		(info '(string (default "A default text"))))
	       ;; jusfity
	       (justify::symbol
		(get %label-justify)
		(set %label-justify-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::label ...                                     */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::label)
   (with-access::label o (%peer)
      (set! %peer (%make-%label o))
      (call-next-method)
      o))
