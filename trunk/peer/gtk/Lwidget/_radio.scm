;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_radio.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Jun 24 16:35:09 2003 (serrano)                */
;*    Copyright   :  2001-03 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Radio Button implementation.                        */
;*    definition: @path ../../../biglook/Lwidget/radio.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%radio
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%frame
	   __biglook_%color
	   __biglook_%button
	   __biglook_%check-button)
   
   (extern (macro %%gtk-radio-button-new::gtkwidget* (::gslist*)
		  "gtk_radio_button_new")
	   (macro %%gtk-emply-radio-button-group::gslist*
		  "0L")
	   (macro %%gtk-radio-button-group::gslist* (::gtkradiobutton*)
		  "gtk_radio_button_group"))
   
   (static (class %radio::%container
	      (%group::gslist* (default %%gtk-emply-radio-button-group))
	      (%frame::%bglk-object read-only))
	   (class %radio-button::%check-button))
   
   (export (%make-%radio ::%bglk-object ::%bglk-object)
	   (%make-%radio-button ::%bglk-object ::%bglk-object)

	   ;; container addition
	   (%radio-add! ::%bglk-object ::%bglk-object)
	   
	   ;; children
	   (%radio-children::pair-nil ::%bglk-object)
	   
	   ;; active?
	   (%radio-active?::bool ::%bglk-object)
	   (%radio-active?-set! ::%bglk-object ::bool)
	   
	   ;; value
	   (%radio-value::bstring ::%bglk-object)
	   (%radio-value-set! ::%bglk-object ::bstring)
	   
	   ;; tooltips
	   (%radio-tooltips::obj ::%bglk-object)
	   (%radio-tooltips-set! ::%bglk-object ::obj)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%radio ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%radio o::%bglk-object frame::%bglk-object)
   (instantiate::%radio
      (%bglk-object o)
      (%frame frame)
      (%builtin (%peer-%builtin (%bglk-object-%peer frame)))))

;*---------------------------------------------------------------------*/
;*    %make-%radio-button ...                                          */
;*---------------------------------------------------------------------*/
(define (%make-%radio-button o::%bglk-object parent::%bglk-object)
   (with-access::%radio (%bglk-object-%peer parent) (%group)
      (let ((rb (%%gtk-radio-button-new %group)))
	 (set! %group (%%gtk-radio-button-group
		       (gtkradiobutton (gtkobject rb))))
	 (instantiate::%radio-button
	    (%bglk-object o)
	    (%builtin (gtkobject rb))))))
	    
;*---------------------------------------------------------------------*/
;*    %radio-add! ...                                                  */
;*---------------------------------------------------------------------*/
(define (%radio-add! o::%bglk-object w::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%frame-add! (%radio-%frame %peer) w)))

;*---------------------------------------------------------------------*/
;*    %radio-children ...                                              */
;*---------------------------------------------------------------------*/
(define (%radio-children o::%bglk-object)
   (%container-children (car (%container-children o))))

;*---------------------------------------------------------------------*/
;*    %radio-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%radio-value o::%bglk-object)
   (let loop ((buttons (%radio-children o)))
      (cond
	 ((null? buttons)
	  "")
	 ((not (not (%check-button-on? (car buttons))))
	  (%button-text (car buttons)))
	 (else
	  (loop (cdr buttons))))))

;*---------------------------------------------------------------------*/
;*    %radio-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%radio-value-set! o::%bglk-object v::bstring)
   (for-each (lambda (button)
		(let ((on? (not (string=? (%button-text button) v))))
		   (%check-button-on?-set! button (not on?))))
	     (%radio-children o)))
      
;*---------------------------------------------------------------------*/
;*    %radio-tooltips ...                                              */
;*---------------------------------------------------------------------*/
(define (%radio-tooltips o::%bglk-object)
   (let ((buttons (%radio-children o)))
      (if (pair? buttons)
	  (%widget-tooltips (car buttons))
	  #f)))

;*---------------------------------------------------------------------*/
;*    %radio-tooltips-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%radio-tooltips-set! o::%bglk-object v::obj)
   (for-each (lambda (b)
		(%widget-tooltips-set! b v))
	     (%radio-children o)))

;*---------------------------------------------------------------------*/
;*    %radio-active? ...                                               */
;*---------------------------------------------------------------------*/
(define (%radio-active?::bool o::%bglk-object)
   (let ((buttons (%radio-children o)))
      (if (pair? buttons)
	  (%check-button-active? (car buttons))
	  #t)))

;*---------------------------------------------------------------------*/
;*    %radio-active?-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%radio-active?-set! o::%bglk-object v::bool)
   (for-each (lambda (b)
		(%check-button-active?-set! b v))
	     (%radio-children o)))

   
