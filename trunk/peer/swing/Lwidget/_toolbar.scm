;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_toolbar.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon Jul 16 10:14:00 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Tool implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/toolbar.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%toolbar
   
   (import __biglook_%peer
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%bglk-object
	   __biglook_%swing-misc
	   __biglook_%widget
	   ;__biglook_%cursor
	   __biglook_%button
	   __biglook_%image
	   __biglook_%container
	   __biglook_%callback)
   
   (static (class %toolbar::%container
	      (%space-size::int (default 10))))
	   
   (export (%make-%toolbar ::%bglk-object ::bool)
	   
	   (%toolbar-shadow::symbol ::%bglk-object)
	   (%toolbar-shadow-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-relief::symbol ::%bglk-object)
	   (%toolbar-relief-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-orientation::symbol ::%bglk-object)
	   (%toolbar-orientation-set! ::%bglk-object ::symbol)
	   
	   (%toolbar-space-size::int ::%bglk-object)
	   (%toolbar-space-size-set! ::%bglk-object ::int)
	   
	   (%toolbar-add! ::%bglk-object ::%bglk-object ::obj ::obj)
	   (%toolbar-item-add! ::%bglk-object ::obj ::obj ::obj ::obj ::obj)))

;*---------------------------------------------------------------------*/
;*    %make-%toolbar ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%toolbar o::%bglk-object floating)
   (let ((jtoolbar (%swing-jtoolbar-new)))
      (%swing-jtoolbar-set-floatable jtoolbar floating)
      (%swing-jtoolbar-set-borderpainted jtoolbar floating)
      (instantiate::%toolbar
	 (%bglk-object o)
	 (%builtin jtoolbar))))

;*---------------------------------------------------------------------*/
;*    %toolbar-shadow ...                                              */
;*---------------------------------------------------------------------*/
(define (%toolbar-shadow::symbol o::%bglk-object)
   (%jcomponent-shadow o))

;*---------------------------------------------------------------------*/
;*    %toolbar-shadow-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-shadow-set! o::%bglk-object v::symbol)
   (%jcomponent-shadow-set! o v))

;*---------------------------------------------------------------------*/
;*    %toolbar-relief ...                                              */
;*---------------------------------------------------------------------*/
(define (%toolbar-relief::symbol o::%bglk-object)
   'none)

;*---------------------------------------------------------------------*/
;*    %toolbar-relief-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-relief-set! o::%bglk-object v::symbol)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %toolbar-orientation ...                                         */
;*---------------------------------------------------------------------*/
(define (%toolbar-orientation::symbol o::%bglk-object)
   (with-access::%toolbar (%bglk-object-%peer o) (%builtin)
      (if (=fx (%swing-jtoolbar-get-orientation %builtin)
	       %swing-constants-HORIZONTAL)
	  'horizontal
	  'vertical)))

;*---------------------------------------------------------------------*/
;*    %toolbar-orientation-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%toolbar-orientation-set! o::%bglk-object v::symbol)
   (with-access::%toolbar (%bglk-object-%peer o) (%builtin)
      (%swing-jtoolbar-set-orientation %builtin
				       (case v
					  ((horizontal)
					   %swing-constants-HORIZONTAL)
					  ((vertical)
					   %swing-constants-VERTICAL)
					  (else
					   (error "%toolbar-orientation-set!"
						  "Illegal orientation"
						  v))))
      o))

;*---------------------------------------------------------------------*/
;*    %toolbar-space-size ...                                          */
;*---------------------------------------------------------------------*/
(define (%toolbar-space-size::int o::%bglk-object)
   (with-access::%toolbar (%bglk-object-%peer o) (%space-size)
      %space-size))

;*---------------------------------------------------------------------*/
;*    %toolbar-space-size-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%toolbar-space-size-set! o::%bglk-object v::int)
   (with-access::%toolbar (%bglk-object-%peer o) (%space-size)
      (set! %space-size v)))

;*---------------------------------------------------------------------*/
;*    %toolbar-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%toolbar-add! c::%bglk-object w::%bglk-object space tip)
   (with-access::%toolbar (%bglk-object-%peer c) (%builtin %space-size)
      (if space
	  (begin
	     (%swing-jtoolbar-add-separator %builtin
					    (%awt-dimension-new %space-size
								%space-size))
	     c))
      (%container-add! c w)
      (if tip
	  (%widget-tooltips-set! w tip))))
   
;*---------------------------------------------------------------------*/
;*    %toolbar-item-add! ...                                           */
;*---------------------------------------------------------------------*/
(define (%toolbar-item-add! c::%bglk-object text icon space tooltips cmd)
   (with-access::%toolbar (%bglk-object-%peer c) (%builtin %space-size)
      ;; add the space 
      (if space
	  (begin
	     (%swing-jtoolbar-add-separator %builtin
					    (%awt-dimension-new %space-size
								%space-size))
						      
	     c))
      ;; add the text/icon
      (let* ((but (%make-%button c))
	     (%but (%peer-%builtin but)))
	 ;; install the callback for this button
	 (if (procedure? cmd)
	     (%connect-toolbar-item-callback! but cmd))
	 ;; the optional tooltips
	 (if (string? tooltips)
	     (begin
		(%swing-jcomponent-tooltip-set! %but
						(%bglk-bstring->jstring
						 tooltips))
		tooltips))
	 (cond
	    ((and (string? text) (%bglk-object? icon))
	     (%swing-abstractbutton-icon-set! %but (%image-%icon
						    (%bglk-object-%peer
						     icon)))
	     (%swing-abstractbutton-text-set! %but
					      (%bglk-bstring->jstring text))
	     (%awt-container-add! %builtin %but)
	     c)
	    ((string? text)
	     (%swing-abstractbutton-text-set! %but
					      (%bglk-bstring->jstring text))
	     (%awt-container-add! %builtin %but)
	     c)
	    ((%bglk-object? icon)
	     (%swing-abstractbutton-icon-set! %but (%image-%icon
						    (%bglk-object-%peer
						     icon)))
	     (%awt-container-add! %builtin %but)
	     c)))))


