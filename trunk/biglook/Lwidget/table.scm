;*=====================================================================*/
;*    biglook/Lwidget/table.scm                                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Fri Apr 16 11:58:19 2004 (dciabrin)               */
;*    Copyright   :  2000-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Table widget                                             */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/table.texi@                                */
;*       @node Table@                                                  */
;*    Examples:                                                        */
;*       @path ../../examples/table/table.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label table@                                    */
;*    null: @path ../../peer/null/Lwidget/_table.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_table.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_table.scm@                */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_table
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_label
	    __biglook_button
	    __biglook_layout
	    __biglook_frame
	    __biglook_box
	    __biglook_event
	    __biglook_image)
   
   (export  (class table::widget
	       ;; rows
	       (rows::int
		(get %table-rows)
		(set %table-rows-set!))
	       ;; columns (titles)
	       (columns::pair read-only)
	       ;; columns-width
	       (columns-width::pair
		(get %table-column-width)
		(set %table-column-width-set!))
	       ;; column class
	       ;; cells
	       (init-cell-value::procedure read-only)
	       ;; editable?
	       (cell-editable?::procedure
		(default (lambda (o x y) #f)) read-only)
	       ;; row-foreground
	       (row-foreground
		(get %table-row-foreground)
		(set %table-row-foreground-set!))
	       ;; row-background
	       (row-background
		(get %table-row-background)
		(set %table-row-background-set!))
	       ;; row-height
	       (row-height::int
		(get %table-row-height)
		(set %table-row-height-set!))
	       ;; shadow
	       (shadow::symbol
		(get %table-shadow)
		(set %table-shadow-set!))
	       ;; select-mode
	       (select-mode::symbol
		(get %table-select-mode)
		(set %table-select-mode-set!))
	       ;; value-changed
	       (value-changed
		(get %table-value-changed)
		(set %table-value-changed-set!))
	       ;; command
	       (command
		(get %table-command)
		(set %table-command-set!)))

	    (table-cell-value ::table ::int ::int)
	    (table-cell-value-set! ::table ::int ::int ::obj)
	    (table-coords->row ::table ::int ::int)
	    (table-coords->column ::table ::int ::int)
	    ))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::table ...                                     */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::table)
   (with-access::table o (%peer columns init-cell-value cell-editable?)
      (set! %peer (%make-%table o columns init-cell-value cell-editable?
				*true-image* *false-image*))
      (call-next-method)
      o))

(define (table-cell-value o::table column::int row::int)
   (%table-cell-value o column row))

(define (table-cell-value-set! o::table column::int row::int val)
   (%table-cell-value-set! o column row val))

(define (table-coords->row o::table x::int y::int)
   (%table-coords->row o x y))

(define (table-coords->column o::table x::int y::int)
   (%table-coords->column o x y))

;*---------------------------------------------------------------------*/
;*    *true-image* ...                                                 */
;*---------------------------------------------------------------------*/
(define *true-image*
   (string->image "/* XPM */
static char *true[] = {
/* width height num_colors chars_per_pixel */
\"    16    16        2            1\",
/* colors */
\". c none\",
\"# c #000000\",
/* pixels */
\"................\",
\".##############.\",
\".#..............\",
\".#...........#..\",
\".#.........#.#..\",
\".#........##.#..\",
\".#..##...##..#..\",
\".#..##..##...#..\",
\".#..##.##....#..\",
\".#..####.....#..\",
\".#..###......#..\",
\".#..##.......#..\",
\".#...........#..\",
\".#.###########..\",
\".#..............\",
\"................\"};"))

(define *false-image*
   (string->image "/* XPM */
static char *false[] = {
/* width height num_colors chars_per_pixel */
\"    16    16        2            1\",
/* colors */
\". c none\",
\"# c #000000\",
/* pixels */
\"................\",
\".##############.\",
\".#..............\",
\".#...........#..\",
\".#...........#..\",
\".#...........#..\",
\".#...........#..\",
\".#...........#..\",
\".#...........#..\",
\".#...........#..\",
\".#...........#..\",
\".#...........#..\",
\".#...........#..\",
\".#.###########..\",
\".#..............\",
\"................\"};"))



