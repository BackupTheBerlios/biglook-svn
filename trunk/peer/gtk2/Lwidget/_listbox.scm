;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_listbox.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon Jun  4 05:58:26 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The gtk peer Listbox implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/listbox.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%listbox
   
   (import  __biglook_%error
	    __biglook_%peer
	    __biglook_%gtk-misc
	    __biglook_%bglk-object
	    __biglook_%widget
	    __biglook_%color
	    __biglook_%container
	    __biglook_%frame
	    __biglook_%scroll
	    __biglook_%callback)

   (extern  (macro %%gtk-list-store-new::gtkliststore* (::int ::int)
		   "gtk_list_store_new")
	    (macro %%gtk-list-store-clear!::void (::gtkliststore*)
		   "gtk_list_store_clear")	    
	    (macro %%gtk-tree-view-new-with-model::gtkwidget* (::gtktreemodel*)
		   "gtk_tree_view_new_with_model")
	    (macro %%gtk-tree-view-set-headers-visible::void (::gtktreeview* ::bool)
		   "gtk_tree_view_set_headers_visible")
	    (macro %%gtk-tree-selection-get-mode::int (::gtktreeselection*)
		   "gtk_tree_selection_get_mode")
	    (macro %%gtk-tree-view-get-selection::gtktreeselection* (::gtktreeview*)
		   "gtk_tree_view_get_selection")
	    (macro %%gtk-tree-selection-set-mode!::void (::gtktreeselection* ::int)
		   "gtk_tree_selection_set_mode")
	    (macro %%gtk-tree-path-new-from-indices::gtktreepath* (::int . ::int)
		   "gtk_tree_path_new_from_indices")
	    (macro %%gtk-tree-selection-select-path!::void (::gtktreeselection* ::gtktreepath*)
		   "gtk_tree_selection_select_path")
	    (macro %%gtk-tree-selection-path-is-selected::bool (::gtktreeselection* ::gtktreepath*)
		   "gtk_tree_selection_path_is_selected")
	    (macro %%gtk-tree-selection-unselect-all!::void (::gtktreeselection*)
		   "gtk_tree_selection_unselect_all")
	    (macro %%bglk-gtk-list-add-view-column!::gtkobject* (::gtkwidget*)
		   "bglk_gtk_list_add_view_column")
	    (macro %%bglk-gtk-list-add-item!::gtkobject* (::gtkliststore* ::string) 
		   "bglk_gtk_list_add_item")
	    (macro %%bglk-gtk-list-coords-to-row::int (::gtktreeview* ::int ::int)
		   "bglk_gtk_list_coords_to_row"))

   (static  (class %listbox::%peer
	       (%tree-view::gtktreeview* read-only)
	       (%list::gtkliststore*)
	       (%items::pair-nil (default '()))))
	    
   (export  (%make-%listbox ::%bglk-object)

	    (%listbox-active?::bool ::%bglk-object)
	    (%listbox-active?-set! ::%bglk-object ::bool)
	    
	    (%listbox-items::pair-nil ::%bglk-object)
	    (%listbox-items-set! ::%bglk-object ::pair-nil)
	    
	    (%listbox-select-mode::symbol ::%bglk-object)
	    (%listbox-select-mode-set! ::%bglk-object ::symbol)
	    
	    (%listbox-selection::obj ::%bglk-object)
	    (%listbox-selection-set! ::%bglk-object ::obj)

	    (%listbox-coords->row::int ::%bglk-object ::int ::int)))

;*---------------------------------------------------------------------*/
;*    %install-widget-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define-method (%%install-widget-callback! o::%listbox e v)
   (with-access::%listbox o (%tree-view)
	 (%connect-widget-callback! (%%gtktreeview->gtkobject %tree-view) e v)))

;*---------------------------------------------------------------------*/
;*    %make-%listbox ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%listbox o)
   (let* ((f (gtkobject (%%gtk-scrolled-window-new
			%%gtk-null-adjustment
			%%gtk-null-adjustment)))
	 (l (%%gtk-list-store-new 1 G-TYPE-STRING))
     	 (t (%%gtk-tree-view-new-with-model (gtkliststore->gtktreemodel l))))

     (%%gtk-tree-view-set-headers-visible (gtktreeview (gtkobject t)) #f)
     (%%bglk-gtk-list-add-view-column! t)

     ;; show the list
     (%%widget-show t)
     
     (%%gtk-container-add! (gtkcontainer f) t)
     ;; resize policy
     (%%gtk-scrolled-window-set-policy (gtkscrollframe f)
				       %%GTK_POLICY_AUTOMATIC
				       %%GTK_POLICY_ALWAYS)
     ;; we set the resize mode for that frame
     (%%gtk-container-set-resize-mode (gtkcontainer f) %%GTK_RESIZE_PARENT)
     (instantiate::%listbox
      (%bglk-object o)
      (%list l)
      (%tree-view (gtktreeview (gtkobject t)))
      (%builtin f))))

;*---------------------------------------------------------------------*/
;*    %listbox-active? ...                                             */
;*---------------------------------------------------------------------*/
(define (%listbox-active? o::%bglk-object)
   (%widget-active? o))
   
;*---------------------------------------------------------------------*/
;*    %listbox-active?-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%listbox-active?-set! o::%bglk-object v)
   (%widget-active?-set! o v))
   
