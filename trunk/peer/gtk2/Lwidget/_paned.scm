;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_paned.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Jun 14 15:07:57 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Paned implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/paned.scm@            */
;*=====================================================================*/
 
;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%paned
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%gtk-misc
	   __biglook_%container)
   
   (extern (macro %%gtk-hpaned-new::gtkwidget* ()
		  "gtk_hpaned_new")
	   (macro %%gtk-vpaned-new::gtkwidget* ()
		  "gtk_vpaned_new")
	   
	   (macro %%bglk-gtk-paned-position::int (::gtkpaned*)
		  "BGLK_PANED_POSITION")
	   (macro %%gtk-paned-position-set!::void (::gtkpaned* ::int)
		  "gtk_paned_set_position")
	   
	   (macro %%gtk-paned-add1::void (::gtkpaned* ::gtkwidget*)
		  "gtk_paned_add1")
	   (macro %%gtk-paned-add2::void (::gtkpaned* ::gtkwidget*)
		  "gtk_paned_add2")
	   
	   (macro %%gtk-paned-pack1::void (::gtkpaned* ::gtkwidget* ::bool ::bool)
		  "gtk_paned_pack1")
	   (macro %%gtk-paned-pack2::void (::gtkpaned* ::gtkwidget* ::bool ::bool)
		  "gtk_paned_pack2"))
   
   (static (class %paned::%container))
   
   (export (%make-%hpaned ::%bglk-object)
	   (%make-%vpaned ::%bglk-object)
	   
	   (%hpaned-fraction ::%bglk-object)
	   (%hpaned-fraction-set! ::%bglk-object ::obj)
	   
	   (%vpaned-fraction ::%bglk-object)
	   (%vpaned-fraction-set! ::%bglk-object ::obj)
	   
	   (%paned-add! ::%bglk-object ::%bglk-object ::bool ::bool ::bool ::int)))

;*---------------------------------------------------------------------*/
;*    %make-%paned ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%paned o::%bglk-object widget::gtkwidget*)
   (let ((owidget::gtkobject* (gtkobject widget)))
      (%%gtk-paned-position-set! (gtkpaned owidget) -1)
      (instantiate::%paned
	 (%bglk-object o)
	 (%builtin owidget))))
	    
;*---------------------------------------------------------------------*/
;*    %make-%hpaned ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%hpaned o)
   (%make-%paned o (%%gtk-hpaned-new)))

;*---------------------------------------------------------------------*/
;*    %make-%vpaned ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%vpaned o)
   (%make-%paned o (%%gtk-vpaned-new)))

;*---------------------------------------------------------------------*/
;*    %hpaned-fraction ...                                             */
;*---------------------------------------------------------------------*/
(define (%hpaned-fraction o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%paned %peer (%builtin)
	 (/fl (fixnum->flonum (%%bglk-gtk-paned-position (gtkpaned %builtin)))
	      (fixnum->flonum (%widget-width o))))))
   
;*---------------------------------------------------------------------*/
;*    %hpaned-fraction-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%hpaned-fraction-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%paned %peer (%builtin)
	 (let* ((w (%widget-width o))
		(pos (if (=fx w 1)
			 -1
			 (flonum->fixnum (*fl v (fixnum->flonum w))))))
	    (%%gtk-paned-position-set! (gtkpaned %builtin) pos)
	    o))))

;*---------------------------------------------------------------------*/
;*    %vpaned-fraction ...                                             */
;*---------------------------------------------------------------------*/
(define (%vpaned-fraction o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%paned %peer (%builtin)
	 (/fl (fixnum->flonum (%%bglk-gtk-paned-position (gtkpaned %builtin)))
	      (fixnum->flonum (%widget-height o))))))
   
;*---------------------------------------------------------------------*/
;*    %vpaned-fraction-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%vpaned-fraction-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%paned %peer (%builtin)
	 (let ((pos (flonum->fixnum (*fl v (fixnum->flonum (%widget-height o))))))
	    (%%gtk-paned-position-set! (gtkpaned %builtin) pos)
	    o))))

;*---------------------------------------------------------------------*/
;*    %paned-add! ...                                                  */
;*---------------------------------------------------------------------*/
(define (%paned-add! c w horizontal? expand shrink number)
   (with-access::%bglk-object c (%peer)
      (with-access::%paned %peer (%builtin %gc-children)
	 (set! %gc-children (cons w %gc-children))
	 (if (=fx number 1)
	     (begin
		(%%gtk-paned-pack1 (gtkpaned %builtin)
				   (gtkwidget (%peer-%builtin
					       (%bglk-object-%peer w)))
				   expand
				   shrink)
		c)
	     (begin
		(%%gtk-paned-pack2 (gtkpaned %builtin)
				   (gtkwidget (%peer-%builtin
					       (%bglk-object-%peer w)))
				   expand
				   shrink)
		c)))))
   
