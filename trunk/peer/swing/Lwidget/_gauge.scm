;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_gauge.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jun 24 13:52:23 2001 (serrano)                */
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
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static  (class %gauge::%peer))
   
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
   (instantiate::%gauge
      (%bglk-object o)
      (%builtin (%swing-jprogressbar-new))))

;*---------------------------------------------------------------------*/
;*    %gauge-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%gauge-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%builtin)
	 (%bglk-jstring->bstring (%swing-jprogressbar-string %builtin)))))

;*---------------------------------------------------------------------*/
;*    %gauge-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%gauge-text-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%builtin)
	 (if (not (string? v))
	     (begin
		(%swing-jprogressbar-string-set! %builtin
						 (%bglk-bstring->jstring ""))
		o)
	     (begin
		(%swing-jprogressbar-string-set! %builtin
						 (%bglk-bstring->jstring v))
		o)))))
   
;*---------------------------------------------------------------------*/
;*    %gauge-style ...                                                 */
;*---------------------------------------------------------------------*/
(define (%gauge-style o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%builtin)
	 (let ((res '()))
	    (if (%swing-jprogressbar-string-on? %builtin)
		(set! res (cons 'value res)))
	    (if (%swing-jprogressbar-border-on? %builtin)
		(set! res (cons 'discrete res)))
	    res))))
   
;*---------------------------------------------------------------------*/
;*    %gauge-style-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%gauge-style-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%gauge %peer (%builtin)
	 (let ((v (if (not (pair? v))
		      (list? v)
		      v)))
	    (if (pair? (memq 'value v))
		(begin
		   (%swing-jprogressbar-string-on?-set! %builtin #t)
		   o))
	    (if (pair? (memq 'discrete v))
		(begin
		   (%swing-jprogressbar-border-on?-set! %builtin #t)
		   o))))))
   
;*---------------------------------------------------------------------*/
;*    %gauge-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%gauge-value o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%swing-jprogressbar-value (%peer-%builtin %peer))))

;*---------------------------------------------------------------------*/
;*    %gauge-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%gauge-value-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (%swing-jprogressbar-value-set! (%peer-%builtin %peer) v)
      o))

