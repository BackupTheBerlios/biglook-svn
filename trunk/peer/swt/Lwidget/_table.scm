;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_table.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon Jul 16 14:07:59 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Swing peer Table implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/table.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%table
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%image
	   __biglook_%swing-misc
	   __biglook_%container
	   __biglook_%callback)

   (static (class %table::%peer
	      (%model::%swing-tablemodel read-only)
	      (%command (default #f))
	      (%column-number::int read-only)
	      (%column-widths::pair-nil (default '()))
	      (%rows::int (default 0))
	      (%foreground (default #f))
	      (%background (default #f))))
   
   (export (%make-%table ::%bglk-object ::pair ::procedure ::obj ::obj)
	   
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

	   (%table-command ::%bglk-object)
	   (%table-command-set! ::%bglk-object ::procedure)))

;*---------------------------------------------------------------------*/
;*    %make-%table ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%table o::%bglk-object columns cell-value _ _)
   (let* ((column-number (length columns))
	  (get-value (lambda (o x y)
			(let ((v (cell-value o x y)))
			   (if (and (%bglk-object? v)
				    (%image? (%bglk-object-%peer v)))
			       (%image-%icon (%bglk-object-%peer v))
			       v))))
 	  (model (%bglk-tablemodel-new o (list->vector columns) get-value))
	  (table (%swing-jtable-new model)))
      (instantiate::%table
	 (%model model)
	 (%bglk-object o)
	 (%builtin table)
	 (%column-number column-number))))

;*---------------------------------------------------------------------*/
;*    %table-rows ...                                                  */
;*---------------------------------------------------------------------*/
(define (%table-rows o::%bglk-object)
   (with-access::%table (%bglk-object-%peer o) (%model)
      (%bglk-tablemodel-getrowcount %model)))

;*---------------------------------------------------------------------*/
;*    %table-rows-set! ...                                             */
;*    -------------------------------------------------------------    */
;*    Update the rows of a table, that is remove some rows or add      */
;*    some rows.                                                       */
;*---------------------------------------------------------------------*/
(define (%table-rows-set! o::%bglk-object v)
   (with-access::%table (%bglk-object-%peer o) (%builtin %model)
      ;; then udpate the rows
      (let ((old-rows (%bglk-tablemodel-getrowcount %model)))
	 (cond
	    ((<fx old-rows v)
	     ;; we are adding new rows
	     (%bglk-tablemodel-addrows %model (-fx v old-rows))
	     v)
	    ((>fx old-rows v)
	     ;; we are removing some rows
	     (%bglk-tablemodel-removerows %model (-fx old-rows v))
	     v)
	    (else
	     ;; we are updating the whole table
	     v)))))

;*---------------------------------------------------------------------*/
;*    %table-row-height ...                                            */
;*---------------------------------------------------------------------*/
(define (%table-row-height o::%bglk-object)
   (with-access::%table (%bglk-object-%peer o) (%builtin)
      (%swing-jtable-rowheight %builtin)))

;*---------------------------------------------------------------------*/
;*    %table-row-height-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%table-row-height-set! o::%bglk-object v)
   (with-access::%table (%bglk-object-%peer o) (%builtin)
      (%swing-jtable-set-rowheight %builtin v)
      v))

;*---------------------------------------------------------------------*/
;*    %table-shadow ...                                                */
;*---------------------------------------------------------------------*/
(define (%table-shadow::symbol o::%bglk-object)
   (%jcomponent-shadow o))

;*---------------------------------------------------------------------*/
;*    %table-shadow-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%table-shadow-set! o::%bglk-object v::symbol)
   (%jcomponent-shadow-set! o v))

;*---------------------------------------------------------------------*/
;*    %table-row-background ...                                        */
;*---------------------------------------------------------------------*/
(define (%table-row-background o::%bglk-object)
   #f)

;*---------------------------------------------------------------------*/
;*    %table-row-background-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%table-row-background-set! o::%bglk-object v::procedure)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %table-row-foreground ...                                        */
;*---------------------------------------------------------------------*/
(define (%table-row-foreground o::%bglk-object)
   #f)

;*---------------------------------------------------------------------*/
;*    %table-row-foreground-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%table-row-foreground-set! o::%bglk-object v::procedure)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %table-column-width ...                                          */
;*---------------------------------------------------------------------*/
(define (%table-column-width::pair o::%bglk-object)
   (with-access::%table (%bglk-object-%peer o) (%column-number %column-widths)
      (if (null? %column-widths)
	  (vector->list (make-vector %column-number -1))
	  %column-widths)))

;*---------------------------------------------------------------------*/
;*    %table-column-width-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%table-column-width-set! o::%bglk-object v)
   (with-access::%table (%bglk-object-%peer o) (%builtin
						%column-number
						%column-widths)
      (if (not (<=fx (length v) %column-number))
	  (error "table-column-width" "Illegal number of widths" v)
	  (let ((model (%swing-jtable-getcolumnmodel %builtin)))
	     (set! %column-widths v)
	     (let loop ((i 0)
			(w v))
		(if (pair? w)
		    (begin
		       (if (>fx (car w) 0)
			   (let ((column (%swing-defaulttablecolumnmodel-getcolumn
					  model
					  i))) 
			      (%swing-tablecolumn-setpreferredwidth column
								    (car w))
			      i))
		       (loop (+fx i 1)
			     (cdr w)))))))))

;*---------------------------------------------------------------------*/
;*    %table-select-mode ...                                           */
;*---------------------------------------------------------------------*/
(define (%table-select-mode::symbol o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (let ((m (%swing-defaultlistselectionmodel-selection-mode
		(%swing-jtable-selection-model %builtin))))
	 (cond
	    ((=fx m %swing-listselectionmodel-MULTIPLE_INTERVAL_SELECTION)
	     'multiple)
	    ((=fx m %swing-listselectionmodel-SINGLE_INTERVAL_SELECTION)
	     'extended)
	    (else
	     'single)))))

;*---------------------------------------------------------------------*/
;*    %table-select-mode-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%table-select-mode-set! o::%bglk-object v::symbol)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%swing-jtable-selection-mode-set!
       %builtin
       (case v
	  ((multiple)
	   %swing-listselectionmodel-MULTIPLE_INTERVAL_SELECTION)
	  ((extended)
	   %swing-listselectionmodel-SINGLE_INTERVAL_SELECTION)
	  (else
	   %swing-listselectionmodel-SINGLE_SELECTION)))
      o))

;*---------------------------------------------------------------------*/
;*    %table-command ...                                               */
;*---------------------------------------------------------------------*/
(define (%table-command o::%bglk-object)
   (with-access::%table (%bglk-object-%peer o) (%command)
      %command))

;*---------------------------------------------------------------------*/
;*    %table-command-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%table-command-set! o::%bglk-object v::procedure)
   (with-access::%table (%bglk-object-%peer o) (%command)
      (if (procedure? %command)
	  (%install-widget-callback! o 'table-selection %command))
      (if (procedure? v)
	  (%install-widget-callback! o 'table-selection v))
      (set! %command v)))
      
