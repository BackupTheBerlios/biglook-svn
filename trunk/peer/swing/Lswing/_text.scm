;*=====================================================================*/
;*    swing/Lswing/_text.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Damien Ciabrini                                   */
;*    Creation    :  Wed Nov  5 11:57:38 2003                          */
;*    Last change :  Wed Nov  5 12:06:47 2003 (dciabrin)               */
;*    Copyright   :  2003 Damien Ciabrini, see LICENCE file            */
;*    -------------------------------------------------------------    */
;*    The Jvm peer Text implementation.                                */
;*    definition: @path ../../../biglook/Lwidget/window.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%window
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%error)

   (static (class %text::%widget))

   (export (%make-%text ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %peer-init ...                                                   */
;*---------------------------------------------------------------------*/
(define-method (%peer-init peer::%text)
   (call-next-method)
   peer)


;*---------------------------------------------------------------------*/
;*    %make-%window ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%text o::%bglk-object)
   (let ((text (instantiate::%text
		  (%builtin (%swing-jtextpane-new))
		  (%bglk-object o))))
      text))

