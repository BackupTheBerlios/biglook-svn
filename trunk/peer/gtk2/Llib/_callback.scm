;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Llib/_callback.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Aug  2 08:11:34 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer event implementation.                               */
;*    definition: @path ../../../biglook/Llib/event.scm@               */
;*                                                                     */
;*    Events are defined in:                                           */
;*    definition: @path _event.scm@                                    */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%callback
   
   (import __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%event)
   
   (extern  (macro %%bglk-install-widget-event-handler!::obj
		   (::gtkobject* ::obj ::string)
		   "bglk_install_widget_event_handler")
	    (macro %%bglk-uninstall-widget-event-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_uninstall_widget_event_handler")
	    (macro %%bglk-install-canvas-item-event-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_install_canvas_item_event_handler")
	    (macro %%bglk-uninstall-canvas-item-event-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_uninstall_canvas_item_event_handler")
	    (macro %%bglk-install-menu-item-event-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_install_menu_item_event_handler")
	    (macro %%bglk-uninstall-menu-item-event-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_uninstall_menu_item_event_handler")
	    (macro %%bglk-install-widget-signal-handler!::obj
		   (::gtkobject* ::obj ::string)
		   "bglk_install_widget_signal_handler")
	    (macro %%bglk-uninstall-widget-signal-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_uninstall_widget_signal_handler")
	    (macro %%bglk-install-child-handler!::obj
		   (::gtkobject* ::obj ::string)
		   "bglk_install_child_handler")
	    (macro %%bglk-uninstall-child-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_uninstall_child_handler")
	    (macro %%bglk-install-row-select-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_install_row_select_handler")
	    (macro %%bglk-uninstall-row-select-handler!::obj
		   (::gtkobject* ::obj)
		   "bglk_uninstall_row_select_handler")
	    
	    (macro %%bglk-toolbar-callback::gtksignalfunc
		   "bglk_toolbar_callback"))
   
   (export (%connect-widget-callback! ::gtkobject* ::symbol ::procedure)
	   (%disconnect-widget-callback! ::gtkobject* ::symbol ::procedure)
	   
	   (generic %connect-menu-item-callback! ::%peer ::gtkobject* ::obj)
	   (generic %disconnect-menu-item-callback! ::%peer ::gtkobject* ::obj)
	   
	   (%connect-row-select-callback! ::gtkobject* ::obj)
	   (%disconnect-row-select-callback! ::gtkobject* ::obj)
	   
	   (%connect-child-callback! ::gtkobject* ::obj)
	   (%disconnect-child-callback! ::gtkobject* ::obj)
	   
	   ;; event handler installers
	   (%install-widget-callback! ::%bglk-object ::symbol ::procedure)
	   (generic %%install-widget-callback! ::%peer ::symbol ::procedure)
	   (%uninstall-widget-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-canvas-item-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-canvas-item-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-tree-branch-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-tree-branch-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-tree-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-tree-callback! ::%bglk-object ::symbol ::procedure)

	   (%install-menu-item-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-menu-item-callback! ::%bglk-object ::symbol ::procedure)))

;*---------------------------------------------------------------------*/
;*    *widget-event-gtk-name* ...                                      */
;*---------------------------------------------------------------------*/
(define *widget-event-gtk-name*
   '((enter . "enter-notify-event")
     (leave . "leave-notify-event")
     (press . "button-press-event")
     (release . "button-release-event")
     (motion . "motion-notify-event")
     (key . "key-press-event")
     (return . "key-press-event")
     (iconify . "unmap-event")
     (deiconify . "map-event")
     (focus-out . "focus-out-event")
     (focus-in . "focus-in-event")
     (configure . ("size-allocate" "configure-event"))))

;*---------------------------------------------------------------------*/
;*    *widget-signal-gtk-name* ...                                     */
;*---------------------------------------------------------------------*/
(define *widget-signal-gtk-name*
   '((click . "clicked")
     (click-ok . "clicked")
     (click-cancel . "clicked")
     (expand . "expand")
     (collapse . "collapse")
     (destroy . "destroy")
     (value-changed . "value-changed")))

;*---------------------------------------------------------------------*/
;*    connect-widget-callback! ...                                     */
;*---------------------------------------------------------------------*/
(define (%connect-widget-callback! builtin e v)
   (let ((ename (assq e *widget-event-gtk-name*)))
      (if (pair? ename)
	  (begin
	    (if (pair? (cdr ename))
	      (for-each (lambda (n)
			   (%%bglk-install-widget-event-handler! builtin v n))
			(cdr ename))
	      (%%bglk-install-widget-event-handler! builtin v (cdr ename))))
	  (let ((sname (assq e *widget-signal-gtk-name*)))
	     (if (pair? sname)
		 (%%bglk-install-widget-signal-handler! builtin v (cdr sname))
		 (error "%connect-widget-event-handler" "Unknown event" e))))))

;*---------------------------------------------------------------------*/
;*    disconnect-widget-callback! ...                                  */
;*---------------------------------------------------------------------*/
(define (%disconnect-widget-callback! builtin e v)
   (let ((event-name (assq e *widget-event-gtk-name*)))
      (if (pair? event-name)
	  (%%bglk-uninstall-widget-event-handler! builtin v)
	  (let ((signal-name (assq e *widget-signal-gtk-name*)))
	     (if (pair? signal-name)
		 (%%bglk-uninstall-widget-signal-handler! builtin v)
		 (error "%connect-widget-event-handler" "Unknown event" e))))))

;*---------------------------------------------------------------------*/
;*    %connect-canvas-item-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%connect-canvas-item-callback! builtin e v)
   (let* ((mask (case e
		   ((click)
		    (bit-lsh 1 %%GDK-BUTTON-PRESS))
		   ((press)
		    (bit-or (bit-lsh 1 %%GDK-BUTTON-PRESS)
			    (bit-or (bit-lsh 1 %%GDK-2BUTTON-PRESS)
				    (bit-lsh 1 %%GDK-3BUTTON-PRESS))))
		   ((release)
		    (bit-lsh 1 %%GDK-BUTTON-RELEASE))
		   ((enter)
		    (bit-lsh 1 %%GDK-ENTER-NOTIFY))
		   ((leave)
		    (bit-lsh 1 %%GDK-LEAVE-NOTIFY))
		   ((motion)
		    (bit-lsh 1 %%GDK-MOTION-NOTIFY))
		   ((key)
		    (bit-lsh 1 %%GDK-KEY-PRESS))
		   (else
		    (error "%connect-canvas-item-handler" "Unknown event" e))))
	  (v (if (eq? e 'click)
		 (lambda (e)
		    (if (and (=fx (%event-mouse-button e) 1)
			     (null? (%event-mouse-modifiers e)))
			(v e)))
		 v))
	  (newv (cons v mask)))
      (%%bglk-install-canvas-item-event-handler! builtin newv)
      newv))
   
;*---------------------------------------------------------------------*/
;*    %connect-menu-item-callback! ...                                 */
;*---------------------------------------------------------------------*/
(define-generic (%connect-menu-item-callback! peer builtin v)
   (%%bglk-install-menu-item-event-handler! builtin v))
   
;*---------------------------------------------------------------------*/
;*    %disconnect-menu-item-callback! ...                              */
;*---------------------------------------------------------------------*/
(define-generic (%disconnect-menu-item-callback! peer builtin v)
   (%%bglk-uninstall-menu-item-event-handler! builtin v))
   
;*---------------------------------------------------------------------*/
;*    %connect-row-select-callback! ...                                */
;*---------------------------------------------------------------------*/
(define (%connect-row-select-callback! builtin v)
   (%%bglk-install-row-select-handler! builtin v))
   
;*---------------------------------------------------------------------*/
;*    %disconnect-row-select-callback! ...                             */
;*---------------------------------------------------------------------*/
(define (%disconnect-row-select-callback! builtin oldv)
   (%%bglk-uninstall-row-select-handler! builtin oldv))
   
;*---------------------------------------------------------------------*/
;*    %connect-child-callback! ...                                     */
;*---------------------------------------------------------------------*/
(define (%connect-child-callback! builtin v)
   (%%bglk-install-child-handler! builtin v "select-child"))
   
;*---------------------------------------------------------------------*/
;*    %disconnect-child-callback! ...                                  */
;*---------------------------------------------------------------------*/
(define (%disconnect-child-callback! builtin oldv)
   (%%bglk-uninstall-child-handler! builtin oldv))
   
;*---------------------------------------------------------------------*/
;*    %install-widget-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define (%install-widget-callback! o e v)
   (with-access::%bglk-object o (%peer)
      (%%install-widget-callback! %peer e v)))

;*---------------------------------------------------------------------*/
;*    %%install-widget-callback! ::peer...                             */
;*---------------------------------------------------------------------*/
(define-generic (%%install-widget-callback! o::%peer e v)
  (with-access::%peer o (%builtin)
     (%connect-widget-callback! %builtin e v)))
	  
;*---------------------------------------------------------------------*/
;*    %uninstall-widget-callback! ...                                  */
;*---------------------------------------------------------------------*/
(define (%uninstall-widget-callback! o sym::symbol oldv)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%disconnect-widget-callback! %builtin sym oldv))))

