;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/checkbutton.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Tue Jun 12 21:25:26 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Check Button widget                                      */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/check-button.texi@                         */
;*       @node Check Button@                                           */
;*    Examples:                                                        */
;*       @path ../../examples/check-button/checkbutton.scm@            */
;*    -------------------------------------------------------------    */
;*    Implementation: @label check-button@                             */
;*    null: @path ../../peer/null/Lwidget/_checkbutton.scm@            */
;*    gtk: @path ../../peer/gtk/Lwidget/_checkbutton.scm@              */
;*    swing: @path ../../peer/swing/Lwidget/_checkbutton.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_check-button
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event
	    __biglook_button)
   
   (export  (class check-button::button
	       ;; active
	       (active::bool
		(get %check-button-active?)
		(set %check-button-active?-set!))
	       ;; on
	       (on::bool
		(get %check-button-on?)
		(set %check-button-on?-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::check-button ...                              */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::check-button)
   (with-access::check-button o (%peer)
      (if (eq? %peer #unspecified)
	  (set! %peer (%make-%check-button o)))
      (call-next-method)
      o))
