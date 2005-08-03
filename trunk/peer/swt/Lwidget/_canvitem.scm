;*=====================================================================*/
;*    swt/Lwidget/_canvitem.scm                                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:42:08 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Canvas items implementation.                      */
;*    definition: @path ../../../biglook/Lwidget/canvitem.scm@         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%canvas-item
   
   (import __biglook_%peer
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%canvas
	   __biglook_%container
	   __biglook_%font
	   __biglook_%color
	   __biglook_%image)
   
   (static (abstract-class %canvas-figure::%canvas-item
	      (%x::float (default 0.0))
	      (%y::float (default 0.0))
	      (%fill-color (default (swing-default-color)))
	      (%visible::bool (default #t)))
	   
	   ;; text
	   (class %canvas-text::%canvas-figure
	      (%actual-x::float (default 0.0))
	      (%actual-y::float (default 0.0))
	      (%text::bstring (default ""))
	      (%font (default (swing-default-font)))
	      (%anchor::symbol (default 'c))
	      (%justification::symbol (default 'left)))
	   
	   ;; line
	   (class %canvas-line::%canvas-figure
	      %stroke::%awt-stroke
	      (%shapes::pair-nil (default '())))
	   
	   ;; rectangle
	   (class %canvas-rectangle::%canvas-figure
	      %stroke::%awt-stroke
	      (%outline-color (default (swing-default-color))))

	   ;; ellipse
	   (class %canvas-ellipse::%canvas-figure
	      %stroke::%awt-stroke
	      (%outline-color (default (swing-default-color))))

	   ;; image
	   (class %canvas-image::%canvas-figure
	      (%width (default #f))
	      (%height (default #f)))

	   ;; widget
	   (class %canvas-widget::%canvas-figure
	      (%widget (default #unspecified))))
   
   (export (%make-%canvas-text ::%bglk-object ::%bglk-object)
	   (%make-%canvas-line ::%bglk-object ::%bglk-object)
	   (%make-%canvas-polygon  ::%bglk-object ::%bglk-object)
	   (%make-%canvas-ellipse ::%bglk-object ::%bglk-object)
	   (%make-%canvas-rectangle ::%bglk-object ::%bglk-object)
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
	   
	   (%canvas-item-tooltips::obj ::%bglk-object)
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
;*    Swing default configuration ...                                  */
;*---------------------------------------------------------------------*/
(define *default-font* #unspecified)
(define *default-swing-font* #unspecified)
(define *default-color* #unspecified)
(define *default-swing-color* #unspecified)
(define *default-textlayout* #unspecified)
(define *default-stroke* #unspecified)

;*---------------------------------------------------------------------*/
;*    swing-default-font ...                                           */
;*---------------------------------------------------------------------*/
(define (swing-default-font)
   (if (not (%font? *default-font*))
       (begin
	  (set! *default-font*
		(instantiate::%font))
	  (set! *default-swing-font*
		(%biglook-font->swing *default-font*))))
   *default-swing-font*)

;*---------------------------------------------------------------------*/
;*    swing-default-color ...                                          */
;*---------------------------------------------------------------------*/
(define (swing-default-color)
   (if (not (%color? *default-color*))
       (begin
	  (set! *default-color*
		(instantiate::%name-color
		   (%name "black")))
	  (set! *default-swing-color*
		(biglook-color->swing *default-color*))))
   *default-swing-color*)

;*---------------------------------------------------------------------*/
;*    %peer-init ::%canvas-figure ...                                  */
;*---------------------------------------------------------------------*/
(define-method (%peer-init o::%canvas-figure)
   (call-next-method))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-text ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-text o::%bglk-object canvas::%bglk-object)
   (with-access::%bglk-object canvas (%peer)
      (with-access::%canvas %peer (children)
	 (set! children (cons o children)))
      (let* ((graphics (%awt-component-graphics (%peer-%builtin %peer)))
	     (graphics-2D::%awt-graphics2D graphics)
	     (fontrender (%awt-graphics2D-fontrender graphics-2D)))
	 (if (eq? *default-textlayout* #unspecified)
	     (set! *default-textlayout*
		   (%awt-textlayout-new 
		    (%bglk-bstring->jstring "Default TextLayout")
		    (swing-default-font)
		    fontrender)))
	 (instantiate::%canvas-text
	    (%canvas canvas)
	    (%bglk-object o)
	    (%builtin *default-textlayout*)))))

;*---------------------------------------------------------------------*/
;*    %canvas-item-draw ::%canvas-text ...                             */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-draw ci::%canvas-text g::%awt-graphics)
   (with-access::%canvas-text ci (%builtin
				  %actual-x %actual-y
				  %fill-color %font
				  %visible)
      (if (and %visible (%awt-graphics2D? g))
	  (begin
	     (%awt-graphics-font-set! g %font)
	     (%awt-graphics-color-set! g %fill-color)
	     (%awt-textlayout-draw %builtin g %actual-x %actual-y)
	     ci)
	  ci)))

;*---------------------------------------------------------------------*/
;*    %canvas-item-contains? ::%canvas-text ...                        */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-contains?::bool o::%canvas-text x::int y::int)
   (with-access::%canvas-text o (%actual-x %actual-y %builtin)
      (let* ((bounds (%awt-textlayout-getbounds %builtin))
	     (width (flonum->fixnum (%awt-rectangle2D-width bounds)))
	     (height (flonum->fixnum (%awt-rectangle2D-height bounds)))
	     (ax (flonum->fixnum %actual-x))
	     (ay (flonum->fixnum %actual-y)))
	 (and (>=fx x ax) (<=fx x (+fx ax width))
	      (>=fx y (-fx ay height)) (<=fx y ay)))))
		      
;*---------------------------------------------------------------------*/
;*    %make-%canvas-line ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-line o::%bglk-object canvas)
   (if (eq? *default-stroke* #unspecified)
       (set! *default-stroke* (%awt-basicstroke-new)))
   (with-access::%bglk-object canvas (%peer)
      (with-access::%canvas %peer (children)
	 (set! children (cons o children)))
      (instantiate::%canvas-line
	 (%canvas canvas)
	 (%bglk-object o)
	 (%stroke *default-stroke*)
	 (%builtin (%awt-line2D-double-new)))))

;*---------------------------------------------------------------------*/
;*    %canvas-item-draw ::%canvas-line ...                             */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-draw ci::%canvas-line g::%awt-graphics)
   (with-access::%canvas-line ci (%shapes %fill-color %stroke %visible)
      (cond
	 ((%awt-graphics2D? g)
	  (if %visible
	      (begin
		 (%awt-graphics-color-set! g %fill-color)
		 (%awt-graphics2D-stroke-set! g %stroke)
		 (for-each (lambda (l::%awt-shape)
			      (%awt-graphics2D-shape-draw g l)
			      l)
			   %shapes)
		 ci)))
	 (else
	  (warning "%canvas-item-draw(line)"
		   "Can't draw on graphics"
		   (find-runtime-type g))
	  ci))))

;*---------------------------------------------------------------------*/
;*    %canvas-item-contains? ::%canvas-line ...                        */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-contains?::bool o::%canvas-line x::int y::int)
   (let ((dx (fixnum->flonum x))
	 (dy (fixnum->flonum y)))
      (with-access::%canvas-line o (%shapes)
	 (let loop ((lines %shapes))
	    (cond
	       ((null? lines)
		#f)
	       ((<fl (%awt-line2D-segment-distance (car lines) dx dy) 1.)
		#t)
	       (else
		(loop (cdr lines))))))))
		      
;*---------------------------------------------------------------------*/
;*    %make-%canvas-polygon ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-polygon o::%bglk-object canvas)
   (not-implemented o "%make-%canvas-polygon"))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-ellipse ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-ellipse o::%bglk-object canvas)
   (if (eq? *default-stroke* #unspecified)
       (set! *default-stroke* (%awt-basicstroke-new)))
   (with-access::%bglk-object canvas (%peer)
      (with-access::%canvas %peer (children)
	 (set! children (cons o children)))
      (instantiate::%canvas-ellipse
	 (%canvas canvas)
	 (%bglk-object o)
	 (%stroke *default-stroke*)
	 (%builtin (%awt-ellipse2D-double-new)))))

;*---------------------------------------------------------------------*/
;*    %canvas-item-contains? ::%canvas-ellipse ...                     */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-contains?::bool o::%canvas-ellipse x y)
   (with-access::%canvas-ellipse o (%builtin)
      (%awt-ellipse2D-double-contains %builtin
				      (fixnum->flonum x)
				      (fixnum->flonum y))))
		      
;*---------------------------------------------------------------------*/
;*    %canvas-item-draw ::%canvas-ellipse ...                          */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-draw ci::%canvas-ellipse g::%awt-graphics)
   (with-access::%canvas-ellipse ci (%builtin
				     %fill-color %outline-color
				     %stroke %visible)
      (cond
	 ((%awt-graphics2D? g)
	  (if %visible
	      (begin
		 (%awt-graphics-color-set! g %outline-color)
		 (%awt-graphics2D-stroke-set! g %stroke)
		 (%awt-graphics2D-shape-draw g %builtin)
		 (%awt-graphics-color-set! g %fill-color)
		 (%awt-graphics2D-shape-fill g %builtin)
		 ci)))
	 (else
	  (warning "%canvas-item-draw(ellipse)"
		   "Can't draw on graphics"
		   (find-runtime-type g))
	  ci))))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-rectangle ...                                      */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-rectangle o::%bglk-object canvas)
   (if (eq? *default-stroke* #unspecified)
       (set! *default-stroke* (%awt-basicstroke-new)))
   (with-access::%bglk-object canvas (%peer)
      (with-access::%canvas %peer (children)
	 (set! children (cons o children)))
      (instantiate::%canvas-rectangle
	 (%canvas canvas)
	 (%bglk-object o)
	 (%stroke *default-stroke*)
	 (%builtin (%awt-rectangle2D-double-new)))))

;*---------------------------------------------------------------------*/
;*    %canvas-item-contains? ::%canvas-rectangle ...                   */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-contains?::bool o::%canvas-rectangle x y)
   (with-access::%canvas-rectangle o (%builtin)
      (%awt-rectangle2D-double-contains %builtin
					(fixnum->flonum x)
					(fixnum->flonum y))))
		      
;*---------------------------------------------------------------------*/
;*    %canvas-item-draw ::%canvas-rectangle ...                        */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-draw ci::%canvas-rectangle g::%awt-graphics)
   (with-access::%canvas-rectangle ci (%builtin
				       %fill-color %outline-color
				       %stroke %visible)
      (cond
	 ((%awt-graphics2D? g)
	  (if %visible
	      (begin
		 (%awt-graphics-color-set! g %outline-color)
		 (%awt-graphics2D-stroke-set! g %stroke)
		 (%awt-graphics2D-shape-draw g %builtin)
		 (%awt-graphics-color-set! g %fill-color)
		 (%awt-graphics2D-shape-fill g %builtin)
		 ci)))
	 (else
	  (warning "%canvas-item-draw(rectangle)"
		   "Can't draw on graphics"
		   (find-runtime-type g))
	  ci))))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-image ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-image o::%bglk-object canvas::%bglk-object)
   (with-access::%canvas (%bglk-object-%peer canvas) (children)
      (set! children (cons o children)))
   (instantiate::%canvas-image
      (%canvas canvas)
      (%bglk-object o)
      ;; the %builtin field is fake, this value will be changed as soon
      ;; as an image will be associated to this canvas-image
      (%builtin (%peer-%builtin (%bglk-object-%peer canvas)))))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-widget ...                                         */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-widget o::%bglk-object canvas::%bglk-object)
   (with-access::%canvas (%bglk-object-%peer canvas) (children)
      (set! children (cons o children)))
   (instantiate::%canvas-widget
      (%canvas canvas)
      (%bglk-object o)
      ;; the %builtin field is fake, this value will be changed as soon
      ;; as an image will be associated to this canvas-image
      (%builtin (%peer-%builtin (%bglk-object-%peer canvas)))))

;*---------------------------------------------------------------------*/
;*    %register-canvas-item-callback! ...                              */
;*---------------------------------------------------------------------*/
(define (%register-canvas-item-callback! o::%bglk-object evt::symbol obj)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %unregister-canvas-item-callback! ...                            */
;*---------------------------------------------------------------------*/
(define (%unregister-canvas-item-callback! o::%bglk-object evt::symbol)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %registered-canvas-item-callback ...                             */
;*---------------------------------------------------------------------*/
(define (%registered-canvas-item-callback o evt proc)
   proc)

;*---------------------------------------------------------------------*/
;*    %canvas-item-draw ::%canvas-image ...                            */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-draw ci::%canvas-image g::%awt-graphics)
   (with-access::%canvas-image ci (%builtin
				   %canvas
				   %x %y
				   %width %height
				   %visible)
      (if (and %visible
	       (%awt-graphics2D? g)
	       (%swing-imageicon? %builtin))
	  (if (and (not (fixnum? %width)) (not (fixnum? %height)))
	      (begin
		 (%awt-graphics-image-draw g
					   (%swing-imageicon-image %builtin)
					   (flonum->fixnum %x)
					   (flonum->fixnum %y)
					   (%canvas-%builtin
					    (%bglk-object-%peer %canvas)))
		 ci)
	      (begin
		 (%awt-graphics-scale-image-draw g
						 (%swing-imageicon-image %builtin)
						 (flonum->fixnum %x)
						 (flonum->fixnum %y)
						 (if (fixnum? %width)
						     %width
						     (%swing-imageicon-width
						      %builtin))
						 (if (fixnum? %height)
						     %height
						     (%swing-imageicon-height
						      %builtin))
						 (%canvas-%builtin
						  (%bglk-object-%peer %canvas)))
		 ci))
	  ci)))

;*---------------------------------------------------------------------*/
;*    %canvas-item-contains? ::%canvas-image ...                       */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-contains?::bool o::%canvas-image x::int y::int)
   (with-access::%canvas-image o (%x %y %builtin)
      (and (%swing-imageicon? %builtin)
	   (let* ((width (%swing-imageicon-width %builtin))
		  (height (%swing-imageicon-height %builtin))
		  (ax (flonum->fixnum %x))
		  (ay (flonum->fixnum %y)))
	      (and (>=fx x ax) (<=fx x (+fx ax width))
		   (>=fx y ay) (<=fx y (+fx ay height)))))))

;*---------------------------------------------------------------------*/
;*    %canvas-item-draw ::%canvas-widget ...                           */
;*---------------------------------------------------------------------*/
(define-method (%canvas-item-draw ci::%canvas-widget g::%awt-graphics)
   #unspecified)
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-width ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-item-width::int o::%bglk-object)
   (not-implemented o "%canvas-figure-width"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-width-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-item-width-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-figure-width-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-height ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-item-height::int o::%bglk-object)
   (not-implemented o "%canvas-figure-height"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-height-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-item-height-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-figure-height-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-tooltips ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-item-tooltips o::%bglk-object)
   (not-implemented o "%canvas-figure-tooltips"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-tooltips-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-item-tooltips-set! o::%bglk-object v)
   (not-implemented o "%canvas-figure-tooltips-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-visible ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-item-visible o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-figure %peer (%visible)
	 %visible)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-visible-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-item-visible-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-figure %peer (%visible)
	 (set! %visible v))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-text-x ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-text-x::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-figure %peer (%x)
	 (inexact->exact %x))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-text-x-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-x-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%actual-x %anchor %x %canvas)
	 (set! %x (exact->inexact v))
	 (let ((width (fixnum->flonum (%canvas-text-width o)))
	       (lv (fixnum->flonum v)))
	    (case %anchor
	       ((center)
		(set! %actual-x (-fl lv (/fl width 2.0))))
	       ((c)
		(set! %actual-x (-fl lv (/fl width 2.0))))
	       ((n)
		(set! %actual-x (-fl lv (/fl width 2.0))))
	       ((s)
		(set! %actual-x (-fl lv (/fl width 2.0))))
	       ((nw)
		(set! %actual-x lv))
	       ((w)
		(set! %actual-x lv))
	       ((sw)
		(set! %actual-x lv))
	       (else
		(set! %actual-x (-fl lv width)))))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-text-y ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-text-y::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%y)
	 (inexact->exact %y))))

