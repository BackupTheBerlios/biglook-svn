;*=====================================================================*/
;*    null/Lwidget/_canvitem.scm                                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Oct 14 17:54:05 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Canvas items implementation.                       */
;*    definition: @path ../../../biglook/Lwidget/canvitem.scm@         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%canvas-item
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error)

   (export (%make-%canvas-text ::%bglk-object ::%bglk-object)
	   (%make-%canvas-line ::%bglk-object ::%bglk-object)
	   (%make-%canvas-polygon ::%bglk-object ::%bglk-object)
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

	   ;; canvas ellipse
	   (%canvas-ellipse-style::symbol ::%bglk-object)
	   (%canvas-ellipse-style-set! ::%bglk-object ::symbol)

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
;*    %make-%canvas-text ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-text o::%bglk-object canvas::%bglk-object)
   (not-implemented o "%make-%canvas-text"))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-line ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-line o::%bglk-object canvas::%bglk-object)
   (not-implemented o "%make-%canvas-line"))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-polygon ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-polygon o::%bglk-object canvas::%bglk-object)
   (not-implemented o "%make-%canvas-polygon"))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-ellipse ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-ellipse o::%bglk-object canvas::%bglk-object)
   (not-implemented o "%make-%canvas-ellipse"))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-rectangle ...                                      */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-rectangle o::%bglk-object canvas::%bglk-object)
   (not-implemented o "%make-%canvas-rectangle"))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-image ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-image o::%bglk-object canvas::%bglk-object)
   (not-implemented o "%make-%canvas-image"))

;*---------------------------------------------------------------------*/
;*    %make-%canvas-widget ...                                         */
;*---------------------------------------------------------------------*/
(define (%make-%canvas-widget o::%bglk-object canvas::%bglk-object)
   (not-implemented o "%make-%canvas-widget"))

;*---------------------------------------------------------------------*/
;*    %register-canvas-item-callback! ...                              */
;*---------------------------------------------------------------------*/
(define (%register-canvas-item-callback! o::%bglk-object evt::symbol obj)
   (not-implemented o "%register-canvas-item-callback!"))

;*---------------------------------------------------------------------*/
;*    %unregister-canvas-item-callback! ...                            */
;*---------------------------------------------------------------------*/
(define (%unregister-canvas-item-callback! o::%bglk-object evt::symbol)
   (not-implemented o "%register-canvas-item-callback!"))

