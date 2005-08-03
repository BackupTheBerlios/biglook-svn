;*=====================================================================*/
;*    swt/Lwidget/_notepad.scm                                         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:42:35 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Label implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/notepad.scm@          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%notepad
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%swing-misc
	   __biglook_%image)

   (static (class %notepad::%peer))
	   
   (export (%make-%notepad ::%bglk-object)
	   
	   (%notepad-position::symbol ::%bglk-object)
	   (%notepad-position-set! ::%bglk-object ::symbol)
	   
	   (%notepad-selected-page::%bglk-object ::%bglk-object)
	   (%notepad-selected-page-set! ::%bglk-object ::%bglk-object)
	   
	   (%notepad-add! ::%bglk-object ::%bglk-object ::obj ::obj)
	   (%notepad-remove! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%notepad ...                                               */
;*---------------------------------------------------------------------*/
(define (%make-%notepad o::%bglk-object)
   (instantiate::%notepad
      (%bglk-object o)
      (%builtin (%swing-jtabbedpane-new))))

;*---------------------------------------------------------------------*/
;*    %notepad-position ...                                            */
;*---------------------------------------------------------------------*/
(define (%notepad-position o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%notepad %peer (%builtin)
	 (swing-position->biglook
	  (%swing-jtabbedpane-position %builtin)))))

;*---------------------------------------------------------------------*/
;*    %notepad-position-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%notepad-position-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%notepad %peer (%builtin)
	 (%swing-jtabbedpane-position-set! %builtin
					   (biglook-position->swing v))
	 o)))
		      
;*---------------------------------------------------------------------*/
;*    %notepad-selected-page ...                                       */
;*---------------------------------------------------------------------*/
(define (%notepad-selected-page o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%notepad %peer (%builtin)
	 (%bglk-get-object (%swing-jtabbedpane-selected %builtin)))))

;*---------------------------------------------------------------------*/
;*    %notepad-selected-page-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%notepad-selected-page-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%notepad %peer (%builtin)
	 (%swing-jtabbedpane-selected-set! %builtin
					   (%peer-%builtin
					    (%bglk-object-%peer v)))
	 o)))

;*---------------------------------------------------------------------*/
;*    %notepad-add! ...                                                */
;*---------------------------------------------------------------------*/
(define (%notepad-add! c::%bglk-object w::%bglk-object title image)
   (with-access::%bglk-object c (%peer)
      (with-access::%notepad %peer (%builtin)
	 (cond
	    ((and (string? title) (%bglk-object? image))
	     (let ((com::%awt-component (%peer-%builtin
					 (%bglk-object-%peer w)))
		   (im::%swing-icon (%image-%icon
				     (%bglk-object-%peer image))))
		(%swing-jtabbedpane-add-text+icon! %builtin
						   (%bglk-bstring->jstring title)
						   im
						   com)
		c))
	    ((string? title)
	     (let ((com::%awt-component (%peer-%builtin
					 (%bglk-object-%peer w))))
		(%swing-jtabbedpane-add-text! %builtin
					      (%bglk-bstring->jstring title)
					      com)
		c))
	    ((%bglk-object? image)
	     (let ((com::%awt-component (%peer-%builtin
					 (%bglk-object-%peer w)))
		   (im::%swing-icon (%image-%icon
				     (%bglk-object-%peer image))))
		(%swing-jtabbedpane-add-text+icon! %builtin
						   (%bglk-bstring->jstring "")
						   im
						   com)
		c))
	    (else
	     (let* ((num (+fx 1 (%swing-jtabbedpane-length %builtin)))
		    (snum (integer->string num))
		    (title (string-append "Tab " snum))
		    (com::%awt-component (%peer-%builtin
					  (%bglk-object-%peer w))))
		(%swing-jtabbedpane-add-text! %builtin
					      (%bglk-bstring->jstring title)
					      com)
		c))))))

;*---------------------------------------------------------------------*/
;*    %notepad-remove! ...                                             */
;*---------------------------------------------------------------------*/
(define (%notepad-remove! c::%bglk-object w::%bglk-object)
   (with-access::%bglk-object c (%peer)
      (with-access::%notepad %peer (%builtin)
	 (%swing-jtabbedpane-remove %builtin
				    (%peer-%builtin (%bglk-object-%peer w)))
	 c)))