;*---------------------------------------------------------------------*/
;*    %install-canvas-item-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%install-canvas-item-callback! o e v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%connect-canvas-item-callback! %builtin e v))))

;*---------------------------------------------------------------------*/
;*    %uninstall-canvas-item-callback! ...                             */
;*---------------------------------------------------------------------*/
(define (%uninstall-canvas-item-callback! o s oldv)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%%bglk-uninstall-canvas-item-event-handler! %builtin oldv))))

;*---------------------------------------------------------------------*/
;*    %install-menu-item-callback! ...                                 */
;*---------------------------------------------------------------------*/
(define (%install-menu-item-callback! o e v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (case e
	    ((activate)
	     (%connect-menu-item-callback! %peer %builtin v))
	    (else
	     (error "%install-menu-item-handler" "Illegal event" e))))))

;*---------------------------------------------------------------------*/
;*    %uninstall-menu-item-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%uninstall-menu-item-callback! o s oldv)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%%bglk-uninstall-menu-item-event-handler! %builtin oldv))))

;*---------------------------------------------------------------------*/
;*    %install-tree-callback! ...                                      */
;*---------------------------------------------------------------------*/
(define (%install-tree-callback! o s p)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %uninstall-tree-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define (%uninstall-tree-callback! o s p)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (not-implemented o "%uninstall-tree-callback!"))))

;*---------------------------------------------------------------------*/
;*    %install-tree-branch-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%install-tree-branch-callback! o s p)
   (%install-widget-callback! o s p))

;*---------------------------------------------------------------------*/
;*    %uninstall-tree-branch-callback! ...                             */
;*---------------------------------------------------------------------*/
(define (%uninstall-tree-branch-callback! o s p)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (not-implemented o "%uninstall-tree-branch-callback!"))))