;*---------------------------------------------------------------------*/
;*    %registered-canvas-item-callback ...                             */
;*---------------------------------------------------------------------*/
(define (%registered-canvas-item-callback o evt proc)
   (not-implemented o "%register-canvas-item-callback"))

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
   (not-implemented o "%canvas-item-tooltips"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-tooltips-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-item-tooltips-set! o::%bglk-object v)
   (not-implemented o "%canvas-item-tooltips-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-visible ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-item-visible o::%bglk-object)
   (not-implemented o "%canvas-item-visible"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-visible-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-item-visible-set! o::%bglk-object v)
   (not-implemented o "%canvas-item-visible-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-text-x ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-text-x::int o::%bglk-object)
   (not-implemented o "%canvas-text-x"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-x-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-x-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-text-x-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-y ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-text-y::int o::%bglk-object)
   (not-implemented o "%canvas-text-y"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-y-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-y-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-text-y-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-text ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-text-text::bstring o::%bglk-object)
   (not-implemented o "%canvas-text-text"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-text-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-text-text-set! o::%bglk-object v::bstring)
   (not-implemented o "%canvas-text-text-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-font ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-text-font o::%bglk-object)
   (not-implemented o "%canvas-text-font"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-font-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-text-font-set! o::%bglk-object v)
   (not-implemented o "%canvas-text-font-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-anchor ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-anchor o::%bglk-object)
   (not-implemented o "%canvas-text-anchor"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-anchor-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-text-anchor-set! o::%bglk-object v)
   (not-implemented o "%canvas-text-anchor-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-justification ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-text-justification o::%bglk-object)
   (not-implemented o "%canvas-text-justification"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-justification-set! ...                              */
;*---------------------------------------------------------------------*/
(define (%canvas-text-justification-set! o::%bglk-object v)
   (not-implemented o "%canvas-text-justification-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-color ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-text-color o::%bglk-object)
   (not-implemented o "%canvas-text-color"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-color-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-text-color-set! o::%bglk-object v)
   (not-implemented o "%canvas-text-color-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-width ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-text-width o::%bglk-object)
   (not-implemented o "%canvas-text-width"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-width-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-text-width-set! o::%bglk-object v)
   (not-implemented o "%canvas-text-width-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-height ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-text-height o::%bglk-object)
   (not-implemented o "%canvas-text-height"))

;*---------------------------------------------------------------------*/
;*    %canvas-text-height-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-text-height-set! o::%bglk-object v)
   (not-implemented o "%canvas-text-height-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-geometry-color ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-color o::%bglk-object)
   (not-implemented o "%canvas-geometry-color"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-color-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-color-set! o::%bglk-object v)
   (not-implemented o "%canvas-geometry-color-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline o::%bglk-object)
   (not-implemented o "%canvas-geometry-outline"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-set! o::%bglk-object v)
   (not-implemented o "%canvas-geometry-outline-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-width ...                               */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-width o::%bglk-object)
   (not-implemented o "%canvas-geometry-outline-width"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-geometry-outline-width-set! ...                          */
;*---------------------------------------------------------------------*/
(define (%canvas-geometry-outline-width-set! o::%bglk-object v)
   (not-implemented o "%canvas-geometry-outline-width-set!"))
   
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
   (not-implemented o "%canvas-shape-x"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-shape-x-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-x-set! o::%bglk-object v)
   (not-implemented o "%canvas-shape-x-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-y ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-y o::%bglk-object)
   (not-implemented o "%canvas-shape-y"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-shape-y-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-y-set! o::%bglk-object v)
   (not-implemented o "%canvas-shape-y-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-width ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-width o::%bglk-object)
   (not-implemented o "%canvas-shape-width"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-shape-width-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-width-set! o::%bglk-object v)
   (not-implemented o "%canvas-shape-width-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-shape-height ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-height o::%bglk-object)
   (not-implemented o "%canvas-shape-height"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-shape-height-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-shape-height-set! o::%bglk-object v)
   (not-implemented o "%canvas-shape-height-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-x ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-line-x o::%bglk-object)
   (not-implemented o "%canvas-line-x"))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-x-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-line-x-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-x"))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-y ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-line-y o::%bglk-object)
   (not-implemented o "%canvas-line-y"))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-y-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-line-y-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-y"))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-points ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-line-points o::%bglk-object)
   (not-implemented o "%canvas-line-points"))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-points-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-line-points-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-points"))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-thickness ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-line-thickness o::%bglk-object)
   (not-implemented o "%canvas-line-thickness"))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-thickness-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-line-thickness-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-thickness"))
	 
;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow o::%bglk-object)
   (not-implemented o "%canvas-line-arrow"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-arrow-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-shape ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-shape o::%bglk-object)
   (not-implemented o "%canvas-line-arrow-shape"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-arrow-shape-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%canvas-line-arrow-shape-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-arrow-shape-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-style ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-line-style o::%bglk-object)
   (not-implemented o "%canvas-line-style"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-style-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-style-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-style-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-ellipse-style ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-ellipse-style o::%bglk-object)
   (not-implemented o "%canvas-ellipse-style"))

;*---------------------------------------------------------------------*/
;*    %canvas-ellipse-style-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-ellipse-style-set! o::%bglk-object v)
   (not-implemented o "%canvas-ellipse-style-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-cap-style ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-line-cap-style o::%bglk-object)
   (not-implemented o "%canvas-line-cap-style"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-cap-style-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%canvas-line-cap-style-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-cap-style-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-join-style ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-line-join-style o::%bglk-object)
   (not-implemented o "%canvas-line-join-style"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-join-style-set! ...                                 */
;*---------------------------------------------------------------------*/
(define (%canvas-line-join-style-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-join-style-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-smooth? ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-line-smooth? o::%bglk-object)
   (not-implemented o "%canvas-line-smooth?"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-smooth?-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-line-smooth?-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-smooth?-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-spline-steps ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-line-spline-steps o::%bglk-object)
   (not-implemented o "%canvas-line-spline-steps"))

;*---------------------------------------------------------------------*/
;*    %canvas-line-spline-steps-set! ...                               */
;*---------------------------------------------------------------------*/
(define (%canvas-line-spline-steps-set! o::%bglk-object v)
   (not-implemented o "%canvas-line-spline-steps-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-image-image ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-image-image o::%bglk-object)
   (not-implemented o "%canvas-image-image"))

;*---------------------------------------------------------------------*/
;*    %canvas-image-image-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-image-image-set! o::%bglk-object v)
   (not-implemented o "%canvas-image-image"))

;*---------------------------------------------------------------------*/
;*    %canvas-image-width ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-image-width::int o::%bglk-object)
   (not-implemented o "%canvas-image-width"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-image-width-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-image-width-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-image-width-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-image-height ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-height::int o::%bglk-object)
   (not-implemented o "%canvas-image-height"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-image-height-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-image-height-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-image-height-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-image-x ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-image-x::int o::%bglk-object)
   (not-implemented o "%canvas-image-x"))

;*---------------------------------------------------------------------*/
;*    %canvas-image-x-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-x-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-image-x-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-image-y ...                                              */
;*---------------------------------------------------------------------*/
(define (%canvas-image-y::int o::%bglk-object)
   (not-implemented o "%canvas-image-y"))

;*---------------------------------------------------------------------*/
;*    %canvas-image-y-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-image-y-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-image-y-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-widget ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-widget o::%bglk-object)
   (not-implemented o "%canvas-widget-widget"))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-widget-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-widget-set! o::%bglk-object v)
   (not-implemented o "%canvas-widget-widget"))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-x ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-x::int o::%bglk-object)
   (not-implemented o "%canvas-widget-x"))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-x-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-x-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-widget-x-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-y ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-y::int o::%bglk-object)
   (not-implemented o "%canvas-widget-y"))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-y-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-y-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-widget-y-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-widget-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-width::int o::%bglk-object)
   (not-implemented o "%canvas-widget-width"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-widget-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-width-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-widget-width-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-widget-height ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-height::int o::%bglk-object)
   (not-implemented o "%canvas-widget-height"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-widget-height-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-widget-height-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-widget-height-set!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-destroy ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-item-destroy ci)
   (not-implemented ci "%canvas-item-destroy"))

;*---------------------------------------------------------------------*/
;*    %canvas-item-raise ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-item-raise ci)
   (not-implemented ci "%canvas-item-raise"))

;*---------------------------------------------------------------------*/
;*    %canvas-item-lower ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-item-lower ci)
   (not-implemented ci "%canvas-item-lower"))

;*---------------------------------------------------------------------*/
;*    %canvas-item-move ...                                            */
;*---------------------------------------------------------------------*/
(define (%canvas-item-move ci deltax deltay)
   (not-implemented ci "%canvas-item-move"))