;*---------------------------------------------------------------------*/
;*    %listbox-items ...                                               */
;*---------------------------------------------------------------------*/
(define (%listbox-items o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%items)
	 %items)))
   
;*---------------------------------------------------------------------*/
;*    %listbox-items-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%listbox-items-set! o::%bglk-object v)
   (with-access::%bglk-object  o (%peer)
      (with-access::%listbox %peer (%items %list)
	 ;; remove all the currently inserted items
	 (%%gtk-list-store-clear! %list)
	 ;; add all the new items
	 (set! %items (map (lambda (t)
			     (%%bglk-gtk-list-add-item! %list t)
			     t)
			   v))
	 #unspecified)))
   
;*---------------------------------------------------------------------*/
;*    %listbox-select-mode ...                                         */
;*---------------------------------------------------------------------*/
(define (%listbox-select-mode o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%tree-view)
	 (gtk-selection->biglook
	  (%%gtk-tree-selection-get-mode (%%gtk-tree-view-get-selection %tree-view))))))

;*---------------------------------------------------------------------*/
;*    %listbox-select-mode-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%listbox-select-mode-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%tree-view)
	 (%%gtk-tree-selection-set-mode! (%%gtk-tree-view-get-selection %tree-view)
					(biglook-selection->gtk v))))
   #unspecified)


;*---------------------------------------------------------------------*/
;*    %listbox-selection ...                                           */
;*---------------------------------------------------------------------*/
(define (%listbox-selection o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%list %tree-view %items)
	 (let loop ((inum 0)
		    (v %items)
		    (res '()))
	   (if (null? v)
	       (reverse! res)
	       (if (%%gtk-tree-selection-path-is-selected (%%gtk-tree-view-get-selection %tree-view)
							  (%%gtk-tree-path-new-from-indices inum -1))
		   (loop (+ inum 1) (cdr v) (cons inum res))
		   (loop (+ inum 1) (cdr v) res)))))))
			     

;*---------------------------------------------------------------------*/
;*    %listbox-selection-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%listbox-selection-set! o::%bglk-object v)
  (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%list %tree-view)
	 ;; first, we unselect everything
	(let* ((selection (%%gtk-tree-view-get-selection %tree-view)))
	 (%%gtk-tree-selection-unselect-all! selection)
	 ;; then, we select the request items
	 (let loop ((inum 0)
		    (v v))
	    (cond
	       ((null? v)
		#unspecified)
	       ((=fx inum (car v))
		(%%gtk-tree-selection-select-path! selection
						   (%%gtk-tree-path-new-from-indices inum -1))
		(loop (+fx inum 1) (cdr v)))
	       (else
		(loop (+fx inum 1) v))))))))


;*---------------------------------------------------------------------*/
;*    %listbox-coords->row ...                                         */
;*---------------------------------------------------------------------*/
(define (%listbox-coords->row::int o::%bglk-object x::int y::int)
  (with-access::%listbox (%bglk-object-%peer o) (%tree-view)
     (%%bglk-gtk-list-coords-to-row %tree-view x y)))