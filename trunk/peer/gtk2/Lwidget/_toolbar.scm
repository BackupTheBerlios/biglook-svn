;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_toolbar.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jul 15 17:43:51 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Tool implementation.                                */
;*    definition: @path ../../../biglook/Lwidget/toolbar.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%toolbar
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%gtk-misc
	   __biglook_%container
	   __biglook_%callback)
   
   (extern  (macro %%gtk-toolbar-new::gtkwidget*
		   ()
		   "gtk_toolbar_new")
	    
	    ;; toolbar misc functions
	    (macro %%bglk-gtk-toolbar-orientation::int
		   (::gtktoolbar*)
		   "gtk_toolbar_get_orientation")
	    (macro %%gtk-toolbar-set-orientation::void
		   (::gtktoolbar* ::int)
		   "gtk_toolbar_set_orientation")
	    (macro %%bglk-gtk-toolbar-space-size::int
		   (::gtktoolbar*)
		   "bglk_toolbar_space_size")
	    (macro %%gtk-toolbar-get-relief::int
		   (::gtktoolbar*)
		   "bglk_toolbar_button_relief")
	    (macro %%gtk-toolbar-set-space-style::void
		   (::gtktoolbar* ::int)
		   "gtk_toolbar_set_space_style")
	    (macro %%gtk-toolbar-set-style::void
		   (::gtktoolbar* ::int)
		   "gtk_toolbar_set_style")
	    (macro %%bglk-gtk-toolbar-get-style::int
		   (::gtktoolbar*)
		   "gtk_toolbar_get_style")
	     
	    ;; item insertion
	    (macro %%gtk-toolbar-append-widget::void
		   (::gtktoolbar* ::gtkwidget* ::string ::string)
		   "gtk_toolbar_append_widget")
	    (macro %%gtk-toolbar-append-item::void
		   (::gtktoolbar* ::string ::string ::string
				  ::gtkwidget*
				  ::gtksignalfunc
				  ::gpointer)
		   "gtk_toolbar_append_item")
	    (macro %%gtk-toolbar-append-space::void
		   (::gtktoolbar*)
		   "gtk_toolbar_append_space")
	    
	    ;; toolbar orientation
	    (macro %%gtk-toolbar-orientation-horizontal::int
		   "GTK_ORIENTATION_HORIZONTAL")
	    (macro %%gtk-toolbar-orientation-vertical::int
		   "GTK_ORIENTATION_VERTICAL")
	    
	    ;; toolbar styles
	    (macro %%gtk-toolbar-style-icons::int
		   "GTK_TOOLBAR_ICONS")
	    (macro %%gtk-toolbar-style-text::int
		   "GTK_TOOLBAR_TEXT")
	    (macro %%gtk-toolbar-style-both::int
		   "GTK_TOOLBAR_BOTH")
	    
	    ;; child style
	    (macro %%gtk-toolbar-child-space::int
		   "GTK_TOOLBAR_CHILD_SPACE")
	    (macro %%gtk-toolbar-child-button::int
		   "GTK_TOOLBAR_CHILD_BUTTON")
	    (macro %%gtk-toolbar-child-togglebutton::int
		   "GTK_TOOLBAR_CHILD_TOGGLEBUTTON")
	    (macro %%gtk-toolbar-child-radiobutton::int
		   "GTK_TOOLBAR_CHILD_RADIOBUTTON")
	    (macro %%gtk-toolbar-child-widget::int
		   "GTK_TOOLBAR_CHILD_WIDGET")
	    
	    ;; space styles
	    (macro %%gtk-toolbar-space-empty::int
		   "GTK_TOOLBAR_SPACE_EMPTY")
	    (macro %%gtk-toolbar-space-line::int
		   "GTK_TOOLBAR_SPACE_LINE")
	    
	    ;; misc
	    (macro %%string-null::string "0L")
	    (macro %%widget-null::gtkwidget* "0L")
	    
	    ;; handle
	    (macro %%gtk-handle-new::gtkwidget* ()
		   "gtk_handle_box_new")
	    (macro %%gtk-handle-box-set-handle-position::void
		   (::gtkhandlebox* ::int)
		   "gtk_handle_box_set_handle_position")
	    (macro %%gtk-handle-box-set-snap-edge::void
		   (::gtkhandlebox* ::int)
		   "gtk_handle_box_set_snap_edge")
	    (macro %%bglk-gtk-handle-get-shadow::int
		   (::gtkhandlebox*)
		   "BGLK_HANDLE_BOX_GET_SHADOW_TYPE")
	    (macro %%gtk-handle-set-shadow::void
		   (::gtkhandlebox* ::int)
		   "gtk_handle_box_set_shadow_type")
	    
	    (macro %%gtk-handle-pos-left::int
		   "GTK_POS_LEFT")
	    (macro %%gtk-handle-pos-right::int
		   "GTK_POS_RIGHT")
	    (macro %%gtk-handle-pos-top::int
		   "GTK_POS_TOP")
	    (macro %%gtk-handle-pos-bottom::int
		   "GTK_POS_BOTTOM"))
   
   (static (abstract-class %toolbar::%container
	      (%toolbar::gtktoolbar* read-only)
	      (%gc-callbacks::pair-nil (default '())))
	   
	   (class %toolbar-floating::%toolbar)
	   
	   (class %toolbar-still::%toolbar))
   
   (export (%make-%toolbar ::%bglk-object ::bool)
	   
	   (%toolbar-shadow::symbol ::%bglk-object)
	   (%toolbar-shadow-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-relief::symbol ::%bglk-object)
	   (%toolbar-relief-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-orientation::symbol ::%bglk-object)
	   (%toolbar-orientation-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-space-size::int ::%bglk-object)
	   (%toolbar-space-size-set! ::%bglk-object ::int)
	   
	   (%toolbar-add! ::%bglk-object ::%bglk-object ::obj ::obj)
	   (%toolbar-item-add! ::%bglk-object ::obj ::obj ::obj ::obj ::obj)))

;*---------------------------------------------------------------------*/
;*    %make-%toolbar ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%toolbar o::%bglk-object floating)
   (let ((tl (%%gtk-toolbar-new)))
      (if floating
	  (%make-floating-toolbar o tl)
	  (%make-still-toolbar o tl))))