;*---------------------------------------------------------------------*/
;*    %canvas-text-y-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-y-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%actual-y %anchor %y %canvas)
	 (set! %y (exact->inexact v))
	 (let ((height (fixnum->flonum (%canvas-text-height o)))
	       (lv (fixnum->flonum v)))
	    (case %anchor
	       ((center)
		(set! %actual-y (+fl lv (/fl height 2.0))))
	       ((c)
		(set! %actual-y (+fl lv (/fl height 2.0))))
	       ((e)
		(set! %actual-y (+fl lv (/fl height 2.0))))
	       ((w)
		(set! %actual-y (+fl lv (/fl height 2.0))))
	       ((nw)
		(set! %actual-y lv))
	       ((n)
		(set! %actual-y lv))
	       ((ne)
		(set! %actual-y lv))
	       (else
		(set! %actual-y (+fl lv height)))))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-text-text ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-text-text::bstring o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%text)
	 %text)))

;*---------------------------------------------------------------------*/
;*    %canvas-text-text-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-text-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%builtin %text %font %canvas)
	 (set! %text v)
	 (let* ((canvas (%canvas-%builtin (%bglk-object-%peer %canvas)))
		(graphics (%awt-component-graphics canvas))
		(graphics-2D::%awt-graphics2D graphics)
		(fontrender (%awt-graphics2D-fontrender graphics-2D))
		(textlayout (%awt-textlayout-new (%bglk-bstring->jstring %text)
						 %font
						 fontrender)))
	    (set! %builtin textlayout)))))
 
