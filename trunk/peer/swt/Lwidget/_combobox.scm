;*=====================================================================*/
;*    .../prgm/project/biglook/peer/swing/Lwidget/_combobox.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Oct 10 15:27:40 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Swing peer Combobox implementation.                          */
;*    definition: @path ../../../biglook/Lwidget/combobox.scm@         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%combobox
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%entry
	   __biglook_%color
	   __biglook_%event
	   __biglook_%callback)
   
   (static (class %combobox::%entry
	       (%text (default #f))))
   
   (export (%make-%combobox ::%bglk-object)
	   
	   (%combobox-text ::%bglk-object)
	   (%combobox-text-set! ::%bglk-object ::bstring)
	   
	   (%combobox-width::int ::%bglk-object)
	   (%combobox-width-set! ::%bglk-object ::int)
	   
	   (%combobox-active?::bool ::%bglk-object)
	   (%combobox-active?-set! ::%bglk-object ::bool)
	   
	   (%combobox-editable?::bool ::%bglk-object)
	   (%combobox-editable?-set! ::%bglk-object ::bool)
	   
	   (%combobox-items ::%bglk-object)
	   (%combobox-items-set! ::%bglk-object ::pair-nil)))

;*---------------------------------------------------------------------*/
;*    %make-%combobox ...                                              */
;*---------------------------------------------------------------------*/
(define (%make-%combobox o::%bglk-object)
   (let* ((combobox (%swing-jcombobox-new))
	  (new-bd::%swing-border (%bglk-border-softbevel-in-new)))
      (%swing-jcomponent-border-set! combobox new-bd)
;*       (%swing-jcomponent-background-set! combobox %awt-color-WHITE) */
      (instantiate::%combobox
	 (%bglk-object o)
	 (%builtin combobox))))

;*---------------------------------------------------------------------*/
;*    %combobox-text ...                                               */
;*---------------------------------------------------------------------*/
(define (%combobox-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin)
	 (let ((item (%swing-jcombobox-selected %builtin)))
	    (if (%jstring? item)
		(%bglk-jstring->bstring item)
		"")))))

;*---------------------------------------------------------------------*/
;*    %combobox-text-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%combobox-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin %text)
	 (set! %text v)
	 (let loop ((i (-fx (%swing-jcombobox-length %builtin) 1)))
	    (if (>=fx i 0)
		(if (string=? (%bglk-jstring->bstring
			       (%swing-jcombobox-ref %builtin i))
			      v)
		    (begin
		       (%swing-jcombobox-selected-set! %builtin i)
		       o)
		    (loop (-fx i 1)))
		(begin
		   (%swing-jcombobox-add! %builtin (%bglk-bstring->jstring v))
		   (%swing-jcombobox-selected-set! %builtin 0)
		   o))))))

;*---------------------------------------------------------------------*/
;*    %combobox-width ...                                              */
;*---------------------------------------------------------------------*/
(define (%combobox-width o::%bglk-object)
   (%widget-width o))

;*---------------------------------------------------------------------*/
;*    %combobox-width-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%combobox-width-set! o::%bglk-object v::int)
   (%widget-width-set! o v))

;*---------------------------------------------------------------------*/
;*    %combobox-active? ...                                            */
;*---------------------------------------------------------------------*/
(define (%combobox-active? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%awt-component-enabled? (%peer-%builtin %peer))))

;*---------------------------------------------------------------------*/
;*    %combobox-active?-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%combobox-active?-set! o::%bglk-object v::bool)
   (with-access::%bglk-object o (%peer)
      (%awt-component-enabled?-set! (%peer-%builtin %peer) v)
      o))

;*---------------------------------------------------------------------*/
;*    %combobox-editable? ...                                          */
;*---------------------------------------------------------------------*/
(define (%combobox-editable? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%swing-jcombobox-editable? (%peer-%builtin %peer))))

;*---------------------------------------------------------------------*/
;*    %combobox-editable?-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%combobox-editable?-set! o::%bglk-object v::bool)
   (with-access::%bglk-object o (%peer)
      (%swing-jcombobox-editable?-set! (%peer-%builtin %peer) v)
      o))

;*---------------------------------------------------------------------*/
;*    %combobox-items ...                                              */
;*---------------------------------------------------------------------*/
(define (%combobox-items o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin)
	 (let loop ((i (-fx (%swing-jcombobox-length %builtin) 1))
		    (res '()))
	    (if (>=fx i 0) 
		(loop (-fx i 1)
		      (cons (%bglk-jstring->bstring
			     (%swing-jcombobox-ref %builtin i))
			    res))
		(reverse! res))))))

;*---------------------------------------------------------------------*/
;*    %combobox-items-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%combobox-items-set! o::%bglk-object v::pair-nil)
   (with-access::%bglk-object o (%peer)
      (with-access::%combobox %peer (%builtin %text)
	 (%swing-jcombobox-remove-all! %builtin)
	 (let loop ((i 0)
		    (strings v))
	    (if (null? strings)
		o
		(let ((s (car strings)))
		   (%swing-jcombobox-add! %builtin (%bglk-bstring->jstring s))
		   (if (and (string? %text) (string=? s %text))
		       (begin
			  (%swing-jcombobox-selected-set! %builtin i)
			  o))
		   (loop (+fx i 1)
			 (cdr strings))))))
      o))

