;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/grid.scm            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Apr  9 17:06:53 2001                          */
;*    Last change :  Thu Jun  7 10:39:39 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The grid layout manager                                          */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/grid.texi@                                 */
;*       @node Grid@                                                   */
;*    Examples:                                                        */
;*       @path ../../examples/grid/grid.scm@                           */
;*       @path ../../examples/fileselect/fileselect.scm@               */
;*    -------------------------------------------------------------    */
;*    Implementation: @label widget@                                   */
;*    null: @path ../../peer/null/Lwidget/_grid.scm@                   */
;*    gtk: @path ../../peer/gtk/Lwidget/_grid.scm@                     */
;*    swing: @path ../../peer/swing/Lwidget/_grid.scm@                 */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_grid
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_widget
	    __biglook_container)
   
   (export  (class grid::container
	       ;; last add
	       (%last::pair read-only (default (cons -1 0)))
	       ;; expand and fill
	       (expand::bool (default #t))
	       (fill (default 'both))
	       ;; rows
	       (rows::int
		(get %grid-rows)
		(set %grid-rows-set!))
	       ;; columns
	       (columns::int
		(get %grid-columns)
		(set %grid-columns-set!))
	       ;; padding
	       (padding::int
		(get %grid-row-spacing)
		(set (lambda (o v)
			(%grid-row-spacing-set! o v)
			(%grid-column-spacing-set! o v))))
	       ;; row spacing
	       (row-spacing::int
		(get %grid-row-spacing)
		(set %grid-row-spacing-set!))
	       ;; column spacing
	       (column-spacing::int
		(get %grid-column-spacing)
		(set %grid-column-spacing-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::grid ...                                      */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::grid)
   (with-access::grid o (%peer)
      (set! %peer (%make-%grid o))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::grid ...                                        */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::grid widget . options)
   (with-access::grid container (padx pady rows columns %last)
      (let ((last-col (+fx 1 (car %last)))
	    (last-row (cdr %last)))
 	 (if (>=fx last-col columns)
	     (begin
		(set! last-col 0)
		(set! last-row (+fx 1 last-row))))
	 (let-options options ((:x last-col)
			       (:width 1)
			       (:y last-row)
			       (:height 1)
			       (:padx padx)
			       (:pady pady)
			       (:expand (grid-expand container))
			       (:fill (grid-fill container))
 			       (error-proc: "container-add!(grid)"))
	    (cond
	       ((<fx x 0)
		(error "container-add!(grid)" "Illegal column number" x))
	       ((<fx y 0)
		(error "container-add!(grid)" "Illegal row number" y))
	       ((<fx width 1)
		(error "container-add!(grid)" "Illegal columnspan" width))
	       ((<fx height 1)
		(error "container-add!(grid)" "Illegal rowspan" height))
	       (else
		;; store the position of the insertion
		(set-car! %last (+fx x (-fx width 1)))
		(set-cdr! %last (+fx y (-fx height 1)))
		;; resize the grid if needed
		(if (>fx (+fx x width) columns)
		    (set! columns (+ 1 x width)))
		(if (>fx (+fx y height) rows)
		    (set! rows (+ 1 y height)))
		;; add the element
		(%grid-add! container widget
			    x width
			    y height
			    padx pady
			    expand fill)))))))

;*---------------------------------------------------------------------*/
;*    container-remove-all! ::grid ...                                 */
;*---------------------------------------------------------------------*/
(define-method (container-remove-all! container::grid)
   (with-access::grid container (%last)
      (set-car! %last -1)
      (set-cdr! %last 0)
      (call-next-method)))
