;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_button.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sat Jul 21 09:49:41 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Button implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/button.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%button
   
   (import __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%image
	   __biglook_%color
	   __biglook_%callback)
   
   (extern (macro %%gtk-button-new::gtkwidget* () "gtk_button_new"))
   
   (export (class %button::%container
	      (%command (default #f)))

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
   (let ((button (gtkobject (%%gtk-button-new))))
;*       (%bglk-g-property-set! button "receives-default" #f)             */
;*       (%bglk-g-property-set! button "can-default" #f)                  */
;*       (%bglk-g-property-set! button "can-focus" #f)                    */
      (instantiate::%button
	 (%bglk-object o)
	 (%builtin button))))

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
	     (%uninstall-widget-callback! o 'click %command))
	 (if (procedure? v)
	     (%install-widget-callback! o 'click v))
	 (set! %command v))))

;*---------------------------------------------------------------------*/
;*    %button-text ...                                                 */
;*---------------------------------------------------------------------*/
(define (%button-text o::%bglk-object)
   (g-property-get o "label"))

;*---------------------------------------------------------------------*/
;*    %button-text-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%button-text-set! o::%bglk-object v::bstring)
   (g-property-set! o "label" v))

;*---------------------------------------------------------------------*/
;*    %button-image ...                                                */
;*---------------------------------------------------------------------*/
(define (%button-image o::%bglk-object)
   (let ((children (%container-children o)))
      (cond
	 ((null? children)
	  #f)
	 ((not (%bglk-object? (car children)))
	  #f)
	 (else
	  (car children)))))

;*---------------------------------------------------------------------*/
;*    %button-image-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%button-image-set! o::%bglk-object v)
   (let ((img (%button-image o)))
      (if (%bglk-object? img)
	  (%container-remove! o img))
      (%container-add! o v)))

;*---------------------------------------------------------------------*/
;*    %button-border-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%button-border-width::int o::%bglk-object)
   (g-property-get o "border-width"))
  
;*---------------------------------------------------------------------*/
;*    %button-border-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%button-border-width-set! o::%bglk-object v::int)
   (g-property-type-set! o "border-width" v G-TYPE-ULONG))
  
;*---------------------------------------------------------------------*/
;*    %button-relief ...                                               */
;*---------------------------------------------------------------------*/
(define (%button-relief::symbol o::%bglk-object)
   (gtk-relief->biglook (g-property-get o "relief")))

;*---------------------------------------------------------------------*/
;*    %button-relief-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%button-relief-set! o::%bglk-object v::symbol)
   (with-access::%bglk-object o (%peer)
      (g-property-type-set! o
			    "relief"
			    (biglook-relief->gtk v)
			    GTK-TYPE-RELIEF-STYLE)))
  
   
