;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/canvitem.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Sun Sep  8 14:10:15 2002 (serrano)                */
;*    Copyright   :  2000-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Canvas item widgets                                      */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/canvitem.texi@                             */
;*       @node Canvas Items@                                           */
;*    Examples:                                                        */
;*       @path ../../examples/canvas/canvas.scm@                       */
;*    -------------------------------------------------------------    */
;*    Implementation: @label canvitem@                                 */
;*    null: @path ../../peer/null/Lwidget/_canvitem.scm@               */
;*    gtk: @path ../../peer/gtk/Lwidget/_canvitem.scm@                 */
;*    swing: @path ../../peer/swing/Lwidget/_canvitem.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_canvas-item
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_event
	    __biglook_font
	    __biglook_color
	    __biglook_canvas
	    __biglook_image)
   
   (export  (abstract-class canvas-item::widget
	       ;; parent
	       (parent
		(get (lambda (o)
			#unspecified))
		(set (lambda (o v)
			(error "canvas-item-parent-set!"
			       "Can't set parent (use the CANVAS field) instead"
			       o))))
	       ;; the dynamic position of the canvas item
	       (x::int
		(get (lambda (o) -1))
		(set (lambda (o v) #unspecified)))
	       (y::int
		(get (lambda (o) -1))
 		(set (lambda (o v) #unspecified)))
	       ;; width
	       (width::int
		(get %canvas-item-width)
		(set %canvas-item-width-set!))
	       ;; height
	       (height::int
		(get %canvas-item-height)
		(set %canvas-item-height-set!))
	       ;; color (abstract slot)
	       (color
		(get (lambda (o) #f))
		(set (lambda (o v) #unspecified)))
	       ;; tooltips
	       (tooltips
		(get %canvas-item-tooltips)
		(set %canvas-item-tooltips-set!))
	       ;; visible
	       (visible
		(get %canvas-item-visible)
		(set %canvas-item-visible-set!))
	       ;; canvas (actual canva-item parent)
	       canvas::canvas)
	    
	    (class canvas-text::canvas-item
	       ;; the dynamic position of the canvas-text
	       (x::int
		(get %canvas-text-x)
		(set %canvas-text-x-set!))
	       (y::int
		(get %canvas-text-y)
		(set %canvas-text-y-set!))
	       ;; the text of the canvas item
	       (text::bstring
		(get %canvas-text-text)
		(set %canvas-text-text-set!))
	       ;; font
	       (font::obj
		(get %canvas-text-font)
		(set %canvas-text-font-set!))
	       ;; anchor
	       (anchor::symbol
		(get %canvas-text-anchor)
		(set %canvas-text-anchor-set!))
	       ;; justification
	       (justification::symbol
		(get %canvas-text-justification)
		(set %canvas-text-justification-set!))
	       ;; color
	       (color::obj
		(get %canvas-text-color)
		(set %canvas-text-color-set!))
	       ;; width
	       (width::int
		(get %canvas-text-width)
		(set %canvas-text-width-set!))
	       ;; height
	       (height::int
		(get %canvas-text-height)
		(set %canvas-text-height-set!)))
	    
	    (class canvas-geometry::canvas-item
	       ;; color
	       (color::obj
		(get %canvas-geometry-color)
		(set %canvas-geometry-color-set!))
	       ;; outline
	       (outline::obj
		(get %canvas-geometry-outline)
		(set %canvas-geometry-outline-set!))
	       ;; outline-width
	       (outline-width::obj
		(get %canvas-geometry-outline-width)
		(set %canvas-geometry-outline-width-set!))
	       ;; width
	       (width::int
		(get %canvas-geometry-width)
		(set %canvas-geometry-width-set!)))
	    
	    (class canvas-line::canvas-geometry
	       ;; points of the line
	       (points::pair-nil
		(get %canvas-line-points)
		(set (lambda (o v)
			(let ((l (length v)))
			   (if (or (<fx l 4) (not (even? l)))
			       (error "canvas-line-set!"
				      "Illegal number of points"
				      v)
			       (%canvas-line-points-set! o v))))))
	       ;; thickness
	       (thickness::int
		(get %canvas-line-thickness)
		(set %canvas-line-thickness-set!))
	       ;; arrow (either both, none, first, last)
	       (arrow::symbol
		(get %canvas-line-arrow)
		(set %canvas-line-arrow-set!))
	       ;; arrow shape (a list of 3 numbers)
	       (arrow-shape::pair-nil
		(get %canvas-line-arrow-shape)
		(set %canvas-line-arrow-shape-set!))
	       ;; style (solid, dotted, dashed)
	       (style::symbol
		(get %canvas-line-style)
		(set %canvas-line-style-set!))
	       ;; cap style (not-last, butt, round, projecting)
	       (cap-style::symbol
		(get %canvas-line-cap-style)
		(set %canvas-line-cap-style-set!))
	       ;; join style (not-last, miter, round, bevel)
	       (join-style::symbol
		(get %canvas-line-join-style)
		(set %canvas-line-join-style-set!))
	       ;; smooth (a spline or a plain line)
	       (smooth?::bool
		(get %canvas-line-smooth?)
		(set %canvas-line-smooth?-set!))
	       ;; spline steps (this value is useful iff smooth? is set to #t)
	       (spline-steps::int
		(get %canvas-line-spline-steps)
		(set %canvas-line-spline-steps-set!)))

	    (class canvas-shape::canvas-geometry
	       ;; x
	       (x::int
		(get %canvas-shape-x)
		(set %canvas-shape-x-set!))
	       ;; y
	       (y::int
		(get %canvas-shape-y)
		(set %canvas-shape-y-set!))
	       ;; width
	       (width::int
		(get %canvas-shape-width)
		(set %canvas-shape-width-set!))
	       ;; height
	       (height::int
		(get %canvas-shape-height)
		(set %canvas-shape-height-set!)))

	    (class canvas-rectangle::canvas-shape)
	    
	    (class canvas-ellipse::canvas-shape)
	    
	    (class canvas-polygon::canvas-geometry)
	    
	    (class canvas-image::canvas-item
	       ;; width
	       (width::int
		(get %canvas-image-width)
		(set %canvas-image-width-set!))
	       ;; height
	       (height::int
		(get %canvas-image-height)
		(set %canvas-image-height-set!))
	       ;; the dynamic position of the canvas-text
	       (x::int
		(get %canvas-image-x)
		(set %canvas-image-x-set!))
	       (y::int
		(get %canvas-image-y)
		(set %canvas-image-y-set!))
	       ;; image
	       (image
		(get %canvas-image-image)
		(set (lambda (o v)
			(if (image? v)
			    (%canvas-image-image-set! o v)
			    (error "canvas-image-set!"
				   "Illegal image"
				   v))))))
	    
 	    (class canvas-widget::canvas-item
	       ;; the widget
	       (widget::widget
		(get %canvas-widget-widget)
		(set %canvas-widget-widget-set!))
	       ;; the dynamic position of the canvas-text
	       (x::int
		(get %canvas-widget-x)
		(set %canvas-widget-x-set!))
	       (y::int
		(get %canvas-widget-y)
		(set %canvas-widget-y-set!))
	       ;; the width
	       (width::int
		(get %canvas-widget-width)
		(set %canvas-widget-width-set!))
	       ;; the height
	       (height::int
		(get %canvas-widget-height)
		(set %canvas-widget-height-set!)))
	    
	    (canvas-item-move ::canvas-item ::int ::int)))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::canvas-item ...                               */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::canvas-item)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::canvas-text ...                               */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::canvas-text)
   (with-access::canvas-text o (%peer canvas)
      (set! %peer (%make-%canvas-text o canvas))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::canvas-line ...                               */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::canvas-line)
   (with-access::canvas-line o (%peer canvas)
      (set! %peer (%make-%canvas-line o canvas))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::canvas-rectangle ...                          */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::canvas-rectangle)
   (with-access::canvas-rectangle o (%peer canvas)
      (set! %peer (%make-%canvas-rectangle o canvas))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::canvas-ellipse ...                            */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::canvas-ellipse)
   (with-access::canvas-ellipse o (%peer canvas)
      (set! %peer (%make-%canvas-ellipse o canvas))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::canvas-image ...                              */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::canvas-image)
   (with-access::canvas-image o (%peer canvas)
      (set! %peer (%make-%canvas-image o canvas))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::canvas-widget ...                             */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::canvas-widget)
   (with-access::canvas-widget o (%peer canvas)
      (set! %peer (%make-%canvas-widget o canvas))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    install-callback! ::canvas-item ...                              */
;*---------------------------------------------------------------------*/
(define-method (install-callback! w::canvas-item evt::symbol proc)
   (cond
      ((procedure? proc)
       (%register-canvas-item-callback!
	w
	evt
	(%install-canvas-item-callback! w evt proc)))
      ((not proc)
       #unspecified)
      (else
       (error "install-callback!(canvas-item)"
	      "Illegal callback (should be #f or a procedure)"
	      proc))))

;*---------------------------------------------------------------------*/
;*    uninstall-callback! ::canvas-item ...                            */
;*---------------------------------------------------------------------*/
(define-method (uninstall-callback! w::canvas-item evt::symbol proc)
   (if (procedure? proc)
       (let ((cb (%registered-canvas-item-callback w evt proc)))
	  (%uninstall-canvas-item-callback! w evt cb)
	  (%unregister-canvas-item-callback! w evt))))

;*---------------------------------------------------------------------*/
;*    destroy ::canvas-item ...                                        */
;*---------------------------------------------------------------------*/
(define-method (destroy ci::canvas-item)
   (let ((oldv (canvas-item-event ci)))
      (if (event-handler? oldv)
	  (disconnect-event-handler! oldv ci)))
   (%canvas-item-destroy ci))

;*---------------------------------------------------------------------*/
;*    raise ...                                                        */
;*---------------------------------------------------------------------*/
(define-method (raise ci::canvas-item)
   (%canvas-item-raise ci))

;*---------------------------------------------------------------------*/
;*    lower ...                                                        */
;*---------------------------------------------------------------------*/
(define-method (lower ci::canvas-item)
   (%canvas-item-lower ci))

;*---------------------------------------------------------------------*/
;*    canvas-item-move ...                                             */
;*---------------------------------------------------------------------*/
(define (canvas-item-move ci deltax deltay)
   (%canvas-item-move ci deltax deltay))
