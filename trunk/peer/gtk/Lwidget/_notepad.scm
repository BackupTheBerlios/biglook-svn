;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_notepad.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Jun 14 15:07:33 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Label implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/notepad.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%notepad
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%gtk-misc
	   __biglook_%color
	   __biglook_%container
	   __biglook_%box
	   __biglook_%label)
   
   (extern (macro %%gtk-notebook-new::gtkwidget* ()
		  "gtk_notebook_new")
	   (macro %%gtk-notebook-append-page::void (::gtknotebook*
						    ::gtkwidget*
						    ::gtkwidget*)
		  "gtk_notebook_append_page")
	   (macro %%gtk-notebook-remove-page::void (::gtknotebook*
						    ::int)
		  "gtk_notebook_remove_page")
	   (macro %%gtk-notebook-page-num::int (::gtknotebook*
						::gtkwidget*)
		  "gtk_notebook_page_num")
	   (macro %%gtk-notebook-get-nth-page::gtkwidget* (::gtknotebook*
							   ::int)
		  "gtk_notebook_get_nth_page"))
   
   (static (class %notepad::%container))
   
   (export (%make-%notepad ::%bglk-object)
	   
	   (%notepad-position::symbol ::%bglk-object)
	   (%notepad-position-set! ::%bglk-object ::symbol)
	   
	   (%notepad-selected-page::%bglk-object ::%bglk-object)
	   (%notepad-selected-page-set! ::%bglk-object ::%bglk-object)
	   
	   (%notepad-add! ::%bglk-object ::%bglk-object ::obj ::obj)
	   (%notepad-remove! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%notepad ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%notepad o::%bglk-object)
   (let ((notepad (gtkobject (%%gtk-notebook-new))))
      ;; Gtk configuration
      (%bglk-gtk-arg-set! notepad "tab_border" 0)
      (%bglk-gtk-arg-set! notepad "tab_hborder" 8)
      (%bglk-gtk-arg-set! notepad "tab_vborder" 2)
      (%bglk-gtk-arg-set! notepad "scrollable" #t)
      (instantiate::%notepad
	 (%bglk-object o)
	 (%builtin notepad))))

;*---------------------------------------------------------------------*/
;*    %notepad-position ...                                            */
;*---------------------------------------------------------------------*/
(define (%notepad-position o::%bglk-object)
   (gtk-position->biglook (gtk-arg-get o "tab_pos")))

;*---------------------------------------------------------------------*/
;*    %notepad-position-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%notepad-position-set! o::%bglk-object v)
   (gtk-arg-type-set! o "tab_pos" (biglook-position->gtk v) GTK-TYPE-POSITION))
		      
;*---------------------------------------------------------------------*/
;*    %notepad-selected-page ...                                       */
;*---------------------------------------------------------------------*/
(define (%notepad-selected-page o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%notepad %peer (%builtin)
	 (let* ((num (gtk-arg-get o "page"))
		(page (%%gtk-notebook-get-nth-page (gtknotebook %builtin)
						   num)))
	    (%bglk-gtk-arg-get (gtkobject page) "user_data")))))

;*---------------------------------------------------------------------*/
;*    %notepad-selected-page-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%notepad-selected-page-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%notepad %peer (%builtin)
	 (let* ((page (gtkwidget (%bglk-object-%peer v)))
		(num (%%gtk-notebook-page-num (gtknotebook %builtin) page)))
	    (gtk-arg-set! o "page" num)))))

;*---------------------------------------------------------------------*/
;*    %notepad-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%notepad-add! c::%bglk-object w::%bglk-object title image)
   (with-access::%bglk-object c (%peer)
      (with-access::%notepad %peer (%builtin %gc-children)
	 (set! %gc-children (cons w %gc-children))
	 (let ((label (cond
			 ((and (string? title) (%bglk-object? image))
			  (let ((box (%%gtk-vbox-new #f 0))
				(lbl (%%gtk-label-new title)))
			     (%%gtk-box-pack-start (gtkbox (gtkobject box))
						   (bglkwidget (%bglk-object-%peer image))
						   #f
						   #f
						   0)
			     (%%gtk-box-pack-start (gtkbox (gtkobject box))
						   lbl
						   #f
						   #f
						   0)
			     (%%widget-show lbl)
			     box))
			 ((string? title)
			  (%%gtk-label-new title))
			 ((%bglk-object? image)
			  (bglkwidget (%bglk-object-%peer image)))
			 (else
			  (let* ((num (+fx 1 (length (%container-children c))))
				 (snum (integer->string num))
				 (str (string-append "Tab " snum)))
			     (%%gtk-label-new str))))))
	    ;; we now add the page
	    (%%gtk-notebook-append-page (gtknotebook %builtin)
					(bglkwidget (%bglk-object-%peer w))
					label)
	    ;; and we are done
	    c))))

;*---------------------------------------------------------------------*/
;*    %notepad-remove! ...                                             */
;*---------------------------------------------------------------------*/
(define (%notepad-remove! c::%bglk-object w::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (with-access::%notepad %peer (%builtin)
	 (let* ((widget (gtkwidget (%bglk-object-%peer w)))
		(page-num (%%gtk-notebook-page-num (gtknotebook %builtin)
						   widget)))
	    (if (>fx page-num 0)
		(begin
		   (%%gtk-notebook-remove-page (gtknotebook %builtin) page-num)
		   c)
		(error "%notepad-remove!"
		       "No such notpad"
		       w))))))
