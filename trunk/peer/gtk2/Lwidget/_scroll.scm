;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_scroll.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Jun 14 15:08:25 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Label implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/scroll.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%scroll
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%gtk-misc
	   __biglook_%color
	   __biglook_%container)
   
   (extern (macro %%gtk-scrolled-window-new::gtkwidget*
		  (::gtkadjustment* ::gtkadjustment*)
		  "gtk_scrolled_window_new")
	    
	   (macro %%gtk-scrolled-window-set-policy::void
		  (::gtkscrollframe* ::int ::int)
		  "gtk_scrolled_window_set_policy")
	   (macro %%gtk-scrolled-window-add-with-viewport::void
		  (::gtkscrollframe* ::gtkwidget*)
		  "gtk_scrolled_window_add_with_viewport")
	   (macro %%gtk-scrolled-window-hadjustment::gtkadjustment*
		  (::gtkscrollframe*)
		  "gtk_scrolled_window_get_hadjustment")
	   (macro %%gtk-scrolled-window-vadjustment::gtkadjustment*
		  (::gtkscrollframe*)
		  "gtk_scrolled_window_get_vadjustment")
	   
	   (macro %%GTK_POLICY_AUTOMATIC::int "GTK_POLICY_AUTOMATIC")
	   (macro %%GTK_POLICY_ALWAYS::int "GTK_POLICY_ALWAYS")
	   (macro %%GTK_POLICY_NEVER::int "GTK_POLICY_NEVER"))
   
   (static (class %scroll::%container))
   
   (export (%make-%scroll ::%bglk-object)
	   
	   (%scroll-hfraction::double ::%bglk-object)
	   (%scroll-hfraction-set! ::%bglk-object ::double)
	   
	   (%scroll-vfraction::double ::%bglk-object)
	   (%scroll-vfraction-set! ::%bglk-object ::double)
	   
	   (%scroll-hside ::%bglk-object)
	   (%scroll-hside-set! ::%bglk-object ::obj)
	   
	   (%scroll-vside ::%bglk-object)
	   (%scroll-vside-set! ::%bglk-object ::obj)
	   
	   (%scroll-hpolicy ::%bglk-object)
	   (%scroll-hpolicy-set! ::%bglk-object ::obj)
	   
	   (%scroll-vpolicy ::%bglk-object)
	   (%scroll-vpolicy-set! ::%bglk-object ::obj)
	   
	   (%scroll-hpage-size::int ::%bglk-object)
	   (%scroll-vpage-size::int ::%bglk-object)
	   
	   (%scroll-add! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%scroll ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%scroll o::%bglk-object)
   (let ((win (gtkobject
	       (%%gtk-scrolled-window-new
		(gtkadjustment
		 (%%gtk-adjustment-new 0.0 0.0 100.0 0.1 1.0 1.0))
		(gtkadjustment
		 (%%gtk-adjustment-new 0.0 0.0 100.0 0.1 1.0 1.0))))))
      ;; resize policy
      (%%gtk-scrolled-window-set-policy (gtkscrollframe win)
					%%GTK_POLICY_AUTOMATIC
					%%GTK_POLICY_ALWAYS)
      ;; we set the resize mode for that frame
      (%%gtk-container-set-resize-mode (gtkcontainer win)
				       %%GTK_RESIZE_PARENT)
      ;; allocate the peer object
      (instantiate::%scroll
	 (%bglk-object o)
	 (%builtin win))))

;*---------------------------------------------------------------------*/
;*    adjustment-fraction ...                                          */
;*---------------------------------------------------------------------*/
(define (adjustment-fraction adjustment)
   (let* ((range (-fl (-fl (%%bglk-gtk-adjustment-upper adjustment)
			   (%%bglk-gtk-adjustment-lower adjustment))
		      (%%bglk-gtk-adjustment-page-size adjustment)))
	  (value (%%bglk-gtk-adjustment-value adjustment)))
      (/ value range)))

;*---------------------------------------------------------------------*/
;*    adjustment-fraction-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (adjustment-fraction-set! adjustment v)
   (let* ((range (-fl (-fl (%%bglk-gtk-adjustment-upper adjustment)
			   (%%bglk-gtk-adjustment-lower adjustment))
		      (%%bglk-gtk-adjustment-page-size adjustment)))
	  (v (cond
		((>fl v 1.0)
		 1.0)
		((<fl v 0.0)
		 0.0)
		(else
		 v))))
      (%%gtk-adjustment-value-set! adjustment (*fl range v))
      (%%gtk-adjustment-value-changed adjustment)
      v))

