;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_paned.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed May 16 06:22:21 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Swing peer Paned implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/paned.scm@            */
;*=====================================================================*/
 
;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%paned
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static  (class %paned::%peer))
   
   (export  (%make-%hpaned ::%bglk-object)
	    (%make-%vpaned ::%bglk-object)

	    (%hpaned-fraction ::%bglk-object)
	    (%hpaned-fraction-set! ::%bglk-object ::obj)

	    (%vpaned-fraction ::%bglk-object)
	    (%vpaned-fraction-set! ::%bglk-object ::obj)

	    (%paned-add! ::%bglk-object ::%bglk-object ::bool ::bool ::bool ::int)))
	    
;*---------------------------------------------------------------------*/
;*    %make-%paned ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%paned o::%bglk-object orientation::int)
   (let ((splitpane (%swing-jsplitpane-new orientation)))
      (%swing-jsplitpane-setcontinuouslayout splitpane #t)
      (%swing-jsplitpane-setonetouchexapandable splitpane #t)
      (instantiate::%paned
	 (%bglk-object o)
	 (%builtin splitpane))))
	    
;*---------------------------------------------------------------------*/
;*    %make-%hpaned ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%hpaned o)
   (%make-%paned o %swing-constants-VERTICAL))

;*---------------------------------------------------------------------*/
;*    %make-%vpaned ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%vpaned o)
   (%make-%paned o %swing-constants-HORIZONTAL))

;*---------------------------------------------------------------------*/
;*    %hpaned-fraction ...                                             */
;*---------------------------------------------------------------------*/
(define (%hpaned-fraction o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%paned %peer (%builtin)
	 (/fl (fixnum->flonum (%swing-jsplitpane-getdividerlocation %builtin))
	      (fixnum->flonum (%awt-component-width %builtin))))))
   
;*---------------------------------------------------------------------*/
;*    %hpaned-fraction-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%hpaned-fraction-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%paned %peer (%builtin)
	 (%swing-jsplitpane-setdividerlocation %builtin v)
	 o)))

;*---------------------------------------------------------------------*/
;*    %vpaned-fraction ...                                             */
;*---------------------------------------------------------------------*/
(define (%vpaned-fraction o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%paned %peer (%builtin)
	 (/fl (fixnum->flonum (%swing-jsplitpane-getdividerlocation %builtin))
	      (fixnum->flonum (%awt-component-height %builtin))))))

;*---------------------------------------------------------------------*/
;*    %vpaned-fraction-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%vpaned-fraction-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%paned %peer (%builtin)
	 (%swing-jsplitpane-setdividerlocation %builtin v)
	 o)))

;*---------------------------------------------------------------------*/
;*    %paned-add! ...                                                  */
;*---------------------------------------------------------------------*/
(define (%paned-add! c w horizontal? expand shrink number)
   (with-access::%bglk-object c (%peer)
      (with-access::%paned %peer (%builtin)
	 (if (=fx number 1)
	     (if horizontal?
		 (begin
		    (%swing-jsplitpane-setleftcomponent
		     %builtin
		     (%peer-%builtin (%bglk-object-%peer w)))
		    c)
		 (begin
		    (%swing-jsplitpane-settopcomponent
		     %builtin
		     (%peer-%builtin (%bglk-object-%peer w)))
		    c))
	     (if horizontal?
		 (begin
		    (%swing-jsplitpane-setrightcomponent
		     %builtin
		     (%peer-%builtin (%bglk-object-%peer w)))
		    c)
		 (begin
		    (%swing-jsplitpane-setbottomcomponent
		     %builtin
		     (%peer-%builtin (%bglk-object-%peer w)))
		    c))))))
						     
   
