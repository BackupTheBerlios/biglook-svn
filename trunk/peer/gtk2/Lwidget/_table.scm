;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_table.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jul 15 17:53:26 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Table implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/table.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%table
   
   (import __biglook_%peer
	   __biglook_%error 
	   __biglook_%bglk-object
	   __biglook_%gtk-misc
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%color
	   __biglook_%image
	   __biglook_%callback)
   
   (extern (macro %%gtk-table-new::gtkwidget*
		  (::int) 
		  "gtk_clist_new")
	   (macro %%bglk-gtk-clist-shadow-type::int
		  (::gtkclist*)
		  "BIGLOOK_CLIST_SHADOW_TYPE")
	   (macro %%gtk-clist-set-shadow-type::void
		  (::gtkclist* ::int)
		  "gtk_clist_set_shadow_type")
	   (macro %%gtk-clist-column-titles-show::void
		  (::gtkclist*)
		  "gtk_clist_column_titles_show")
	   (macro %%gtk-clist-set-column-title::void
		  (::gtkclist* ::int ::string)
		  "gtk_clist_set_column_title")
	   (macro %%gtk-clist-set-column-widget::void
		  (::gtkclist* ::int ::gtkwidget*)
		  "gtk_clist_set_column_widget")
	   (macro %%gtk-clist-get-text::string
		  (::gtkclist* ::int ::int ::gchar**)
		  "gtk_clist_get_text")
	   (macro %%gtk-clist-set-text::void
		  (::gtkclist* ::int ::int ::string)
		  "gtk_clist_set_text")
	   (macro %%gtk-clist-set-pixmap::void
		  (::gtkclist* ::int ::int ::gdkpixmap* ::gdkbitmap*)
		  "gtk_clist_set_pixmap")
	   (macro %%gtk-clist-set-foreground::void
		  (::gtkclist* ::int ::gdkcolor*)
		  "gtk_clist_set_foreground")
	   (macro %%gtk-clist-set-background::void
		  (::gtkclist* ::int ::gdkcolor*)
		  "gtk_clist_set_background")
	   (macro %%bglk-gtk-clist-add-row::void
		  (::gtkclist* ::int)
		  "bglk_gtk_clist_add_row")
	   (macro %%gtk-clist-remove::void
		  (::gtkclist* ::int)
		  "gtk_clist_remove")
	   (macro %%gtk-clist-set-column-width::void
		  (::gtkclist* ::int ::int)
		  "gtk_clist_set_column_width")
	   (macro %%gtk-clist-set-row-height::void
		  (::gtkclist* ::int)
		  "gtk_clist_set_row_height")
	   (macro %%bglk-gtk-clist-row-height::int
		  (::gtkclist*)
		  "BIGLOOK_CLIST_ROW_HEIGHT")
	   (macro %%gtk-clist-set-column-justification::void
		  (::gtkclist* ::int ::int)
 		  "gtk_clist_set_column_justification")
	   (macro %%gtk-clist-set-selection-mode::void
		  (::gtkclist* ::int)
		  "gtk_clist_set_selection_mode"))
   
   (static (class %table::%peer
	      (%command (default #f))
	      (%value-changed (default #f))
	      (%cell-value::procedure read-only)
	      (%column-titles::pair read-only)
	      (%column-number::int read-only)
	      (%column-widths::pair-nil (default '()))
	      (%rows::int (default 0))
	      (%true-image read-only)
	      (%false-image read-only)
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
	   
	   (%table-value-changed ::%bglk-object)
	   (%table-value-changed-set! ::%bglk-object ::procedure)

	   (%table-command ::%bglk-object)
	   (%table-command-set! ::%bglk-object ::procedure)

	   (%table-cell-value ::%bglk-object ::int ::int)
	   (%table-cell-value-set! ::%bglk-object ::int ::int ::obj)

	   (%table-coords->row ::%bglk-object ::int ::int)
	   (%table-coords->column ::%bglk-object ::int ::int)))

;*---------------------------------------------------------------------*/
;*    %make-%table ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%table o::%bglk-object columns cell-value true false)
   (let* ((column-number (length columns))
	  (table (gtkobject (%%gtk-table-new column-number))))
      (%%gtk-clist-column-titles-show (gtkclist table))
      (instantiate::%table
	 (%bglk-object o)
	 (%builtin table)
	 (%cell-value cell-value)
	 (%column-titles columns)
	 (%column-number column-number)
	 (%true-image true)
	 (%false-image false))))

;*---------------------------------------------------------------------*/
;*    %table-rows ...                                                  */
;*---------------------------------------------------------------------*/
(define (%table-rows o::%bglk-object)
   (with-access::%table (%bglk-object-%peer o) (%rows)
      %rows))

;*---------------------------------------------------------------------*/
;*    %table-rows-set! ...                                             */
;*    -------------------------------------------------------------    */
;*    Update the rows of a table, that is remove some rows or add      */
;*    some rows.                                                       */
;*---------------------------------------------------------------------*/
(define (%table-rows-set! o::%bglk-object v)
   (with-access::%table (%bglk-object-%peer o) (%rows
						%builtin
						%column-number
						%column-titles)
      ;; update the title row each time we resize the table
      (%%table-update-titles o %column-titles)
      ;; then udpate the rows
      (let ((old-rows %rows))
	 (set! %rows v)
	 (cond
	    ((<fx old-rows v)
	     ;; we are adding new rows
	     (let ((clist (gtkclist %builtin)))
		(let loop ((row old-rows))
		   (if (<fx row v)
		       (begin
			  (%%bglk-gtk-clist-add-row clist %column-number)
			  (%%table-update-row o row)
			  (loop (+fx row 1)))))))
	    ((>fx old-rows v)
	     ;; we are removing some rows
	     (let ((clist (gtkclist %builtin)))
		(let loop ((row (-fx old-rows 1)))
		   (if (>=fx row v)
		       (begin
			  (%%gtk-clist-remove clist row)
			  (loop (-fx row 1)))))))
	    (else
	     ;; we are updating the whole table
	     (let loop ((i (-fx %rows 1)))
		(if (>=fx i 0)
		    (begin
		       (%%table-update-row o i)
		       (loop (-fx i 1))))))))))

;*---------------------------------------------------------------------*/
;*    %table-row-height ...                                            */
;*---------------------------------------------------------------------*/
(define (%table-row-height o::%bglk-object)
   (g-property-get o "row-height"))

;*---------------------------------------------------------------------*/
;*    %table-row-height-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%table-row-height-set! o::%bglk-object v)
   (g-property-set! o "row-height" v))

;*---------------------------------------------------------------------*/
;*    %table-shadow ...                                                */
;*---------------------------------------------------------------------*/
(define (%table-shadow::symbol o::%bglk-object)
   (gtk-shadow->biglook (g-property-get o "shadow-type")))

;*---------------------------------------------------------------------*/
;*    %table-shadow-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%table-shadow-set! o::%bglk-object v::symbol)
   (g-property-type-set! o "shadow-type"
			 (biglook-shadow->gtk v)
			 GTK-TYPE-SHADOW-TYPE))

