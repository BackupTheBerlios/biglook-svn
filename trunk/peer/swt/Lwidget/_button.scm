;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_button.scm      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon Jul 16 10:10:47 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Swing peer Button implementation.                            */
;*    definition: @path ../../../biglook/Lwidget/button.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%button
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%image
	   __biglook_%callback)
   
   (export (class %button::%peer
	      (%command (default #f))
	      (%image (default #unspecified)))

	   (%make-%button ::%bglk-object)
	   
	   (%button-command ::%bglk-object)
	   (%button-command-set! ::%bglk-object ::obj)
	   
	   (%button-text ::%bglk-object)
	   (%button-text-set! ::%bglk-object ::bstring)
	   
	   (%button-image ::%bglk-object)
	   (%button-image-set! ::%bglk-object ::%bglk-object)
	   
	   (%button-border-width::int ::%bglk-object)
	   (%button-border-width-set! ::%bglk-object ::int)
	   
	   (%button-relief::symbol ::%bglk-object)
	   (%button-relief-set! ::%bglk-object ::symbol)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%button ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%button o::%bglk-object)
   (let ((b (%swing-jbutton-new)))
      (%swing-jcomponent-alignment-x-set! b 0.5)
      (instantiate::%button
	 (%bglk-object o)
	 (%builtin b))))

;*---------------------------------------------------------------------*/
;*    %button-command ...                                              */
;*---------------------------------------------------------------------*/
(define (%button-command o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%button %peer (%command)
	 %command)))

;*---------------------------------------------------------------------*/
;*    %button-command-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%button-command-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%button %peer (%command)
	 (if (procedure? %command)
	     (%uninstall-widget-callback! o 'command %command))
	 (if (procedure? v)
	     (%install-widget-callback! o 'command v))
	 (set! %command v))))

;*---------------------------------------------------------------------*/
;*    %button-text ...                                                 */
;*---------------------------------------------------------------------*/
(define (%button-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%bglk-jstring->bstring
       (%swing-abstractbutton-text (%peer-%builtin %peer)))))

;*---------------------------------------------------------------------*/
;*    %button-text-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%button-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (%swing-abstractbutton-text-set! (%peer-%builtin %peer)
				       (%bglk-bstring->jstring v))
      o))

;*---------------------------------------------------------------------*/
;*    %button-image ...                                                */
;*---------------------------------------------------------------------*/
(define (%button-image o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%button %peer (%image)
	 %image)))

;*---------------------------------------------------------------------*/
;*    %button-image-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%button-image-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%button %peer (%builtin %image)
	 (set! %image v)
	 (let ((icon::%swing-imageicon (%image-%icon (%bglk-object-%peer v))))
	    (%swing-abstractbutton-icon-set! %builtin icon)
	    o))))

;*---------------------------------------------------------------------*/
;*    %button-border-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%button-border-width::int o::%bglk-object)
   (with-access::%button (%bglk-object-%peer o) (%builtin)
      (%awt-insets-bottom (%swing-abstractbutton-margin %builtin))))
  
;*---------------------------------------------------------------------*/
;*    %button-border-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%button-border-width-set! o::%bglk-object v::int)
   (with-access::%button (%bglk-object-%peer o) (%builtin)
      (let ((inset (%awt-insets-new v v v v)))
	 (%swing-abstractbutton-margin-set! %builtin inset)
	 v)))
  
;*---------------------------------------------------------------------*/
;*    %button-relief ...                                               */
;*---------------------------------------------------------------------*/
(define (%button-relief o::%bglk-object)
   (with-access::%button (%bglk-object-%peer o) (%builtin)
      (if (not (%swing-abstractbutton-isborderpainted %builtin))
	  'flat
	  'normal)))
  
;*---------------------------------------------------------------------*/
;*    %button-relief-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%button-relief-set! o::%bglk-object v)
   (with-access::%button (%bglk-object-%peer o) (%builtin)
      (if (memq v '(none flat))
	  (begin
	     (%swing-abstractbutton-isborderpainted-set! %builtin #f)
	     v))))
  
   
