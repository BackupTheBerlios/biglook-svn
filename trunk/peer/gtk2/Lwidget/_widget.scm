;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_widget.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Jul 25 15:10:04 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Widget implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/widget.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%widget
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%color
   	   __biglook_%cursor
           )
   
   (extern (macro %%gtk-tooltips-new::gtktooltips* ()
		  "gtk_tooltips_new")
	   (macro %%gtk-tooltips-set-tip::void (::gtktooltips*
						::gtkwidget*
						::string
						::string)
		  "gtk_tooltips_set_tip")
	   (macro %%bglk-tooltips?::bool (::gtkwidget*)
		  "BGLK_TOOLTIPS_P")
	   (macro %%bglk-tooltips-text::string (::gtkwidget*)
		  "BGLK_TOOLTIPS_TEXT")
	   (macro %%gtk-widget-state-set!::void (::gtkwidget* ::int)
		  "gtk_widget_set_state")
	   (macro %%gtk-widget-state::int (::gtkwidget*)
		  "GTK_WIDGET_STATE")
	   (macro %%GTK_STATE_NORMAL::int
		  "GTK_STATE_NORMAL")
	   (macro %%GTK_STATE_INSENSITIVE::int
		  "GTK_STATE_INSENSITIVE")
		   
	   (macro %%bglk-gtk-widget-width::int (::gtkwidget*)
		  "BGLK_GTK_WIDGET_WIDTH")
	   (macro %%bglk-gtk-widget-height::int (::gtkwidget*)
		  "BGLK_GTK_WIDGET_HEIGHT")
	   (macro %%bglk-gtk-widget-x::int (::gtkwidget*)
		  "BGLK_GTK_WIDGET_X")
	   (macro %%bglk-gtk-widget-y::int (::gtkwidget*)
		  "BGLK_GTK_WIDGET_Y")

	   (macro %%gtk-widget-name-set!::void (::gtkwidget* ::string)
		  "gtk_widget_set_name")
	   (macro %%gtk-widget-name::string (::gtkwidget*)
		  "gtk_widget_get_name")
	   
	   (macro %%gtk-object-destroy::void (::gtkobject*)
		  "gtk_object_destroy")
	   (macro %%gtk-widget-destroy::void (::gtkwidget*)
		  "gtk_widget_destroy")

	   (macro %%gtk-widget-hide!::void (::gtkwidget*)
		  "gtk_widget_hide")

	   (macro %bglk-gtk-widget-sensitive::bool (::gtkwidget*)
		  "GTK_WIDGET_SENSITIVE")
	   (macro %%gtk-widget-set-sensitive!::void (::gtkwidget* ::bool)
		  "gtk_widget_set_sensitive")
	   
	   (macro %%gtk-widget-modify-font!::void (::gtkwidget* ::pangofont*)
		  "gtk_widget_modify_font"))
   
   (export (class %widget::%peer)
	   
	   (%widget-parent ::%bglk-object)
	   
	   (%widget-event::obj ::%bglk-object)
	   (%widget-event-set! ::%bglk-object ::obj)
	   
	   (%widget-width::int ::%bglk-object)
	   (%widget-width-set! ::%bglk-object ::int)
	   
	   (%widget-height::int ::%bglk-object)
	   (%widget-height-set! ::%bglk-object ::int)
	   
	   (%widget-tooltips::obj ::%bglk-object)
	   (%widget-tooltips-set! ::%bglk-object ::obj)
	   
	   (%widget-active?::bool ::%bglk-object)
	   (%widget-active?-set! ::%bglk-object v::bool)
	   
	   (%widget-name::bstring ::%bglk-object)
	   (%widget-name-set! ::%bglk-object ::bstring)
	   
	   (%widget-visible::bool ::%bglk-object)
	   (%widget-visible-set! ::%bglk-object ::bool)
	   
	   (%widget-enabled::bool ::%bglk-object)
	   (%widget-enabled-set! ::%bglk-object ::bool)

	   (%widget-can-focus?::bool ::%bglk-object)
	   (%widget-can-focus?-set! ::%bglk-object ::bool)

           (%widget-cursor ::%bglk-object)
	   (%widget-cursor-set! ::%bglk-object ::obj)

	   (%destroy-widget ::%bglk-object)
	   (%repaint-widget ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %widget-parent ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-parent o::%bglk-object)
   (let ((parent (g-property-get o "parent")))
      (if (%bglk-object? parent)
	  (g-property-get parent "user-data")
	  #unspecified)))

;*---------------------------------------------------------------------*/
;*    %widget-event ...                                                */
;*---------------------------------------------------------------------*/
(define (%widget-event o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%event)
      %event))

;*---------------------------------------------------------------------*/
;*    %widget-event-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-event-set! o::%bglk-object v)
   (with-access::%peer (%bglk-object-%peer o) (%event)
      (set! %event v)))

