;*=====================================================================*/
;*    .../prgm/project/biglook/peer/gtk/Lwidget/_checkbutton.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sat Jul 21 09:52:09 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Check Button implementation.                       */
;*    definition: @path ../../../biglook/Lwidget/check-button.scm@     */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%check-button
   
   (import __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%container
	   __biglook_%button)
   
   (extern (macro %%gtk-check-button-new::gtkwidget* ()
		  "gtk_check_button_new"))

   (export (class %check-button::%button)

	   (%make-%check-button ::%bglk-object)
	   
	   (%check-button-active?::bool ::%bglk-object)
	   (%check-button-active?-set! ::%bglk-object ::bool)
	   
	   (%check-button-on?::bool ::%bglk-object)
	   (%check-button-on?-set! ::%bglk-object ::bool)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%check-button ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-%check-button o::%bglk-object)
   (instantiate::%check-button
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-check-button-new)))))

;*---------------------------------------------------------------------*/
;*    %check-button-active? ...                                        */
;*---------------------------------------------------------------------*/
(define (%check-button-active? o::%bglk-object)
   (g-property-get o "draw-indicator"))

;*---------------------------------------------------------------------*/
;*    %check-button-active?-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%check-button-active?-set! o::%bglk-object v)
   (g-property-set! o "draw-indicator" v))

;*---------------------------------------------------------------------*/
;*    %check-button-on? ...                                            */
;*---------------------------------------------------------------------*/
(define (%check-button-on? o::%bglk-object)
   (g-property-get o "active"))

;*---------------------------------------------------------------------*/
;*    %check-button-on?-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%check-button-on?-set! o::%bglk-object v)
   (g-property-set! o "active" v))
