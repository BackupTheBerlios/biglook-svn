;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lgtk/gtk-misc.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Apr 10 14:23:29 2001                          */
;*    Last change :  Thu Aug  2 09:49:52 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The connection part of the Gtk Biglook's peer.                   */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%gtk-misc
   
   (import __biglook_%peer
	   __biglook_%bglk-object)
   
   (extern (macro %%widget-show::void
		  (::gtkwidget*)
		  "gtk_widget_show")

	   ;; resources
	   (macro %%gtk-parse-string::void
		  (::string)
		  "gtk_rc_parse_string")
	   
	   ;; unref
	   (macro %%gtk-object-unref::void
		  (::gtkobject*)
		  "gtk_object_unref")
	   
	   ;; Gtk argument passing
	   (macro %bglk-gtk-arg-get::obj
		  (::gtkobject* ::string)
		  "bglk_gtk_arg_get")
	   (macro %bglk-gtk-arg-set!::obj
		  (::gtkobject* ::string ::obj)
		  "bglk_gtk_arg_set")
	   (macro %bglk-gtk-arg-type-set!::obj
		  (::gtkobject* ::string ::obj ::int)
		  "bglk_gtk_arg_type_set")
	   (macro %%bglk-gtk-arg-gtkobject-set!::obj
		  (::gtkobject* ::string ::gtkobject*)
		  "bglk_gtk_arg_gtkobject_set")
	   
	   ;; adjustment
	   (macro %%gtk-adjustment-new::gtkobject*
		  (::double ::double ::double ::double ::double ::double)
		  "gtk_adjustment_new")
	   (macro %%gtk-null-adjustment::gtkadjustment* "0L")
	   (macro %%bglk-gtk-adjustment-value::double
		  (::gtkadjustment*)
		  "BGLK_ADJUSTMENT_VALUE")
	   (macro %%bglk-gtk-adjustment-page-size::double
		  (::gtkadjustment*)
		  "BGLK_ADJUSTMENT_PAGE_SIZE")
	   (macro %%gtk-adjustment-value-set!::void
		  (::gtkadjustment* ::double)
		  "gtk_adjustment_set_value")
	   (macro %%gtk-adjustment-value-changed::void
		  (::gtkadjustment*)
		  "gtk_adjustment_value_changed")
	   (macro %%bglk-gtk-adjustment-lower::double
		  (::gtkadjustment*)
		  "BGLK_ADJUSTMENT_LOWER")
	   (macro %%bglk-gtk-adjustment-lower-set!::void
		  (::gtkadjustment* ::double)
		  "BGLK_ADJUSTMENT_LOWER_SET")
	   (macro %%bglk-gtk-adjustment-upper::double
		  (::gtkadjustment*)
		  "BGLK_ADJUSTMENT_UPPER")
	   (macro %%bglk-gtk-adjustment-upper-set!::void
		  (::gtkadjustment* ::double)
		  "BGLK_ADJUSTMENT_UPPER_SET")
	   (macro %%bglk-gtk-adjustment-page-increment-set!::void
		  (::gtkadjustment* ::double)
		  "BGLK_ADJUSTMENT_PAGE_INCREMENT_SET")
	   
	   ;; glist
	   (macro %%bglk-gtk-glist-strings-new::glist*
		  (::pair-nil)
		  "bglk_glist_strings_new")
	   (macro %%bglk-gtk-glist-strings::pair-nil
		  (::glist*)
		  "bglk_gtk_glist_strings")
	   (macro %%bglk-gtk-glist-objs::pair-nil
		  (::glist*)
		  "bglk_gtk_glist_objs")
	   (macro %%gtk-glist-previous::glist*
		  (::glist*)
		  "g_list_previous")
	   (macro %%gtk-glist-next::glist*
		  (::glist*)
		  "g_list_next")
	   (macro %%bglk-glist-data::gpointer
		  (::glist*)
		  "BGLK_GLIST_DATA"))
   
   (export (gtk-arg-get ::%bglk-object ::bstring)
	   (gtk-arg-set! ::%bglk-object ::bstring ::obj)
	   (gtk-arg-type-set! ::%bglk-object ::bstring ::obj ::int)
	   
	   (biglook-relief->gtk::int ::symbol)
	   (gtk-relief->biglook::symbol ::int)
	   
	   (biglook-shadow->gtk::int ::symbol)
	   (gtk-shadow->biglook::symbol ::int)
	   
	   (biglook-position->gtk::int ::symbol)
	   (gtk-position->biglook::symbol ::int)
	   
	   (biglook-justify->gtk::int ::symbol)
	   (gtk-justify->biglook::symbol ::int)
	   
	   (biglook-title-justify->gtk::real ::symbol)
	   (gtk-title-justify->biglook::symbol ::real)

	   (gtk-anchor->biglook::symbol ::int)
	   (biglook-anchor->gtk::int ::symbol)

	   (gtk-selection->biglook::symbol ::int)
	   (biglook-selection->gtk::int ::symbol)))