;*---------------------------------------------------------------------*/
;*    %table-row-background ...                                        */
;*---------------------------------------------------------------------*/
(define (%table-row-background o::%bglk-object)
   (with-access::%table (%bglk-object-%peer o) (%background)
      %background))

;*---------------------------------------------------------------------*/
;*    %table-row-background-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%table-row-background-set! o::%bglk-object v::procedure)
   (with-access::%table (%bglk-object-%peer o) (%builtin
						%background
						%rows)
      (set! %background v)
      (let ((clist (gtkclist %builtin)))
	 (let loop ((i (-fx %rows 1)))
	    (if (>=fx i 0)
		(begin
		   (%%table-update-row-colors o i)
		   (loop (-fx i 1))))))))

;*---------------------------------------------------------------------*/
;*    %table-row-foreground ...                                        */
;*---------------------------------------------------------------------*/
(define (%table-row-foreground o::%bglk-object)
   (with-access::%table (%bglk-object-%peer o) (%foreground)
      %foreground))

;*---------------------------------------------------------------------*/
;*    %table-row-foreground-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%table-row-foreground-set! o::%bglk-object v::procedure)
   (with-access::%table (%bglk-object-%peer o) (%builtin
						%foreground
						%rows)
      (set! %foreground v)
      (let ((clist (gtkclist %builtin)))
	 (let loop ((i (-fx %rows 1)))
	    (if (>=fx i 0)
		(begin
		   (%%table-update-row-colors o i)
		   (loop (-fx i 1))))))))

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
(define (%table-column-width-set! o::%bglk-object v::pair)
   (with-access::%table (%bglk-object-%peer o) (%builtin
						%column-number
						%column-widths)
      (if (not (<=fx (length v) %column-number))
	  (error "table-column-width" "Illegal number of widths" v)
	  (begin
	     (set! %column-widths v)
	     (let loop ((i 0)
			(w v))
		(if (pair? w)
		    (begin
		       (if (>fx (car w) 0)
			   (begin
			      (%%gtk-clist-set-column-width (gtkclist %builtin)
							    i
							    (car w))
			      i))
		       (loop (+fx i 1)
			     (cdr w)))))))))

