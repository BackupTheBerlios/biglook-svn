;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_container.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri Jul 27 10:30:52 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Container implementation.                           */
;*    definition: @path ../../../biglook/Lwidget/container.scm@        */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%container

   (import __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)

   (extern (macro %%gtk-container-add!::void (::gtkcontainer* ::gtkwidget*)
		  "gtk_container_add")
	   (macro %%gtk-reshow::void (::gtkwindow*)
		  "gtk_window_reshow_with_initial_size")
	   (macro %%gtk-container-remove!::void (::gtkcontainer* ::gtkwidget*)
		  "gtk_container_remove")
	   (macro %%bglk-gtk-container-remove-all!::void (::gtkcontainer*)
		  "bglk_gtk_container_remove_all")
	   (macro %%gtk-container-set-resize-mode::void (::gtkcontainer* ::int)
		  "gtk_container_set_resize_mode")
	   (macro %%gtk-container-set-border-width::void (::gtkcontainer* ::int)
		  "gtk_container_set_border_width")
	   (macro %%bglk-gtk-container-children::obj (::gtkcontainer*)
		  "bglk_gtk_container_children")
	   (macro %%bglk-gtk-viewport-children::obj (::gtkcontainer*)
		  "bglk_gtk_viewport_children")

	   (macro %%GTK_RESIZE_PARENT::int "GTK_RESIZE_PARENT"))
	   
   (export (class %container::%peer
	      (%gc-children::pair-nil (default '())))

	   (%container-add!::obj ::%bglk-object ::%bglk-object)
	   (%container-remove!::obj ::%bglk-object ::%bglk-object)
	   
	   (%container-children::obj ::%bglk-object)
	   (generic %%container-children::obj ::%container)
	   
	   (%container-border-width::int ::%bglk-object)
	   (%container-border-width-set! ::%bglk-object ::int)))

;*---------------------------------------------------------------------*/
;*    %container-add! ...                                              */
;*---------------------------------------------------------------------*/
(define (%container-add! c::%bglk-object w::%bglk-object)
  (with-access::%bglk-object c (%peer)
      (with-access::%container %peer (%gc-children)
	 ;; mark the new child otherwise its callbacks could be collected
	 (set! %gc-children (cons w %gc-children))
	 (%%gtk-container-add! (bglkcontainer %peer)
			       (bglkwidget (%bglk-object-%peer w)))
	 c)))

;*---------------------------------------------------------------------*/
;*    %container-remove! ...                                           */
;*---------------------------------------------------------------------*/
(define (%container-remove! c::%bglk-object w::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (with-access::%container %peer (%gc-children)
	 ;; unmark the new child for collection
	 (set! %gc-children (remq! w %gc-children))
	 (%%gtk-container-remove! (bglkcontainer %peer)
				  (bglkwidget (%bglk-object-%peer w)))
	 (%%bglk-window-reshow-with-initial-size (bglkwidget %peer))
	 c)))

;*---------------------------------------------------------------------*/
;*    %container-children ...                                          */
;*---------------------------------------------------------------------*/
(define (%container-children c::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (%%container-children %peer)))

;*---------------------------------------------------------------------*/
;*    %%container-children ::%peer ...                                 */
;*---------------------------------------------------------------------*/
(define-generic (%%container-children c::%container)
   (%%bglk-gtk-container-children (bglkcontainer c)))
 
;*---------------------------------------------------------------------*/
;*    %container-border-width ...                                      */
;*---------------------------------------------------------------------*/
(define (%container-border-width o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (g-property-get o "border-width")))
  
;*---------------------------------------------------------------------*/
;*    %container-border-width-set! ...                                 */
;*---------------------------------------------------------------------*/
(define (%container-border-width-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (g-property-type-set! o "border-width" v G-TYPE-ULONG)))
  