;*---------------------------------------------------------------------*/
;*    %canvas-text-font ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-text-font o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%font)
	 (%swing-font->biglook %font))))

;*---------------------------------------------------------------------*/
;*    %canvas-text-font-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-text-font-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%builtin %text %font %canvas)
	 (set! %font (%biglook-font->swing v))
	 (let* ((canvas (%canvas-%builtin (%bglk-object-%peer %canvas)))
		(graphics (%awt-component-graphics canvas))
		(graphics-2D::%awt-graphics2D graphics)
		(fontrender (%awt-graphics2D-fontrender graphics-2D))
		(textlayout (%awt-textlayout-new (%bglk-bstring->jstring %text)
						 %font
						 fontrender)))
	    (set! %builtin textlayout)))))

;*---------------------------------------------------------------------*/
;*    %canvas-text-anchor ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-anchor o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%anchor)
	 %anchor)))

;*---------------------------------------------------------------------*/
;*    %canvas-text-anchor-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-text-anchor-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%anchor %x %y)
	 (set! %anchor v)
	 ;; recompute actual-x and actual-y from the new anchor
	 (%canvas-text-x-set! o (flonum->fixnum %x))
	 (%canvas-text-y-set! o (flonum->fixnum %y)))))

;*---------------------------------------------------------------------*/
;*    %canvas-text-justification ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-text-justification o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%justification)
	 %justification)))

