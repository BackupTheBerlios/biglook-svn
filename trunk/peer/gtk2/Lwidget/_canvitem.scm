;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_canvitem.scm      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Dec 15 08:24:17 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Canvas items implementation.                        */
;*    definition: @path ../../../biglook/Lwidget/canvitem.scm@         */
;*    -------------------------------------------------------------    */
;*    The extern declarations for that module are in the               */
;*    __biglook_%canvas module (@path _canvas.scm@).                   */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%canvas-item
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%container
	   __biglook_%canvas
	   __biglook_%gtk-misc
	   __biglook_%font
	   __biglook_%color
	   __biglook_%widget
	   __biglook_%label
	   __biglook_%image)
   
   (extern (macro %%gnome-canvas-add-widget!::void (::gobject* ::gtkwidget*)
		  "gnome_canvas_add_widget")
	   (macro %%gnome-canvas-text-font-set!::void (::gobject* ::string ::string ::int ::int ::int)
		  "gnome_canvas_text_font_set")
           (macro %%gtk-type-gdk-line-style::int
		  "GDK_TYPE_LINE_STYLE")
	   (macro %%gtk-type-gdk-cap-style::int
		  "GDK_TYPE_CAP_STYLE")
	   (macro %%gtk-type-gdk-join-style::int
		  "GDK_TYPE_JOIN_STYLE")
	   
	   ;; line styles
	   (macro %%gdk-line-solid::int
		  "GDK_LINE_SOLID")
	   (macro %%gdk-line-on-off-dash::int
		  "GDK_LINE_ON_OFF_DASH")
	   (macro %%gdk-line-double-dash::int
		  "GDK_LINE_DOUBLE_DASH")
	   
	   ;; cap styles
	   (macro %%gdk-cap-not-last::int 
		  "GDK_CAP_NOT_LAST")
	   (macro %%gdk-cap-butt::int
		  "GDK_CAP_BUTT")
	   (macro %%gdk-cap-round::int
		  "GDK_CAP_ROUND")
	   (macro %%gdk-cap-projecting::int
		  "GDK_CAP_PROJECTING")
	   
	   ;; join styles
	   (macro %%gdk-join-miter::int
		  "GDK_JOIN_MITER")
	   (macro %%gdk-join-round::int
		  "GDK_JOIN_ROUND")
	   (macro %%gdk-join-bevel::int
		  "GDK_JOIN_BEVEL")
	   
	   ;; misc
	   (macro %%bglk-gnome-canvas-item-visible::bool  (::gnomecanvasitem*)
		  "BGLK_GNOME_CANVAS_ITEM_VISIBLE")
	   (macro %%gnome-canvas-item-hide::void (::gnomecanvasitem*)
		  "gnome_canvas_item_hide")
	   (macro %%gnome-canvas-item-show::void (::gnomecanvasitem*)
		  "gnome_canvas_item_show")
 	   (macro %%gnome-canvas-item-move::void (::gnomecanvasitem*
						  ::double
						  ::double)
		  "gnome_canvas_item_move")
	   (macro %%gnome-canvas-item-set!::void (::gnomecanvasitem* ::pair-nil)
		  "gnome_canvas_item_set")
	   (macro %%gnome-canvas-item-raise-to-top::void (::gnomecanvasitem*)
		  "gnome_canvas_item_raise_to_top")
	   (macro %%gnome-canvas-item-lower-to-bottom::void (::gnomecanvasitem*)
		  "gnome_canvas_item_lower_to_bottom")
	   (macro %%bglk-g-property-pixbuf-set!::obj (::gtkobject*
						      ::string
						      ::gdkpixbuf*)
		  "BGLK_GTK_PIXBUF_TYPE_SET"))
   
   (static (abstract-class %canvas-item::%peer
	      %canvas
	      (%callbacks::pair-nil (default '())))

	   ;; figure
	   (abstract-class %canvas-figure::%canvas-item
	      (%fill-color (default #unspecified)))

	   ;; text
	   (class %canvas-text::%canvas-figure
	      (%font (default #unspecified)))

	   ;; line
	   (class %canvas-line::%canvas-figure)

	   ;; rectangle
	   (class %canvas-rectangle::%canvas-figure)

	   ;; ellipse
	   (class %canvas-ellipse::%canvas-figure)

	   ;; image
	   (class %canvas-image::%canvas-figure
	      (%image (default #unspecified)))
	   
	   ;; widget
	   (class %canvas-widget::%canvas-figure
	      (%widget (default #unspecified))))
   
   (export (%make-%canvas-text ::%bglk-object ::%bglk-object)
	   (%make-%canvas-line ::%bglk-object ::%bglk-object)
	   (%make-%canvas-rectangle ::%bglk-object ::%bglk-object)
	   (%make-%canvas-ellipse ::%bglk-object ::%bglk-object)
	   (%make-%canvas-polygon  ::%bglk-object ::%bglk-object)
	   (%make-%canvas-image ::%bglk-object ::%bglk-object)
	   (%make-%canvas-widget ::%bglk-object ::%bglk-object)
	   
	   ;; callbacks registration
	   (%register-canvas-item-callback! ::%bglk-object ::symbol ::obj)
	   (%unregister-canvas-item-callback! ::%bglk-object ::symbol)
	   (%registered-canvas-item-callback ::%bglk-object ::symbol ::procedure)
	   
	   ;; canvas item
	   (%canvas-item-width::int ::%bglk-object)
	   (%canvas-item-width-set! ::%bglk-object ::int)
	   
	   (%canvas-item-height::int ::%bglk-object)
	   (%canvas-item-height-set! ::%bglk-object ::int)
	   
	   (%canvas-item-tooltips ::%bglk-object)
	   (%canvas-item-tooltips-set! ::%bglk-object ::obj)
	   
	   (%canvas-item-visible ::%bglk-object)
	   (%canvas-item-visible-set! ::%bglk-object ::bool)
	   
	   ;; canvas text
	   (%canvas-text-x::int ::%bglk-object)
	   (%canvas-text-x-set! ::%bglk-object ::int)
	   
	   (%canvas-text-y::int ::%bglk-object)
	   (%canvas-text-y-set! ::%bglk-object ::int)
	   
	   (%canvas-text-text::bstring ::%bglk-object)
	   (%canvas-text-text-set! ::%bglk-object ::bstring)
	   
	   (%canvas-text-font::obj ::%bglk-object)
	   (%canvas-text-font-set! ::%bglk-object ::obj)
	   
	   (%canvas-text-anchor::symbol ::%bglk-object)
	   (%canvas-text-anchor-set! ::%bglk-object ::symbol)
	   
	   (%canvas-text-justification::symbol ::%bglk-object)
	   (%canvas-text-justification-set! ::%bglk-object ::symbol)
	   
	   (%canvas-text-color::obj ::%bglk-object)
	   (%canvas-text-color-set! ::%bglk-object ::obj)
	   
	   (%canvas-text-width::int ::%bglk-object)
	   (%canvas-text-width-set! ::%bglk-object ::int)
	   
	   (%canvas-text-height::int ::%bglk-object)
	   (%canvas-text-height-set! ::%bglk-object ::int)
	   
	   ;; canvas geometry
	   (%canvas-geometry-color::obj ::%bglk-object)
	   (%canvas-geometry-color-set! ::%bglk-object ::obj)
	   
	   (%canvas-geometry-outline::obj ::%bglk-object)
	   (%canvas-geometry-outline-set! ::%bglk-object ::obj)
	   
	   (%canvas-geometry-outline-width::int ::%bglk-object)
	   (%canvas-geometry-outline-width-set! ::%bglk-object ::int)
	   
	   (%canvas-geometry-width::int ::%bglk-object)
	   (%canvas-geometry-width-set! ::%bglk-object ::int)

	   ;; canvas shape
	   (%canvas-shape-x::int ::%bglk-object)
	   (%canvas-shape-x-set! ::%bglk-object ::int)
	   
	   (%canvas-shape-y::int ::%bglk-object)
	   (%canvas-shape-y-set! ::%bglk-object ::int)
	   
	   (%canvas-shape-width::int ::%bglk-object)
	   (%canvas-shape-width-set! ::%bglk-object ::int)
	   
	   (%canvas-shape-height::int ::%bglk-object)
	   (%canvas-shape-height-set! ::%bglk-object ::int)
	   
	   ;; canvas line
	   (%canvas-line-x::int ::%bglk-object)
	   (%canvas-line-x-set! ::%bglk-object ::int)
	   
	   (%canvas-line-y::int ::%bglk-object)
	   (%canvas-line-y-set! ::%bglk-object ::int)
	   
	   (%canvas-line-points::pair-nil ::%bglk-object)
	   (%canvas-line-points-set! ::%bglk-object ::pair-nil)
	   
	   (%canvas-line-thickness::int ::%bglk-object)
	   (%canvas-line-thickness-set! ::%bglk-object ::int)
	   
	   (%canvas-line-arrow::symbol ::%bglk-object)
	   (%canvas-line-arrow-set! ::%bglk-object ::symbol)
	   
	   (%canvas-line-arrow-shape::pair-nil ::%bglk-object)
	   (%canvas-line-arrow-shape-set! ::%bglk-object ::pair)
	   
	   (%canvas-line-style::symbol ::%bglk-object)
	   (%canvas-line-style-set! ::%bglk-object ::symbol)
	   
	   (%canvas-line-cap-style::symbol ::%bglk-object)
	   (%canvas-line-cap-style-set! ::%bglk-object ::symbol)
	   
	   (%canvas-line-join-style::symbol ::%bglk-object)
	   (%canvas-line-join-style-set! ::%bglk-object ::symbol)
	   
	   (%canvas-line-smooth?::bool ::%bglk-object)
	   (%canvas-line-smooth?-set! ::%bglk-object ::bool)
	   
	   (%canvas-line-spline-steps::int ::%bglk-object)
	   (%canvas-line-spline-steps-set! ::%bglk-object ::int)
	   
	   ;; canvas image
	   (%canvas-image-x::int ::%bglk-object)
	   (%canvas-image-x-set! ::%bglk-object ::int)
	   
	   (%canvas-image-y::int ::%bglk-object)
	   (%canvas-image-y-set! ::%bglk-object ::int)
	   
	   (%canvas-image-image::obj ::%bglk-object)
	   (%canvas-image-image-set! ::%bglk-object ::%bglk-object)
	   
	   (%canvas-image-width::int ::%bglk-object)
	   (%canvas-image-width-set! ::%bglk-object ::int)
	   
	   (%canvas-image-height::int ::%bglk-object)
	   (%canvas-image-height-set! ::%bglk-object ::int)
	   
	   ;; canvas widget
	   (%canvas-widget-x::int ::%bglk-object)
	   (%canvas-widget-x-set! ::%bglk-object ::int)
	   
	   (%canvas-widget-y::int ::%bglk-object)
	   (%canvas-widget-y-set! ::%bglk-object ::int)
	   
	   (%canvas-widget-widget::obj ::%bglk-object)
	   (%canvas-widget-widget-set! ::%bglk-object ::%bglk-object)
	   
	   (%canvas-widget-width::int ::%bglk-object)
	   (%canvas-widget-width-set! ::%bglk-object ::int)
	   
	   (%canvas-widget-height::int ::%bglk-object)
	   (%canvas-widget-height-set! ::%bglk-object ::int)
	   
	   ;; misc
	   (%canvas-item-destroy ::%bglk-object)
	   (%canvas-item-raise ::%bglk-object)
	   (%canvas-item-lower ::%bglk-object)
	   (%canvas-item-move ::%bglk-object ::int ::int)))

;*---------------------------------------------------------------------*/
;*    %peer-init ::%canvas-item ...                                    */
;*---------------------------------------------------------------------*/
(define-method (%peer-init i::%canvas-item)
   ;; a canvas-item is not a widget so we *must not* initialize it
   ;; as regular widgets
   #unspecified)

;*---------------------------------------------------------------------*/
;*    *default-item-font* ...                                          */
;*---------------------------------------------------------------------*/
(define *default-item-font* #unspecified)
(define *default-gtk-item-font* #unspecified)
(define *default-item-fill-color* #unspecified)
(define *default-gtk-item-fill-color* #unspecified)

;*---------------------------------------------------------------------*/
;*    %make-%canvas-text ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-text o::%bglk-object canvas::%bglk-object)
   (if (not (%font? *default-item-font*))
       (begin
	  (set! *default-item-font*
		(instantiate::%font))
	  (set! *default-gtk-item-font*
		(%biglook-font->xfld *default-item-font*))))
   (if (not (string? *default-gtk-item-fill-color*))
       (begin
	  (set! *default-gtk-item-fill-color* "black")
	  (set! *default-item-fill-color*
		(instantiate::%name-color
		   (%name *default-gtk-item-fill-color*)))))
   (let* ((group (%canvas-%group (%bglk-object-%peer canvas)))
	  (type (%%gnome-canvas-text-get-type))
	  (opt (list "x" 0.0
		     "y" 0.0 
		     "font" *default-gtk-item-font*))
	  (ci (%%bglk-canvas-item-new group type opt)))
      (let ((peer (instantiate::%canvas-text
		     (%canvas canvas)
		     (%bglk-object o)
		     (%builtin ci)
		     (%fill-color *default-item-fill-color*)
		     (%font *default-item-font*))))
	 (%canvas-add-item! canvas o)
	 peer)))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-line ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-line o::%bglk-object canvas::%bglk-object)
   (if (not (string? *default-gtk-item-fill-color*))
       (begin
	  (set! *default-gtk-item-fill-color* "black")
	  (set! *default-item-fill-color*
		(instantiate::%name-color
		   (%name *default-gtk-item-fill-color*)))))
   (let* ((group (%canvas-%group (%bglk-object-%peer canvas)))
	  (type (%%gnome-canvas-line-get-type))
	  (ci (%%bglk-canvas-item-new group type '())))
      (let ((peer (instantiate::%canvas-line
		     (%canvas canvas)
		     (%bglk-object o)
		     (%builtin ci)
		     (%fill-color *default-item-fill-color*))))
	 (%canvas-add-item! canvas o)
	 peer)))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-polygon ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-polygon o::%bglk-object canvas::%bglk-object)
   (not-implemented o "%make-%canvas-polygon"))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-ellipse ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-ellipse o::%bglk-object canvas::%bglk-object)
   (if (not (string? *default-gtk-item-fill-color*))
       (begin
	  (set! *default-gtk-item-fill-color* "black")
	  (set! *default-item-fill-color*
		(instantiate::%name-color
		   (%name *default-gtk-item-fill-color*)))))
   (let* ((group (%canvas-%group (%bglk-object-%peer canvas)))
	  (type (%%gnome-canvas-ellipse-get-type))
	  (ci (%%bglk-canvas-item-new group type '())))
      (let ((peer (instantiate::%canvas-ellipse
		     (%canvas canvas)
		     (%bglk-object o)
		     (%builtin ci)
		     (%fill-color *default-item-fill-color*))))
	 (%canvas-add-item! canvas o)
	 peer)))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-rectangle ...                                      */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-rectangle o::%bglk-object canvas::%bglk-object)
   (if (not (string? *default-gtk-item-fill-color*))
       (begin
	  (set! *default-gtk-item-fill-color* "black")
	  (set! *default-item-fill-color*
		(instantiate::%name-color
		   (%name *default-gtk-item-fill-color*)))))
   (let* ((group (%canvas-%group (%bglk-object-%peer canvas)))
	  (type (%%gnome-canvas-rectangle-get-type))
	  (ci (%%bglk-canvas-item-new group type '())))
      (let ((peer (instantiate::%canvas-rectangle
		     (%canvas canvas)
		     (%bglk-object o)
		     (%builtin ci)
		     (%fill-color *default-item-fill-color*))))
	 (%canvas-add-item! canvas o)
	 peer)))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-image ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-image o::%bglk-object canvas::%bglk-object)
   (let* ((group (%canvas-%group (%bglk-object-%peer canvas)))
	  (type (%%gnome-canvas-pixbuf-get-type))
	  (ci (%%bglk-canvas-item-new group type '())))
      (let ((peer (instantiate::%canvas-image
		     (%canvas canvas)
		     (%bglk-object o)
		     (%builtin ci))))
	 (%canvas-add-item! canvas o)
	 peer)))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-widget ...                                         */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-widget o::%bglk-object canvas::%bglk-object)
  (let* ((group (%canvas-%group (%bglk-object-%peer canvas)))
	 (type (%%gnome-canvas-widget-get-type))
	 (opt (list "x" 0.0 "y" 0.0))
	 (ci (%%bglk-canvas-item-new group type opt)))
    (let ((peer (instantiate::%canvas-widget
		 (%canvas canvas)
		 (%bglk-object o)
		 (%builtin ci))))
      (%canvas-add-item! canvas o)
      peer)))

;*---------------------------------------------------------------------*/
;*    %register-canvas-item-callback! ...                              */
;*---------------------------------------------------------------------*/
(define (%register-canvas-item-callback! o::%bglk-object evt::symbol obj)
   (with-access::%canvas-item (%bglk-object-%peer o) (%callbacks)
      (set! %callbacks (cons (cons evt obj) %callbacks))))

;*---------------------------------------------------------------------*/
;*    %unregister-canvas-item-callback! ...                            */
;*---------------------------------------------------------------------*/
(define (%unregister-canvas-item-callback! o::%bglk-object evt::symbol)
   (with-access::%canvas-item (%bglk-object-%peer o) (%callbacks)
      (let ((cell (assq evt %callbacks)))
	 (if (pair? cell)
	     (set! %callbacks (remq! cell %callbacks))))))

;*---------------------------------------------------------------------*/
;*    %registered-canvas-item-callback ...                             */
;*---------------------------------------------------------------------*/
(define (%registered-canvas-item-callback o evt proc)
   (with-access::%canvas-item (%bglk-object-%peer o) (%callbacks)
      (let ((cell (assq evt %callbacks)))
	 (if (pair? cell)
	     (cdr cell)
	     (begin
		(warning "%registered-canvas-item-callback"
			 "Can't find callback -- "
			 evt)
		#f)))))

;*---------------------------------------------------------------------*/
;*    %canvas-figure-color ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-figure-color o::%bglk-object)
   (with-access::%canvas-figure (%bglk-object-%peer o) (%fill-color)
      ;; the gnome "fill_color" field is write only (!!!), so
      ;; we can't try to read it, we have to store its value by
      ;; ourselves
      %fill-color))

;*---------------------------------------------------------------------*/
;*    %canvas-figure-color-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-figure-color-set! o::%bglk-object v)
   (with-access::%canvas-figure (%bglk-object-%peer o) (%fill-color)
      (set! %fill-color v)
      (g-property-set! o "fill_color" (biglook-color->rgb-string v))))

;*---------------------------------------------------------------------*/
;*    %canvas-item-width ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-item-width::int o::%bglk-object)
   (inexact->exact (g-property-get o "width")))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-width-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-item-width-set! o::%bglk-object v::int)
   (g-property-set! o "width" (fixnum->flonum v)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-height ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-item-height::int o::%bglk-object)
   (if (%canvas-line? (%bglk-object-%peer o))
       -1
       (inexact->exact (g-property-get o "height"))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-height-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-item-height-set! o::%bglk-object v::int)
   (g-property-set! o "height" (fixnum->flonum v)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-tooltips ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-item-tooltips o::%bglk-object)
   #f)
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-tooltips-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-item-tooltips-set! o::%bglk-object v)
   #unspecified)
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-visible ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-item-visible o::%bglk-object)
   (let ((ci (gnomecanvasitem (%peer-%builtin (%bglk-object-%peer o)))))
      (%%bglk-gnome-canvas-item-visible ci)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-visible-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-item-visible-set! o::%bglk-object v)
   (let ((ci (gnomecanvasitem (%peer-%builtin (%bglk-object-%peer o)))))
      (if v
	  (begin
	     (%%gnome-canvas-item-show ci)
	     ci)
	  (begin
	     (%%gnome-canvas-item-hide ci)
	     ci))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-text-x ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-text-x::int o::%bglk-object)
   (flonum->fixnum (g-property-get o "x")))

;*---------------------------------------------------------------------*/
;*    %canvas-text-x-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-x-set! o::%bglk-object v::int)
   (g-property-set! o "x" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-text-y ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-text-y::int o::%bglk-object)
   (flonum->fixnum (g-property-get o "y")))

;*---------------------------------------------------------------------*/
;*    %canvas-text-y-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-y-set! o::%bglk-object v::int)
   (g-property-set! o "y" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-text-text ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-text-text::bstring o::%bglk-object)
   (g-property-get o "text"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-text-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-text-text-set! o::%bglk-object v::bstring)
  (g-property-set! o "text" v))

;*---------------------------------------------------------------------*/
;*    %canvas-text-font ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-text-font o::%bglk-object)
   (with-access::%canvas-text (%bglk-object-%peer o) (%font)
      ;; the gnome "font" field is write only (!!!), so
      ;; we can't try to read it, we have to store its value by
      ;; ourselves
      %font))

;*---------------------------------------------------------------------*/
;*    %canvas-text-font-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-text-font-set! o::%bglk-object v)
  (define (weight->int weight)
    (case weight
      ((*) 0)
      ((bold) 1)
      ((medium) 2)
      (else (error "canvas-text-font-set!" "Illegal weight" weight))))
  (define (slant->int slant)
    (case slant
      ((*) 0)
      ((roman) 1)
      ((italic) 2)
      ((oblique) 3)
      (else (error "canvas-text-font-set!" "Illegal slant" slant))))

   (with-access::%canvas-text (%bglk-object-%peer o) (%font)
      (set! %font v)
      (with-access::%font v (family weight slant width size)
	 (%%gnome-canvas-text-font-set! (gobject (%peer-%builtin (%bglk-object-%peer o))) 
					family
					(symbol->string width)
					(weight->int weight)
					(slant->int slant)
					size)))
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %canvas-text-anchor ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-anchor o::%bglk-object)
   (gtk-anchor->biglook (g-property-get o "anchor")))

;*---------------------------------------------------------------------*/
;*    %canvas-text-anchor-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-text-anchor-set! o::%bglk-object v)
   (g-property-type-set! o "anchor" (biglook-anchor->gtk v) GTK-TYPE-ANCHOR-TYPE))

;*---------------------------------------------------------------------*/
;*    %canvas-text-justification ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-text-justification o::%bglk-object)
   (gtk-justify->biglook (g-property-get o "justification")))