;*---------------------------------------------------------------------*/
;*    %scroll-hfraction ...                                            */
;*---------------------------------------------------------------------*/
(define (%scroll-hfraction o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((adjustment (%%gtk-scrolled-window-hadjustment
			    (gtkscrollframe %builtin))))
	    (adjustment-fraction adjustment)))))

;*---------------------------------------------------------------------*/
;*    %scroll-hfraction-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%scroll-hfraction-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((adjustment (%%gtk-scrolled-window-hadjustment
			    (gtkscrollframe %builtin))))
	    (adjustment-fraction-set! adjustment v)))))

;*---------------------------------------------------------------------*/
;*    %scroll-vfraction ...                                            */
;*---------------------------------------------------------------------*/
(define (%scroll-vfraction o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((adjustment (%%gtk-scrolled-window-vadjustment
			    (gtkscrollframe %builtin))))
	    (adjustment-fraction adjustment)))))
   
;*---------------------------------------------------------------------*/
;*    %scroll-vfraction-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%scroll-vfraction-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((adjustment (%%gtk-scrolled-window-vadjustment
			    (gtkscrollframe %builtin))))
	    (adjustment-fraction-set! adjustment v)))))

;*---------------------------------------------------------------------*/
;*    %scroll-hside ...                                                */
;*---------------------------------------------------------------------*/
(define (%scroll-hside o::%bglk-object)
   (let ((placement (g-property-get o "window-placement")))
      (cond
	 ((or (=fx placement gtk-corner-top-left)
	      (=fx placement gtk-corner-top-right))
	  'top)
	 ((or (=fx placement gtk-corner-bottom-left)
	      (=fx placement gtk-corner-bottom-right))
	  'bottom)
	 (else
	  (error "%scroll-hside"
		 "Illegal placement"
		 placement)))))

;*---------------------------------------------------------------------*/
;*    %scroll-hside-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-hside-set! o::%bglk-object v)
   (let ((placement (g-property-get o "window-placement")))
      (cond
	 ((or (=fx placement gtk-corner-top-left)
	      (=fx placement gtk-corner-bottom-left))
	  (case v
	     ((top)
	      (g-property-type-set! o
				    "window-placement"
				    gtk-corner-top-left 
				    GTK-TYPE-CORNER-TYPE))
	     ((bottom)
	      (g-property-type-set! o
				    "window-placement"
				    gtk-corner-bottom-left
				    GTK-TYPE-CORNER-TYPE))
	     (else
	      (error "%scroll-hside-set!"
		     "Illegal position"
		     v))))
	 ((or (=fx placement gtk-corner-top-right)
	      (=fx placement gtk-corner-bottom-right))
	  (case v
	     ((top)
	      (g-property-type-set! o
				    "window-placement"
				    gtk-corner-top-right 
				    GTK-TYPE-CORNER-TYPE))
	     ((bottom)
	      (g-property-type-set! o
				    "window-placement"
				    gtk-corner-bottom-right
				    GTK-TYPE-CORNER-TYPE))
	     (else
	      (error "%scroll-hside-set!"
		     "Illegal position"
		     v)))))))

;*---------------------------------------------------------------------*/
;*    %scroll-vside ...                                                */
;*---------------------------------------------------------------------*/
(define (%scroll-vside o::%bglk-object)
   (let ((placement (g-property-get o "window-placement")))
      (cond
	 ((or (=fx placement gtk-corner-top-left)
	      (=fx placement gtk-corner-bottom-left))
	  'left)
	 ((or (=fx placement gtk-corner-top-right)
	      (=fx placement gtk-corner-bottom-right))
	  'right)
	 (else
	  (error "%scroll-vside"
		 "Illegal placement"
		 placement)))))

;*---------------------------------------------------------------------*/
;*    %scroll-vside-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-vside-set! o::%bglk-object v)
   (let ((placement (g-property-get o "window-placement")))
      (cond
	 ((or (=fx placement gtk-corner-top-left)
	      (=fx placement gtk-corner-top-right))
	  (case v
	     ((left)
	      (g-property-type-set! o
				    "window-placement"
				    gtk-corner-top-left 
				    GTK-TYPE-CORNER-TYPE))
	     ((right)
	      (g-property-type-set! o
				    "window-placement"
				    gtk-corner-top-right
				    GTK-TYPE-CORNER-TYPE))
	     (else
	      (error "%scroll-vside-set!"
		     "Illegal position"
		     v))))
	 ((or (=fx placement gtk-corner-bottom-left)
	      (=fx placement gtk-corner-bottom-right))
	  (case v
	     ((left)
	      (g-property-type-set! o
				    "window-placement"
				    gtk-corner-bottom-left 
				    GTK-TYPE-CORNER-TYPE))
	     ((right)
	      (g-property-type-set! o
				    "window-placement"
				    gtk-corner-bottom-right
				    GTK-TYPE-CORNER-TYPE))
	     (else
	      (error "%scroll-vside-set!"
		     "Illegal position"
		     v)))))))

