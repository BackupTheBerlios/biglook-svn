;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_scale.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jul 15 17:29:39 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Swing peer Scale implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/scale.scm@            */
;*=====================================================================*/
 
;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%scale
   
   (import __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%callback)
   
   (extern (macro %%gtk-hscale-new::gtkwidget* (::gtkadjustment*)
		  "gtk_hscale_new")
	   (macro %%gtk-vscale-new::gtkwidget* (::gtkadjustment*)
		  "gtk_vscale_new"))
   
   (static (class %scale::%peer
	      %adjustment::gtkadjustment*
	      (%command (default #f))))
   
   (export (%make-%hscale ::%bglk-object)
	   (%make-%vscale ::%bglk-object)
	   
	   (%scale-command ::%bglk-object)
	   (%scale-command-set! ::%bglk-object ::obj)
	   
	   (%scale-value::int ::%bglk-object)
	   (%scale-value-set! ::%bglk-object ::int)
	   
	   (%scale-show-value?::bool ::%bglk-object)
	   (%scale-show-value?-set! ::%bglk-object ::bool)
	   
	   (%scale-from::int ::%bglk-object)
	   (%scale-from-set! ::%bglk-object ::int)
	   
	   (%scale-to::int ::%bglk-object)
	   (%scale-to-set! ::%bglk-object ::int)))

;*---------------------------------------------------------------------*/
;*    %make-%scale ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%scale o adjustment::gtkadjustment* scale::gtkwidget*)
   ;; we have to connect the adjustment to the Biglook object because
   ;; it is the adjustment that we receive the events when the scale
   ;; will be changed
   (%bglk-gtk-arg-type-set! (%%gtkadjustment->gtkobject adjustment)
			    "user_data"
			    o
			    GTK-TYPE-POINTER)
   (%bglk-gtk-arg-type-set! (gtkobject scale) "digits" 0 GTK-TYPE-INT)
   (instantiate::%scale
      (%adjustment adjustment)
      (%bglk-object o)
      (%builtin (gtkobject scale))))

;*---------------------------------------------------------------------*/
;*    %make-%hscale ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%hscale o)
   (let* ((adjustment (gtkadjustment
		       (%%gtk-adjustment-new 0.0 0.0 100.0 0.1 1.0 1.0)))
	  (scale (%%gtk-hscale-new adjustment)))
      (%make-%scale o adjustment scale)))

;*---------------------------------------------------------------------*/
;*    %make-%vscale ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%vscale o)
   (let* ((adjustment (gtkadjustment
		       (%%gtk-adjustment-new 0.0 0.0 100.0 0.1 1.0 1.0)))
	  (scale (%%gtk-vscale-new adjustment)))
      (%make-%scale o adjustment scale)))

;*---------------------------------------------------------------------*/
;*    %scale-command ...                                               */
;*---------------------------------------------------------------------*/
(define (%scale-command o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%command)
	 %command)))
   
;*---------------------------------------------------------------------*/
;*    %scale-command-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%scale-command-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%adjustment %command)
	 (let ((adj (%%gtkadjustment->gtkobject %adjustment)))
	    (if (procedure? %command)
		(%disconnect-widget-callback! adj 'value-changed %command))
	    (if (procedure? v)
		(%connect-widget-callback! adj 'value-changed v))
	    (set! %command v)))))

;*---------------------------------------------------------------------*/
;*    %scale-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%scale-value o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%adjustment)
	 (flonum->fixnum (%%bglk-gtk-adjustment-value %adjustment)))))
   
;*---------------------------------------------------------------------*/
;*    %scale-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%scale-value-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%adjustment)
	 (%%gtk-adjustment-value-set! %adjustment (fixnum->flonum v))
	 o)))

;*---------------------------------------------------------------------*/
;*    %scale-show-value? ...                                           */
;*---------------------------------------------------------------------*/
(define (%scale-show-value? o::%bglk-object)
   (gtk-arg-get o "draw_value"))
   
;*---------------------------------------------------------------------*/
;*    %scale-show-value?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%scale-show-value?-set! o::%bglk-object v)
   (gtk-arg-set! o "draw_value" v))
   
;*---------------------------------------------------------------------*/
;*    %scale-from ...                                                  */
;*---------------------------------------------------------------------*/
(define (%scale-from o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%adjustment)
	 (flonum->fixnum (%%bglk-gtk-adjustment-lower %adjustment)))))

;*---------------------------------------------------------------------*/
;*    %scale-from-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%scale-from-set! o::%bglk-object from::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%adjustment)
	 (let ((from (fixnum->flonum from))
	       (to (%%bglk-gtk-adjustment-upper %adjustment)))
	    (%%bglk-gtk-adjustment-lower-set! %adjustment from)
	    (if (>fl from to)
		(%%bglk-gtk-adjustment-page-increment-set! %adjustment -1.)
		(%%bglk-gtk-adjustment-page-increment-set! %adjustment 1.))
	    o))))

;*---------------------------------------------------------------------*/
;*    %scale-to ...                                                    */
;*---------------------------------------------------------------------*/
(define (%scale-to o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%adjustment)
	 (-fx (flonum->fixnum (%%bglk-gtk-adjustment-upper %adjustment)) 1))))

;*---------------------------------------------------------------------*/
;*    %scale-to-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%scale-to-set! o::%bglk-object to::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%adjustment)
	 (let ((to (fixnum->flonum (+fx 1 to)))
	       (from (%%bglk-gtk-adjustment-lower %adjustment)))
	    (%%bglk-gtk-adjustment-upper-set! %adjustment to)
	    (if (>fl from to)
		(%%bglk-gtk-adjustment-page-increment-set! %adjustment -1.)
		(%%bglk-gtk-adjustment-page-increment-set! %adjustment 1.))
	    o))))

