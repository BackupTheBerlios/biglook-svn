;*=====================================================================*/
;*    .../prgm/project/biglook/peer/gtk/Lwidget/_fileselector.scm      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jul 15 17:45:03 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Fileselector implementation.                        */
;*    definition: @path ../../../biglook/Lwidget/fileselector.scm@     */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%file-selector
   
   (import __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%callback)

   (extern (macro %%gtk-file-selection-new::gtkwidget*
		  (::string)
		  "gtk_file_selection_new")
	   (macro %%gtk-file-selection-set-filename::void
		  (::gtkfileselection* ::string)
		  "gtk_file_selection_set_filename")
	   (macro %%gtk-file-selection-get-filename::string
		  (::gtkfileselection*)
		  "gtk_file_selection_get_filename")
	   (macro %%bglk-gtk-file-selection-ok-button::gtkobject*
		  (::gtkfileselection*)
		  "BGLK_FILE_SELECTION_OK_BUTTON")
	   (macro %%bglk-gtk-file-selection-cancel-button::gtkobject*
		  (::gtkfileselection*)
		  "BGLK_FILE_SELECTION_CANCEL_BUTTON"))

   (static (class %file-selector::%peer
	      (%ok-command (default #f))
	      (%cancel-command (default #f))))
	   
   (export (%make-%file-selector ::%bglk-object ::bstring)

	   (%file-selector-file::bstring ::%bglk-object)
	   (%file-selector-file-set! ::%bglk-object ::bstring)
	   
	   (%file-selector-path::bstring ::%bglk-object)
	   (%file-selector-path-set! ::%bglk-object ::bstring)
	   
	   (%file-selector-ok-command ::%bglk-object)
	   (%file-selector-ok-command-set! ::%bglk-object ::obj)
	   
	   (%file-selector-cancel-command ::%bglk-object)
	   (%file-selector-cancel-command-set! ::%bglk-object ::obj)))

;*---------------------------------------------------------------------*/
;*    %make-%file-selector ...                                         */
;*---------------------------------------------------------------------*/
(define (%make-%file-selector o title)
   (instantiate::%file-selector
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-file-selection-new title)))))

;*---------------------------------------------------------------------*/
;*    %file-selector-file ...                                          */
;*---------------------------------------------------------------------*/
(define (%file-selector-file o)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-file-selection-get-filename (gtkfileselection %builtin))))
					 

;*---------------------------------------------------------------------*/
;*    %file-selector-file-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%file-selector-file-set! o v)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-file-selection-set-filename (gtkfileselection %builtin) v)
      v))

;*---------------------------------------------------------------------*/
;*    %file-selector-path ...                                          */
;*---------------------------------------------------------------------*/
(define (%file-selector-path o)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (dirname (%%gtk-file-selection-get-filename (gtkfileselection %builtin)))))

;*---------------------------------------------------------------------*/
;*    %file-selector-path-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%file-selector-path-set! o v)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (let ((path (string-append v "/")))
	 (%%gtk-file-selection-set-filename (gtkfileselection %builtin) path)
	 v)))

;*---------------------------------------------------------------------*/
;*    %file-selector-ok-command ...                                    */
;*---------------------------------------------------------------------*/
(define (%file-selector-ok-command o)
   (with-access::%file-selector (%bglk-object-%peer o) (%ok-command)
      %ok-command))

;*---------------------------------------------------------------------*/
;*    %file-selector-ok-command-set! ...                               */
;*---------------------------------------------------------------------*/
(define (%file-selector-ok-command-set! o v)
   (with-access::%bglk-object o (%peer)
      (with-access::%file-selector %peer (%ok-command %builtin)
	 (let ((but (%%bglk-gtk-file-selection-ok-button
		     (gtkfileselection %builtin))))
	    ;; connect it to the Biglook widget
	    (%bglk-g-property-type-set! (gobject but) "user-data" o G-TYPE-POINTER)
	    ;; de-install the format event handler
	    (if (procedure? %ok-command)
		(%disconnect-widget-callback! but 'click-ok %ok-command))
	    ;; install the event handler
	    (if (procedure? v)
		(%connect-widget-callback! but 'click-ok v))
	    ;; store the callback
	    (set! %ok-command v)))))

;*---------------------------------------------------------------------*/
;*    %file-selector-cancel-command ...                                */
;*---------------------------------------------------------------------*/
(define (%file-selector-cancel-command o)
   (with-access::%file-selector (%bglk-object-%peer o) (%cancel-command)
      %cancel-command))

;*---------------------------------------------------------------------*/
;*    %file-selector-cancel-command-set! ...                           */
;*---------------------------------------------------------------------*/
(define (%file-selector-cancel-command-set! o v)
   (with-access::%bglk-object o (%peer)
      (with-access::%file-selector %peer (%cancel-command %builtin)
	 (let ((but (%%bglk-gtk-file-selection-cancel-button
		     (gtkfileselection %builtin))))
	    ;; connect it to the Biglook widget
	    (%bglk-g-property-type-set! (gobject but) "user-data" o G-TYPE-POINTER)
	    ;; de-install the previous handler
	    (if (procedure? %cancel-command)
		(%disconnect-widget-callback! but
					      'click-cancel
					      %cancel-command))
	    ;; install the event handler
	    (if (procedure? v)
		(%connect-widget-callback! but
					   'click-cancel
					   v))
	    ;; store the callback
	    (set! %cancel-command v)))))

