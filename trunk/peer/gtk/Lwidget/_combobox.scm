;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_combobox.scm      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Nov 13 14:38:32 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Combobox implementation.                            */
;*    definition: @path ../../../biglook/Lwidget/combobox.scm@         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%combobox
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%gtk-misc
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%entry
	   __biglook_%color
	   __biglook_%event
	   __biglook_%callback)
   
   (extern (macro %%gtk-combobox-new::gtkwidget* ()
		  "gtk_combo_new")
	   (macro %%bglk-gtk-combobox-entry::gtkentry* (::gtkcombo*)
		  "BGLK_GTK_COMBO_ENTRY")
	   (macro %%bglk-gtk-combobox-list::glist* (::gtkcombo*)
		  "BGLK_GTK_COMBO_LIST")
	   (macro %%gtk-combo-set-popdown-strings::void (::gtkcombo* ::glist*)
		   "gtk_combo_set_popdown_strings"))
   
   (static (class %combobox::%entry))
   
   (export (%make-%combobox ::%bglk-object)
	   
	   (%combobox-text ::%bglk-object)
	   (%combobox-text-set! ::%bglk-object ::bstring)
	   
	   (%combobox-width::int ::%bglk-object)
	   (%combobox-width-set! ::%bglk-object ::int)
	   
	   (%combobox-active?::bool ::%bglk-object)
	   (%combobox-active?-set! ::%bglk-object ::bool)
	   
	   (%combobox-editable?::bool ::%bglk-object)
	   (%combobox-editable?-set! ::%bglk-object ::bool)
	   
	   (%combobox-items ::%bglk-object)
	   (%combobox-items-set! ::%bglk-object ::pair-nil)))

;*---------------------------------------------------------------------*/
;*    %make-%combobox ...                                              */
;*---------------------------------------------------------------------*/
(define (%make-%combobox o::%bglk-object)
   (instantiate::%combobox
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-combobox-new)))))

;*---------------------------------------------------------------------*/
;*    %combobox-text ...                                               */
;*---------------------------------------------------------------------*/
(define (%combobox-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin)
	  (%%gtk-entry-text
	   (%%bglk-gtk-combobox-entry (gtkcombo %builtin))))))

;*---------------------------------------------------------------------*/
;*    %combobox-text-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%combobox-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin)
	 (%%gtk-entry-text-set!
	  (%%bglk-gtk-combobox-entry (gtkcombo %builtin))
	  v)
	 o)))

;*---------------------------------------------------------------------*/
;*    %combobox-width ...                                              */
;*---------------------------------------------------------------------*/
(define (%combobox-width o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin)
	 (%bglk-gtk-arg-get
	  (%%gtkentry->gtkobject
	   (%%bglk-gtk-combobox-entry (gtkcombo %builtin)))
	  "max_length"))))

;*---------------------------------------------------------------------*/
;*    %widget-width-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%combobox-width-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin)
	 (%bglk-gtk-arg-type-set!
	  (%%gtkentry->gtkobject
	   (%%bglk-gtk-combobox-entry (gtkcombo %builtin)))
	  "max_length"
	  v
	  GTK-TYPE-UINT))))

;*---------------------------------------------------------------------*/
;*    %combobox-active? ...                                            */
;*---------------------------------------------------------------------*/
(define (%combobox-active? o::%bglk-object)
   (%widget-active? o))

;*---------------------------------------------------------------------*/
;*    %widget-active?-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%combobox-active?-set! o::%bglk-object v)
   (%widget-active?-set! o v)
   o)

;*---------------------------------------------------------------------*/
;*    %combobox-editable? ...                                          */
;*---------------------------------------------------------------------*/
(define (%combobox-editable? o::%bglk-object)
   #t)

;*---------------------------------------------------------------------*/
;*    %combobox-editable?-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%combobox-editable?-set! o::%bglk-object v::bool)
   (not-implemented o "%combobox-editable?-set!"))

;*---------------------------------------------------------------------*/
;*    %combobox-items ...                                              */
;*---------------------------------------------------------------------*/
(define (%combobox-items o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin)
	 (%%bglk-gtk-glist-strings
	  (%%bglk-gtk-combobox-list (gtkcombo %builtin))))))

;*---------------------------------------------------------------------*/
;*    %combobox-items-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%combobox-items-set! o::%bglk-object v::pair-nil)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin)
	 (let ((text (%combobox-text o)))
	    (if (pair? v)
		(begin
		   (%%gtk-combo-set-popdown-strings
		    (gtkcombo %builtin)
		    (%%bglk-gtk-glist-strings-new v))
		   #unspecified))
	    (if (member text v)
		(%combobox-text-set! o text)))
	 #unspecified)))

