;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/combobox.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Mon Jul 23 13:42:57 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Combobox widget                                          */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/combobox.texi@                             */
;*       @node Combobox@                                               */
;*    Examples:                                                        */
;*       @path ../../examples/combobox/combobox.scm@                   */
;*    -------------------------------------------------------------    */
;*    Implementation: @label combobox@                                 */
;*    null: @path ../../peer/null/Lwidget/_combobox.scm@               */
;*    gtk: @path ../../peer/gtk/Lwidget/_combobox.scm@                 */
;*    swing: @path ../../peer/swing/Lwidget/_combobox.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_combobox
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event
	    __biglook_entry)
   
   (export  (class combobox::entry
	       ;; text
	       (text::bstring
		(get %combobox-text)
		(set %combobox-text-set!))
	       ;; width
	       (width::int
		(get %combobox-width)
		(set %combobox-width-set!))
	       ;; active
	       (active::bool
		(get %combobox-active?)
		(set %combobox-active?-set!))
	       ;; editable
	       (editable::bool
		(get %combobox-editable?)
		(set %combobox-editable?-set!))
	       ;; items
	       (items::pair-nil
		(get %combobox-items)
		(set %combobox-items-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::combobox ...                                  */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::combobox)
   (with-access::combobox o (%peer)
      (set! %peer (%make-%combobox o))
      (call-next-method)
      o))