;*---------------------------------------------------------------------*/
;*    %canvas-text-justification-set! ...                              */
;*---------------------------------------------------------------------*/
(define (%canvas-text-justification-set! o::%bglk-object v)
   (g-property-set! o "justification" (biglook-justify->gtk v)))

;*---------------------------------------------------------------------*/
;*    %canvas-text-color ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-text-color o::%bglk-object)
   (%canvas-figure-color o))

;*---------------------------------------------------------------------*/
;*    %canvas-text-color-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-text-color-set! o::%bglk-object v)
   (%canvas-figure-color-set! o v))

;*---------------------------------------------------------------------*/
;*    %canvas-text-width ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-text-width o::%bglk-object)
   (inexact->exact (g-property-get o "text-width")))

;*---------------------------------------------------------------------*/
;*    %canvas-text-width-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-text-width-set! o::%bglk-object v)
   (g-property-set! o "clip-width" (exact->inexact v)))

;*---------------------------------------------------------------------*/
;*    %canvas-text-height ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-height o::%bglk-object)
   (inexact->exact (g-property-get o "text-height")))

;*---------------------------------------------------------------------*/
;*    %canvas-text-height-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-text-height-set! o::%bglk-object v)
   (g-property-set! o "clip-height" (exact->inexact v)))

;*---------------------------------------------------------------------*/
;*    %canvas-geometry-color ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-color o::%bglk-object)
   (%canvas-figure-color o))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-color-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-color-set! o::%bglk-object v)
   (%canvas-figure-color-set! o v))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline o::%bglk-object)
   (if (%canvas-line? (%bglk-object-%peer o))
       #unspecified
       (rgb-string-color->biglook (g-property-get o "outline-color"))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-set! o::%bglk-object v)
   (g-property-set! o "outline-color" (biglook-color->rgb-string v)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-width ...                               */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-width o::%bglk-object)
   (if (%canvas-line? (%bglk-object-%peer o))
       0
       (g-property-get o "width-pixels")))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-width-set! ...                          */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-width-set! o::%bglk-object v)
   (g-property-set! o "width-pixels" v))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-width ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-width o::%bglk-object)
   -1)
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-width-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-width-set! o::%bglk-object v)
   (g-property-set! o "width-pixels" v))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-x ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-x o::%bglk-object)
   (flonum->fixnum (g-property-get o "x1")))
   
