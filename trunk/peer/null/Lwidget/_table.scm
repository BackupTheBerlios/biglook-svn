;*=====================================================================*/
;*    null/Lwidget/_table.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri Apr 16 11:58:50 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Table implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/table.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%table
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error)

   (static (class %table::%peer))
   
   (export (%make-%table ::%bglk-object ::pair ::procedure ::procedure
			 ::obj ::obj)
	   
	   (%table-rows::int ::%bglk-object)
	   (%table-rows-set! ::%bglk-object ::int)
	   
	   (%table-row-height::int ::%bglk-object)
	   (%table-row-height-set! ::%bglk-object ::int)

	   (%table-shadow::symbol ::%bglk-object)
	   (%table-shadow-set! ::%bglk-object ::symbol)

	   (%table-row-background ::%bglk-object)
	   (%table-row-background-set! ::%bglk-object ::procedure)

	   (%table-row-foreground ::%bglk-object)
	   (%table-row-foreground-set! ::%bglk-object ::procedure)

	   (%table-column-width::pair ::%bglk-object)
	   (%table-column-width-set! ::%bglk-object ::pair)

	   (%table-select-mode::symbol ::%bglk-object)
	   (%table-select-mode-set! ::%bglk-object ::symbol)

	   (%table-value-changed ::%bglk-object)
	   (%table-value-changed-set! ::%bglk-object ::procedure)

	   (%table-command ::%bglk-object)
	   (%table-command-set! ::%bglk-object ::procedure)

	   (%table-cell-value ::%bglk-object ::int ::int)
	   (%table-cell-value-set! ::%bglk-object ::int ::int ::obj)

	   (%table-coords->row ::%bglk-object ::int ::int)
	   (%table-coords->column ::%bglk-object ::int ::int)
	   ))

;*---------------------------------------------------------------------*/
;*    %make-%table ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%table o::%bglk-object columns cell-value cell-editable? t f)
   (not-implemented o "%make-%table"))

;*---------------------------------------------------------------------*/
;*    %table-rows ...                                                  */
;*---------------------------------------------------------------------*/
(define (%table-rows o::%bglk-object)
   (not-implemented o "%table-rows"))

;*---------------------------------------------------------------------*/
;*    %table-rows-set! ...                                             */
;*    -------------------------------------------------------------    */
;*    Update the rows of a table, that is remove some rows or add      */
;*    some rows.                                                       */
;*---------------------------------------------------------------------*/
(define (%table-rows-set! o::%bglk-object v)
   (not-implemented o "%table-rows-set!"))

;*---------------------------------------------------------------------*/
;*    %table-row-height ...                                            */
;*---------------------------------------------------------------------*/
(define (%table-row-height o::%bglk-object)
   (not-implemented o "%table-row-height"))

;*---------------------------------------------------------------------*/
;*    %table-row-height-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%table-row-height-set! o::%bglk-object v)
   (not-implemented o "%table-row-height-set!"))

;*---------------------------------------------------------------------*/
;*    %table-shadow ...                                                */
;*---------------------------------------------------------------------*/
(define (%table-shadow::symbol o::%bglk-object)
   (not-implemented o "%table-shadow"))

;*---------------------------------------------------------------------*/
;*    %table-shadow-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%table-shadow-set! o::%bglk-object v::symbol)
   (not-implemented o "%table-shadow-set!"))

;*---------------------------------------------------------------------*/
;*    %table-row-background ...                                        */
;*---------------------------------------------------------------------*/
(define (%table-row-background o::%bglk-object)
   (not-implemented o "%table-row-background"))

;*---------------------------------------------------------------------*/
;*    %table-row-background-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%table-row-background-set! o::%bglk-object v::procedure)
   (not-implemented o "%table-row-background-set!"))

;*---------------------------------------------------------------------*/
;*    %table-row-foreground ...                                        */
;*---------------------------------------------------------------------*/
(define (%table-row-foreground o::%bglk-object)
   (not-implemented o "%table-row-foreground"))

;*---------------------------------------------------------------------*/
;*    %table-row-foreground-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%table-row-foreground-set! o::%bglk-object v::procedure)
   (not-implemented o "%table-row-foreground-set!"))

;*---------------------------------------------------------------------*/
;*    %table-column-width ...                                          */
;*---------------------------------------------------------------------*/
(define (%table-column-width::pair o::%bglk-object)
   (not-implemented o "%table-column-width"))

;*---------------------------------------------------------------------*/
;*    %table-column-width-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%table-column-width-set! o::%bglk-object v::pair)
   (not-implemented o "%table-column-width-set!"))

;*---------------------------------------------------------------------*/
;*    %table-select-mode ...                                           */
;*---------------------------------------------------------------------*/
(define (%table-select-mode::symbol o::%bglk-object)
   (not-implemented o "%table-select-mode"))

;*---------------------------------------------------------------------*/
;*    %table-select-mode-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%table-select-mode-set! o::%bglk-object v::symbol)
   (not-implemented o "%table-select-mode-set!"))

;*---------------------------------------------------------------------*/
;*    %table-command ...                                               */
;*---------------------------------------------------------------------*/
(define (%table-command o::%bglk-object)
   (not-implemented o "%table-command"))

;*---------------------------------------------------------------------*/
;*    %table-command-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%table-command-set! o::%bglk-object v::procedure)
   (not-implemented o "%table-command-set!"))

;*---------------------------------------------------------------------*/
;*    %table-value-changed ...                                         */
;*---------------------------------------------------------------------*/
(define (%table-value-changed o::%bglk-object)
   (not-implemented o "%table-value-changed"))

;*---------------------------------------------------------------------*/
;*    %table-value-changed-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%table-value-changed-set! o::%bglk-object v::procedure)
   (not-implemented o "%table-value-changed-set!"))

;*---------------------------------------------------------------------*/
;*    %table-cell-value ...                                            */
;*---------------------------------------------------------------------*/
(define (%table-cell-value o::%bglk-object column::int row::int)
   (not-implemented o "%table-cell-value"))

;*---------------------------------------------------------------------*/
;*    %table-cell-value-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%table-cell-value-set! o::%bglk-object column::int row::int val)
   (not-implemented o "%table-cell-value-set!"))

;*---------------------------------------------------------------------*/
;*    %table-coords->row ...                                           */
;*---------------------------------------------------------------------*/
(define (%table-coords->row o::%bglk-object x::int y::int)
   (not-implemented o "%table-cell->row"))

;*---------------------------------------------------------------------*/
;*    %table-coords->column ...                                        */
;*---------------------------------------------------------------------*/
(define (%table-coords->column o::%bglk-object x::int y::int)
   (not-implemented o "%table-cell->column"))