;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_tree.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Dec 15 07:57:57 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Frame implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/tree.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%tree
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%container
	   __biglook_%gtk-misc
	   __biglook_%widget
	   __biglook_%scroll
	   __biglook_%callback
	   __biglook_%event
	   __biglook_%box
	   __biglook_%label)

   (extern  (macro %%gtk-tree-new::gtkwidget*
		   ()
		   "gtk_tree_new")
	    (macro %%gtk-tree-item-new::gtkwidget*
		   ()
		   "gtk_tree_item_new")
	    (macro %%gtk-tree-append::void
		   (::gtktree* ::gtkwidget*)
		   "gtk_tree_append")
	    (macro %%gtk-tree-item-set-subtree::void
		   (::gtktreeitem* ::gtkwidget*)
		   "gtk_tree_item_set_subtree")
	    (macro %%gtk-tree-item-remove-subtree::void
		   (::gtktreeitem*)
		   "gtk_tree_item_remove_subtree")
	    (macro %%gtk-tree-remove-item::void
		   (::gtktree* ::gtkwidget*)
		   "gtk_tree_remove_item")
	    (macro %%gtk-tree-set-view-mode::void
		   (::gtktree* ::int)
		   "gtk_tree_set_view_mode")
	    (macro %%gtk-tree-set-selection-mode::void
		   (::gtktree* ::int)
		   "gtk_tree_set_selection_mode")
	    (macro %%gtk-tree-selection::glist*
		   (::gtktree*)
		   "GTK_TREE_SELECTION")
	    (macro %%gtk-tree-view-item::int "GTK_TREE_VIEW_ITEM")
	    (macro %%gtk-tree-item-expand::void
		   (::gtktreeitem*)
		   "gtk_tree_item_expand")
	    (macro %%gtk-tree-item-collapse::void
		   (::gtktreeitem*)
		   "gtk_tree_item_collapse")
	    (macro %%gtk-tree-item-select::void
		   (::gtktreeitem*)
		   "gtk_tree_item_select")
	    (macro %%gtk-tree-item-deselect::void
		   (::gtktreeitem*)
		   "gtk_tree_item_deselect"))
   
   (static (abstract-class %tree-item::%container)
	   
	   (class %tree-node::%tree-item)
	   
	   (class %tree-seed::%tree-node
	      (%node-expand::procedure read-only)
	      (%node-collapse::procedure read-only)
	      (%node-label::procedure read-only)
	      (%node-image::procedure read-only)
	      (%node-tooltips::procedure read-only)
	      (%command (default #f))
	      (%select-mode (default 'single)))
	   
	   (class %tree-branch::%tree-node
	      (%seed::%tree-seed read-only)
	      (%branch::gtkobject* read-only)
	      (expd-command (default #f))
	      (col-command (default #f)))
	   
	   (class %tree-leaf::%tree-item
	      (%seed::%tree-seed read-only)))
   
   (export (%make-%tree-seed ::%bglk-object
			     ::procedure ::procedure
			     ::procedure ::procedure
			     ::procedure)
	   (%make-%tree-branch ::%bglk-object ::%bglk-object)
	   (%make-%tree-leaf ::%bglk-object ::%bglk-object)
	   
	   (%tree-branch-render ::%bglk-object ::symbol)
	   (%tree-leaf-render ::%bglk-object)

	   (%tree-seed-command ::%bglk-object)
	   (%tree-seed-command-set! ::%bglk-object ::procedure)
	   
	   (%tree-select-mode::symbol ::%bglk-object)
	   (%tree-select-mode-set! ::%bglk-object ::symbol)

	   (%tree-selection::pair-nil ::%bglk-object)

	   (%tree-seed-event ::%bglk-object)
	   (%tree-seed-event-set! ::%bglk-object ::procedure)
	   
	   (%tree-leaf-add! ::%bglk-object ::%bglk-object)
	   (%tree-seed-add! ::%bglk-object ::%bglk-object)
	   (%tree-branch-add! ::%bglk-object ::%bglk-object)

	   (%tree-coords->item ::%bglk-object ::int ::int)

 	   (%tree-node-items c::%bglk-object)
	   (%tree-node-expand ::%bglk-object)
	   (%tree-node-select ::%bglk-object)
	   (%tree-node-collapse ::%bglk-object)
	   (%tree-node-remove-item! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%tree-seed ...                                             */
;*---------------------------------------------------------------------*/
(define (%make-%tree-seed o::%bglk-object
			  expand::procedure
			  collapse::procedure
			  label::procedure
			  image::procedure
			  tooltips::procedure)
   (instantiate::%tree-seed
      (%builtin (gtkobject (%%gtk-tree-new)))
      (%bglk-object o)
      (%node-expand expand)
      (%node-collapse collapse)
      (%node-label label)
      (%node-image image)
      (%node-tooltips tooltips)))
 
;*---------------------------------------------------------------------*/
;*    %make-%tree-branch ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%tree-branch o::%bglk-object seed::%bglk-object)
   ;; the tree-branch cannot be attached to the tree item until
   ;; the tree-item is added to its parent. In consequence, this
   ;; attachement is delayed in %TREE-BRANCH-ADD! and %TREE-SEED-ADD!
   (with-access::%bglk-object seed (%peer)
      (let* ((tree-item (gtkobject (%%gtk-tree-item-new)))
	     (tree-branch (gtkobject (%%gtk-tree-new)))
	     (branch (instantiate::%tree-branch
			(%builtin tree-item)
			(%branch tree-branch)
			(%bglk-object o)
			(%seed %peer))))
	 ;; set the backpoint from the TREE-BRANCH to the Bglk object
	 ;; for correct event handling
	 (%bglk-gtk-arg-type-set! tree-branch "user_data" o GTK-TYPE-POINTER)
	 (with-access::%tree-seed %peer (%node-expand %node-collapse %command)
	    (let ((expd (lambda (e)
			   (let ((o (%event-%widget e)))
			      (%tree-branch-render o 'open)
			      (%node-expand o))))
		  (col (lambda (e)
			  (let ((o (%event-%widget e)))
			     (%tree-branch-render o 'close)
			     (%node-collapse o)))))
	       (%connect-widget-callback! tree-item 'expand expd)
	       (%connect-widget-callback! tree-item 'collapse col)
	       (with-access::%tree-branch branch (col-command expd-command)
		  (set! expd-command expd)
		  (set! col-command col))
	       (if (procedure? %command)
		   (%connect-child-callback! tree-branch %command))
	       branch)))))

;*---------------------------------------------------------------------*/
;*    %make-%tree-leaf ...                                             */
;*---------------------------------------------------------------------*/
(define (%make-%tree-leaf o::%bglk-object seed::%bglk-object)
   (instantiate::%tree-leaf
      (%builtin (gtkobject (%%gtk-tree-item-new)))
      (%bglk-object o)
      (%seed (%bglk-object-%peer seed))))

;*---------------------------------------------------------------------*/
;*    %tree-render ...                                                 */
;*---------------------------------------------------------------------*/
(define (%tree-render container::gtkcontainer* lbl image tooltips)
   (let* ((text (cond
		   ((string? lbl)
		    lbl)
		   ((symbol? lbl)
		    (symbol->string lbl))
		   ((number? lbl)
		    (number->string lbl))
		   (else
		    (let ((p (open-output-string)))
		       (display lbl p)
		       (close-output-port p)))))
	  (box (%%gtk-hbox-new #f 0)))
      (%%widget-show box)
      (%%bglk-gtk-container-remove-all! container)
      (%%gtk-container-add! container box)
      (if tooltips
	  (let ((tt::gtktooltips* (%%gtk-tooltips-new)))
	     (%%gtk-tooltips-set-tip tt
				     (%%gtkcontainer->gtkwidget container)
				     tooltips
				     "")
	     tt))
      (if (%bglk-object? image)
	  (with-access::%peer (%bglk-object-%peer image) (%builtin)
	     (%%gtk-box-pack-start (gtkbox (gtkobject box))
				   (gtkwidget %builtin)
				   #f
				   #f
				   0)
	     image))
      (let ((lbl (%%gtk-label-new text)))
	 (%%widget-show lbl)
	 (%%gtk-box-pack-start (gtkbox (gtkobject box))
			       lbl
			       #f
			       #f
			       2)
	 container)))

;*---------------------------------------------------------------------*/
;*    %tree-branch-render ...                                          */
;*---------------------------------------------------------------------*/
(define (%tree-branch-render o::%bglk-object kind)
   (with-access::%tree-branch (%bglk-object-%peer o) (%seed %builtin)
      (with-access::%tree-seed %seed (%node-image %node-label %node-tooltips)
	 (%tree-render (gtkcontainer %builtin)
		       (%node-label o)
		       (%node-image o kind)
		       (%node-tooltips o)))))
   
;*---------------------------------------------------------------------*/
;*    %tree-leaf-render ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-leaf-render o::%bglk-object)
   (with-access::%tree-leaf (%bglk-object-%peer o) (%seed %builtin)
      (with-access::%tree-seed %seed (%node-image %node-label %node-tooltips)
	 (%tree-render (gtkcontainer %builtin)
		       (%node-label o)
		       (%node-image o 'leaf)
		       (%node-tooltips o)))))
   
;*---------------------------------------------------------------------*/
;*    %tree-seed-command ...                                           */
;*---------------------------------------------------------------------*/
(define (%tree-seed-command o::%bglk-object)
   (with-access::%tree-seed (%bglk-object-%peer o) (%command)
      %command))

;*---------------------------------------------------------------------*/
;*    %tree-seed-command-set! ...                                      */
;*    -------------------------------------------------------------    */
;*    When we set a command on a tree widget, we have to walk thru all */
;*    the embedded tree nodes and set the appropriate signal handler.  */
;*---------------------------------------------------------------------*/
(define (%tree-seed-command-set! o::%bglk-object v)
   (with-access::%tree-seed (%bglk-object-%peer o) (%command %builtin)
      ;; de-install the old command
      (if (procedure? %command)
	  (%disconnect-child-callback! %builtin v))
      ;; install the command on the root node
      (if (procedure? v)
	  (%connect-child-callback! %builtin v))
      ;; on all the currently added children
      (let loop ((items (%container-children o)))
	 (for-each (lambda (item)
		      (with-access::%bglk-object item (%peer)
			 (if (%tree-branch? %peer)
			     (with-access::%tree-branch %peer (%branch)
				(if (procedure? %command)
				    (%disconnect-child-callback! %branch
								 %command))
				(if (procedure? v)
				    (%connect-child-callback! %branch
							      v))
				(loop (%tree-node-items item))))))
		   items))
      ;; store the command
      (set! %command v)))

;*---------------------------------------------------------------------*/
;*    %tree-select-mode ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-select-mode::symbol o::%bglk-object)
   (with-access::%tree-seed (%bglk-object-%peer o) (%select-mode)
      %select-mode))

;*---------------------------------------------------------------------*/
;*    %tree-select-mode-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%tree-select-mode-set! o::%bglk-object v::symbol)
   (with-access::%tree-seed (%bglk-object-%peer o) (%select-mode %builtin)
      (%%gtk-tree-set-selection-mode (gtktree %builtin)
				     (biglook-selection->gtk v))
      (set! %select-mode v)))

;*---------------------------------------------------------------------*/
;*    %tree-selection ...                                              */
;*---------------------------------------------------------------------*/
(define (%tree-selection o::%bglk-object)
   (with-access::%tree-seed (%bglk-object-%peer o) (%select-mode %builtin)
      (%%bglk-gtk-glist-objs (%%gtk-tree-selection (gtktree %builtin)))))

;*---------------------------------------------------------------------*/
;*    %tree-seed-event ...                                             */
;*---------------------------------------------------------------------*/
(define (%tree-seed-event o::%bglk-object)
   (not-implemented o "%tree-seed-event"))

;*---------------------------------------------------------------------*/
;*    %tree-seed-event-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%tree-seed-event-set! o::%bglk-object v)
   (not-implemented o "%tree-seed-event-set!"))

;*---------------------------------------------------------------------*/
;*    %tree-leaf-add! ...                                              */
;*---------------------------------------------------------------------*/
(define (%tree-leaf-add! c::%bglk-object w::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (with-access::%container %peer (%gc-children)
	 (set! %gc-children (cons w %gc-children))
	 (%container-add! c w))))

;*---------------------------------------------------------------------*/
;*    %tree-seed-add! ...                                              */
;*---------------------------------------------------------------------*/
(define (%tree-seed-add! c::%bglk-object w::%bglk-object)
   (%%gtk-tree-append (gtktree (%tree-seed-%builtin (%bglk-object-%peer c)))
		      (gtkwidget (%peer-%builtin (%bglk-object-%peer w))))
   (with-access::%bglk-object w (%peer)
      (let ((peer (%bglk-object-%peer c)))
	 (%tree-node-%gc-children-set! peer
				       (cons w
					     (%tree-node-%gc-children peer))))
      (if (%tree-branch? %peer)
	  (with-access::%tree-branch %peer (%builtin %branch)
	     (%%gtk-tree-item-set-subtree (gtktreeitem %builtin)
					  (gtkwidget %branch))
	     c)
	  c)))

;*---------------------------------------------------------------------*/
;*    %tree-branch-add! ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-branch-add! c::%bglk-object w::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (with-access::%container %peer (%builtin %gc-children)
	 (set! %gc-children (cons w %gc-children))
	 (%%gtk-tree-append (gtktree (%tree-branch-%branch %peer))
			    (gtkwidget (%peer-%builtin
					(%bglk-object-%peer w))))))
   (with-access::%bglk-object w (%peer)
      (if (%tree-branch? %peer)
	  (with-access::%tree-branch %peer (%builtin %branch)
	     (%%gtk-tree-item-set-subtree (gtktreeitem %builtin)
					  (gtkwidget %branch))
	     c)
	  c)))

;*---------------------------------------------------------------------*/
;*    %tree-node-items ...                                             */
;*---------------------------------------------------------------------*/
(define (%tree-node-items c::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (if (%tree-branch? %peer)
	  (with-access::%tree-branch %peer (%branch)
	     (%%bglk-gtk-container-children (gtkcontainer %branch)))
	  '())))

;*---------------------------------------------------------------------*/
;*    %tree-node-expand ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-node-expand c::%bglk-object)
   (with-access::%tree-node (%bglk-object-%peer c) (%builtin)
      (%%gtk-tree-item-expand (gtktreeitem %builtin))
      c))

;*---------------------------------------------------------------------*/
;*    %tree-node-select ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-node-select c::%bglk-object)
   (define (deselect node::%tree-item)
      (for-each (lambda (it)
		   (with-access::%peer (%bglk-object-%peer it) (%builtin)
		      (%%gtk-tree-item-deselect (gtktreeitem %builtin))))
		(%%container-children node)))
   (with-access::%bglk-object c (%peer)
      (let ((seed (if (%tree-branch? %peer)
		      (%tree-branch-%seed %peer)
		      (%tree-leaf-%seed %peer))))
	 (let loop ((items (%%container-children seed)))
	    (for-each (lambda (item)
			 (with-access::%bglk-object item (%peer)
			    (%%gtk-tree-item-deselect (gtktreeitem
						       (%peer-%builtin %peer)))
			    (if (%tree-branch? %peer)
				(loop (%tree-node-items item)))))
		      items))
	 (if (%tree-node? %peer)
	     (with-access::%tree-node %peer (%builtin)
		(%%gtk-tree-item-select (gtktreeitem %builtin))
		c)
	     (with-access::%tree-leaf %peer (%builtin)
		(%%gtk-tree-item-select (gtktreeitem %builtin))
		c)))))

;*---------------------------------------------------------------------*/
;*    %tree-node-collapse ...                                          */
;*---------------------------------------------------------------------*/
(define (%tree-node-collapse c::%bglk-object)
   (with-access::%tree-node (%bglk-object-%peer c) (%builtin)
      (%%gtk-tree-item-collapse (gtktreeitem %builtin))
      c))

;*---------------------------------------------------------------------*/
;*    %tree-node-remove-item! ...                                      */
;*---------------------------------------------------------------------*/
(define (%tree-node-remove-item! c::%bglk-object w::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (if (%tree-branch? %peer)
	  (with-access::%tree-branch (%bglk-object-%peer c) (%branch)
	     (%%gtk-tree-remove-item (gtktree %branch)
				     (bglkwidget (%bglk-object-%peer w)))
	     c))))

;*---------------------------------------------------------------------*/
;*    %tree-coords->item ...                                           */
;*---------------------------------------------------------------------*/
(define (%tree-coords->item o::%bglk-object x::int y::int)
   (not-implemented o "%tree-coords->item"))
