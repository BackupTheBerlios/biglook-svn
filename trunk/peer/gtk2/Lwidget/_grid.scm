;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_grid.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Jun 14 15:03:34 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Label implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/grid.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%grid

   (import __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%color)

   (extern (macro %%gtk-grid-new::gtkwidget* (::int ::int ::bool)
		  "gtk_table_new")
	   (macro %%gtk-table-attach::void (::gtktable*
					    ::gtkwidget*
					    ::int ::int ::int ::int
					    ::int ::int ::int ::int)
		  "gtk_table_attach"))
					      
   (static (class %grid::%container))

   (export (%make-%grid ::%bglk-object)

	   (%grid-rows::int ::%bglk-object)
	   (%grid-rows-set! ::%bglk-object ::int)

	   (%grid-columns::int ::%bglk-object)
	   (%grid-columns-set! ::%bglk-object ::int)

	   (%grid-row-spacing::int ::%bglk-object)
	   (%grid-row-spacing-set! ::%bglk-object ::int)

	   (%grid-column-spacing::int ::%bglk-object)
	   (%grid-column-spacing-set! ::%bglk-object ::int)

	   (%grid-homogeneous::bool ::%bglk-object)
	   (%grid-homogeneous-set! ::%bglk-object ::bool)

	   (%grid-add! ::%bglk-object ::%bglk-object
		       ::int ::int ::int ::int
		       ::int ::int
		       ::bool ::obj)))

;*---------------------------------------------------------------------*/
;*    %make-%grid ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%grid o::%bglk-object)
   (instantiate::%grid
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-grid-new 1 1 #t)))))

;*---------------------------------------------------------------------*/
;*    %grid-rows ...                                                   */
;*---------------------------------------------------------------------*/
(define (%grid-rows::int o::%bglk-object)
   (g-property-get o "n-rows"))

;*---------------------------------------------------------------------*/
;*    %grid-rows-set! ...                                              */
;*---------------------------------------------------------------------*/
(define (%grid-rows-set! o::%bglk-object v::int)
   (g-property-set! o "n-rows" v))

;*---------------------------------------------------------------------*/
;*    %grid-columns ...                                                */
;*---------------------------------------------------------------------*/
(define (%grid-columns::int o::%bglk-object)
   (g-property-get o "n-columns"))

;*---------------------------------------------------------------------*/
;*    %grid-columns-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%grid-columns-set! o::%bglk-object v::int)
   (g-property-set! o "n-columns" v))

;*---------------------------------------------------------------------*/
;*    %grid-row-spacing ...                                            */
;*---------------------------------------------------------------------*/
(define (%grid-row-spacing::int o::%bglk-object)
   (g-property-get o "row-spacing"))

;*---------------------------------------------------------------------*/
;*    %grid-row-spacing-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%grid-row-spacing-set! o::%bglk-object v::int)
   (g-property-set! o "row-spacing" v))

;*---------------------------------------------------------------------*/
;*    %grid-column-spacing ...                                         */
;*---------------------------------------------------------------------*/
(define (%grid-column-spacing::int o::%bglk-object)
   (g-property-get o "column-spacing"))

;*---------------------------------------------------------------------*/
;*    %grid-column-spacing-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%grid-column-spacing-set! o::%bglk-object v::int)
   (g-property-set! o "column-spacing" v))

;*---------------------------------------------------------------------*/
;*    %grid-homogeneous ...                                            */
;*---------------------------------------------------------------------*/
(define (%grid-homogeneous::bool o::%bglk-object)
   (g-property-get o "homogeneous"))

;*---------------------------------------------------------------------*/
;*    %grid-homogeneous-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%grid-homogeneous-set! o::%bglk-object v::bool)
   (g-property-set! o "homogeneous" v))

;*---------------------------------------------------------------------*/
;*    gtk-attach-options ...                                           */
;*---------------------------------------------------------------------*/
(define (gtk-attach-options expand fill)
   (+ (if expand gtk-expand 0)
      (if fill (+ gtk-fill gtk-shrink) 0)))

;*---------------------------------------------------------------------*/
;*    %grid-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%grid-add! c::%bglk-object w::%bglk-object
		    column::int columnspan::int
		    row::int rowspan::int
		    padx::int pady::int
		    expand::bool fill::obj)
   (let ((attach-options-x (gtk-attach-options expand
					       (memq fill '(#t both x))))
	 (attach-options-y (gtk-attach-options expand
					       (memq fill '(#t both y)))))
      (with-access::%container (%bglk-object-%peer c) (%gc-children)
	 (set! %gc-children (cons w %gc-children)))
      (%%gtk-table-attach (bglktable (%bglk-object-%peer c))
			  (bglkwidget (%bglk-object-%peer w))
			  column (+fx column columnspan)
			  row (+fx row rowspan)
			  attach-options-x
			  attach-options-y
			  padx pady)
      c))
