;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_tree.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Dec 15 07:59:06 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Frame implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/tree.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%tree
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%container
	   __biglook_%error
	   __biglook_%event
	   __biglook_%callback)
   
   (static (abstract-class %tree-item::%container)
	   
	   (class %tree-node::%tree-item
	      (%gc-items::pair-nil (default '())))
	   
	   (class %tree-seed::%tree-node
	      (%command (default #f))
	      (%listener (default #f))
	      (%node::%swing-treenode read-only))

	   (class %tree-node/seed::%tree-node
	      (%seed::%tree-seed read-only))
	      
	   (class %tree-branch::%tree-node/seed)
	   
	   (class %tree-leaf::%tree-node/seed))
   
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
	   (%tree-seed-event-set! ::%bglk-object ::obj)
	   
	   (%tree-leaf-add! ::%bglk-object ::%bglk-object)
	   (%tree-seed-add! ::%bglk-object ::%bglk-object)
	   (%tree-branch-add! ::%bglk-object ::%bglk-object)
	   
 	   (%tree-node-items c::%bglk-object)
	   (%tree-node-expand ::%bglk-object)
	   (%tree-node-select ::%bglk-object)
	   (%tree-node-collapse ::%bglk-object)
	   (%tree-node-remove-item! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %peer-init ::%tree-branch ...                                    */
;*---------------------------------------------------------------------*/
(define-method (%peer-init o::%tree-branch)
   ;; don't call the default PEER-INIT method because since a TREE-BRANCH
   ;; is not a COMPONENT we cannot make it visible
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %peer-init ::%tree-leaf ...                                      */
;*---------------------------------------------------------------------*/
(define-method (%peer-init o::%tree-leaf)
   ;; don't call the default PEER-INIT method because since a TREE-LEAF
   ;; is not a COMPONENT we cannot make it visible
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %make-%tree-seed ...                                             */
;*---------------------------------------------------------------------*/
(define (%make-%tree-seed o::%bglk-object
			  expand::procedure
			  collapse::procedure
			  label::procedure
			  image::procedure
			  tooltips::procedure)
   (let* ((node (%bglk-treenode-new (%bglk-bstring->jstring "dummy") #f))
	  (treemodel (%swing-defaulttreemodel-new node #t))
	  (tree (%swing-jtree-new/model treemodel))
	  (line.key (%bglk-bstring->jstring "JTree.lineStyle"))
	  (line.value (%bglk-bstring->jstring "Angled"))
	  (get-label (lambda (item)
			(let ((lbl (label item)))
			   (cond
			      ((string? lbl)
			       lbl)
			      ((symbol? lbl)
			       (symbol->string lbl))
			      ((number? lbl)
			       (number->string lbl))
			      (else
			       (let ((p (open-output-string)))
				  (display lbl p)
				  (close-output-port p)))))))
	  (get-image (lambda (item kind)
			(let ((img (image item kind)))
			   (if (%bglk-object? img)
			       (%peer-%builtin (%bglk-object-%peer img))
			       img))))
	  (expand (lambda (e)
		     (let ((o (%event-%widget e)))
			(expand o))))
	  (collapse (lambda (e)
		       (let ((o (%event-%widget e)))
			  (collapse o))))
	  (renderer (%bglk-treecellrenderer-new get-label get-image tooltips)))
      ;; Swing tree configuration
      (%swing-jtree-set-cellrenderer tree renderer)
      (%swing-jtree-set-rootvisible tree #f)
      (%swing-jtree-set-showsroothandles tree #t)
      (%swing-jcomponent-put-client-property tree line.key line.value)
      (%swing-jcomponent-alignment-x-set! tree 0.0)
      (let ((seed (instantiate::%tree-seed
		     (%builtin tree)
		     (%bglk-object o)
		     (%node node))))
	 (%connect-tree-will-callback! seed expand collapse)
	 seed)))

;*---------------------------------------------------------------------*/
;*    %make-%tree-branch ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%tree-branch o::%bglk-object seed::%bglk-object)
   (instantiate::%tree-branch
      (%builtin (%bglk-treenode-new (%bglk-object->jobject o) #f))
      (%bglk-object o)
      (%seed (%bglk-object-%peer seed))))

;*---------------------------------------------------------------------*/
;*    %make-%tree-leaf ...                                             */
;*---------------------------------------------------------------------*/
(define (%make-%tree-leaf o::%bglk-object seed::%bglk-object)
    (instantiate::%tree-leaf
       (%builtin (%bglk-treenode-new (%bglk-object->jobject o) #t))
       (%bglk-object o)
       (%seed (%bglk-object-%peer seed))))

;*---------------------------------------------------------------------*/
;*    %tree-branch-render ...                                          */
;*---------------------------------------------------------------------*/
(define (%tree-branch-render o::%bglk-object kind)
   #unspecified)
   
;*---------------------------------------------------------------------*/
;*    %tree-leaf-render ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-leaf-render o::%bglk-object)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %tree-seed-command ...                                           */
;*---------------------------------------------------------------------*/
(define (%tree-seed-command o::%bglk-object)
   (with-access::%tree-seed (%bglk-object-%peer o) (%command)
      %command))

;*---------------------------------------------------------------------*/
;*    %tree-seed-command-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%tree-seed-command-set! o::%bglk-object v)
   (with-access::%tree-seed (%bglk-object-%peer o) (%command %listener %builtin)
      (if (%swing-treeselectionlistener? %listener)
	  (begin
	     (%swing-jtree-remove-selectionlistener! %builtin %listener)
	     %builtin))
      (let ((new-listener (%install-widget-callback! o 'tree-selection v)))
	 (set! %listener new-listener)
	 (set! %command v)
	 v)))

;*---------------------------------------------------------------------*/
;*    %tree-select-mode ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-select-mode::symbol o::%bglk-object)
   'single)

;*---------------------------------------------------------------------*/
;*    %tree-select-mode-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%tree-select-mode-set! o::%bglk-object v::symbol)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %tree-selection ...                                              */
;*---------------------------------------------------------------------*/
(define (%tree-selection  o::%bglk-object)
   '())

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
   (with-access::%tree-item (%bglk-object-%peer c) (%builtin)
      (%bglk-treenode-add! %builtin (%peer-%builtin (%bglk-object-%peer w)))
      c))

;*---------------------------------------------------------------------*/
;*    %tree-seed-add! ...                                              */
;*---------------------------------------------------------------------*/
(define (%tree-seed-add! c::%bglk-object w::%bglk-object)
   (with-access::%tree-seed (%bglk-object-%peer c) (%node %builtin)
      (let ((new-node (%peer-%builtin (%bglk-object-%peer w)))
	    (parent %node)
	    (count (%swing-defaultmutabletreenode-childcount %node))
	    (model (%swing-jtree-model %builtin)))
	 (%swing-defaulttreemodel-insertnodeinto model new-node %node count)
	 c)))

;*---------------------------------------------------------------------*/
;*    %tree-branch-add! ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-branch-add! c::%bglk-object w::%bglk-object)
   (%swing-defaultmutabletreenode-add! (%peer-%builtin (%bglk-object-%peer c))
				       (%peer-%builtin (%bglk-object-%peer w)))
   c)

;*---------------------------------------------------------------------*/
;*    %tree-node-items ...                                             */
;*---------------------------------------------------------------------*/
(define (%tree-node-items c::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (cond
	 ((%tree-seed? %peer)
	  (with-access::%tree-seed %peer (%node)
	     (%bglk-tree-node-items %node)))
	 ((%tree-branch? %peer)
	  (with-access::%tree-branch %peer (%builtin)
	     (%bglk-tree-node-items %builtin)))
	 (else
	  '()))))

;*---------------------------------------------------------------------*/
;*    %tree-node-expand ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-node-expand c::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (if (%tree-node/seed? %peer)
	  (with-access::%tree-node/seed %peer (%builtin %seed)
	     (%swing-jtree-clearselection (%peer-%builtin %seed))
	     (%swing-jtree-expandpath (%peer-%builtin %seed)
				      (%bglk-treenode-full-path %builtin))
	     c))))

;*---------------------------------------------------------------------*/
;*    %tree-node-select ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-node-select c::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (if (%tree-node/seed? %peer)
	  (with-access::%tree-node/seed %peer (%builtin %seed)
	     (%swing-jtree-clearselection (%peer-%builtin %seed))
	     (let ((path (%bglk-treenode-full-path %builtin)))
		(%swing-jtree-set-selection (%peer-%builtin %seed) path)
		(%swing-jtree-scroll-path (%peer-%builtin %seed) path)
		c)))))

;*---------------------------------------------------------------------*/
;*    %tree-node-collapse ...                                          */
;*---------------------------------------------------------------------*/
(define (%tree-node-collapse c::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (if (%tree-branch? %peer)
	  (with-access::%tree-branch %peer (%builtin %seed)
	     (let ((p (%bglk-treenode-full-path %builtin))
		   (t (%tree-seed-%builtin %seed)))
		(%swing-jtree-collapsepath t p)
		(%swing-jtree-fire-collapsed t p)
		c)))))

;*---------------------------------------------------------------------*/
;*    %tree-node-remove-item! ...                                      */
;*---------------------------------------------------------------------*/
(define (%tree-node-remove-item! c::%bglk-object w::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (if (%tree-node? %peer)
	  (with-access::%tree-node (%bglk-object-%peer c) (%builtin)
	     (%swing-defaultmutabletreenode-remove %builtin
						   (%peer-%builtin
						    (%bglk-object-%peer w)))
	     c))))

;*---------------------------------------------------------------------*/
;*    %%container-children ::%tree-node ...                            */
;*---------------------------------------------------------------------*/
(define-method (%%container-children peer::%tree-node)
   (cond
      ((%tree-seed? peer)
       (with-access::%tree-seed peer (%node)
	  (%bglk-tree-node-items %node)))
      ((%tree-branch? peer)
       (with-access::%tree-branch peer (%builtin)
	  (%bglk-tree-node-items %builtin)))
      (else
       '())))
