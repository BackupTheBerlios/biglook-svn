;*=====================================================================*/
;*    biglook/Lwidget/listbox.scm                                      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Tue May 18 17:06:16 2004 (dciabrin)               */
;*    Copyright   :  2000-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Listbox widget                                           */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/listbox.texi@                              */
;*       @node Listbox@                                                */
;*    Examples:                                                        */
;*       @path ../../examples/listbox/listbox.scm@                     */
;*    -------------------------------------------------------------    */
;*    Implementation: @label listbox@                                  */
;*    null: @path ../../peer/null/Lwidget/_listbox.scm@                */
;*    gtk: @path ../../peer/gtk/Lwidget/_listbox.scm@                  */
;*    swing: @path ../../peer/swing/Lwidget/_listbox.scm@              */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_listbox
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event)
   
   (export  (class listbox::widget
	       ;; active
	       (active::bool
		(get %listbox-active?)
		(set %listbox-active?-set!))
	       ;; items
	       (items
		(get %listbox-items)
		(set %listbox-items-set!))
	       ;; select-mode
	       (select-mode::symbol
		(get %listbox-select-mode)
		(set %listbox-select-mode-set!))
	       ;; selection
	       (selection
		(get %listbox-selection)
		(set %listbox-selection-set!)))
	    (listbox-coords->row::int ::listbox ::int ::int)))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::listbox ...                                   */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::listbox)
   (with-access::listbox o (%peer)
      (set! %peer (%make-%listbox o))
      (call-next-method)
      o))

(define (listbox-coords->row::int lb::listbox x::int y::int)
   (%listbox-coords->row lb x y))