;*---------------------------------------------------------------------*/
;*    %widget-width ...                                                */
;*---------------------------------------------------------------------*/
(define (%widget-width::int o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gtk-widget-width (gtkwidget %builtin))))

;*---------------------------------------------------------------------*/
;*    %widget-width-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-width-set! o::%bglk-object v::int)
   (g-property-type-set! o "width-request" v G-TYPE-INT))

;*---------------------------------------------------------------------*/
;*    %widget-height ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-height::int o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%bglk-gtk-widget-height (gtkwidget %builtin))))

;*---------------------------------------------------------------------*/
;*    %widget-height-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%widget-height-set! o::%bglk-object v::int)
   (g-property-type-set! o "height-request" v G-TYPE-INT))

;*---------------------------------------------------------------------*/
;*    %widget-tooltips ...                                             */
;*---------------------------------------------------------------------*/
(define (%widget-tooltips o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (if (%%bglk-tooltips? (gtkwidget %builtin))
	  (%%bglk-tooltips-text (gtkwidget %builtin)))))

;*---------------------------------------------------------------------*/
;*    %widget-tooltips-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%widget-tooltips-set! o::%bglk-object v)
   (if v
       (with-access::%bglk-object o (%peer)
	  (let ((tt::gtktooltips* (%%gtk-tooltips-new)))
	     (%%gtk-tooltips-set-tip tt
				     (gtkwidget (%peer-%builtin %peer))
				     v
				     "")
	     v))))

;*---------------------------------------------------------------------*/
;*    %widget-active? ...                                              */
;*---------------------------------------------------------------------*/
(define (%widget-active?::bool o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (not (=fx (%%gtk-widget-state (gtkwidget %builtin))
		%%GTK_STATE_INSENSITIVE))))

;*---------------------------------------------------------------------*/
;*    %widget-active?-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-active?-set! o::%bglk-object v::bool)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-widget-state-set!
       (gtkwidget %builtin)
       (if v %%GTK_STATE_NORMAL %%GTK_STATE_INSENSITIVE))
      o))

;*---------------------------------------------------------------------*/
;*    %widget-name ...                                                 */
;*---------------------------------------------------------------------*/
(define (%widget-name o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-widget-name (gtkwidget %builtin))))

;*---------------------------------------------------------------------*/
;*    %widget-name-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%widget-name-set! o::%bglk-object v)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (let ((old (%%gtk-widget-name (gtkwidget %builtin))))
	 (%%gtk-widget-name-set! (gtkwidget %builtin)
				 (string-append old "." v))
	 v)))

;*---------------------------------------------------------------------*/
;*    %widget-visible ...                                              */
;*---------------------------------------------------------------------*/
(define (%widget-visible::bool o::%bglk-object)
   (g-property-get o "visible"))

;*---------------------------------------------------------------------*/
;*    %widget-visible-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-visible-set! o::%bglk-object v::bool)
   (g-property-set! o "visible" v))


;*---------------------------------------------------------------------*/
;*    %widget-enabled ...                                              */
;*---------------------------------------------------------------------*/
(define (%widget-enabled::bool o::%bglk-object)
  (with-access::%peer (%bglk-object-%peer o) (%builtin)
     (%bglk-gtk-widget-sensitive (gtkwidget %builtin))))
;*---------------------------------------------------------------------*/
;*    %widget-enabled-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-enabled-set! o::%bglk-object v::bool)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-widget-set-sensitive! (gtkwidget %builtin) v))
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %widget-can-focus? ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-can-focus?::bool o::%bglk-object)
   (g-property-get o "can-focus"))

;*---------------------------------------------------------------------*/
;*    %widget-can-focus?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%widget-can-focus?-set! o::%bglk-object v::bool)
   (g-property-set! o "can-focus" v))

;*---------------------------------------------------------------------*/
;*    %destroy-widget ...                                              */
;*---------------------------------------------------------------------*/
(define (%destroy-widget o::%bglk-object)
  (let ((widget (bglkwidget (%bglk-object-%peer o)))
	(parent (%widget-parent o)))
    (%%gtk-widget-destroy widget)
    (when (%bglk-object? parent)
	  (%%bglk-window-reshow-with-initial-size (bglkwidget (%bglk-object-%peer parent)))
	  #unspecified))
  o)

;*---------------------------------------------------------------------*/
;*    %repaint-widget ...                                              */
;*---------------------------------------------------------------------*/
(define (%repaint-widget o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (when (%widget-visible o)
	    (%%gtk-widget-hide! (gtkwidget %builtin))
	    (%%widget-show (gtkwidget %builtin))
	    #unspecified))
   o)

;*---------------------------------------------------------------------*/
;*    %widget-cursor ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-cursor o::%bglk-object)
   (not-implemented o "%widget-cursor"))

;*---------------------------------------------------------------------*/
;*    %widget-can-focus?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%widget-cursor-set! o::%bglk-object v::obj)
   (not-implemented o "%widget_cursor-set!"))