;*---------------------------------------------------------------------*/
;*    %table-select-mode ...                                           */
;*---------------------------------------------------------------------*/
(define (%table-select-mode::symbol o::%bglk-object)
   (gtk-selection->biglook (g-property-get o "selection-mode")))

;*---------------------------------------------------------------------*/
;*    %table-select-mode-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%table-select-mode-set! o::%bglk-object v::symbol)
   (g-property-type-set! o
			 "selection-mode"
			 (biglook-selection->gtk v)
			 GTK-TYPE-SELECTION-TYPE))

;*---------------------------------------------------------------------*/
;*    %%table-update-titles ...                                        */
;*---------------------------------------------------------------------*/
(define (%%table-update-titles o::%bglk-object column-titles)
   (with-access::%table (%bglk-object-%peer o) (%builtin
						%column-number
						%column-titles)
      (let loop ((column 0)
		 (titles %column-titles))
	 (if (<fx column %column-number)
	     (let ((title (car titles)))
		(cond
		   ((string? title)
		    (%%gtk-clist-set-column-title (gtkclist %builtin)
						  column
						  title)
		    title)
		   ((%bglk-object? title)
		    (let ((w (gtkwidget (%peer-%builtin
					 (%bglk-object-%peer title)))))
		       (%%gtk-clist-set-column-widget (gtkclist %builtin)
						      column w)
		       title))
		   (else
		    (let ((p (open-output-string)))
		       (display title p)
		       (%%gtk-clist-set-column-title (gtkclist %builtin)
						     column
						     (close-output-port p))
		       title)))
		(loop (+fx column 1)
		      (cdr titles)))))))

