;*=====================================================================*/
;*    .../prgm/project/biglook/peer/gtk/Lwidget/_colorselector.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Dec 15 08:32:59 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Colorselector implementation.                       */
;*    definition: @path ../../../biglook/Lwidget/colorselector.scm@    */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%color-selector
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (extern (macro %%gtk-color-selection-new::gtkwidget* ()
		  "gtk_color_selection_new")
	   (macro %%gtk-color-selection-get-color::void
		  (::gtkcolorselection* ::gdouble*)
		  "gtk_color_selection_get_color")
	   (macro %%gtk-color-selection-set-color::void
		  (::gtkcolorselection* ::gdouble*)
		  "gtk_color_selection_set_color")
	   (macro %%gtk-color-selection-set-opacity::void
		  (::gtkcolorselection* ::bool)
		  "gtk_color_selection_set_opacity"))

   (static (class %color-selector::%peer))
	   
   (export (%make-%color-selector ::%bglk-object)

	   (%color-selector-color::%color ::%bglk-object ::procedure)
	   (%color-selector-color-set! ::%bglk-object ::%color)))

;*---------------------------------------------------------------------*/
;*    %make-%color-selector ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%color-selector o)
   (let ((selector (gtkobject (%%gtk-color-selection-new))))
      (%%gtk-color-selection-set-opacity (gtkcolorselection selector) #t)
      (instantiate::%color-selector
	 (%bglk-object o)
	 (%builtin selector))))

;*---------------------------------------------------------------------*/
;*    %color-selector-color ...                                        */
;*---------------------------------------------------------------------*/
(define (%color-selector-color o make-color)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-color-selection-get-color (gtkcolorselection %builtin)
				       %%gtk-color-buffer)
      (make-color (%%gtk-color-red %%gtk-color-buffer)
		  (%%gtk-color-green %%gtk-color-buffer)
		  (%%gtk-color-blue %%gtk-color-buffer)
		  (%%gtk-color-opacity %%gtk-color-buffer))))

;*---------------------------------------------------------------------*/
;*    %color-selector-color-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%color-selector-color-set! o v)
   (tprint "color-selector-color-set: " (find-runtime-type v) " " (%color? v))
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (let ((x::gdouble* (biglook-color->gtk v)))
	 (%%gtk-color-selection-set-color (gtkcolorselection %builtin) x)))
   #unspecified)