;*---------------------------------------------------------------------*/
;*    %canvas-text-justification-set! ...                              */
;*---------------------------------------------------------------------*/
(define (%canvas-text-justification-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%justification)
	 (set! %justification v))))

;*---------------------------------------------------------------------*/
;*    %canvas-text-color ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-text-color o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%fill-color)
	 (swing-color->biglook %fill-color))))

;*---------------------------------------------------------------------*/
;*    %canvas-text-color-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-text-color-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%fill-color %canvas %text)
	 (set! %fill-color (biglook-color->swing v))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))

;*---------------------------------------------------------------------*/
;*    %canvas-text-width ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-text-width o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%builtin)
	 (flonum->fixnum
	  (%awt-rectangle2D-width
	   (%awt-textlayout-getbounds %builtin))))))

;*---------------------------------------------------------------------*/
;*    %canvas-text-width-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-text-width-set! o::%bglk-object v)
   (not-implemented o "%canvas-text-width-set!"))
 
;*---------------------------------------------------------------------*/
;*    %canvas-text-height ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-height o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-text %peer (%builtin)
	 (flonum->fixnum
	  (%awt-rectangle2D-height
	   (%awt-textlayout-getbounds %builtin))))))

;*---------------------------------------------------------------------*/
;*    %canvas-text-height-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-text-height-set! o::%bglk-object v)
   (not-implemented o "%canvas-text-height-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-geometry-color ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-color o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-figure %peer (%fill-color)
	 (swing-color->biglook %fill-color))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-color-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-color-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-figure %peer (%fill-color %canvas)
	 (set! %fill-color (biglook-color->swing v))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (cond
	 ((%canvas-rectangle? %peer)
	  (swing-color->biglook (%canvas-rectangle-%outline-color %peer)))
	 ((%canvas-ellipse? %peer)
	  (swing-color->biglook (%canvas-ellipse-%outline-color %peer)))
	 (else
	  #unspecified))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (cond
	 ((%canvas-rectangle? %peer)
	  (%canvas-rectangle-%outline-color-set! %peer
						 (biglook-color->swing v)))
	 ((%canvas-ellipse? %peer)
	  (%canvas-ellipse-%outline-color-set! %peer
					       (biglook-color->swing v)))
	 (else
	  #unspecified))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-width ...                               */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-width o::%bglk-object)
   1)
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-width-set! ...                          */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-width-set! o::%bglk-object v)
   #unspecified)
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-width ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-width o::%bglk-object)
   (not-implemented o "%canvas-geometry-width"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-width-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-width-set! o::%bglk-object v)
   (not-implemented o "%canvas-geometry-width-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-x ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-x o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (cond
	 ((%canvas-rectangle? %peer)
	  (flonum->fixnum
	   (%awt-rectangle2D-double-getX (%peer-%builtin %peer))))
	 ((%canvas-ellipse? %peer)
	  (flonum->fixnum
	   (%awt-ellipse2D-double-getX (%peer-%builtin %peer))))
	 (else
	  (error "%canvas-shape-x" "Illegal shape" %peer)))))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-x-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-x-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-item %peer (%builtin %canvas)
	 (cond
	    ((%canvas-rectangle? %peer)
	     (%canvas-rectangle-%x-set! %peer (exact->inexact v))
	     (%awt-rectangle2D-double-set-rectangle
	      %builtin
	      (fixnum->flonum v)
	      (%awt-rectangle2D-double-getY %builtin)
	      (%awt-rectangle2D-double-getWidth %builtin)
	      (%awt-rectangle2D-double-getHeight %builtin))
	     v)
	    ((%canvas-ellipse? %peer)
	     (%canvas-ellipse-%x-set! %peer (exact->inexact v))
	     (%awt-ellipse2D-double-set-ellipse
	      %builtin
	      (fixnum->flonum v)
	      (%awt-ellipse2D-double-getY %builtin)
	      (%awt-ellipse2D-double-getWidth %builtin)
	      (%awt-ellipse2D-double-getHeight %builtin))
	     v)
	    (else
	     (error "%canvas-shape-x-set!" "Illegal shape" o)))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-y ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-y o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (cond
	 ((%canvas-rectangle? %peer)
	  (flonum->fixnum
	   (%awt-rectangle2D-double-getY (%peer-%builtin %peer))))
	 ((%canvas-ellipse? %peer)
	  (flonum->fixnum
	   (%awt-ellipse2D-double-getY (%peer-%builtin %peer))))
	 (else
	  (error "%canvas-shape-y" "Illegal shape" o)))))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-y-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-y-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-item %peer (%builtin %canvas)
	 (cond
	    ((%canvas-rectangle? %peer)
	     (%canvas-rectangle-%y-set! %peer (exact->inexact v))
	     (%awt-rectangle2D-double-set-rectangle
	      %builtin
	      (%awt-rectangle2D-double-getX %builtin)
	      (fixnum->flonum v)
	      (%awt-rectangle2D-double-getWidth %builtin)
	      (%awt-rectangle2D-double-getHeight %builtin))
	     v)
	    ((%canvas-ellipse? %peer)
	     (%canvas-ellipse-%y-set! %peer (exact->inexact v))
	     (%awt-ellipse2D-double-set-ellipse
	      %builtin
	      (%awt-ellipse2D-double-getX %builtin)
	      (fixnum->flonum v)
	      (%awt-ellipse2D-double-getWidth %builtin)
	      (%awt-ellipse2D-double-getHeight %builtin))
	     v)
	    (else
	     (error "%canvas-shape-y-set!" "Illegal shape" o)))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-width ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-width o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (cond
	 ((%canvas-rectangle? %peer)
	  (flonum->fixnum
	   (%awt-rectangle2D-double-getWidth (%peer-%builtin %peer))))
	 ((%canvas-ellipse? %peer)
	  (flonum->fixnum
	   (%awt-ellipse2D-double-getWidth (%peer-%builtin %peer))))
	 (else
	  (error "%canvas-shape-width" "Illegal shape" o)))))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-width-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-width-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (cond
	    ((%canvas-rectangle? %peer)
	     (%awt-rectangle2D-double-set-rectangle
	      %builtin
	      (%awt-rectangle2D-double-getX %builtin)
	      (%awt-rectangle2D-double-getY %builtin)
	      (fixnum->flonum v)
	      (%awt-rectangle2D-double-getHeight %builtin))
	     v)
	    ((%canvas-ellipse? %peer)
	     (%awt-ellipse2D-double-set-ellipse
	      %builtin
	      (%awt-ellipse2D-double-getX %builtin)
	      (%awt-ellipse2D-double-getY %builtin)
	      (fixnum->flonum v)
	      (%awt-ellipse2D-double-getHeight %builtin))
	     v)
	    (else
	     (error "%canvas-shape-width-set!" "Illegal shape" o))))))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-height ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-height o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (cond
	 ((%canvas-rectangle? %peer)
	  (flonum->fixnum
	   (%awt-rectangle2D-double-getHeight (%peer-%builtin %peer))))
	 ((%canvas-ellipse? %peer)
	  (flonum->fixnum
	   (%awt-ellipse2D-double-getHeight (%peer-%builtin %peer))))
	 (else
	  (error "%canvas-shape-height" "Illegal shape" o)))))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-height-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-height-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (cond
	    ((%canvas-rectangle? %peer)
 	     (%awt-rectangle2D-double-set-rectangle
	      %builtin
	      (%awt-rectangle2D-double-getX %builtin)
	      (%awt-rectangle2D-double-getY %builtin)
	      (%awt-rectangle2D-double-getWidth %builtin)
	      (fixnum->flonum v))
	     v)
	    ((%canvas-ellipse? %peer)
	     (%awt-ellipse2D-double-set-ellipse
	      %builtin
	      (%awt-ellipse2D-double-getX %builtin)
	      (%awt-ellipse2D-double-getY %builtin)
	      (%awt-ellipse2D-double-getWidth %builtin)
	      (fixnum->flonum v))
	     #unspecified)
	    (else
	     (error "%canvas-shape-height-set!" "Illegal shape" o))))))

