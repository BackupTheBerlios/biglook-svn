;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_peer.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 31 13:34:23 2001                          */
;*    Last change :  Sun Jul 15 08:12:32 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The implementation of the peer object.                           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%peer
   
   (import __biglook_%error
	   __biglook_%bglk-object
	   __biglook_%gtk-misc)

   (extern
    ;; Include gtk main header so that everyone can see
    ;; all its structures' fields
    (include "gtk/gtk.h")
    (include "gnome.h")
    (include "biglook_peer.h")
    
    ;; GTk types.
    (type gtkobject*          (opaque) "GtkObject*")
    (type gtkbin*             (opaque) "GtkBin*")
    (type gtkbox*             (opaque) "GtkBox*")
    (type gtkbutton*          (opaque) "GtkButton*")
    (type gtktogglebutton*    (opaque) "GtkToggleButton*")
    (type gtkradiobutton*     (opaque) "GtkRadioButton*")
    (type gtkcheckbutton*     (opaque) "GtkCheckButton*")
    (type gtkcombo*           (opaque) "GtkCombo*")
    (type gtkcontainer*       (opaque) "GtkContainer*")
    (type gtkmisc*            (opaque) "GtkMisc*")
    (type gtkeditable*        (opaque) "GtkEditable*")
    (type gtkentry*           (opaque) "GtkEntry*")
    (type gtkhbox*            (opaque) "GtkHBox*")
    (type gtkitem*            (opaque) "GtkItem*")
    (type gtklabel*           (opaque) "GtkLabel*")
    (type gtklist*            (opaque) "GtkList*")
    (type gtklistitem*        (opaque) "GtkListItem*")
    (type gtkmenu*            (opaque) "GtkMenu*")
    (type gtkmenubar*         (opaque) "GtkMenuBar*")
    (type gtkmenuitem*        (opaque) "GtkMenuItem*")
    (type gtkoptionmenu*      (opaque) "GtkOptionMenu*")
    (type gtktearoffmenuitem* (opaque) "GtkTearoffMenuItem*")
    (type gtkcheckmenuitem*   (opaque) "GtkCheckMenuItem*")
    (type gtkradiomenuitem*   (opaque) "GtkRadioMenuItem*")
    (type gtkmenushell*       (opaque) "GtkMenuShell*")
    (type gtkpacker*          (opaque) "GtkPacker*")
    (type gtktable*           (opaque) "GtkTable*")
    (type gtkpackerchild*     (opaque) "GtkPackerChild*")
    (type gtkvbox*            (opaque) "GtkVBox*")
    (type gtkwidget*          (opaque) "GtkWidget*")
    (type gtkwindow*          (opaque) "GtkWindow*")
    (type gtkframe*           (opaque) "GtkFrame*")
    (type gtkpaned*           (opaque) "GtkPaned*")
    (type gtknotebook*        (opaque) "GtkNotebook*")
    (type gtkscrollframe*     (opaque) "GtkScrolledWindow*")
    (type gtkscrollbar*       (opaque) "GtkScrollbar*")
    (type gtktooltips*        (opaque) "GtkTooltips*")
    (type gtktoolbar*         (opaque) "GtkToolbar*")
    (type gtkhandlebox*       (opaque) "GtkHandleBox*")
    (type gtkcolorselection*  (opaque) "GtkColorSelection*")
    (type gtkfontselection*   (opaque) "GtkFontSelection*")
    (type gtkfileselection*   (opaque) "GtkFileSelection*")
    (type gtkscale*           (opaque) "GtkScale*")
    (type gtkrange*           (opaque) "GtkRange*")
    (type gtkadjustment*      (opaque) "GtkAdjustment*")
    (type gtktree*            (opaque) "GtkTree*")
    (type gtktreeitem*        (opaque) "GtkTreeItem*")
    (type gtkprogress*        (opaque) "GtkProgress*")
    (type gtkprogressbar*     (opaque) "GtkProgressBar*")
    (type gtktext*            (opaque) "GtkText*")
    (type gtkspinbutton*      (opaque) "GtkSpinButton*")
    (type gtkclist*           (opaque) "GtkCList*")
    
    (type gtktype             (opaque) "GtkType")
    (type gtksignalfunc       (opaque) "GtkSignalFunc")
    (type gtkjustification    (opaque) "GtkJustification")
    (type glist*              (opaque) "GList*")
    (type gslist*             (opaque) "GSList*")
    (type gtkstatetype        (opaque) "GtkStateType")
    
    (type gint                (opaque) "gint")
    (type guint               (opaque) "guint")
    (type gchar*              (opaque) "gchar*")
    (type gchar**             (opaque) "gchar**")
    (type gdouble*            (opaque) "gdouble*")
    (type gpointer            (opaque) "gpointer")
    (type gsourcefunc         (opaque) "GSourceFunc")
    
    (type gdkcolor*           (opaque) "GdkColor*")
    (type gdkfont*            (opaque) "GdkFont*")
    (type gdkevent*           (opaque) "GdkEvent*")
    
    (type gnomecanvas*        (opaque) "GnomeCanvas*")
    (type gnomecanvasitem*    (opaque) "GnomeCanvasItem*")
    (type gnomecanvasgroup*   (opaque) "GnomeCanvasGroup*")
    (type gnomecanvaspoint*   (opaque) "GnomeCanvasPoints*")
    
    (type gdkpixbuf*          (opaque) "GdkPixbuf*")
    (type gdkpixmap*          (opaque) "GdkPixmap*")
    (type gdkbitmap*          (opaque) "GdkBitmap*")
    
    (macro opaque::obj      (opaque) "(obj_t)")
    
    (macro GTK-TYPE-INT::int "GTK_TYPE_INT")
    (macro GTK-TYPE-UINT::int "GTK_TYPE_UINT")
    (macro GTK-TYPE-ULONG::int "GTK_TYPE_ULONG")
    (macro GTK-TYPE-FLOAT::int "GTK_TYPE_FLOAT")
    (macro GTK-TYPE-POINTER::int "GTK_TYPE_POINTER")
    (macro GTK-TYPE-ENUM::int "GTK_TYPE_ENUM")
    (macro GTK-TYPE-JUSTIFICATION::int "GTK_TYPE_JUSTIFICATION")
    (macro GTK-TYPE-POSITION::int "GTK_TYPE_POSITION_TYPE")
    (macro GTK-TYPE-RELIEF-STYLE::int "GTK_TYPE_RELIEF_STYLE")
    (macro GTK-TYPE-SHADOW-TYPE::int "GTK_TYPE_SHADOW_TYPE")
    (macro GTK-TYPE-ANCHOR-TYPE::int "GTK_TYPE_ANCHOR_TYPE")
    (macro GTK-TYPE-BOOL::int "GTK_TYPE_BOOL")
    (macro GTK-TYPE-PROGRESS-BAR-STYLE::int "GTK_TYPE_PROGRESS_BAR_STYLE")
    (macro GTK-TYPE-GNOME-CANVAS-POINTS::int "GTK_TYPE_GNOME_CANVAS_POINTS")
    (macro GTK-TYPE-BOXED::int "GTK_TYPE_BOXED")
    (macro GTK-TYPE-POLICY-TYPE::int "GTK_TYPE_POLICY_TYPE")
    (macro GTK-TYPE-CORNER-TYPE::int "GTK_TYPE_CORNER_TYPE")
    (macro GTK-TYPE-SELECTION-TYPE::int " GTK_TYPE_SELECTION_MODE")
    (macro GTK-TYPE-OBJECT::int "GTK_TYPE_OBJECT")
    
    ;; GTk enum constants
    ;; gtkjustification
    (macro gtk-justify-fill::long      "GTK_JUSTIFY_FILL")
    (macro gtk-justify-left::long      "GTK_JUSTIFY_LEFT")
    (macro gtk-justify-right::long     "GTK_JUSTIFY_RIGHT")
    (macro gtk-justify-center::long    "GTK_JUSTIFY_CENTER")
    ;; gtkposition
    (macro gtk-position-top::long      "GTK_POS_TOP")
    (macro gtk-position-left::long     "GTK_POS_LEFT")
    (macro gtk-position-right::long    "GTK_POS_RIGHT")
    (macro gtk-position-bottom::long   "GTK_POS_BOTTOM")
    ;; gtkcorner
    (macro gtk-corner-top-left::long     "GTK_CORNER_TOP_LEFT")
    (macro gtk-corner-bottom-left::long  "GTK_CORNER_BOTTOM_LEFT")
    (macro gtk-corner-top-right::long    "GTK_CORNER_TOP_RIGHT")
    (macro gtk-corner-bottom-right::long "GTK_CORNER_BOTTOM_RIGHT")
    ;; attach
    (macro gtk-expand::long            "GTK_EXPAND")
    (macro gtk-shrink::long            "GTK_SHRINK")
    (macro gtk-fill::long              "GTK_FILL")
    ;; gtkstatetype
    (macro gtk-state-normal::long      "GTK_STATE_NORMAL")
    (macro gtk-state-active::long      "GTK_STATE_ACTIVE")
    (macro gtk-state-prelight::long    "GTK_STATE_PRELIGHT")
    (macro gtk-state-selected::long    "GTK_STATE_SELECTED")
    (macro gtk-state-insensitive::long "GTK_STATE_INSENSITIVE")
    ;; gtkwindowtypes
    (macro %%gtk-window-toplevel::long "GTK_WINDOW_TOPLEVEL")
    (macro %%gtk-window-popup::long    "GTK_WINDOW_POPUP")
    (macro %%gtk-window-dialog::long   "GTK_WINDOW_DIALOG")
    ;; gtkresizemode
    (macro gtk-resize-parent::long    "GTK_RESIZE_PARENT")
    (macro gtk-resize-queue::long     "GTK_RESIZE_QUEUE")
    (macro gtk-resize-immediate::long "GTK_RESIZE_IMMEDIATE")
    ;; gtksidetype
    (macro gtk-side-top::long         "GTK_SIDE_TOP")
    (macro gtk-side-bottom::long      "GTK_SIDE_BOTTOM")
    (macro gtk-side-left::long        "GTK_SIDE_LEFT")
    (macro gtk-side-right::long       "GTK_SIDE_RIGHT")
    ;; gtkanchortype
    (macro gtk-anchor-center::long    "GTK_ANCHOR_CENTER")
    (macro gtk-anchor-n::long         "GTK_ANCHOR_N")
    (macro gtk-anchor-nw::long        "GTK_ANCHOR_NW")
    (macro gtk-anchor-ne::long        "GTK_ANCHOR_NE")
    (macro gtk-anchor-s::long         "GTK_ANCHOR_S")
    (macro gtk-anchor-sw::long        "GTK_ANCHOR_SW")
    (macro gtk-anchor-se::long        "GTK_ANCHOR_SE")
    (macro gtk-anchor-w::long         "GTK_ANCHOR_W")
    (macro gtk-anchor-e::long         "GTK_ANCHOR_E")
    ;; gtkpackeroptions
    (macro gtk-pack-expand::long      "GTK_PACK_EXPAND")
    (macro gtk-fill-x::long           "GTK_FILL_X")
    (macro gtk-fill-y::long           "GTK_FILL_Y")
    ;; relief
    (macro gtk-relief-normal::int     "GTK_RELIEF_NORMAL")
    (macro gtk-relief-half::int       "GTK_RELIEF_HALF")
    (macro gtk-relief-none::int       "GTK_RELIEF_NONE")
    ;; shadow
    (macro gtk-shadow-none::int       "GTK_SHADOW_NONE")
    (macro gtk-shadow-in::int         "GTK_SHADOW_IN")
    (macro gtk-shadow-out::int        "GTK_SHADOW_OUT")
    (macro gtk-shadow-etched-in::int  "GTK_SHADOW_ETCHED_IN")
    (macro gtk-shadow-etched-out::int "GTK_SHADOW_ETCHED_OUT")
    ;; selection
    (macro %%gtk-selection-single::int "GTK_SELECTION_SINGLE")
    (macro %%gtk-selection-multiple::int "GTK_SELECTION_MULTIPLE")
    (macro %%gtk-selection-browse::int "GTK_SELECTION_BROWSE")
    (macro %%gtk-selection-extended::int "GTK_SELECTION_EXTENDED")
    
    ;; Cast
    (macro gtkobject::gtkobject* (::gtkwidget*) "GTK_OBJECT")
    
    (macro gpointer::gpointer (::gtkwidget*) "(gpointer)")
    
    (macro gtkwidget::gtkwidget* (::gtkobject*)
	   "GTK_WIDGET")
    (macro gtkwindow::gtkwindow* (::gtkobject*)
	   "GTK_WINDOW")
    (macro gtkcontainer::gtkcontainer* (::gtkobject*)
	   "GTK_CONTAINER")
    (macro gtkbox::gtkbox* (::gtkobject*)
	   "GTK_BOX")
    (macro gtktable::gtktable* (::gtkobject*)
	   "GTK_TABLE")
    (macro gtkframe::gtkframe* (::gtkobject*)
	   "GTK_FRAME")
    (macro gnomecanvas::gnomecanvas* (::gtkobject*)
	   "GNOME_CANVAS")
    (macro gnomecanvasitem::gnomecanvasitem* (::gtkobject*)
	   "GNOME_CANVAS_ITEM")
    (macro gnomecanvasgroup::gnomecanvasgroup* (::gtkobject*)
	   "GNOME_CANVAS_GROUP")
    (macro gtktooltips::gtktooltips* (::gtkobject*)
	   "GTK_TOOLTIPS")
    (macro gtkradiobutton::gtkradiobutton* (::gtkobject*)
	   "GTK_RADIO_BUTTON")
    (macro gslist::gslist* (::gtkobject*)
	   "(GSList *)")
    (macro gtkentry::gtkentry* (::gtkobject*)
	   "GTK_ENTRY")
    (macro gtkadjustment::gtkadjustment* (::gtkobject*)
	   "GTK_ADJUSTMENT")
    (macro gtkprogress::gtkprogress* (::gtkobject*)
	   "GTK_PROGRESS")
    (macro gtkprogressbar::gtkprogressbar* (::gtkobject*)
	   "GTK_PROGRESS_BAR")
    (macro gtkscrollframe::gtkscrollframe* (::gtkobject*)
	   "GTK_SCROLLED_WINDOW")
    (macro gtklist::gtklist* (::gtkobject*)
	   "GTK_LIST")
    (macro gtklistitem::gtklistitem* (::gtkobject*)
	   "GTK_LIST_ITEM")
    (macro gtkcombo::gtkcombo* (::gtkobject*)
	   "GTK_COMBO")
    (macro gtknotebook::gtknotebook* (::gtkobject*)
	   "GTK_NOTEBOOK")
    (macro gtkpaned::gtkpaned* (::gtkobject*)
	   "GTK_PANED")
    (macro gtkmenu::gtkmenu* (::gtkobject*)
	   "GTK_MENU")
    (macro gtkitem::gtkitem* (::gtkobject*)
	   "GTK_ITEM")
    (macro gtkoptionmenu::gtkoptionmenu* (::gtkobject*)
	   "GTK_OPTION_MENU")
    (macro gtkmenubar::gtkmenubar* (::gtkobject*)
	   "GTK_MENU_BAR")
    (macro gtkmenuitem::gtkmenuitem* (::gtkobject*)
	   "GTK_MENU_ITEM")
    (macro gtktearoffmenuitem::gtktearoffmenuitem* (::gtkobject*)
	   "GTK_TEAROFF_MENU_ITEM")
    (macro gtkcheckmenuitem::gtkcheckmenuitem* (::gtkobject*)
	   "GTK_CHECK_MENU_ITEM")
    (macro gtkradiomenuitem::gtkradiomenuitem* (::gtkobject*)
	   "GTK_RADIO_MENU_ITEM")
    (macro gtkmenushell::gtkmenushell* (::gtkobject*)
	   "GTK_MENU_SHELL")
    (macro gtkscrollbar::gtkscrollbar* (::gtkobject*)
	   "GTK_SCROLLBAR")
    (macro gtktoolbar::gtktoolbar* (::gtkobject*)
	   "GTK_TOOLBAR")
    (macro gtkhandlebox::gtkhandlebox* (::gtkobject*)
	   "GTK_HANDLE_BOX")
    (macro gtkcolorselection::gtkcolorselection* (::gtkobject*)
	   "GTK_COLOR_SELECTION")
    (macro gtkfontselection::gtkfontselection* (::gtkobject*)
	   "GTK_FONT_SELECTION")
    (macro gtkfileselection::gtkfileselection* (::gtkobject*)
	   "GTK_FILE_SELECTION")
    (macro gtktree::gtktree* (::gtkobject*)
	   "GTK_TREE")
    (macro gtktreeitem::gtktreeitem* (::gtkobject*)
	   "GTK_TREE_ITEM")
    (macro gtkclist::gtkclist* (::gtkobject*)
	   "GTK_CLIST")
    
    ;; Biglook conversion
    (macro %%gtklist->container::gtkcontainer* (::gtklist*)
	   "GTK_CONTAINER")
    (macro %%gtklist->gtkobject::gtkobject* (::gtklist*)
	   "GTK_OBJECT")
    (macro %%gpointer->gtkobject::gtkobject* (::gpointer)
	   "GTK_OBJECT")
    (macro %%gtkentry->gtkobject::gtkobject* (::gtkentry*)
	   "GTK_OBJECT")
    (macro %%gtkadjustment->gtkobject::gtkobject* (::gtkadjustment*)
	   "GTK_OBJECT")
    (macro %%obj->gpointer::gpointer (::obj)
	   "(gpointer)")
    (macro %%gtkcontainer->gtkwidget::gtkwidget* (::gtkcontainer*)
	   "GTK_WIDGET")

    ;; above is unused
    (macro gtkeditable::gtkeditable* (::gtkwidget*) "GTK_EDITABLE")
    (macro gtktext::gtktext* (::gtkwidget*) "GTK_TEXT")
    (macro bglktext::gtktext* (::opaque) "BGLK_GTK_TEXT")
    (macro gtkspinbutton::gtkspinbutton* (::gtkwidget*) "GTK_SPIN_BUTTON")
    (macro bglkspinbutton::gtkspinbutton* (::opaque) "BGLK_GTK_SPIN_BUTTON"))
	   
   (export (class %peer
	      ;; constructor
	      (%peer-init)
	      ;; the builtin object
	      (%builtin::gtkobject* read-only)
	      ;; the biglook object
	      (%bglk-object
	       (get peer-%bglk-object)
	       (set peer-%bglk-object-set!))
	      ;; callbacks
	      (%event (default #f)))
	   
	   (generic %peer-init ::%peer)
	   
	   (peer-%bglk-object ::%peer)
	   (peer-%bglk-object-set! ::%peer ::obj)

	   (bglkwidget ::%peer)
	   (bglkcontainer ::%peer)
	   (bglkbox ::%peer)
	   (bglktable ::%peer)
	   (bglkframe ::%peer)))
	   
;*---------------------------------------------------------------------*/
;*    %peer-init ...                                                   */
;*---------------------------------------------------------------------*/
(define-generic (%peer-init peer::%peer)
   ;; we store the user-data in order to retreive the Scheme object
   ;; from the gtk reference
   (with-access::%peer peer (%builtin)
      ;; we make the label to be displayed by gtk
      (%%widget-show (gtkwidget %builtin))
      ;; we store the back pointer
      peer))

;*---------------------------------------------------------------------*/
;*    peer-%bglk-object ...                                            */
;*---------------------------------------------------------------------*/
(define (peer-%bglk-object peer::%peer)
   (with-access::%peer peer (%builtin)
      (%bglk-gtk-arg-get %builtin "user_data")))

;*---------------------------------------------------------------------*/
;*    peer-%bglk-object-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (peer-%bglk-object-set! peer::%peer v)
   (with-access::%peer peer (%builtin)
      (%bglk-gtk-arg-type-set! %builtin "user_data" v GTK-TYPE-POINTER)))

;*---------------------------------------------------------------------*/
;*    object-print ::%peer ...                                         */
;*---------------------------------------------------------------------*/
(define-method (object-print peer::%peer port print-slot)
   (display "#<GTK-PEER>" port))

;*---------------------------------------------------------------------*/
;*    bglkwidget ...                                                   */
;*---------------------------------------------------------------------*/
(define (bglkwidget peer::%peer)
   (gtkwidget (%peer-%builtin peer)))

;*---------------------------------------------------------------------*/
;*    bglkcontainer ...                                                */
;*---------------------------------------------------------------------*/
(define (bglkcontainer peer::%peer)
   (gtkcontainer (%peer-%builtin peer)))

;*---------------------------------------------------------------------*/
;*    bglkbox ...                                                      */
;*---------------------------------------------------------------------*/
(define (bglkbox peer::%peer)
   (gtkbox (%peer-%builtin peer)))

;*---------------------------------------------------------------------*/
;*    bglktable ...                                                    */
;*---------------------------------------------------------------------*/
(define (bglktable peer::%peer)
   (gtktable (%peer-%builtin peer)))

;*---------------------------------------------------------------------*/
;*    bglkframe ...                                                    */
;*---------------------------------------------------------------------*/
(define (bglkframe peer::%peer)
   (gtkframe (%peer-%builtin peer)))
