;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_canvas.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Jun 13 07:50:20 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Canvas implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/canvas.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%canvas
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%error
	   __biglook_%container)
   
   (extern (macro %%gnome-canvas-new::gtkwidget* () "gnome_canvas_new")
	   (macro %%gnome-canvas-set-scroll-region::void
		  (::gnomecanvas* ::double ::double ::double ::double)
		  "gnome_canvas_set_scroll_region")
	   (macro %%gnome-canvas-set-pixels-per-unit::void
		  (::gnomecanvas* ::double)
		  "gnome_canvas_set_pixels_per_unit")
	   (macro %%gnome-canvas-root::gnomecanvasgroup*
		  (::gnomecanvas*)
		  "gnome_canvas_root")
	   (macro %%gnome-canvas-group-null::gnomecanvasgroup* "0L")
	   (macro %%bglk-canvas-item-new::gtkobject*
		  (::gnomecanvasgroup* ::gtktype ::obj)
		  "bglk_gnome_canvas_item_new")
	   (macro %%gnome-canvas-text-get-type::gtktype
		  ()
		  "gnome_canvas_text_get_type")
	   (macro %%gnome-canvas-line-get-type::gtktype
		  ()
		  "gnome_canvas_line_get_type")
	   (macro %%gnome-canvas-rectangle-get-type::gtktype
		  ()
		  "gnome_canvas_rect_get_type")
	   (macro %%gnome-canvas-ellipse-get-type::gtktype
		  ()
		  "gnome_canvas_ellipse_get_type")
	   (macro %%gnome-canvas-pixbuf-get-type::gtktype
		  ()
		  "gnome_canvas_pixbuf_get_type")
	   (macro %%gnome-canvas-group-get-type::gtktype
		  ()
		  "gnome_canvas_group_get_type")
	   (macro %%gnome-canvas-widget-get-type::gtktype
		  ()
		  "gnome_canvas_widget_get_type")
	   (macro %%gtk-widget-set-usize::void
		  (::gtkwidget* ::int ::int)
		  "gtk_widget_set_usize")
	   (macro %%bglk-gnome-canvas-scroll-region-x::int
		  (::gnomecanvas*)
		  "bglk_gnome_canvas_get_scroll_region_x")
	   (macro %%bglk-gnome-canvas-scroll-region-y::int
		  (::gnomecanvas*)
		  "bglk_gnome_canvas_get_scroll_region_y")
	   (macro %%bglk-gnome-canvas-scroll-region-width::int
		  (::gnomecanvas*)
		  "bglk_gnome_canvas_get_scroll_region_width")
	   (macro %%bglk-gnome-canvas-scroll-region-height::int
		  (::gnomecanvas*)
		  "bglk_gnome_canvas_get_scroll_region_height")
	   (macro %%bglk-gnome-canvas-scroll-region-x-set!::void
		  (::gnomecanvas* ::int)
		  "bglk_gnome_canvas_scroll_region_x_set")
	   (macro %%bglk-gnome-canvas-scroll-region-y-set!::void
		  (::gnomecanvas* ::int)
		  "bglk_gnome_canvas_scroll_region_y_set")
	   (macro %%bglk-gnome-canvas-scroll-region-width-set!::void
		  (::gnomecanvas* ::int)
		  "bglk_gnome_canvas_scroll_region_width_set")
	   (macro %%bglk-gnome-canvas-scroll-region-height-set!::void
		  (::gnomecanvas* ::int)
		  "bglk_gnome_canvas_scroll_region_height_set"))
   
   (export (class %canvas::%container
	      (%group::gnomecanvasgroup* (default %%gnome-canvas-group-null)))
	   
	   (%make-%canvas ::%bglk-object)
	   
	   (%canvas-width::int ::%bglk-object)
	   (%canvas-width-set! ::%bglk-object ::int)
	   
	   (%canvas-height::int ::%bglk-object)
 	   (%canvas-height-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-x::int ::%bglk-object)
	   (%canvas-scroll-x-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-y::int ::%bglk-object)
	   (%canvas-scroll-y-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-width::int ::%bglk-object)
	   (%canvas-scroll-width-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-height::int ::%bglk-object)
	   (%canvas-scroll-height-set! ::%bglk-object ::int)

           (%canvas-zoom-x::float ::%bglk-object)
	   (%canvas-zoom-x-set! ::%bglk-object ::float)

	   (%canvas-zoom-y::float ::%bglk-object)
	   (%canvas-zoom-y-set! ::%bglk-object ::float)

	   (%canvas-add! ::%bglk-object ::%bglk-object ::pair-nil)
	   (%canvas-add-item! ::%bglk-object ::%bglk-object)
	   (%canvas-remove-item! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%canvas ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%canvas o::%bglk-object)
   (let* ((canvas::gtkwidget* (%%gnome-canvas-new))
	  (w (instantiate::%canvas
		(%bglk-object o)
		(%builtin (gtkobject canvas)))))
      ;; default size
      (%%gtk-widget-set-usize canvas 200 200)
      ;; default scrollregion
      (%%gnome-canvas-set-scroll-region (gnomecanvas (gtkobject canvas))
					0.0 0.0
					200.0 200.0)
      ;; default pixel unit
      (%%gnome-canvas-set-pixels-per-unit (gnomecanvas (gtkobject canvas)) 1.0)
      ;; set a new group for this canvas
      (let ((group (%%gnome-canvas-root (gnomecanvas (gtkobject canvas))))
	    (type (%%gnome-canvas-group-get-type)))
	 (%canvas-%group-set! w
			      (gnomecanvasgroup
			       (%%bglk-canvas-item-new group type '()))))
      ;; we are done
      w))

;*---------------------------------------------------------------------*/
;*    %canvas-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%canvas-add! c::%bglk-object w::%bglk-object options)
   (not-implemented c "%canvas-add!"))

;*---------------------------------------------------------------------*/
;*    %canvas-add-item! ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-add-item! c::%bglk-object i::%bglk-object)
   (with-access::%canvas (%bglk-object-%peer c) (%gc-children)
      (set! %gc-children (cons i %gc-children))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-remove-item! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-remove-item! c::%bglk-object i::%bglk-object)
   (with-access::%canvas (%bglk-object-%peer c) (%gc-children)
      (set! %gc-children (remq! i %gc-children))))
   