;*---------------------------------------------------------------------*/
;*    %canvas-line-x ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-line-x o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-line %peer (%shapes)
	 (if (null? %shapes)
	     -1
	     (flonum->fixnum
	      (%awt-line2D-double-getX2 (car (last-pair %shapes))))))))
   
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
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-line %peer (%shapes)
	 (if (null? %shapes)
	     -1
	     (flonum->fixnum
	      (%awt-line2D-double-getY2 (car (last-pair %shapes))))))))
   
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
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-line %peer (%shapes)
	 (cond
	    ((null? %shapes)
	     '())
	    ((null? (cdr %shapes))
	     (list (%awt-line2D-double-getX1 (car %shapes))
		   (%awt-line2D-double-getY1 (car %shapes))
		   (%awt-line2D-double-getX2 (car %shapes))
		   (%awt-line2D-double-getY2 (car %shapes))))
	    (else
	     (let loop ((lines (cdr %shapes))
			(res (list (%awt-line2D-double-getX2 (car %shapes))
				   (%awt-line2D-double-getY2 (car %shapes)))))
		(if (null? (cdr lines))
		    (cons* (%awt-line2D-double-getX1 (car lines))
			   (%awt-line2D-double-getY1 (car lines))
			   res)
		    (loop (cdr lines)
			  (cons* (%awt-line2D-double-getX2 (car lines))
				 (%awt-line2D-double-getY2 (car lines))
				 res)))))))))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-points-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-line-points-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-line %peer (%shapes %canvas)
	 (if (null? v)
	     (set! %shapes '())
	     (let loop ((points (cddddr v))
			(x0::double (fixnum->flonum (car v)))
			(y0::double (fixnum->flonum (cadr v)))
			(x1::double (fixnum->flonum (caddr v)))
			(y1::double (fixnum->flonum (cadddr v)))
			(lines '()))
		(let ((line (%awt-line2D-double-new)))
		   (%awt-line2D-set! line x0 y0 x1 y1)
		   (if (null? points)
		       (begin
			  (set! %shapes (cons line lines))
			  (%awt-component-repaint
			   (%peer-%builtin (%bglk-object-%peer %canvas)))
			  o)
		       (let ((new-x0 x1)
			     (new-y0 y1))
			  (loop (cddr points)
				new-x0
				new-y0
				(fixnum->flonum (car points))
				(fixnum->flonum (cadr points))
				(cons line lines))))))))))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-thickness ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-line-thickness o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-line %peer (%stroke)
	 (flonum->fixnum (%awt-basicstroke-line-width %stroke)))))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-thickness-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-line-thickness-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-line %peer (%stroke %canvas)
	 (set! %stroke (%awt-basicstroke-width-new (fixnum->flonum v)))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 o)))

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow o::%bglk-object)
   'none)

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-arrow-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-shape ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-shape o::%bglk-object)
   '())

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-shape-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-shape-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-arrow-shape-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-style ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-line-style o::%bglk-object)
   'plain)

