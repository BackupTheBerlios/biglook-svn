;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_listbox.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jun 24 13:49:55 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Swing peer Listbox implementation.                           */
;*    definition: @path ../../../biglook/Lwidget/listbox.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%listbox
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static  (class %listbox::%peer
	       (%jlist::%swing-jlist read-only)
	       (%items::pair-nil (default '()))))
   
   (export  (%make-%listbox ::%bglk-object)

	    (%listbox-active?::bool ::%bglk-object)
	    (%listbox-active?-set! ::%bglk-object ::bool)
	    
	    (%listbox-items::pair-nil ::%bglk-object)
	    (%listbox-items-set! ::%bglk-object ::pair-nil)
	    
	    (%listbox-select-mode::symbol ::%bglk-object)
	    (%listbox-select-mode-set! ::%bglk-object ::symbol)
	    
	    (%listbox-selection ::%bglk-object)
	    (%listbox-selection-set! ::%bglk-object ::obj)))
	    
;*---------------------------------------------------------------------*/
;*    %make-%listbox ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%listbox o)
   (let ((jlist (%swing-jlist-new)))
      (instantiate::%listbox
	 (%bglk-object o)
	 (%jlist jlist)
	 (%builtin (%swing-jscrollpane-new jlist)))))

;*---------------------------------------------------------------------*/
;*    %listbox-active? ...                                             */
;*---------------------------------------------------------------------*/
(define (%listbox-active? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%awt-component-enabled? (%listbox-%jlist %peer))))
   
;*---------------------------------------------------------------------*/
;*    %listbox-active?-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%listbox-active?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (%awt-component-enabled?-set! (%listbox-%jlist %peer) v)
      o))

;*---------------------------------------------------------------------*/
;*    %listbox-items ...                                               */
;*---------------------------------------------------------------------*/
(define (%listbox-items o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%items)
	 %items)))
   
;*---------------------------------------------------------------------*/
;*    %listbox-items-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%listbox-items-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%items %jlist)
	 (set! %items (reverse! (reverse v)))
	 (let* ((len (length v))
		(data (make-%jobject* len)))
	    (let loop ((v v)
		       (i 0))
	       (if (=fx i len)
		   (begin
		      (%swing-jlist-items-set! %jlist data)
		      o)
		   (begin
		      (%jobject*-set! data i (%bglk-bstring->jstring (car v)))
		      (loop (cdr v) (+fx i 1)))))))))
   
;*---------------------------------------------------------------------*/
;*    %listbox-select-mode ...                                         */
;*---------------------------------------------------------------------*/
(define (%listbox-select-mode o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%jlist)
	 (let ((m (%swing-jlist-selection-mode %jlist)))
	    (cond
	       ((=fx m %swing-listselectionmodel-MULTIPLE_INTERVAL_SELECTION)
		'multiple)
	       ((=fx m %swing-listselectionmodel-SINGLE_INTERVAL_SELECTION)
		'extended)
	       (else
		'single))))))
		
;*---------------------------------------------------------------------*/
;*    %listbox-select-mode-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%listbox-select-mode-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%jlist)
	 (%swing-jlist-selection-mode-set!
	  %jlist
	  (case v
	     ((multiple)
	      %swing-listselectionmodel-MULTIPLE_INTERVAL_SELECTION)
	     ((extended)
	      %swing-listselectionmodel-SINGLE_INTERVAL_SELECTION)
	     (else
	      %swing-listselectionmodel-SINGLE_SELECTION)))
	 o)))

;*---------------------------------------------------------------------*/
;*    %listbox-selection ...                                           */
;*---------------------------------------------------------------------*/
(define (%listbox-selection o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%items %jlist)
	 (let ((len (length %items)))
	    (let loop ((i (-fx len 1))
		       (res '()))
	       (cond
		  ((=fx i -1)
		   res)
		  ((%swing-jlist-is-selected? %jlist i)
		   (loop (-fx i 1) (cons i res)))
		  (else
		   (loop (-fx i 1) res))))))))

;*---------------------------------------------------------------------*/
;*    %listbox-selection-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%listbox-selection-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%listbox %peer (%items %jlist)
	 (let* ((len (length v))
		(data (make-int* len)))
	    (let loop ((v v)
		       (i 0))
	       (if (=fx i len)
		   (begin
		      (%swing-jlist-selection-set! %jlist data)
		      o)
		   (begin
		      (int*-set! data i (car v))
		      (loop (cdr v) (+fx i 1)))))))))