;*---------------------------------------------------------------------*/
;*    %canvas-shape-x-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-x-set! o::%bglk-object v)
   (g-property-set! o "x1" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-y ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-y o::%bglk-object)
   (flonum->fixnum (g-property-get o "y1")))
   
;*---------------------------------------------------------------------*/
;*    %canvas-shape-y-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-y-set! o::%bglk-object v)
   (g-property-set! o "y1" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-width ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-width o::%bglk-object)
   (absfx (-fx (flonum->fixnum (g-property-get o "x2"))
	       (flonum->fixnum (g-property-get o "x1")))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-shape-width-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-width-set! o::%bglk-object v)
   (if (<=fx v 0)
       (g-property-set! o "x2" (g-property-get o "x1"))
       (g-property-set! o "x2"		     
			(-fl (+fl (g-property-get o "x1") (fixnum->flonum v)) 1.))))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-height ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-height o::%bglk-object)
   (absfx (-fx (flonum->fixnum (g-property-get o "y2"))
	       (flonum->fixnum (g-property-get o "y1")))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-shape-height-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-height-set! o::%bglk-object v)
   (if (<=fx v 0)
       (g-property-set! o "y2" (g-property-get o "y1"))
       (g-property-set! o
			"y2"
			(-fl (+fl (g-property-get o "y1") (fixnum->flonum v)) 1.))))

