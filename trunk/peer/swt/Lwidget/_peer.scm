;*=====================================================================*/
;*    swt/Lwidget/_peer.scm                                            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 31 13:34:23 2001                          */
;*    Last change :  Wed Oct  8 14:02:17 2003 (dciabrin)               */
;*    Copyright   :  2001-03 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The implementation of the peer object.                           */
;*    -------------------------------------------------------------    */
;*    Awt/Swing connections:                                           */
;*      @path ../Lswing/%awt.scm@                                      */
;*      @path ../Lswing/%swing.scm@                                    */
;*    Various Java implementations:                                    */
;*      @path ../Jlib/BglkWindow.java@                                 */
;*      @path ../Jlib/BglkBox.java@                                    */
;*      @path ../Jlib/Bglk.java@                                       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%peer
   
   (import __biglook_%bglk-object
	   __biglook_%awt
	   __biglook_%swing)
   
   (java   (class %bglk-jcomponentadapter::%awt-componentadapter
	      (constructor new ())
	      "bigloo.biglook.peer.Jlib.BJComponentAdapter")
	   
	   ;; BJWindowAdapter
	   (class %bglk-windowadapter::%awt-windowadapter
	      (method static add!::void
		      (::%awt-window ::obj ::obj ::obj ::procedure)
		      "addWindowAdapter")
	      (method static iconify::obj
		      (::%awt-window)
		      "getWindowAdapterIconify")
	      (method static deiconify::obj
		      (::%awt-window)
		      "getWindowAdapterDeiconify")
	      (method static destroy::obj
		      (::%awt-window)
		      "getWindowAdapterDestroy")
	      "bigloo.biglook.peer.Jlib.BJWindowAdapter")

	   ;; BJMouseAdapter
	   (class %bglk-mouseadapter::%awt-mouseadapter
	      (method static add!::void
		      (::%awt-component ::obj ::obj ::obj ::obj ::obj ::obj ::procedure)
		      "addMouseAdapter")
	      (method static press::obj
		      (::%awt-component)
		      "getMouseAdapterPress")
	      (method static release::obj
		      (::%awt-component)
		      "getMouseAdapterRelease")
	      (method static enter::obj
		      (::%awt-component)
		      "getMouseAdapterEnter")
	      (method static leave::obj
		      (::%awt-component)
		      "getMouseAdapterLeave")
	      (method static click::obj
		      (::%awt-component)
		      "getMouseAdapterClick")
	      (method static command::obj
		      (::%awt-component)
		      "getMouseAdapterCommand")
	      "bigloo.biglook.peer.Jlib.BJMouseAdapter")
	      
	   ;; BJMouseMotionAdapter
	   (class %bglk-mousemotionadapter::%awt-mousemotionadapter
	      (method static add!::void
		      (::%awt-component ::obj ::obj ::procedure)
		      "addMouseMotionAdapter")
	      (method static drag::obj
		      (::%awt-component)
		      "getMouseMotionAdapterDrag")
	      (method static move::obj
		      (::%awt-component)
		      "getMouseMotionAdapterMove")
	      "bigloo.biglook.peer.Jlib.BJMouseMotionAdapter")

	   ;; BJKeyAdapter
	   (class %bglk-keyadapter::%awt-keyadapter
	      (method static add!::void
		      (::%awt-component ::obj ::procedure)
		      "addKeyAdapter")
	      (method static return-add!::void
		      (::%awt-component ::obj ::procedure)
		      "addKeyReturnAdapter")
	      (method static press::obj
		      (::%awt-component)
		      "getKeyAdapterPress")
	      "bigloo.biglook.peer.Jlib.BJKeyAdapter")

	   ;; BJFocusAdapter
	   (class %bglk-focusadapter::%awt-focusadapter
	      (method static add!::void
		      (::%awt-component ::obj ::obj ::procedure)
		      "addFocusAdapter")
	      (method static in::obj
		      (::%awt-component)
		      "getFocusAdapterIn")
	      (method static out::obj
		      (::%awt-component)
		      "getFocusAdapterOut")
	      "bigloo.biglook.peer.Jlib.BJFocusAdapter")

	   ;; BJComponentAdapter
	   (class %bglk-componentadapter::%awt-componentadapter
	      (method static add!::void
		      (::%awt-component ::obj ::procedure)
		      "addComponentAdapter")
	      (method static configure::obj
		      (::%awt-component)
		      "getComponentAdapterConfigure")
	      "bigloo.biglook.peer.Jlib.BJComponentAdapter")

	   ;; BJCanvasMouseMotionAdpater
	   (class %bglk-canvas-mousemotionadapter::%awt-mousemotionadapter
	      (constructor new (::procedure))
	      (method static add!::void
		      (::%bglk-canvas ::obj)
		      "addCanvasMouseMotionAdapter")
	      (method static proc::obj
		      (::%bglk-canvas)
		      "getCanvasMouseMotionAdapterProc")
	      "bigloo.biglook.peer.Jlib.BJCanvasMouseMotionAdapter")
	      
	   ;; BJCanvasMouseAdpater
	   (class %bglk-canvas-mouseadapter::%awt-mouseadapter
	      (constructor new (::procedure ::procedure))
	      (method static add!::void
		      (::%bglk-canvas ::obj ::obj)
		      "addCanvasMouseAdapter")
	      (method static press::obj
		      (::%bglk-canvas)
		      "getCanvasMouseAdapterPress")
	      (method static release::obj
		      (::%bglk-canvas)
		      "getCanvasMouseAdapterRelease")
	      "bigloo.biglook.peer.Jlib.BJCanvasMouseAdapter")
	      
	   ;; BJCanvasKeyAdpater
	   (class %bglk-canvas-keyadapter::%awt-keyadapter
	      (constructor new ())
	      "bigloo.biglook.peer.Jlib.BJCanvasKeyAdapter")

	   ;; BJTreeSelectionAdapter
	   (class %bglk-tree-selectionadapter::%swing-treeselectionlistener
	      (method static add!::void
		      (::%swing-jtree ::obj ::procedure)
		      "addTreeSelectionAdapter")
	      (method static proc::obj
		      (::%swing-jtree)
		      "getTreeSelectionAdapterProc")
	      "bigloo.biglook.peer.Jlib.BJTreeSelectionAdapter")

	   ;; BJListSelectionAdpater
	   (class %bglk-list-selectionadapter::%swing-listselectionlistener
	      (method static add!::void
		      (::%swing-defaultlistselectionmodel ::obj ::obj ::procedure)
		      "addListSelectionAdapter")
	      (method static proc::obj
		      (::%swing-listselectionmodel)
		      "getListSelectionAdapterProc")
	      "bigloo.biglook.peer.Jlib.BJListSelectionAdapter")

	   ;; BJTimerAdapter
	   (class %bglk-timeradapter::%awt-actionlistener
	      (constructor new (::procedure))
	      "bigloo.biglook.peer.Jlib.BJTimerAdapter")

	   ;; BJChangeAdapter
	   (class %bglk-changeadapter::%swing-changelistener
	      (method static add!::void
		      (::%swing-jslider ::obj ::procedure)
		      "addChangeAdapter")
	      (method static proc::obj
		      (::%swing-jslider)
		      "getChangeAdapterProc")
	      "bigloo.biglook.peer.Jlib.BJChangeAdapter")

	   ;; BJActionAdapter
	   (class %bglk-actionadapter::%swing-abstractaction
	      (method static add!::void
		      (::%awt-component ::obj ::procedure ::%jstring)
		      "addActionAdapter")
	      (method static proc::obj
		      (::%awt-component ::%jstring)
		      "getActionAdapterProc")
	      "bigloo.biglook.peer.Jlib.BJActionAdapter")

	   ;; BJTreeWillExpandAdapter
	   (class %bglk-treewillexpandadapter::%swing-treewillexpandlistener
	      (constructor new (::procedure ::procedure ::procedure))
	      "bigloo.biglook.peer.Jlib.BJTreeWillExpandAdapter")
	   
	   ;; BJBorder
	   (class %bglk-border::%swing-compoundborder
	      (method static new::%bglk-border
		      (::%swing-border ::%jstring)
		      "make_BJBorder")
	      (method copy::%bglk-border
		      (::%bglk-border ::%swing-border)
		      "copy_BJBorder")
	      (method static etched-in-new::%swing-etchedborder
		      ()
		      "make_etched_in_border")
	      (method static etched-out-new::%swing-etchedborder
		      ()
		      "make_etched_out_border")
	      (method static bevel-in-new::%swing-bevelborder
		      ()
		      "make_bevel_in_border")
	      (method static bevel-out-new::%swing-bevelborder
		      ()
		      "make_bevel_out_border")
	      (method static softbevel-in-new::%swing-softbevelborder
		      ()
		      "make_softbevel_in_border")
	      (method static softbevel-out-new::%swing-softbevelborder
		      ()
		      "make_softbevel_out_border")
	      (method static empty-new::%swing-emptyborder
		      ()
		      "make_empty_border")
	      (method outside::%swing-border
		      (::%bglk-border)
		      "getOutsideBorder")
	      (method title::%jstring
		      (::%bglk-border)
		      "getTitle")
	      (method title-set!::void
		      (::%bglk-border ::%jstring)
		      "setTitle")
	      (method justification::int
		      (::%bglk-border)
		      "getTitleJustification")
	      (method justification-set!::void
		      (::%bglk-border ::int)
		      "setTitleJustification")
	      "bigloo.biglook.peer.Jlib.BJBorder")

	   ;; BJCanvas
	   (class %bglk-canvas::%swing-jpanel
	      (constructor new (::procedure))
	      (field public peer::obj "peer")
	      "bigloo.biglook.peer.Jlib.BJCanvas")

	   ;; BJTreeCellRenderer
	   (class %bglk-treecellrenderer::%swing-treecellrenderer
	      (constructor new (::procedure ::procedure ::procedure))
	      "bigloo.biglook.peer.Jlib.BJTreeCellRenderer")
	   
	   ;; BJTreeNode
	   (class %bglk-treenode::%swing-defaultmutabletreenode
	      (constructor new (::%jobject ::bool))
	      (method add!::void
		      (::%bglk-treenode ::%awt-component)
		      "add")
	      (method full-path::%swing-treepath
		      (::%bglk-treenode)
		      "getFullPath")
	      "bigloo.biglook.peer.Jlib.BJTreeNode")

	   ;; BJTableModel
	   (class %bglk-tablemodel::%swing-abstracttablemodel
	      (constructor new
			   (::obj ::vector ::procedure))
	      (method getrowcount::int
		      (::%bglk-tablemodel)
		      "getRowCount")
	      (method addrows::void
		      (::%bglk-tablemodel ::int)
		      "addRows")
	      (method removerows::void
		      (::%bglk-tablemodel ::int)
		      "removeRows")
	      "bigloo.biglook.peer.Jlib.BJTableModel")
	   
	   ;; Bglk
	   (class %bglk
	      (method static register-object::void
		      (::%jobject ::%jobject)
		      "register_bglk_object")
	      (method static unregister-object::void
		      (::%jobject)
		      "unregister_bglk_object")
	      (method static get-object::obj
		      (::%jobject)
		      "get_bglk_object")
	      (method static get-applet::%swing-japplet
		      ()
		      "get_applet")
	      (method static bool->jobject::%jobject
		      (::bool)
		      "bool_to_jobject")
	      (method static object->jobject::%jobject
		      (::object)
		      "object_to_jobject")
	      (method static bstring->jstring::%jstring
		      (::string)
		      "bstring_to_jstring")
	      (method static jstring->bstring::string
		      (::%jstring)
		      "jstring_to_bstring")
	      (method static jgridbaglayoutadd!::void
		      (::%awt-panel
		       ::%awt-component
		       ::int ::int ::int ::int
		       ::bool ::bool ::bool)
		      "gridbag_add")
	      (method static get-bglk-default-font::%awt-font
		      ()
		      "get_bglk_default_font")
	      (method static input-event-time::int
		      (::%awt-inputevent)
		      "getWhen")
	      (method static buttongroup-buttons::pair-nil
		      (::%swing-buttongroup)
		      "bglk_buttongroup_buttons")
	      (method static idle::void
		      (::procedure)
		      "after_idle")
	      (method static show-filechooser::int
		      (::%swing-jfilechooser ::%jstring)
		      "show_dialog")
	      (method static tree-node-items::pair-nil
		      (::%swing-treenode)
		      "bglk_treenode_items")
	      (method static listselectionevent-selection::int
		      (::%swing-listselectionevent)
		      "bglk_listselectionevent_selection")
	      "bigloo.biglook.peer.Jlib.Bglk"))
   
   (export (class %peer
	      ;; constructor
	      (%peer-init)
	      ;; the builtin object
	      %builtin::%jobject
	      ;; the biglook object
	      (%bglk-object
	       (get peer-%bglk-object)
	       (set peer-%bglk-object-set!))
	      ;; the event descriptor of that peer object
	      (%event (default #f)))
	   
	   (generic %peer-init ::%peer)
	   
	   (peer-%bglk-object ::%peer)
	   (peer-%bglk-object-set! ::%peer ::obj)))

;*---------------------------------------------------------------------*/
;*    %peer-init ...                                                   */
;*---------------------------------------------------------------------*/
(define-generic (%peer-init peer::%peer)
   ;(%awt-component-visible-set! (%peer-%builtin peer) #t)
   peer)

;*---------------------------------------------------------------------*/
;*    object-print ::%peer ...                                         */
;*---------------------------------------------------------------------*/
(define-method (object-print peer::%peer port pslot)
   (display "#<JVM-PEER>" port))

;*---------------------------------------------------------------------*/
;*    peer-%bglk-object ...                                            */
;*---------------------------------------------------------------------*/
(define (peer-%bglk-object o::%peer)
   (%bglk-get-object (%peer-%builtin o)))

;*---------------------------------------------------------------------*/
;*    peer-%bglk-object-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (peer-%bglk-object-set! o::%peer v::obj)
   (%bglk-register-object (%peer-%builtin o) v)
   o)
