;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_grid.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri Jun  1 07:19:50 2001 (serrano)                */
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
	   __biglook_%peer
	   __biglook_%bglk-object)
   
   (static (class %grid::%peer))
	   
   (export (%make-%grid ::%bglk-object)
	   
	   (%grid-rows::int ::%bglk-object)
	   (%grid-rows-set! ::%bglk-object ::int)
	   
	   (%grid-columns::int ::%bglk-object)
	   (%grid-columns-set! ::%bglk-object ::int)
	   
	   (%grid-row-spacing::int ::%bglk-object)
	   (%grid-row-spacing-set! ::%bglk-object ::int)
	   
	   (%grid-column-spacing::int ::%bglk-object)
	   (%grid-column-spacing-set! ::%bglk-object ::int)
	   
	   (%grid-add! ::%bglk-object ::%bglk-object
		       ::int ::int ::int ::int
		       ::int ::int
		       ::bool ::obj)))

;*---------------------------------------------------------------------*/
;*    %make-%grid ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%grid o::%bglk-object)
   (not-implemented o "%make-%grid"))

;*---------------------------------------------------------------------*/
;*    %grid-rows ...                                                   */
;*---------------------------------------------------------------------*/
(define (%grid-rows::int o::%bglk-object)
   (not-implemented o "%grid-rows"))

;*---------------------------------------------------------------------*/
;*    %grid-rows-set! ...                                              */
;*---------------------------------------------------------------------*/
(define (%grid-rows-set! o::%bglk-object v::int)
   (not-implemented o "%grid-rows-set!"))

;*---------------------------------------------------------------------*/
;*    %grid-columns ...                                                */
;*---------------------------------------------------------------------*/
(define (%grid-columns::int o::%bglk-object)
   (not-implemented o "%grid-columns"))

;*---------------------------------------------------------------------*/
;*    %grid-columns-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%grid-columns-set! o::%bglk-object v::int)
   (not-implemented o "%grid-rows-set!"))

;*---------------------------------------------------------------------*/
;*    %grid-row-spacing ...                                            */
;*---------------------------------------------------------------------*/
(define (%grid-row-spacing::int o::%bglk-object)
   (not-implemented o "%grid-row-spacing"))

;*---------------------------------------------------------------------*/
;*    %grid-row-spacing-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%grid-row-spacing-set! o::%bglk-object v::int)
   (not-implemented o "%grid-row-spacing-set!"))

;*---------------------------------------------------------------------*/
;*    %grid-column-spacing ...                                         */
;*---------------------------------------------------------------------*/
(define (%grid-column-spacing::int o::%bglk-object)
   (not-implemented o "%grid-column-spacing"))

;*---------------------------------------------------------------------*/
;*    %grid-column-spacing-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%grid-column-spacing-set! o::%bglk-object v::int)
   (not-implemented o "%grid-column-spacing-set!"))

;*---------------------------------------------------------------------*/
;*    %grid-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%grid-add! container::%bglk-object widget::%bglk-object
		    column::int columnspan::int
		    row::int rowspan::int
		    padx::int pady::int
		    expand::bool fill::obj)
   (not-implemented container "%grid-add!"))