;*---------------------------------------------------------------------*/
;*    %canvas-line-x ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-line-x o::%bglk-object)
   (let ((pts (%canvas-line-points o)))
      (if (pair? pts)
	  (car (%canvas-line-points o))
	  -1)))

;*---------------------------------------------------------------------*/
;*    %canvas-line-x-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-line-x-set! o::%bglk-object v)
   (let* ((old-x (%canvas-line-x o))
	  (delta-x (-fx v old-x)))
      (%canvas-item-move o delta-x 0)))

;*---------------------------------------------------------------------*/
;*    %canvas-line-y ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-line-y o::%bglk-object)
   (let ((pts (%canvas-line-points o)))
      (if (pair? pts)
	  (car (%canvas-line-points o))
	  -1)))

;*---------------------------------------------------------------------*/
;*    %canvas-line-y-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-line-y-set! o::%bglk-object v)
   (let* ((old-y (%canvas-line-y o))
	  (delta-y (-fx v old-y)))
      (%canvas-item-move o 0 delta-y)))

;*---------------------------------------------------------------------*/
;*    %canvas-line-points ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-line-points o::%bglk-object)
   (let ((l (%bglk-g-property-get (gobject (%peer-%builtin (%bglk-object-%peer o)))
				  "points")))
      (if (not (pair? l))
	  '()
	  l)))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-points-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-line-points-set! o::%bglk-object v)
   (g-property-type-set! o "points" v GNOME-TYPE-CANVAS-POINTS))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-thickness ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-line-thickness o::%bglk-object)
   -1)
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-thickness-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-line-thickness-set! o::%bglk-object v)
   (g-property-set! o "width-units" (fixnum->flonum v)))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow o::%bglk-object)
   (let ((first (g-property-get o "first-arrowhead"))
	 (last (g-property-get o "last-arrowhead")))
      (if first
	  (if last '<-> '<-)
	  (if last '-> '-))))

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-set! o::%bglk-object v)
   (case v
      ((<->)
       (g-property-set! o "first-arrowhead" #t)
       (g-property-set! o "last-arrowhead" #t))
      ((<-)
       (g-property-set! o "first-arrowhead" #t)
       (g-property-set! o "last-arrowhead" #f))
      ((->)
       (g-property-set! o "first-arrowhead" #f)
       (g-property-set! o "last-arrowhead" #t))
      ((-)
       (g-property-set! o "first-arrowhead" #f)
       (g-property-set! o "last-arrowhead" #f))
      (else
       (error "line-arrow-set!"
	      "Illegal arrow configuration (should be <-, <->, -> or -"
	      v))))

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-shape ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-shape o::%bglk-object)
   (list (g-property-get o "arrow-shape-a")
	 (g-property-get o "arrow-shape-b")
	 (g-property-get o "arrow-shape-c")))
	      
;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-shape-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-shape-set! o::%bglk-object v)
   (match-case v
      ((?a ?b ?c)
       (g-property-set! o "arrow-shape-a" (exact->inexact a))
       (g-property-set! o "arrow-shape-b" (exact->inexact b))
       (g-property-set! o "arrow-shape-c" (exact->inexact c)))
      (else
       (error "canvas-line-arrow-shape-set!" "Illegal arrow shape" v))))

;*---------------------------------------------------------------------*/
;*    %canvas-line-style ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-line-style o::%bglk-object)
   (let ((style (g-property-get o "line-style")))
      (if (=fx style %%gdk-line-solid)
	  'solid
	  (if (=fx style %%gdk-line-on-off-dash)
	      'dotted
	      'dashed))))

;*---------------------------------------------------------------------*/
;*    %canvas-line-style-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-style-set! o::%bglk-object v)
   (case v
      ((solid)
       (g-property-type-set! o
			     "line-style"
			     %%gdk-line-solid
			     %%gtk-type-gdk-line-style))
      ((dotted)
       (g-property-type-set! o
			     "line-style"
			     %%gdk-line-on-off-dash
			     %%gtk-type-gdk-line-style))
      ((dashed)
       (g-property-type-set! o
			     "line-style"
			     %%gdk-line-double-dash
			     %%gtk-type-gdk-line-style))
      (else
       (error "line-style-set!" "Illegal style value" v))))

;*---------------------------------------------------------------------*/
;*    %canvas-line-cap-style ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-line-cap-style o::%bglk-object)
   (let ((style (g-property-get o "cap-style")))
      (if (=fx style %%gdk-cap-not-last)
	  'not-last
	  (if (=fx style %%gdk-cap-butt)
	      'butt
	      (if (=fx style %%gdk-cap-projecting)
		  'projecting
		  'none)))))
	      
;*---------------------------------------------------------------------*/
;*    %canvas-line-cap-style-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-line-cap-style-set! o::%bglk-object v)
   (case v
      ((not-last)
       (g-property-type-set! o
			     "cap-style"
			     %%gdk-cap-not-last
			     %%gtk-type-gdk-cap-style))
      ((butt)
       (g-property-type-set! o
			     "cap-style"
			     %%gdk-cap-butt
			     %%gtk-type-gdk-cap-style))
      ((round)
       (g-property-type-set! o
			     "cap-style"
			     %%gdk-cap-round
			     %%gtk-type-gdk-cap-style))
      ((projecting)
       (g-property-type-set! o
			     "cap-style"
			     %%gdk-cap-projecting
			     %%gtk-type-gdk-cap-style))
      (else
       (error "cap-style-set!" "Illegal style value" v))))
	      
;*---------------------------------------------------------------------*/
;*    %canvas-line-join-style ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-join-style o::%bglk-object)
   (let ((style (g-property-get o "cap-style")))
      (if (=fx style %%gdk-join-miter)
	  'miter
	  (if (=fx style %%gdk-join-round)
	      'round
	      'bevel))))
	      
;*---------------------------------------------------------------------*/
;*    %canvas-line-join-style-set! ...                                 */
;*---------------------------------------------------------------------*/
(define (%canvas-line-join-style-set! o::%bglk-object v)
   (case v
      ((miter)
       (g-property-type-set! o
			     "join-style"
			     %%gdk-join-miter
			     %%gtk-type-gdk-join-style))
      ((round)
       (g-property-type-set! o
			     "join-style"
			     %%gdk-join-round
			     %%gtk-type-gdk-join-style))
      ((bevel)
       (g-property-type-set! o
			     "join-style"
			     %%gdk-join-bevel
			     %%gtk-type-gdk-join-style))
      (else
       (error "join-style-set!" "Illegal style value" v))))

;*---------------------------------------------------------------------*/
;*    %canvas-line-smooth? ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-line-smooth? o::%bglk-object)
   (g-property-get o "smooth"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-smooth?-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-line-smooth?-set! o::%bglk-object v)
   (g-property-set! o "smooth" v))

;*---------------------------------------------------------------------*/
;*    %canvas-line-spline-steps ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-line-spline-steps o::%bglk-object)
   (g-property-get o "spline-steps"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-spline-steps-set! ...                               */
;*---------------------------------------------------------------------*/
(define (%canvas-line-spline-steps-set! o::%bglk-object v)
   (g-property-set! o "spline-steps" v))

;*---------------------------------------------------------------------*/
;*    %canvas-image-x ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-image-x::int o::%bglk-object)
   (flonum->fixnum (g-property-get o "x")))

;*---------------------------------------------------------------------*/
;*    %canvas-image-x-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-x-set! o::%bglk-object v::int)
   (g-property-set! o "x" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-image-y ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-image-y::int o::%bglk-object)
   (flonum->fixnum (g-property-get o "y")))

;*---------------------------------------------------------------------*/
;*    %canvas-image-y-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-y-set! o::%bglk-object v::int)
   (g-property-set! o "y" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-image-image ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-image-image o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%image)
	 %image)))