;*---------------------------------------------------------------------*/
;*    %%table-update-row ...                                           */
;*    -------------------------------------------------------------    */
;*    Update one table row (that is render each cell of the row).      */
;*---------------------------------------------------------------------*/
(define (%%table-update-row o::%bglk-object y::int)
   (define (render-string-cell clist x y str)
      (%%gtk-clist-set-text clist y x str)
      str)
   (define (render-number-cell clist x y num)
      (%%gtk-clist-set-column-justification clist
					    x
					    (biglook-justify->gtk 'right))
      (render-string-cell clist x y (number->string num)))
   (define (render-image-cell clist x y img)
      (%%gtk-clist-set-column-justification clist
					    x
					    (biglook-justify->gtk 'center))
      (with-access::%bglk-object img (%peer)
	 (let ((pixmap (%%bglk-image->pixmap (%peer-%builtin %peer)))
	       (mask (%%bglk-image-mask->bitmap (%peer-%builtin %peer))))
	    (%%gtk-clist-set-pixmap clist y x pixmap mask)
	    img)))
   (define (render-boolean-cell clist x y val)
      (with-access::%table (%bglk-object-%peer o) (%true-image %false-image)
	 (if val
	     (if (and (%bglk-object? %true-image)
		      (%image? (%bglk-object-%peer %true-image)))
		 (render-image-cell clist x y %true-image)
		 (render-string-cell clist x y "true"))
	     (if (and (%bglk-object? %false-image)
		      (%image? (%bglk-object-%peer %false-image)))
		 (render-image-cell clist x y %false-image)
		 (render-string-cell clist x y "false")))))
   (define (render-obj-cell clist x y val)
      (%%gtk-clist-set-column-justification clist
					    x
					    (biglook-justify->gtk 'center))
      (let ((str (if (symbol? val)
		     (symbol->string val)
		     (let ((p (open-output-string)))
			(display val p)
			(close-output-port p)))))
	 (render-string-cell clist x y str)))
   (with-access::%table (%bglk-object-%peer o) (%builtin
						%cell-value
						%column-number)
      (let ((clist (gtkclist %builtin)))
	 (let loop ((x (-fx %column-number 1)))
	    (if (>=fx x 0)
		(let ((val (%cell-value o x y)))
		   (cond
		      ((string? val)
		       ;; strings
		       (render-string-cell clist x y val))
		      ((number? val)
		       ;; numbers
		       (render-number-cell clist x y val))
		      ((and (%bglk-object? val)
			    (%image? (%bglk-object-%peer val)))
		       ;; images
		       (render-image-cell clist x y val))
		      ((boolean? val)
		       ;; booleans
		       (render-boolean-cell clist x y val))
		      (else
		       ;; default
		       (render-obj-cell clist x y val)))
		   ;; the color adjustment
		   (%%table-update-row-colors o y)
		   (loop (-fx x 1))))))))

;*---------------------------------------------------------------------*/
;*    %%table-update-row-colors ...                                    */
;*---------------------------------------------------------------------*/
(define (%%table-update-row-colors o::%bglk-object row::int)
   (with-access::%table (%bglk-object-%peer o) (%builtin
						%background
						%foreground)
      (let ((clist (gtkclist %builtin)))
	 (let ((bg (and (procedure? %background) (%background row)))
	       (fg (and (procedure? %foreground) (%foreground row))))
	    (if (%color? bg)
		(let ((gdk (biglook-color->gdk bg)))
		   (%%gtk-clist-set-background clist row gdk)
		   gdk))
	    (if (%color? fg)
		(let ((gdk (biglook-color->gdk fg)))
		   (%%gtk-clist-set-foreground clist row gdk)
		   gdk))))))

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
   (with-access::%bglk-object o (%peer)
      (with-access::%table %peer (%builtin %command)
	 (if (procedure? %command)
	     (%disconnect-row-select-callback! %builtin %command))
	 (if (procedure? v)
	     (%connect-row-select-callback! %builtin v))
	 (set! %command v))))

;*---------------------------------------------------------------------*/
;*    %table-value-changed ...                                         */
;*---------------------------------------------------------------------*/
(define (%table-value-changed o::%bglk-object)
   (with-access::%table (%bglk-object-%peer o) (%value-changed)
      %value-changed))

;*---------------------------------------------------------------------*/
;*    %table-value-changed-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%table-value-changed-set! o::%bglk-object v::procedure)
   (with-access::%table (%bglk-object-%peer o) (%value-changed)
      (if (procedure? %value-changed)
	  (%uninstall-widget-callback! o 'table-changed %value-changed))
      (if (procedure? v)
	  (%install-widget-callback! o 'table-changed v))
      (set! %value-changed v)))

;*---------------------------------------------------------------------*/
;*    %table-cell-value ...                                            */
;*---------------------------------------------------------------------*/
(define (%table-cell-value o::%bglk-object column::int row::int)
  (not-implemented o "%table-cell-value"))

;*---------------------------------------------------------------------*/
;*    %table-cell-value-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%table-cell-value-set! o::%bglk-object column::int row::int val)
  (not-implemented o "%table-cell-value-set"))

;*---------------------------------------------------------------------*/
;*    %table-coords->row ...                                           */
;*---------------------------------------------------------------------*/
(define (%table-coords->row o::%bglk-object x::int y::int)
  (not-implemented o "%table-coords->row"))

;*---------------------------------------------------------------------*/
;*    %table-coords->column ...                                        */
;*---------------------------------------------------------------------*/
(define (%table-coords->column o::%bglk-object x::int y::int)
  (not-implemented o "%table-coords->column"))

