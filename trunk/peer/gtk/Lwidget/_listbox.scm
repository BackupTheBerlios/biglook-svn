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
	    __biglook_%scroll)

   (extern  (macro %%gtk-list-new::gtkwidget* ()
		   "gtk_list_new")
	    (macro %%gtk-list-clear-items::void (::gtklist* ::int ::int)
		   "gtk_list_clear_items")
	    (macro %%gtk-list-set-selection-mode::void (::gtklist* ::int)
		   "gtk_list_set_selection_mode")
	    (macro %%bglk-gtk-list-get-selection-mode::int (::gtklist*)
		   "BGLK_LIST_GET_SELECTION_MODE")
	    (macro %%gtk-list-unselect-all::void (::gtklist*)
		   "gtk_list_unselect_all")
	    (macro %%gtk-list-select-item::void (::gtklist* ::int)
		   "gtk_list_select_item")
	    (macro %%bglk-list-selection::pair-nil (::gtklist*)
		   "bglk_gtk_list_selection")
	    
	    (macro %%gtk-list-item-new-with-label::gtkwidget* (::string)
		   "gtk_list_item_new_with_label"))
   
   (static  (class %listbox::%peer
	       (%list::gtklist* read-only)
	       (%items::pair-nil (default '())))

	    (class %list-item::%peer))
   
   (export  (%make-%listbox ::%bglk-object)

	    (%listbox-active?::bool ::%bglk-object)
	    (%listbox-active?-set! ::%bglk-object ::bool)
	    
	    (%listbox-items::pair-nil ::%bglk-object)
	    (%listbox-items-set! ::%bglk-object ::pair-nil)
	    
	    (%listbox-select-mode::symbol ::%bglk-object)
	    (%listbox-select-mode-set! ::%bglk-object ::symbol)
	    
	    (%listbox-selection::obj ::%bglk-object)
	    (%listbox-selection-set! ::%bglk-object ::obj)

	    (%listbox-coords->row::int ::%bglk-object ::int ::int)
		    
	    ))
	    
;*---------------------------------------------------------------------*/
;*    %make-%listbox ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%listbox o)
   (let ((f::gtkobject* (gtkobject (%%gtk-scrolled-window-new
				    %%gtk-null-adjustment
				    %%gtk-null-adjustment)))
	 (l::gtkobject* (gtkobject (%%gtk-list-new))))
      ;; show the list
      (%%widget-show (gtkwidget l))
      ;; we insert with an ad-hoc insertion the inner frame
      (%%gtk-scrolled-window-add-with-viewport (gtkscrollframe f)
					       (gtkwidget l))
      ;; resize policy
      (%%gtk-scrolled-window-set-policy (gtkscrollframe f)
					%%GTK_POLICY_AUTOMATIC
					%%GTK_POLICY_ALWAYS)
      ;; we set the resize mode for that frame
      (%%gtk-container-set-resize-mode (gtkcontainer f) %%GTK_RESIZE_PARENT)
      (instantiate::%listbox
	 (%bglk-object o)
	 (%list (gtklist l))
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
	 (map (lambda (item)
		 (with-access::%list-item item (%bglk-object)
		    %bglk-object))
	      %items))))
   
;*---------------------------------------------------------------------*/
;*    %listbox-items-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%listbox-items-set! o::%bglk-object v)
   (with-access::%bglk-object  o (%peer)
      (with-access::%listbox %peer (%builtin %items %list)
	 ;; remove all the currently inserted items
	 (%%gtk-list-clear-items %list 0 -1)
	 ;; add all the new items
	 (set! %items (map (lambda (t)
			      (let* ((li (%%gtk-list-item-new-with-label t))
				     (i (instantiate::%list-item
					   (%builtin (gtkobject li))
					   (%bglk-object t))))
				 (%%gtk-container-add! (%%gtklist->container
							 %list)
						       li)
				 i))
			   v))
	 #unspecified)))
   
;*---------------------------------------------------------------------*/
;*    %listbox-select-mode ...                                         */
;*---------------------------------------------------------------------*/
(define (%listbox-select-mode o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%list)
	 (gtk-selection->biglook
	  (%bglk-gtk-arg-get (%%gtklist->gtkobject %list)
			     "selection_mode")))))

;*---------------------------------------------------------------------*/
;*    %listbox-select-mode-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%listbox-select-mode-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%list)
	 (%bglk-gtk-arg-type-set! (%%gtklist->gtkobject %list)
				  "selection_mode"
				  (biglook-selection->gtk v)
				  GTK-TYPE-SELECTION-TYPE))))

;*---------------------------------------------------------------------*/
;*    %listbox-selection ...                                           */
;*---------------------------------------------------------------------*/
(define (%listbox-selection o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%list %items)
	 (let loop ((selects (%%bglk-list-selection %list))
		    (items %items)
		    (i 0)
		    (res '()))
	    (cond
	       ((or (null? selects) (null? items))
		(reverse! res))
	       ((eq? (car selects) (%list-item-%bglk-object (car items)))
		(loop (cdr selects)
		      (cdr items)
		      (+fx i 1)
		      (cons i res)))
	       (else
		(loop selects
		      (cdr items)
		      (+fx i 1)
		      res)))))))

;*---------------------------------------------------------------------*/
;*    %listbox-selection-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%listbox-selection-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%list)
	 ;; first, we unselect everything
	 (%%gtk-list-unselect-all %list)
	 ;; then, we select the request items
	 (let loop ((inum 0)
		    (v v))
	    (cond
	       ((null? v)
		#unspecified)
	       ((=fx inum (car v))
		(%%gtk-list-select-item %list inum)
		(loop (+fx inum 1) (cdr v)))
	       (else
		(loop (+fx inum 1) v)))))))

;*---------------------------------------------------------------------*/
;*    %listbox-coords->row ...                                         */
;*---------------------------------------------------------------------*/
(define (%listbox-coords->row::int o::%bglk-object x::int y::int)
   (not-implemented o "%listbox-coords->row"))