;*---------------------------------------------------------------------*/
;*    %canvas-image-image-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-image-image-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%image)
	 (set! %image v)
	 (%%bglk-g-property-pixbuf-set! (%peer-%builtin %peer)
					"pixbuf"
					(%%bglk-image->pixbuf
					 (%peer-%builtin (%bglk-object-%peer v)))))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-width ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-image-width o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%image)
	 (%image-width %image))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-width-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-image-width-set! o::%bglk-object v::int)
   (g-property-set! o "width-set" #t)
   (g-property-set! o "width" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-image-height ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-height o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%image)
	 (%image-height %image))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-height-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-image-height-set! o::%bglk-object v::int)
   (g-property-set! o "height-set" #t)
   (g-property-set! o "height" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-widget ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-widget o::%bglk-object)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget)
      %widget))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-widget-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-widget-set! o::%bglk-object v)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget)
      (set! %widget v)
      (%%gnome-canvas-add-widget! (gobject (%peer-%builtin (%bglk-object-%peer o))) (bglkwidget (%bglk-object-%peer v))))
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %canvas-widget-x ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-x::int o::%bglk-object)
   (flonum->fixnum (g-property-get o "x")))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-x-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-x-set! o::%bglk-object v::int)
   (g-property-set! o "x" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-y ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-y::int o::%bglk-object)
   (flonum->fixnum (g-property-get o "y")))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-y-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-y-set! o::%bglk-object v::int)
   (g-property-set! o "y" (fixnum->flonum v)))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-width o::%bglk-object)
   (%canvas-item-width o))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-width-set! o::%bglk-object v::int)
   (%canvas-item-width-set! o v))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-height ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-height o::%bglk-object)
   (%canvas-item-height o))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-height-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-height-set! o::%bglk-object v::int)
   (%canvas-item-height-set! o v))

