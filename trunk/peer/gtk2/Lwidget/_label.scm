;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/%label.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sat Apr 28 14:50:15 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Label implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/label.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%label

   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%gtk-misc
	   __biglook_%color)

   (extern (macro %%gtk-label-new::gtkwidget* (::string) "gtk_label_new"))
	   
   (static (class %label::%peer))

   (export (%make-%label ::%bglk-object)

	   (%label-text::bstring ::%bglk-object)
	   (%label-text-set! ::%bglk-object ::bstring)

	   (%label-justify::symbol ::%bglk-object)
	   (%label-justify-set! ::%bglk-object ::symbol)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%label ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%label o::%bglk-object)
   (instantiate::%label
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-label-new "")))))

;*---------------------------------------------------------------------*/
;*    %label-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%label-text o::%bglk-object)
   (g-property-get o "label"))

;*---------------------------------------------------------------------*/
;*    %label-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%label-text-set! o::%bglk-object v::bstring)
   (g-property-set! o "label" v))

;*---------------------------------------------------------------------*/
;*    %label-justify ...                                               */
;*---------------------------------------------------------------------*/
(define (%label-justify o::%bglk-object)
   (gtk-justify->biglook (g-property-get o "justify")))

;*---------------------------------------------------------------------*/
;*    %label-justify-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%label-justify-set! o::%bglk-object v::symbol)
   (with-access::%bglk-object o (%peer)
      (g-property-type-set! o
			    "justify"
			    (biglook-justify->gtk v)
			    GTK-TYPE-JUSTIFICATION)))
