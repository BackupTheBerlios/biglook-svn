;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_entry.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Oct 10 15:26:51 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Entry implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/entry.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%entry
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%gtk-misc
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%event
	   __biglook_%callback)
   
   (extern (macro %%gtk-entry-new::gtkwidget* ()
		  "gtk_entry_new")
	   (macro %%gtk-entry-text::string (::gtkentry*)
		  "gtk_entry_get_text")
	   (macro %%gtk-entry-text-set!::void (::gtkentry* ::string)
		  "gtk_entry_set_text"))
   
   (export (class %entry::%peer
	      (%user-command (default #f))
	      (%sys-command (default #f)))

	   (%make-%entry ::%bglk-object)
	   
	   (%entry-command ::%bglk-object)
	   (%entry-command-set! ::%bglk-object ::obj)
	   
	   (%entry-text::bstring ::%bglk-object)
	   (%entry-text-set! ::%bglk-object ::bstring)
	   
	   (%entry-active?::bool ::%bglk-object)
	   (%entry-active?-set! ::%bglk-object ::bool)
	   
	   (%entry-width::int ::%bglk-object)
	   (%entry-width-set! ::%bglk-object ::int)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%entry ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%entry o::%bglk-object)
   (instantiate::%entry
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-entry-new)))))

;*---------------------------------------------------------------------*/
;*    %entry-command ...                                               */
;*---------------------------------------------------------------------*/
(define (%entry-command o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%entry %peer (%user-command)
	 %user-command)))

;*---------------------------------------------------------------------*/
;*    %entry-command-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%entry-command-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%entry %peer (%user-command %sys-command)
	 (if (procedure? %sys-command)
	     (%uninstall-widget-callback! o 'return %sys-command))
	 (if (procedure? v)
	     (let ((sys-command (lambda (e)
				   (if (char=? (%event-key-char e) #\Newline)
				       (v e)))))
		(%install-widget-callback! o 'return sys-command)
		(set! %sys-command sys-command))
	     (set! %sys-command #f))
	 (set! %user-command v))))

;*---------------------------------------------------------------------*/
;*    %entry-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%entry-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%entry %peer (%builtin)
	 (%%gtk-entry-text (gtkentry %builtin)))))

;*---------------------------------------------------------------------*/
;*    %entry-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%entry-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (with-access::%entry %peer (%builtin)
	 (%%gtk-entry-text-set! (gtkentry %builtin) v)
	 o)))

;*---------------------------------------------------------------------*/
;*    %entry-active? ...                                               */
;*---------------------------------------------------------------------*/
(define (%entry-active? o::%bglk-object)
   (g-property-get o "editable"))

;*---------------------------------------------------------------------*/
;*    %entry-active?-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%entry-active?-set! o::%bglk-object v::bool)
   (g-property-set! o "editable" v))

;*---------------------------------------------------------------------*/
;*    %entry-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%entry-width::int o::%bglk-object)
   (%widget-width o))
;*    (g-property-get o "max-length"))                                    */

;*---------------------------------------------------------------------*/
;*    %entry-width-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%entry-width-set! o::%bglk-object v::int)
   (%widget-width-set! o v))
;*    (g-property-type-set! o "max-length" v G-TYPE-UINT))              */