;*---------------------------------------------------------------------*/
;*    gtk-arg-get ...                                                  */
;*---------------------------------------------------------------------*/
(define (gtk-arg-get o::%bglk-object name::bstring)
   (with-access::%bglk-object o (%peer)
      (%bglk-gtk-arg-get (%peer-%builtin %peer) name)))

;*---------------------------------------------------------------------*/
;*    gtk-arg-set! ...                                                 */
;*---------------------------------------------------------------------*/
(define (gtk-arg-set! o::%bglk-object name::bstring v::obj)
   (with-access::%bglk-object o (%peer)
      (%bglk-gtk-arg-set! (%peer-%builtin %peer) name v)))

;*---------------------------------------------------------------------*/
;*    gtk-arg-type-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (gtk-arg-type-set! o::%bglk-object name::bstring v::obj t::int)
   (with-access::%bglk-object o (%peer)
      (%bglk-gtk-arg-type-set! (%peer-%builtin %peer) name v t)))

;*---------------------------------------------------------------------*/
;*    biglook-relief->gtk ...                                          */
;*---------------------------------------------------------------------*/
(define (biglook-relief->gtk v)
   (case v
      ((flat none)
       gtk-relief-none)
      ((raised solid)
       gtk-relief-normal)
      ((ridge)
       gtk-relief-half)
      (else
       gtk-relief-normal)))
   