;*---------------------------------------------------------------------*/
;*    %make-floating-toolbar ...                                       */
;*---------------------------------------------------------------------*/
(define (%make-floating-toolbar o::%bglk-object tl::gtkwidget*)
   (let ((handle (gtkobject (%%gtk-handle-new))))
      ;; show the toolbar
      (%%widget-show tl)
      ;; add it to the gtk handle box
      (%%gtk-container-add! (gtkcontainer handle) tl)
      ;; connect it to the Biglook widget
      (%bglk-g-property-type-set! (gobject (gtkobject tl)) "user-data" o G-TYPE-POINTER)
      (instantiate::%toolbar-floating
	 (%bglk-object o)
	 (%toolbar (gtktoolbar (gtkobject tl)))
	 (%builtin handle))))

;*---------------------------------------------------------------------*/
;*    %make-still-toolbar ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-still-toolbar o::%bglk-object tl::gtkwidget*)
   (instantiate::%toolbar-still
      (%toolbar (gtktoolbar (gtkobject tl)))
      (%bglk-object o)
      (%builtin (gtkobject tl))))

;*---------------------------------------------------------------------*/
;*    %toolbar-shadow ...                                              */
;*---------------------------------------------------------------------*/
(define (%toolbar-shadow::symbol o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (if (%toolbar-floating? %peer)
	  (with-access::%toolbar %peer (%builtin)
	     (gtk-shadow->biglook
	      (%%bglk-gtk-handle-get-shadow (gtkhandlebox %builtin))))
	  'none)))

;*---------------------------------------------------------------------*/
;*    %toolbar-shadow-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-shadow-set! o::%bglk-object v::symbol)
   (with-access::%bglk-object o (%peer)
      (if (%toolbar-floating? %peer)
	  (with-access::%toolbar %peer (%builtin)
	     (%%gtk-handle-set-shadow (gtkhandlebox %builtin)
				      (biglook-shadow->gtk v))
	     o))))

;*---------------------------------------------------------------------*/
;*    %toolbar-relief ...                                              */
;*---------------------------------------------------------------------*/
(define (%toolbar-relief::symbol o::%bglk-object)
   (with-access::%toolbar (%bglk-object-%peer o) (%toolbar)
      (gtk-relief->biglook (%%gtk-toolbar-get-relief %toolbar))))

;*---------------------------------------------------------------------*/
;*    %toolbar-relief-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-relief-set! o::%bglk-object v::symbol)
  ;; !!!! Not settable in Gtk2? -- goga
  o)

;*---------------------------------------------------------------------*/
;*    %toolbar-orientation ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-orientation::symbol o::%bglk-object)
   (with-access::%toolbar (%bglk-object-%peer o) (%toolbar)
      (let ((orien (%%bglk-gtk-toolbar-orientation %toolbar)))
	 (cond
	    ((=fx orien %%gtk-toolbar-orientation-horizontal)
	     'horizontal)
	    ((=fx orien %%gtk-toolbar-orientation-vertical)
	     'vertical)
	    (else
	     (error "toolbar-orientation" "Illegal orientation" orien))))))

;*---------------------------------------------------------------------*/
;*    %toolbar-orientation-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%toolbar-orientation-set! o::%bglk-object v::symbol)
   (with-access::%bglk-object o (%peer)
      (with-access::%toolbar %peer (%toolbar %builtin)
	 ;; the orientation of the toolbar
	 (let ((toolbar-orien (case v
				 ((vertical)
				  %%gtk-toolbar-orientation-vertical)
				 ((horizontal)
				  %%gtk-toolbar-orientation-horizontal)
				 (else
				  (error "toolbar-orientation-set!"
					 "Illegal orientation"
					 v)))))
	    (%%gtk-toolbar-set-orientation %toolbar toolbar-orien))
	 ;; and if needed the position of the handle
	 (if (%toolbar-floating? %peer)
	     (let ((handle-pos (case v
				  ((vertical)
				   %%gtk-handle-pos-top)
				  ((horizontal)
				   %%gtk-handle-pos-left))))
		(%%gtk-handle-box-set-handle-position (gtkhandlebox %builtin)
						      handle-pos)
		o)))))

