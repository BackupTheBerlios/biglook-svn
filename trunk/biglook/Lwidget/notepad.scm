;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/notepad.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Sat Jun  2 09:00:14 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Notepad widget                                           */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/notepad.texi@                              */
;*       @node Notepad@                                                */
;*    Examples:                                                        */
;*       @path ../../examples/notepad/notepad.scm@                     */
;*    -------------------------------------------------------------    */
;*    Implementation: @label notepad@                                  */
;*    null: @path ../../peer/null/Lwidget/_notepad.scm@                */
;*    gtk: @path ../../peer/gtk/Lwidget/_notepad.scm@                  */
;*    swing: @path ../../peer/swing/Lwidget/_notepad.scm@              */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_notepad
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event)
   
   (export  (class notepad::container
	       (position::symbol
		(get %notepad-position)
		(set %notepad-position-set!))
	       (selected-page::widget
		(get %notepad-selected-page)
		(set %notepad-selected-page-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::notepad ...                                   */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::notepad)
   (with-access::notepad o (%peer)
      (set! %peer (%make-%notepad o))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::notepad ...                                     */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::notepad w . options)
   (let-options options ((:title #f)
			 (:image #f)
			 (error-proc: "container-add!(vbox)"))
      (%notepad-add! container w title image)))

;*---------------------------------------------------------------------*/
;*    container-remove! ::notepad ...                                  */
;*---------------------------------------------------------------------*/
(define-method (container-remove! container::notepad w)
   (%notepad-remove! container w))