;*---------------------------------------------------------------------*/
;*    %canvas-line-style-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-style-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-style-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-cap-style ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-line-cap-style o::%bglk-object)
   'plain)

;*---------------------------------------------------------------------*/
;*    %canvas-line-cap-style-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-line-cap-style-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-cap-style-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-join-style ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-join-style o::%bglk-object)
   'plain)

;*---------------------------------------------------------------------*/
;*    %canvas-line-join-style-set! ...                                 */
;*---------------------------------------------------------------------*/
(define (%canvas-line-join-style-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-join-style-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-smooth? ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-line-smooth? o::%bglk-object)
   #t)

;*---------------------------------------------------------------------*/
;*    %canvas-line-smooth?-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-line-smooth?-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-smooth?-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-spline-steps ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-line-spline-steps o::%bglk-object)
   0)

;*---------------------------------------------------------------------*/
;*    %canvas-line-spline-steps-set! ...                               */
;*---------------------------------------------------------------------*/
(define (%canvas-line-spline-steps-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-spline-steps-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-image-x ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-image-x o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%x)
	 (inexact->exact %x))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-x-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-x-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%x %canvas)
	 (set! %x (fixnum->flonum v))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))

;*---------------------------------------------------------------------*/
;*    %canvas-image-y ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-image-y o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%y)
	 (inexact->exact %y))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-y-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-y-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%y %canvas)
	 (set! %y (fixnum->flonum v))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))

