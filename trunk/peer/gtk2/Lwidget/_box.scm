;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_box.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Jun 14 15:03:08 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Label implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/box.scm@              */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%box
   
   (import __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%color)
   
   (extern (macro %%gtk-vbox-new::gtkwidget* (::bool ::int)
		  "gtk_vbox_new")
	   (macro %%gtk-hbox-new::gtkwidget* (::bool ::int)
		  "gtk_hbox_new")
	   (macro %%gtk-box-pack-start::void (::gtkbox*
					      ::gtkwidget*
					      ::bool
					      ::bool
					      ::int)
		  "gtk_box_pack_start")
	   (macro %%gtk-box-pack-end::void (::gtkbox*
					    ::gtkwidget*
					    ::bool
					    ::bool
					    ::int)
		  "gtk_box_pack_end"))
   
   (static (class %hbox::%container)
	   (class %vbox::%container))
	   
   (export (%make-%hbox ::%bglk-object)
	   (%make-%vbox ::%bglk-object)

	   (%vbox-add! ::%bglk-object ::%bglk-object ::bool ::bool ::int ::bool)
	   (%hbox-add! ::%bglk-object ::%bglk-object ::bool ::bool ::int ::bool)

	   (%box-homogenous::bool ::%bglk-object)
	   (%box-homogenous-set! ::%bglk-object ::bool)))

;*---------------------------------------------------------------------*/
;*    %make-%hbox ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%hbox o::%bglk-object)
   ;; we allocate the vbox
   (let* ((gtk-hbox (%%gtk-hbox-new #f 0))
	  (%box (instantiate::%hbox
		   (%bglk-object o)
		   (%builtin (gtkobject gtk-hbox)))))
      ;; we make the box to be displayed by gtk
      (%%widget-show gtk-hbox)
      ;; we are done
      %box))

;*---------------------------------------------------------------------*/
;*    %make-%vbox ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%vbox o::%bglk-object)
   ;; we allocate the vbox
   (let* ((gtk-vbox (%%gtk-vbox-new #f 0))
	  (%box (instantiate::%vbox
		   (%bglk-object o)
		   (%builtin (gtkobject gtk-vbox)))))
      ;; we make the box to be displayed by gtk
      (%%widget-show gtk-vbox)
      ;; we are done
      %box))

;*---------------------------------------------------------------------*/
;*    %box-add! ...                                                    */
;*---------------------------------------------------------------------*/
(define (%box-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (with-access::%bglk-object c (%peer)
      (with-access::%container %peer (%gc-children)
	 (set! %gc-children (cons w %gc-children))
	 (if top
	     (%%gtk-box-pack-start (bglkbox %peer)
				   (bglkwidget (%bglk-object-%peer w))
				   expand
				   fill
				   padding)
	     (%%gtk-box-pack-end (bglkbox %peer)
				 (bglkwidget (%bglk-object-%peer w))
				 expand
				 fill
				 padding))
	 w)))
   
;*---------------------------------------------------------------------*/
;*    %vbox-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%vbox-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (%box-add! c w expand fill padding top))

;*---------------------------------------------------------------------*/
;*    %hbox-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%hbox-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (%box-add! c w expand fill padding top))

;*---------------------------------------------------------------------*/
;*    %box-homogenous ...                                              */
;*---------------------------------------------------------------------*/
(define (%box-homogenous o::%bglk-object)
   (g-property-get o "homogeneous"))

;*---------------------------------------------------------------------*/
;*    %box-homogenous-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%box-homogenous-set! o::%bglk-object v)
  (g-property-set! o "homogeneous" v))