;*---------------------------------------------------------------------*/
;*    %%container-children ::%canvas ...                               */
;*---------------------------------------------------------------------*/
(define-method (%%container-children o::%canvas)
   (with-access::%canvas o (%gc-children)
      %gc-children))

;*---------------------------------------------------------------------*/
;*    %canvas-width ...                                                */
;*    -------------------------------------------------------------    */
;*    When fetching the width of a canvas, we adjust its scrollregion. */
;*---------------------------------------------------------------------*/
(define (%canvas-width::int o::%bglk-object)
   (%widget-width o))

;*---------------------------------------------------------------------*/
;*    %canvas-width-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-width-set! o::%bglk-object v::int)
   (%widget-width-set! o v)
   (let ((rw (%canvas-scroll-width o)))
      (if (> v rw)
	  (%canvas-scroll-width-set! o v))))

;*---------------------------------------------------------------------*/
;*    %canvas-height ...                                               */
;*    -------------------------------------------------------------    */
;*    When fetching the height of a canvas, we adjust its scrollregion.*/
;*---------------------------------------------------------------------*/
(define (%canvas-height::int o::%bglk-object)
   (%widget-height o))

;*---------------------------------------------------------------------*/
;*    %canvas-height-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-height-set! o::%bglk-object v::int)
   (%widget-height-set! o v)
   (let ((rh (%canvas-scroll-height o)))
      (if (> v rh)
	  (%canvas-scroll-height-set! o v))))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-x ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-x::int o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gnome-canvas-scroll-region-x (gnomecanvas %builtin))))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-x-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-x-set! o::%bglk-object v::int)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gnome-canvas-scroll-region-x-set! (gnomecanvas %builtin) v)
      o))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-y ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-y::int o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gnome-canvas-scroll-region-y (gnomecanvas %builtin))))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-y-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-y-set! o::%bglk-object v::int)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gnome-canvas-scroll-region-y-set! (gnomecanvas %builtin) v)
      o))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-width::int o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gnome-canvas-scroll-region-width (gnomecanvas %builtin))))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-width-set! o::%bglk-object v::int)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gnome-canvas-scroll-region-width-set! (gnomecanvas %builtin) v)
      o))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-height ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-height::int o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gnome-canvas-scroll-region-height (gnomecanvas %builtin))))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-height-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-height-set! o::%bglk-object v::int)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gnome-canvas-scroll-region-height-set! (gnomecanvas %builtin) v)
      o))

;*---------------------------------------------------------------------*/
;*    %canvas-zoom-x ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-zoom-x::float o::%bglk-object)
   (not-implemented o "%canvas-zoom-x"))

;*---------------------------------------------------------------------*/
;*    %canvas-zoom-x-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-zoom-x-set! o::%bglk-object v::float)
   (not-implemented o "%canvas-zoom-x-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-zoom-y ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-zoom-y::float o::%bglk-object)
   (not-implemented o "%canvas-zoom-y"))

;*---------------------------------------------------------------------*/
;*    %canvas-zoom-y-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-zoom-y-set! o::%bglk-object v::float)
   (not-implemented o "%canvas-zoom-y-set!"))