;*---------------------------------------------------------------------*/
;*    %canvas-image-image ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-image-image o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%builtin)
	 (if (%awt-image? %builtin)
	     %builtin
	     #f))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-image-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-image-image-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%builtin %canvas)
	 (set! %builtin (%image-%icon (%bglk-object-%peer v)))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 o)))

;*---------------------------------------------------------------------*/
;*    %canvas-image-width ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-image-width o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%width)
	 (if (fixnum? %width)
	     %width
	     (%image-width o)))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-width-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-image-width-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%width)
	 (set! %width v))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-height ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-height o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%height)
	 (if (fixnum? %height)
	     %height
	     (%image-height o)))))

;*---------------------------------------------------------------------*/
;*    %canvas-image-height-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-image-height-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-image %peer (%height)
	 (set! %height v))))

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
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget %canvas)
      (if (%bglk-object? %widget)
	  ;; remove the former widget
	  (%container-remove! %canvas %widget))
      (set! %widget v)
      (%container-add! %canvas v)
      (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
      v))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-x ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-x::int o::%bglk-object)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget)
      (with-access::%peer (%bglk-object-%peer %widget) (%builtin)
	 (%awt-component-x %builtin))))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-x-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-x-set! o::%bglk-object v::int)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget %canvas)
      (with-access::%peer (%bglk-object-%peer %widget) (%builtin)
	 (%awt-component-location-set! %builtin v (%awt-component-y %builtin))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-y ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-y::int o::%bglk-object)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget)
      (with-access::%peer (%bglk-object-%peer %widget) (%builtin)
	 (%awt-component-y %builtin))))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-y-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-y-set! o::%bglk-object v::int)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget %canvas)
      (with-access::%peer (%bglk-object-%peer %widget) (%builtin)
	 (%awt-component-location-set! %builtin (%awt-component-x %builtin) v)
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 v)))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-width::int o::%bglk-object)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget)
      (with-access::%peer (%bglk-object-%peer %widget) (%builtin)
	 (%awt-component-width %builtin))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-widget-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-width-set! o::%bglk-object v::int)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget)
      (with-access::%peer (%bglk-object-%peer %widget) (%builtin)
	 (%awt-component-size-set! %builtin
				   v
				   (%awt-component-height %builtin))
	 v)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-widget-height ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-height::int o::%bglk-object)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget)
      (with-access::%peer (%bglk-object-%peer %widget) (%builtin)
	 (%awt-component-height %builtin))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-widget-height-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-height-set! o::%bglk-object v::int)
   (with-access::%canvas-widget (%bglk-object-%peer o) (%widget)
      (with-access::%peer (%bglk-object-%peer %widget) (%builtin)
	 (%awt-component-size-set! %builtin
				   (%awt-component-width %builtin)
				   v)
	 v)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-destroy ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-item-destroy ci::%bglk-object)
   (with-access::%bglk-object ci (%peer)
      (with-access::%canvas-item %peer (%canvas)
	 (with-access::%canvas (%bglk-object-%peer %canvas) (children
							     motion-items
							     release-items
							     press-items
							     enter-items
							     leave-items
							     key-items)
	    (set! children (remq! ci children))
	    (set! motion-items (remq! ci motion-items))
	    (set! release-items (remq! ci release-items))
	    (set! press-items (remq! ci press-items))
	    (set! enter-items (remq! ci enter-items))
	    (set! leave-items (remq! ci leave-items))
	    (set! key-items (remq! ci key-items))
	    (%awt-component-repaint
	     (%peer-%builtin (%bglk-object-%peer %canvas)))
	    ci))))