;*---------------------------------------------------------------------*/
;*    %toolbar-space-size ...                                          */
;*---------------------------------------------------------------------*/
(define (%toolbar-space-size::int o::%bglk-object)
   (with-access::%toolbar (%bglk-object-%peer o) (%toolbar)
      (%%bglk-gtk-toolbar-space-size %toolbar)))

;*---------------------------------------------------------------------*/
;*    %toolbar-space-size-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%toolbar-space-size-set! o::%bglk-object v::int)
  ;; !!! Not settable in Gtk2? -- goga
  o)

;*---------------------------------------------------------------------*/
;*    %toolbar-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%toolbar-add! c::%bglk-object w::%bglk-object space tip)
   (with-access::%toolbar (%bglk-object-%peer c) (%toolbar %gc-children)
      ;; GC protection
      (set! %gc-children (cons w %gc-children))
      (if space
	  (begin
	     (%%gtk-toolbar-append-space %toolbar)
	     c))
      (%%gtk-toolbar-append-widget %toolbar
				   (gtkwidget
				    (%peer-%builtin (%bglk-object-%peer w)))
				   (if (string? tip) tip %%string-null)
				   %%string-null)
      c))
   
;*---------------------------------------------------------------------*/
;*    %toolbar-item-add! ...                                           */
;*    -------------------------------------------------------------    */
;*    When this function is called, the Biglook library has already    */
;*    called to the %INSTALL-TOOLBAR-EVENT-HANDLER! function.          */
;*---------------------------------------------------------------------*/
(define (%toolbar-item-add! c::%bglk-object text icon space tooltips command)
   (with-access::%toolbar (%bglk-object-%peer c) (%toolbar
						  %gc-callbacks
						  %gc-children)
      ;; store the callback to prevent GC reclaim on these objects
      (if (procedure? command)
	  (set! %gc-callbacks (cons command %gc-callbacks)))
      ;; add the space 
      (if space
	  (begin
	     (%%gtk-toolbar-append-space %toolbar)
	     c))
      ;; add the text/icon
      (let ((tooltips::string (if (string? tooltips)
				  tooltips
				  %%string-null)))
	 (cond
	    ((and (string? text) (%bglk-object? icon))
	     (set! %gc-children (cons icon %gc-children))
	     (%%gtk-toolbar-set-style %toolbar %%gtk-toolbar-style-both)
	     (%%gtk-toolbar-append-item %toolbar
					;; text
					text
					;; tooltips
					tooltips
					;; private tooltips
					%%string-null
					;; icon
					(gtkwidget
					 (%peer-%builtin
					  (%bglk-object-%peer icon)))
					;; callback
					%%bglk-toolbar-callback
					(%%obj->gpointer command))
	     c)
	    ((string? text)
	     (cond
		((=fx (%%bglk-gtk-toolbar-get-style %toolbar)
		      %%gtk-toolbar-style-icons)
		 (%%gtk-toolbar-set-style %toolbar %%gtk-toolbar-style-both)
		 c)
		((not (=fx (%%bglk-gtk-toolbar-get-style %toolbar)
			   %%gtk-toolbar-style-both))
		 (%%gtk-toolbar-set-style %toolbar %%gtk-toolbar-style-text)
		 c))
	     (%%gtk-toolbar-append-item %toolbar
					;; text
					text
					;; tooltips
					tooltips
					;; private tooltips
					%%string-null
					;; icon
					%%widget-null
					;; callback
					%%bglk-toolbar-callback
					(%%obj->gpointer command))
	     c)
	    ((%bglk-object? icon)
	     (set! %gc-children (cons icon %gc-children))
	     (cond
		((=fx (%%bglk-gtk-toolbar-get-style %toolbar)
		      %%gtk-toolbar-style-text)
		 (%%gtk-toolbar-set-style %toolbar %%gtk-toolbar-style-both)
		 c)
		((not (=fx (%%bglk-gtk-toolbar-get-style %toolbar)
			   %%gtk-toolbar-style-both))
		 (%%gtk-toolbar-set-style %toolbar %%gtk-toolbar-style-icons)
		 c))
	     (%%gtk-toolbar-append-item %toolbar
					;; text
					%%string-null
					;; tooltips
					tooltips
					;; private tooltips
					%%string-null
					;; icon
					(gtkwidget
					 (%peer-%builtin
					  (%bglk-object-%peer icon)))
					;; callback
					%%bglk-toolbar-callback
					(%%obj->gpointer command))
	     c)))))