;*---------------------------------------------------------------------*/
;*    gtk-relief->biglook ...                                          */
;*---------------------------------------------------------------------*/
(define (gtk-relief->biglook v)
   (cond 
      ((=fx v gtk-relief-none)
       'flat)
      ((=fx v gtk-relief-normal)
       'raised)
      ((=fx v gtk-relief-half)
       'ridge)
      (else
       'normal)))
   
;*---------------------------------------------------------------------*/
;*    biglook-position->gtk ...                                        */
;*---------------------------------------------------------------------*/
(define (biglook-position->gtk v)
   (case v
      ((top) gtk-position-top)
      ((bottom) gtk-position-bottom)
      ((left) gtk-position-left)
      ((right) gtk-position-right)
      (else (error "biglook-position->gtk" "Illegal position value" v))))
   
;*---------------------------------------------------------------------*/
;*    gtk-position->biglook ...                                        */
;*---------------------------------------------------------------------*/
(define (gtk-position->biglook v)
   (cond
      ((=fx v gtk-position-top)
       'top)
      ((=fx v gtk-position-bottom)
       'bottom)
      ((=fx v gtk-position-left)
       'left)
      ((=fx v gtk-position-right)
       'right)
      (else
       (error "gtk-position->biglook" "Illegal position value" v))))
   
;*---------------------------------------------------------------------*/
;*    biglook-justify->gtk ...                                         */
;*---------------------------------------------------------------------*/
(define (biglook-justify->gtk v)
   (case v
      ((fill) gtk-justify-fill)
      ((center) gtk-justify-center)
      ((left) gtk-justify-left)
      ((right) gtk-justify-right)
      (else (error "biglook-justify->gtk" "Illegal justify value" v))))
   
;*---------------------------------------------------------------------*/
;*    gtk-justify->biglook ...                                         */
;*---------------------------------------------------------------------*/
(define (gtk-justify->biglook v)
   (cond
      ((=fx v gtk-justify-fill)
       'fill)
      ((=fx v gtk-justify-center)
       'center)
      ((=fx v gtk-justify-left)
       'left)
      ((=fx v gtk-justify-right)
       'right)
      (else
       (error "gtk-justify->biglook" "Illegal justify value" v))))
   
;*---------------------------------------------------------------------*/
;*    biglook-shadow->gtk ...                                          */
;*---------------------------------------------------------------------*/
(define (biglook-shadow->gtk v)
   (case v
      ((none)
       gtk-shadow-none)
      ((in shadow-in)
       gtk-shadow-in)
      ((out shadow-out)
       gtk-shadow-out)
      ((etched-in etched)
       gtk-shadow-etched-in)
      ((etched-out)
       gtk-shadow-etched-out)
      (else
       (error "biglook-shadow->gtk" "Illegal shadow" v))))
   
;*---------------------------------------------------------------------*/
;*    gtk-shadow->biglook ...                                          */
;*---------------------------------------------------------------------*/
(define (gtk-shadow->biglook v)
   (cond 
      ((=fx v gtk-shadow-none)
       'none)
      ((=fx v gtk-shadow-in)
       'in)
      ((=fx v gtk-shadow-out)
       'out)
      ((=fx v gtk-shadow-etched-in)
       'etched-in)
      ((=fx v gtk-shadow-etched-out)
       'etched-out)
      (else
       (error "gtk-shadow->biglook" "Illegal shadow" v))))
   
;*---------------------------------------------------------------------*/
;*    biglook-title-justify->gtk ...                                   */
;*---------------------------------------------------------------------*/
(define (biglook-title-justify->gtk v)
   (case v
      ((center) 0.5)
      ((left) 0.1)
      ((right) 0.9)
      (else (error "biglook-title-justify->gtk" "Illegal justify value" v))))
   
;*---------------------------------------------------------------------*/
;*    gtk-title-justify->biglook ...                                   */
;*---------------------------------------------------------------------*/
(define (gtk-title-justify->biglook v)
   (cond
      ((<=fl v 0.4)
       'left)
      ((>=fl v 0.6)
       'right)
      (else
       'center)))
   
;*---------------------------------------------------------------------*/
;*    *bglk-anchor-opt* ...                                            */
;*---------------------------------------------------------------------*/
(define *bglk-anchor-opts*
   `((center . ,gtk-anchor-center)
     (c      . ,gtk-anchor-center)
     (n      . ,gtk-anchor-n)
     (nw     . ,gtk-anchor-nw)
     (ne     . ,gtk-anchor-ne)
     (s      . ,gtk-anchor-s)
     (sw     . ,gtk-anchor-sw)
     (se     . ,gtk-anchor-se)
     (w      . ,gtk-anchor-w)
     (e      . ,gtk-anchor-e)))

;*---------------------------------------------------------------------*/
;*    *gtk-anchor-opts* ...                                            */
;*---------------------------------------------------------------------*/
(define *gtk-anchor-opts*
   `((,gtk-anchor-center . center)
     (,gtk-anchor-n      . n)
     (,gtk-anchor-nw     . nw)
     (,gtk-anchor-ne     . ne)
     (,gtk-anchor-s      . s)
     (,gtk-anchor-sw     . sw)
     (,gtk-anchor-se     . se)
     (,gtk-anchor-w      . w)
     (,gtk-anchor-e      . e)))

;*---------------------------------------------------------------------*/
;*    gtk-anchor->biglook ...                                          */
;*---------------------------------------------------------------------*/
(define (gtk-anchor->biglook anchor)
   (let ((cell (assq anchor *gtk-anchor-opts*)))
      (if (pair? cell)
	  (cdr cell)
	  (begin
	     (warning "gtk-anchor->bigloo:" "Unknown anchor -- " anchor)
	     'center))))

;*---------------------------------------------------------------------*/
;*    biglook-anchor->gtk ...                                          */
;*---------------------------------------------------------------------*/
(define (biglook-anchor->gtk anchor)
   (let ((cell (assq anchor *bglk-anchor-opts*)))
      (if (pair? cell)
	  (cdr cell)
	  (begin
	     (warning "biglook-anchor-gtk:" "Unknown anchor -- " anchor)
	     gtk-anchor-center))))

;*---------------------------------------------------------------------*/
;*    gtk-selection->biglook ...                                       */
;*---------------------------------------------------------------------*/
(define (gtk-selection->biglook v)
   (cond
      ((=fx v %%gtk-selection-single)
       'single)
      ((=fx v %%gtk-selection-multiple)
       'multiple)
      (else
       'extended)))

;*---------------------------------------------------------------------*/
;*    biglook-selection->gtk ...                                       */
;*---------------------------------------------------------------------*/
(define (biglook-selection->gtk v)
   (case v
      ((multiple)
       %%gtk-selection-multiple)
      ((extended)
       %%gtk-selection-extended)
      (else
       %%gtk-selection-single)))