;*---------------------------------------------------------------------*/
;*    %canvas-item-raise ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-item-raise ci)
   (with-access::%bglk-object ci (%peer)
      (with-access::%canvas-item %peer (%canvas)
	 (with-access::%canvas (%bglk-object-%peer %canvas) (children)
	    (if (pair? (cdr children))
		;; if there is exactly one child in the canvas,
		;; raising it is useless
		(begin
		   (set! children (remq! ci children))
		   (set-cdr! (last-pair children) (cons ci '())))))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 ci)))

;*---------------------------------------------------------------------*/
;*    %canvas-item-lower ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-item-lower ci)
   (with-access::%bglk-object ci (%peer)
      (with-access::%canvas-item %peer (%canvas)
	 (with-access::%canvas (%bglk-object-%peer %canvas) (children)
	    (if (pair? (cdr children))
		;; if there is exactly one child in the canvas,
		;; raising it is useless
		(begin
		   (set! children (remq! ci children))
		   (set! children (cons ci children)))))
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 ci)))

;*---------------------------------------------------------------------*/
;*    %canvas-item-move ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-item-move ci::%bglk-object deltax::int deltay::int)
   (move-item (%bglk-object-%peer ci) ci deltax deltay))

;*---------------------------------------------------------------------*/
;*    move-item ...                                                    */
;*---------------------------------------------------------------------*/
(define-generic (move-item %ci::%canvas-item ci deltax::int deltay::int)
   (warning "Illegal move item -- " (find-runtime-type ci)))

;*---------------------------------------------------------------------*/
;*    move-item ::%canvas-text ...                                     */
;*---------------------------------------------------------------------*/
(define-method (move-item %ci::%canvas-text ci deltax deltay)
   (with-access::%canvas-text %ci (%x %y %canvas)
      (%canvas-text-x-set! ci (+fx (flonum->fixnum %x) deltax))
      (%canvas-text-y-set! ci (+fx (flonum->fixnum %y) deltay))
      (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
      ci))
      
;*---------------------------------------------------------------------*/
;*    move-item ::%canvas-line ...                                     */
;*---------------------------------------------------------------------*/
(define-method (move-item %ci::%canvas-line ci deltax deltay)
   (with-access::%canvas-line %ci (%shapes %canvas)
      (let ((dx (fixnum->flonum deltax))
	    (dy (fixnum->flonum deltay)))
	 (for-each (lambda (l::%awt-line2D-double)
		      (%awt-line2D-set! l
					(+fl dx (%awt-line2D-double-getX1 l))
					(+fl dy (%awt-line2D-double-getY1 l))
					(+fl dx (%awt-line2D-double-getX2 l))
					(+fl dy (%awt-line2D-double-getY2 l)))
		      l)
		   %shapes)
	 ;; we have to force a repaint
	 (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
	 ci)))

;*---------------------------------------------------------------------*/
;*    move-item ::%canvas-image ...                                    */
;*---------------------------------------------------------------------*/
(define-method (move-item %ci::%canvas-image ci deltax deltay)
   (with-access::%canvas-image %ci (%x %y %canvas)
      (%canvas-image-x-set! ci (+fx (flonum->fixnum %x) deltax))
      (%canvas-image-y-set! ci (+fx (flonum->fixnum %y) deltay))
      ;; we have to force a repaint
      (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
      ci))
      
;*---------------------------------------------------------------------*/
;*    move-item ::%canvas-widget ...                                   */
;*---------------------------------------------------------------------*/
(define-method (move-item %ci::%canvas-widget ci deltax deltay)
   (with-access::%canvas-widget %ci (%x %y %canvas)
      (%canvas-widget-x-set! ci (+fx (flonum->fixnum %x) deltax))
      (%canvas-widget-y-set! ci (+fx (flonum->fixnum %y) deltay))
      ;; we have to force a repaint
      (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
      ci))
     
;*---------------------------------------------------------------------*/
;*    move-item ::%canvas-rectangle ...                                */
;*---------------------------------------------------------------------*/
(define-method (move-item %ci::%canvas-rectangle ci deltax deltay)
   (with-access::%canvas-rectangle %ci (%x %y %canvas)
      (%canvas-shape-x-set! ci (+fx (flonum->fixnum %x) deltax))
      (%canvas-shape-y-set! ci (+fx (flonum->fixnum %y) deltay))
      ;; we have to force a repaint
      (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
      ci))

;*---------------------------------------------------------------------*/
;*    move-item ::%canvas-ellipse ...                                  */
;*---------------------------------------------------------------------*/
(define-method (move-item %ci::%canvas-ellipse ci deltax deltay)
   (with-access::%canvas-ellipse %ci (%x %y %canvas)
      (%canvas-shape-x-set! ci (+fx (flonum->fixnum %x) deltax))
      (%canvas-shape-y-set! ci (+fx (flonum->fixnum %y) deltay))
      ;; we have to force a repaint
      (%awt-component-repaint (%peer-%builtin (%bglk-object-%peer %canvas)))
      ci))
     

      

