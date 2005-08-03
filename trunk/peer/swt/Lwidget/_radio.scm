;*=====================================================================*/
;*    swt/Lwidget/_radio.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:41:04 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Check Button implementation.                       */
;*    definition: @path ../../../biglook/Lwidget/radio.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%radio
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%button
	   __biglook_%check-button
	   __biglook_%container
	   __biglook_%frame)
   
   (static (class %radio::%container
	      (%group::%swing-buttongroup (default (%swing-buttongroup-new)))
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
      (let ((rb (%swing-jradiobutton-new)))
	 (%swing-buttongroup-add! %group rb)
	 (instantiate::%radio-button
	    (%bglk-object o)
	    (%builtin rb)))))

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
   (with-access::%radio (%bglk-object-%peer o) (%group)
      (%bglk-buttongroup-buttons %group)))

;*---------------------------------------------------------------------*/
;*    %radio-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%radio-value o::%bglk-object)
   (with-access::%radio (%bglk-object-%peer o) (%group)
      (let loop ((buttons (%radio-children o)))
	 (cond
	    ((null? buttons)
	     "")
	    ((%swing-abstractbutton-selected? (%peer-%builtin
					       (%bglk-object-%peer
						(car buttons))))
	     (%button-text (car buttons)))
	    (else
	     (loop (cdr buttons)))))))
      
;*---------------------------------------------------------------------*/
;*    %radio-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%radio-value-set! o::%bglk-object v::bstring)
   (with-access::%radio (%bglk-object-%peer o) (%group)
      (for-each (lambda (button)
		   (let ((on? (string=? (%button-text button) v)))
		      (%swing-abstractbutton-selected?-set!
		       (%peer-%builtin (%bglk-object-%peer button))
		       on?)
		      button))
		(%radio-children o))))

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
