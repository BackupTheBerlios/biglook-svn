;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/%gauge.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon May  7 06:47:48 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Gauge implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/gauge.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%gauge
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%gtk-misc
	   __biglook_%color)
   
   (extern  (macro %%gtk-progress-bar-new::gtkwidget* (::gtkadjustment*)
		   "gtk_progress_bar_new_with_adjustment")
	    
	    (macro %%gtk-progress-get-value::float (::gtkprogress*)
		   "gtk_progress_get_value")
	    (macro %%gtk-progress-set-value::void (::gtkprogress* ::float)
		   "gtk_progress_set_value")
	    (macro %%gtk-progress-set-activity::void (::gtkprogress* ::bool)
		   "gtk_progress_set_activity_mode")
	    (macro %%gtk-progress-set-format-string::void (::gtkprogress* ::string)
		   "gtk_progress_set_format_string")

	    (macro %%GTK-PROGRESS-BAR-CONTINUOUS::int
		   "GTK_PROGRESS_CONTINUOUS")
	    (macro %%GTK-PROGRESS-BAR-DISCRETE::int
		   "GTK_PROGRESS_DISCRETE"))
	   
   (static  (class %gauge::%peer
	       (%text (default #f))
	       (%style (default '()))))
   
   (export  (%make-%gauge ::%bglk-object)

	    (%gauge-text ::%bglk-object)
	    (%gauge-text-set! ::%bglk-object ::obj)
	    
	    (%gauge-style ::%bglk-object)
	    (%gauge-style-set! ::%bglk-object ::obj)
	    
	    (%gauge-value ::%bglk-object)
	    (%gauge-value-set! ::%bglk-object ::int)))

;*---------------------------------------------------------------------*/
;*    %make-%gauge ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%gauge o)
   (let* ((adj (%%gtk-adjustment-new 0.0 0.0 100.0 1.0 1.0 1.0))
	  (bar (%%gtk-progress-bar-new (gtkadjustment adj))))
      (instantiate::%gauge
	 (%bglk-object o)
	 (%builtin (gtkobject bar)))))

;*---------------------------------------------------------------------*/
;*    %gauge-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%gauge-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%text)
	 %text)))
   
;*---------------------------------------------------------------------*/
;*    %gauge-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%gauge-text-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%text %style)
	 (set! %text v)
	 (%gauge-style-set! o %style))))
   
;*---------------------------------------------------------------------*/
;*    %gauge-style ...                                                 */
;*---------------------------------------------------------------------*/
(define (%gauge-style o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%text %builtin %style)
	 %style)))
   
;*---------------------------------------------------------------------*/
;*    %gauge-style-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%gauge-style-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%text %builtin %style)
	 (set! %style v)
	 (let* ((vs (if (memq 'value v)
			"(%v %%)"
			#f))
		(fmt (cond
			((and (string? %text) (string? vs))
			 (string-append %text " " vs))
			((string? %text)
			 %text)
			((string? vs)
			 vs)
			(else
			 #f))))
	    (if (string? fmt)
		(begin
		   (%%gtk-progress-set-format-string (gtkprogress %builtin)
						     fmt)
		   (gtk-arg-set! o "show_text" #t))
		(gtk-arg-set! o "show_text" #f)))
	 (if (memq 'activity v)
	     (gtk-arg-set! o "activity_mode" #t))
	 (if (memq 'discrete v)
	     (gtk-arg-type-set! o "bar_style"
				%%GTK-PROGRESS-BAR-DISCRETE
				GTK-TYPE-PROGRESS-BAR-STYLE)
	     (gtk-arg-type-set! o "bar_style"
				%%GTK-PROGRESS-BAR-CONTINUOUS
				GTK-TYPE-PROGRESS-BAR-STYLE)))))
   
;*---------------------------------------------------------------------*/
;*    %gauge-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%gauge-value o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%builtin)
	 (let ((res (%%gtk-progress-get-value (gtkprogress %builtin))))
	    (flonum->fixnum res)))))

;*---------------------------------------------------------------------*/
;*    %gauge-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%gauge-value-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%builtin)
	 (let ((val (fixnum->flonum v)))
	    (%%gtk-progress-set-value (gtkprogress %builtin) val)
	    #unspecified))))

