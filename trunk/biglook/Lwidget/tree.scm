;*=====================================================================*/
;*    biglook/Lwidget/tree.scm                                         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Fri May  7 11:02:26 2004 (dciabrin)               */
;*    Copyright   :  2000-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Tree widget                                              */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/tree.texi@                                 */
;*       @node Tree@                                                   */
;*    Examples:                                                        */
;*       @path ../../examples/tree/tree.scm@                           */
;*    -------------------------------------------------------------    */
;*    Implementation: @label tree@                                     */
;*    null: @path ../../peer/null/Lwidget/_tree.scm@                   */
;*    gtk: @path ../../peer/gtk/Lwidget/_tree.scm@                     */
;*    swing: @path ../../peer/swing/Lwidget/_tree.scm@                 */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_tree
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_label
	    __biglook_button
	    __biglook_layout
	    __biglook_frame
	    __biglook_box
	    __biglook_event
	    __biglook_scroll)
   
   (export  (class tree::scroll
	       ;; private actual slots
	       (%seed (default #f))
	       ;; user actual slots
	       (auto-collapse (default #t))
	       (root read-only)
	       ;; node info
	       (node-children::procedure read-only)
	       (node-label::procedure read-only (default (lambda (x) x)))
	       (node-image::procedure read-only (default tree-image))
	       (node-tooltips::procedure read-only (default (lambda (x) #f)))
	       ;; the tree root branches
	       (children::pair-nil
		read-only
		(get (lambda (o)
			(let ((seed (tree-%seed o)))
			   (if (not seed)
			       ;; The tree is not fully initialized yet. This
			       ;; test is required because TREE is a subclass
			       ;; of SCROLL and SCROLL checks the children
			       ;; list before adding accepting any widget.
			       '()
			       (container-children seed))))))
	       ;; tooltip
	       (tooltips
		(get (lambda (o) #f))
		(set (lambda (o v)
 			(error "tree-tooltips"
			       "Can't set tree tooltips (see node-tooltips)"
			       v))))
	       ;; command
	       (command
		(get (lambda (o)
			(%tree-seed-command (tree-%seed o))))
		(set (lambda (o v)
			(%tree-seed-command-set! (tree-%seed o) v))))
	       ;; open comand
	       (open-command (default #f))
	       ;; close command
	       (close-command (default #f))
	       ;; select-mode
	       (select-mode::symbol
		(get (lambda (o)
			(%tree-select-mode (tree-%seed o))))
		(set (lambda (o v)
			(%tree-select-mode-set! (tree-%seed o) v))))
	       ;; selection
	       (selection::pair-nil
		read-only
		(get (lambda (o)
			(%tree-selection (tree-%seed o)))))
	       ;; event
	       (event
		(get (lambda (o)
			(call-next-slot)))
		(set (lambda (o v)
			(call-next-slot)
			(tree-seed-set-event! (tree-%seed o) v)))))
	    
	    (abstract-class tree-item::container
	       (tree::tree read-only)
	       (value (default #unspecified)))
	    
	    (class tree-seed::tree-item
	       (expand::bool (default #f))
	       (items read-only (get %tree-node-items)))
	    
	    (class tree-branch::tree-seed)
	    
	    (class tree-leaf::tree-item)
	    
	    (tree-image ::obj ::symbol)
	    
	    (tree-node-expand ::tree-item)
	    (tree-node-collapse ::tree-item)

	    (tree-coords->item ::tree ::int ::int)
	    (tree-open ::tree ::procedure ::bool)
	    (tree-close ::tree)))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::tree ...                                      */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::tree)
   ;; construct and initialize the surounding scroll
   (call-next-method)
   ;; construct and initialize the tree
   (with-access::tree o (root %seed)
      ;; we allocate the builtin tree into which all the root are connected
      (set! %seed (instantiate::tree-seed
		     (tree o)
		     (parent `(,o :expand #t :fill #t))))
      ;; we are done with this tree
      (if (pair? root)
	  (for-each (lambda (r) (tree-seed-add! %seed r)) root)
	  (tree-seed-add! %seed root))
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::tree-seed ...                                 */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::tree-seed)
   (with-access::tree-seed o (%peer tree)
      (if (not (%peer? %peer))
	  (set! %peer (%make-%tree-seed o
					tree-node-expand
					tree-node-collapse
					%tree-node-label
					%tree-node-image
					(tree-node-tooltips tree))))
      (call-next-method)
      o))
   
;*---------------------------------------------------------------------*/
;*    bglk-object-init ::tree-branch ...                               */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::tree-branch)
   (with-access::tree-branch o (%peer tree)
      (if (not (%peer? %peer))
	  (set! %peer (%make-%tree-branch o (tree-%seed tree))))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::tree-leaf ...                                 */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::tree-leaf)
   (with-access::tree-leaf o (%peer tree)
      (if (not (%peer? %peer))
	  (set! %peer (%make-%tree-leaf o (tree-%seed tree))))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    tree-seed-add! ...                                               */
;*---------------------------------------------------------------------*/
(define (tree-seed-add! seed::tree-seed value)
   (with-access::tree-seed seed (tree)
      (with-access::tree tree (node-children event)
	 (define (tree-add-branch! value)
	    (let ((branch (instantiate::tree-branch
			     (tree tree)
			     (value value)
			     (event event)
			     (parent seed))))
	       (%tree-branch-render branch 'close)
	       branch))
	 (define (tree-add-leaf! value)
	    (let ((leaf (instantiate::tree-leaf
			   (tree tree)
			   (value value)
			   (event event)
			   (parent seed))))
	       (%tree-leaf-render leaf)
	       leaf))
	 (let ((children (node-children value)))
	    (if (pair? children)
		(tree-add-branch! value)
		(tree-add-leaf! value))))))

;*---------------------------------------------------------------------*/
;*    tree-node-expand ...                                             */
;*    -------------------------------------------------------------    */
;*    Both Gtk and Swing have the same weird behavior which is that    */
;*    if all the children are removed from a subtree, that subtree     */
;*    is turned into a leaf. Thus TREE-NODE-COLLAPSE doesn't remove    */
;*    any children and TREE-NODE-EXPAND remove all but one.            */
;*---------------------------------------------------------------------*/
(define (tree-node-expand o::tree-item)
   (if (tree-seed? o)
       (with-access::tree-seed o (tree expand value items)
	  (with-access::tree tree (node-children auto-collapse open-command)
	     (if (and (procedure? open-command)
		      (correct-arity? open-command 1))
		 (open-command o))
	     (if (or (not expand) auto-collapse)
		 (let ((old-items items))
		    ;; add all the new ones
		    (for-each (lambda (child)
				 (tree-seed-add! o child))
			      (node-children value))
		    ;; remove all the old one
		    (for-each (lambda (child)
				 (%tree-node-remove-item! o child))
			      old-items)
		    (set! expand #t)))))))

;*---------------------------------------------------------------------*/
;*    tree-node-collapse ...                                           */
;*---------------------------------------------------------------------*/
(define (tree-node-collapse o::tree-item)
   (if (tree-seed? o)
       (with-access::tree-seed o (tree expand items)
	  (with-access::tree tree (auto-collapse close-command)
	     (if (and (procedure? close-command)
		      (correct-arity? close-command 1))
		 (close-command o))
	     (if auto-collapse
		 (begin
		    (for-each (lambda (child)
				 (if (tree-seed? child)
				     (%tree-node-collapse child)))
			      items)
		    (set! expand #f)))))))


;*---------------------------------------------------------------------*/
;*    tree-coords->item ...                                            */
;*---------------------------------------------------------------------*/
(define (tree-coords->item::obj t::tree x::int y::int)
   (%tree-coords->item (tree-%seed t) x y))

;*---------------------------------------------------------------------*/
;*    tree-open ...                                                    */
;*---------------------------------------------------------------------*/
(define (tree-open o::tree proc::procedure select::bool)
   (let ((last #f))
      (let loop ((items (container-children o)))
	 (for-each (lambda (item)
		      (if (proc (tree-item-value item))
			  (begin
			     (tree-node-expand item)
			     (set! last item)
			     (if (tree-seed? item)
				 (begin
				    (%tree-node-expand item)
				    (loop (tree-branch-items item)))))))
		   items))
      (if (and select (tree-item? last))
	  (%tree-node-select last))))

;*---------------------------------------------------------------------*/
;*    tree-close ...                                                   */
;*---------------------------------------------------------------------*/
(define (tree-close o::tree)
   (let loop ((items (container-children o)))
      (for-each (lambda (item)
		   (tree-node-collapse item)
		   (if (tree-seed? item)
		       (begin
			  (%tree-node-collapse item)
			  (loop (tree-branch-items item)))))
		items)))
   
;*---------------------------------------------------------------------*/
;*    %tree-node-label ...                                             */
;*---------------------------------------------------------------------*/
(define (%tree-node-label o::tree-item)
   (with-access::tree-item o (tree value)
      (with-access::tree tree (node-label)
	 (node-label value))))

;*---------------------------------------------------------------------*/
;*    %tree-node-image ...                                             */
;*---------------------------------------------------------------------*/
(define (%tree-node-image o::tree-item kind)
   (with-access::tree-item o (tree value)
      (with-access::tree tree (node-image)
	 (node-image value kind))))

;*---------------------------------------------------------------------*/
;*    container-add! ::tree ...                                        */
;*---------------------------------------------------------------------*/
(define-method (container-add! c::tree w . options)
   (if (not (tree-seed? w))
       (error "container-add!(tree)" "Illegal widget" w)
       (with-access::tree c (%seed)
	  (call-next-method))))

;*---------------------------------------------------------------------*/
;*    container-add! ::tree-seed ...                                   */
;*---------------------------------------------------------------------*/
(define-method (container-add! c::tree-seed w . options)
   (%tree-seed-add! c w))

;*---------------------------------------------------------------------*/
;*    container-add! ::tree-branch ...                                 */
;*---------------------------------------------------------------------*/
(define-method (container-add! c::tree-branch w . options)
   (if (not (tree-item? w))
       (error "container-add!(tree-branch)" "Illegal widget" w)
       (%tree-branch-add! c w)))

;*---------------------------------------------------------------------*/
;*    container-add! ::tree-leaf ...                                   */
;*---------------------------------------------------------------------*/
(define-method (container-add! c::tree-leaf w . options)
   (error "container-add!(tree-leaf)" "Illegal widget" w))

;*---------------------------------------------------------------------*/
;*    container-remove! ...                                            */
;*---------------------------------------------------------------------*/
(define-method (container-remove! c::tree-item w)
   (%container-remove! c w))

;*---------------------------------------------------------------------*/
;*    install-callback! ::tree ...                                     */
;*---------------------------------------------------------------------*/
(define-method (install-callback! w::tree e::symbol proc)
   (cond
      ((procedure? proc)
       (%install-tree-callback! (tree-%seed w) e proc))
      ((not proc)
       #unspecified)
      (else
       (error "install-callback!(tree)"
	      "Illegal callback (should be #f or a procedure)"
	      proc))))

;*---------------------------------------------------------------------*/
;*    install-callback! ::tree-branch ...                              */
;*---------------------------------------------------------------------*/
(define-method (install-callback! w::tree-branch e::symbol proc)
   (cond
      ((procedure? proc)
       (%install-tree-branch-callback! w e proc))
      ((not proc)
       #unspecified)
      (else
       (error "install-callback!(tree-branch)"
	      "Illegal callback (should be #f or a procedure)"
	      proc))))

;*---------------------------------------------------------------------*/
;*    uninstall-callback! ::tree ...                                   */
;*---------------------------------------------------------------------*/
(define-method (uninstall-callback! w::tree evt::symbol proc)
   ;; uninstall is not a user function, we don't have to check any error here
   (if (procedure? proc)
       (%uninstall-tree-callback! w evt proc)))

;*---------------------------------------------------------------------*/
;*    uninstall-callback! ::tree-branch ...                            */
;*---------------------------------------------------------------------*/
(define-method (uninstall-callback! w::tree-branch evt::symbol proc)
   ;; uninstall is not a user function, we don't have to check any error here
   (if (procedure? proc)
       (%uninstall-tree-branch-callback! w evt proc)))

;*---------------------------------------------------------------------*/
;*    tree-seed-set-event! ...                                         */
;*---------------------------------------------------------------------*/
(define (tree-seed-set-event! o handler)
   (let loop ((items (container-children o)))
      (for-each (lambda (item)
		   (if (tree-branch? item)
		       (begin
			  (widget-event-set! item handler)
			  (loop (tree-branch-items item)))))
		items)))

;*---------------------------------------------------------------------*/
;*    tree-image ...                                                   */
;*---------------------------------------------------------------------*/
(define (tree-image user-data kind)
   (case kind
      ((leaf)
       (string->image "/* XPM */
static char * file_xpm[] = {
\"12 12 3 1\",
\" 	c None\",
\".	c black\",
\"X	c #FFFFCE\",
\" ........   \",
\" .XXXXXX.   \",
\" .XXXXXX... \",
\" .XXXXXXXX. \",
\" .XXXXXXXX. \",
\" .XXXXXXXX. \",
\" .XXXXXXXX. \",
\" .XXXXXXXX. \",
\" .XXXXXXXX. \",
\" .XXXXXXXX. \",
\" .XXXXXXXX. \",
\" .......... \"};"))
      ((close)
       (string->image "/* XPM */
static char * dir_xpm[] = {
\"16 16 5 1\",
\" 	c None\",
\".	c grey51\",
\"X	c goldenrod1\",
\"o	c white\",
\"O	c grey4\",
\"                \",
\"  .....         \",
\" .XXXXX.        \",
\".XXXXXXX......  \",
\".oooooooooooo.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\".oXXXXXXXXXXX.O \",
\"..............O \",
\" OOOOOOOOOOOOOO \",
\"                \",
\"                \"};"))
      ((open)
       (string->image "/* XPM */
static char * diropen_xpm[] = {
\"16 16 5 1\",
\" 	c None\",
\".	c grey51\",
\"X	c white\",
\"o	c goldenrod1\",
\"O	c grey4\",
\"                \",
\"   ....         \",
\"  .XXXX.        \",
\" .XooooX......  \",
\" .XoooooXXXXX.O \",
\" .Xoooooooooo.O \",
\"...........oo.O \",
\".XXXXXXXXX.Oo.O \",
\".XoooooooooO..O \",
\" .Xoooooooo.O.O \",
\" .XoooooooooO.O \",
\"  .Xoooooooo.OO \",
\"  ...........OO \",
\"   OOOOOOOOOOOO \",
\"                \",
\"                \"};"))
      (else
       (error "tree-image" "Illegal tree-item kind" kind))))