;*---------------------------------------------------------------------*/
;*    %scroll-hpolicy ...                                              */
;*---------------------------------------------------------------------*/
(define (%scroll-hpolicy o::%bglk-object)
   (let ((policy (g-property-get o "hscrollbar-policy")))
      (cond
	 ((=fx policy %%GTK_POLICY_AUTOMATIC)
	  'automatic)
	 ((=fx policy %%GTK_POLICY_ALWAYS)
	  'always)
	 ((=fx policy %%GTK_POLICY_NEVER)
	  'never))))

;*---------------------------------------------------------------------*/
;*    %scroll-hpolicy-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%scroll-hpolicy-set! o::%bglk-object v)
   (g-property-type-set! o
			 "hscrollbar-policy"
			 (case v
			   ((automatic)
			    %%GTK_POLICY_AUTOMATIC)
			   ((always)
			    %%GTK_POLICY_ALWAYS)
			   ((never)
			    %%GTK_POLICY_NEVER)
			   (else
			    (error "%scroll-hpolicy-set!"
				   "Illegal policy"
				   v)))
			 GTK-TYPE-POLICY-TYPE)
   o)
			  
;*---------------------------------------------------------------------*/
;*    %scroll-vpolicy ...                                              */
;*---------------------------------------------------------------------*/
(define (%scroll-vpolicy o::%bglk-object)
   (let ((policy (g-property-get o "vscrollbar-policy")))
      (cond
	 ((=fx policy %%GTK_POLICY_AUTOMATIC)
	  'automatic)
	 ((=fx policy %%GTK_POLICY_ALWAYS)
	  'always)
	 ((=fx policy %%GTK_POLICY_NEVER)
	  'never))))

;*---------------------------------------------------------------------*/
;*    %scroll-vpolicy-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%scroll-vpolicy-set! o::%bglk-object v)
   (g-property-type-set! o
			 "vscrollbar-policy"
			 (case v
			   ((automatic)
			    %%GTK_POLICY_AUTOMATIC)
			   ((always)
			    %%GTK_POLICY_ALWAYS)
			   ((never)
			    %%GTK_POLICY_NEVER)
			   (else
			    (error "%scroll-vpolicy-set!"
				   "Illegal policy"
				   v)))
			 GTK-TYPE-POLICY-TYPE)
   o)
			  
;*---------------------------------------------------------------------*/
;*    %scroll-hpage-size ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-hpage-size o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((adjustment (%%gtk-scrolled-window-hadjustment
			    (gtkscrollframe %builtin))))
	    (flonum->fixnum (%%bglk-gtk-adjustment-page-size adjustment))))))

;*---------------------------------------------------------------------*/
;*    %scroll-vpage-size ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-vpage-size o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((adjustment (%%gtk-scrolled-window-vadjustment
			    (gtkscrollframe %builtin))))
	    (flonum->fixnum (%%bglk-gtk-adjustment-page-size adjustment))))))

;*---------------------------------------------------------------------*/
;*    %scroll-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%scroll-add! c::%bglk-object w::%bglk-object)
   (with-access::%scroll (%bglk-object-%peer c) (%builtin %gc-children)
      (set! %gc-children (cons w %gc-children))
      (%%gtk-scrolled-window-add-with-viewport (gtkscrollframe %builtin)
					       (gtkwidget
						(%peer-%builtin
						 (%bglk-object-%peer w))))
      c))

;*---------------------------------------------------------------------*/
;*    %%container-children ::%scroll ...                               */
;*---------------------------------------------------------------------*/
(define-method (%%container-children c::%scroll)
   (%%bglk-gtk-viewport-children (bglkcontainer c)))
   