;*---------------------------------------------------------------------*/
;*    %canvas-item-destroy ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-item-destroy ci::%bglk-object)
   (with-access::%canvas-item (%bglk-object-%peer ci) (%canvas %builtin)
      (%canvas-remove-item! %canvas ci)
      (%%gtk-object-destroy %builtin)
      ci))

;*---------------------------------------------------------------------*/
;*    %canvas-item-raise ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-item-raise ci)
   (with-access::%canvas-item (%bglk-object-%peer ci) (%builtin)
      (%%gnome-canvas-item-raise-to-top (gnomecanvasitem %builtin))
      ci))

;*---------------------------------------------------------------------*/
;*    %canvas-item-lower ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-item-lower ci)
   (with-access::%canvas-item (%bglk-object-%peer ci) (%builtin)
      (%%gnome-canvas-item-lower-to-bottom (gnomecanvasitem %builtin))
      ci))

;*---------------------------------------------------------------------*/
;*    %canvas-item-move ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-item-move ci::%bglk-object deltax::int deltay::int)
   (with-access::%canvas-item (%bglk-object-%peer ci) (%builtin)
      (%%gnome-canvas-item-move (gnomecanvasitem %builtin)
				(fixnum->flonum deltax)
				(fixnum->flonum deltay))
      ci))
