;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_image.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sat Jun  2 15:28:28 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Image implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/image.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%image
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%gtk-misc
	   __biglook_%color)
   
   (extern (macro %%bglk-file-image-new::gtkwidget* (::string)
		  "bglk_gtk_file_image_new")
	   (macro %%bglk-data-image-new::gtkwidget* (::string ::string)
		  "bglk_gtk_data_image_new")
	   (macro %%bglk-image-duplicate::gtkwidget* (::gtkobject*)
		  "bglk_gtk_image_duplicate")
	   (macro %%bglk-image->pixbuf::gdkpixbuf* (::gtkobject*)
		  "bglk_gtk_image_to_pixbuf")
	   (macro %%gdk-pixbuf-width::int (::gdkpixbuf*)
		  "gdk_pixbuf_get_width")
	   (macro %%gdk-pixbuf-height::int (::gdkpixbuf*)
		  "gdk_pixbuf_get_height")
	   (macro %%bglk-image->pixmap::gdkpixmap* (::gtkobject*)
		  "BGLK_GTK_PIXMAP_PIXMAP")
	   (macro %%bglk-image-mask->bitmap::gdkbitmap* (::gtkobject*)
		  "BGLK_GTK_PIXMAP_BITMAP"))
	   
   (export (class %image::%peer)

	   (%make-%file-image ::%bglk-object ::bstring)
	   (%make-%data-image ::%bglk-object ::bstring ::bstring)
	   (%duplicate-image ::%bglk-object)
	   
	   (%image-parent ::%bglk-object)
	   
	   (%image-width::int ::%bglk-object)
	   (%image-height::int ::%bglk-object)

	   (%delete-image ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%file-image ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%file-image o::%bglk-object filename::bstring)
   (instantiate::%image
      (%bglk-object o)
      (%builtin (gtkobject (%%bglk-file-image-new filename)))))

;*---------------------------------------------------------------------*/
;*    %make-%data-image ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%data-image o::%bglk-object data::bstring mask::bstring)
   (instantiate::%image
      (%bglk-object o)
      (%builtin (gtkobject (%%bglk-data-image-new data mask)))))

;*---------------------------------------------------------------------*/
;*    %duplicate-image ...                                             */
;*---------------------------------------------------------------------*/
(define (%duplicate-image o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (instantiate::%image
	 (%bglk-object o)
	 (%builtin (gtkobject (%%bglk-image-duplicate %builtin))))))

;*---------------------------------------------------------------------*/
;*    %image-parent ...                                                */
;*---------------------------------------------------------------------*/
(define (%image-parent o::%bglk-object)
   (%widget-parent o))

;*---------------------------------------------------------------------*/
;*    %image-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%image-width::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%%gdk-pixbuf-width (%%bglk-image->pixbuf %builtin)))))

;*---------------------------------------------------------------------*/
;*    %image-height ...                                                */
;*---------------------------------------------------------------------*/
(define (%image-height::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%%gdk-pixbuf-height (%%bglk-image->pixbuf %builtin)))))

;*---------------------------------------------------------------------*/
;*    %delete-image ...                                                */
;*---------------------------------------------------------------------*/
(define (%delete-image o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%%gtk-object-unref (%peer-%builtin %peer))
      #unspecified))


