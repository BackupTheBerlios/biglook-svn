;*=====================================================================*/
;*    swing/Llib/_callback.scm                                         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Mar 31 15:02:04 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer event implementation.                             */
;*    definition: @path ../../../biglook/Llib/event.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%callback
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%event)
   
   (use    __biglook_%container
	   __biglook_%canvas)
   
   (export (%connect-widget-callback! ::%peer ::%jobject ::symbol ::obj)
	   (generic %connect-menu-item-callback! ::%peer ::symbol ::obj)
	   (%connect-toolbar-item-callback! ::%peer ::obj)
	   (%connect-tree-will-callback! ::%peer ::procedure ::procedure)
	   
	   ;; public installers/deinstallers
	   (%install-widget-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-widget-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-canvas-item-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-canvas-item-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-tree-branch-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-tree-branch-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-tree-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-tree-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-menu-item-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-menu-item-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-window-destroy-handler! ::%peer ::procedure)
	   ))
	   
;*---------------------------------------------------------------------*/
;*    %connect-widget-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define (%connect-widget-callback! peer builtin s v)
   (if (%awt-component? builtin)
       (case s
	  ((enter)
	   ;; enter
	   (%bglk-mouseadapter-add! builtin
				    #unspecified
				    #unspecified
				    v
				    #unspecified
				    #unspecified
				    #unspecified
				    wrap-mouse-descriptor)
	   v)
	  ((leave)
	   ;; leave
	   (%bglk-mouseadapter-add! builtin
				    #unspecified
				    #unspecified
				    #unspecified
				    v
				    #unspecified
				    #unspecified
				    wrap-mouse-descriptor)
	   v)
	  ((press)
	   ;; press
	   (%bglk-mouseadapter-add! builtin
				    v
				    #unspecified
				    #unspecified
				    #unspecified
				    #unspecified
				    #unspecified
				    wrap-mouse-descriptor)
	   v)
	  ((release)
	   ;; release
	   (%bglk-mouseadapter-add! builtin
				    #unspecified
				    v
				    #unspecified
				    #unspecified
				    #unspecified
				    #unspecified
				    wrap-mouse-descriptor)
	   v)
	  ((click)
	   ;; click
	   (%bglk-mouseadapter-add! builtin
				    #unspecified
				    #unspecified
				    #unspecified
				    #unspecified
				    v
				    #unspecified
				    wrap-mouse-descriptor)
	   v)
	  ((command)
	   ;; action adapter, otherwise widget-enabled-set! has no effect
	   ;; (ie one still get mouse click event...)
	   (%bglk-actionadapter-add! builtin
				     v
				     wrap-event-descriptor
				     (%bglk-bstring->jstring ""))	   
	   ;; command
;	   (%bglk-mouseadapter-add! builtin
;				    #unspecified
;				    #unspecified
;				    #unspecified
;				    #unspecified
;				    #unspecified
;				    v
;				    wrap-mouse-descriptor)
	   v)
	  ((action)
	   ;; action
	   (%bglk-actionadapter-add! builtin
				     v
				     wrap-event-descriptor
				     (%bglk-bstring->jstring ""))
	   v)
	  ((return)
	   ;; return
	   (%bglk-keyadapter-return-add! builtin v wrap-key-descriptor)
	   v)
	  ((motion)
	   ;; motion
	   (%bglk-mousemotionadapter-add! builtin
					  #unspecified
					  v
					  wrap-mouse-descriptor)
	   v)
	  ((key)
	   ;; key
	   (%bglk-keyadapter-add! builtin v wrap-key-descriptor)
	   v)
	  ((configure)
	   ;; configure
	   (%bglk-componentadapter-add! builtin v wrap-event-descriptor)
	   v)
	  ((focus-in)
	   ;; focus-in
	   (%bglk-focusadapter-add! builtin
				    v
				    #unspecified
				    wrap-event-descriptor)
	   v)
	  ((focus-out)
	   ;; focus-out
	   (%bglk-focusadapter-add! builtin 
				    #unspecified
				    v
				    wrap-event-descriptor)
	   v)
	  ((destroy)
	   ;; destroy
	   (if (not (%awt-window? builtin))
	       (error "install-widget-event-handler!"
		      "Can't install event on non window widget"
		      s)
	       (%install-window-destroy-handler! peer v)))
	  ((iconify)
	   ;; iconify
	   (if (not (%awt-window? builtin))
	       (error "install-widget-event-handler!"
		      "Can't install event on non window widget"
		      peer)
	       (begin
		  (%bglk-windowadapter-add! builtin
					    v
					    #unspecified
					    #unspecified
					    wrap-event-descriptor)
		  v)))
	  ((deiconify)
	   ;; deiconifu
	   (if (not (%awt-window? builtin))
	       (error "install-widget-event-handler!"
		      "Can't install event on non window widget"
		      peer)
	       (begin
		  (%bglk-windowadapter-add! builtin
					    #unspecified
					    v
					    #unspecified
					    wrap-event-descriptor)
		  v)))
	  ((jslider-change)
	   ;; jslider-change
	   (if (not (%swing-jslider? builtin))
	       (error "install-widget-event-handler!"
		      "Can't install event on non slider widget"
		      peer)
	       (begin
		  (%bglk-changeadapter-add! builtin
					    v
					    wrap-event-descriptor)
		  v)))
	  ((tree-selection)
	   (if (not (%swing-jtree? builtin))
	       (error "install-widget-event-handler!"
		      "Can't install event on non jtree widget"
		      peer)
	       (begin
		  (%bglk-tree-selectionadapter-add! builtin
						    v
						    wrap-event-descriptor)
		  v)))
	  ((table-selection)
	   (if (not (%swing-jtable? builtin))
	       (error "install-widget-event-handler!"
		      "Can't install event on non jtable widget"
		      peer)
	       (let ((model (%swing-jtable-selection-model builtin)))
		  (%bglk-list-selectionadapter-add! model
						    (%peer-%bglk-object peer)
						    v
						    wrap-event-descriptor)
		  v)))
	  ((table-changed)
	   (if (not (%swing-jtable? builtin))
	       (error "install-widget-event-handler!"
		      "Can't install event on non jtable widget"
		      peer)
	       (let ((model (%swing-jtable-model builtin)))
		  (%bglk-table-modeladapter-add! model
						 (%peer-%bglk-object peer)
						 v
						 wrap-event-descriptor)
		  v)))
	  ((expand)
	   #unspecified)
	  ((collapse)
	   #unspecified)
	  (else
	   (error "%install-handler!" "Unknown event" s)))))

;*---------------------------------------------------------------------*/
;*    %connect-menu-item-event-handler! ::%peer ...                    */
;*---------------------------------------------------------------------*/
(define-generic (%connect-menu-item-callback! %p::%peer e v)
   (with-access::%peer %p (%builtin)
      (case e
	 ((release)
	  (with-access::%peer %p (%builtin)
	     (%bglk-actionadapter-add! %builtin
				       v
				       wrap-event-descriptor
				       (%bglk-bstring->jstring ""))
	     %p))
	 (else
	  (error "%install-menu-item-handler" "Illegal event" e)))))

;*    %connect-toolbar-item-callback! ...                              */
;*    -------------------------------------------------------------    */
;*    MOUSE-DESCR has already been set before the call to this         */
;*    function.                                                        */
;*---------------------------------------------------------------------*/
(define (%connect-toolbar-item-callback! peer::%peer v)
   (with-access::%peer peer (%builtin)
      (%bglk-mouseadapter-add! %builtin
			       #unspecified
			       #unspecified
			       #unspecified
			       #unspecified
			       #unspecified
			       v
			       wrap-mouse-descriptor)
      v))

;*---------------------------------------------------------------------*/
;*    %connect-tree-will-callback! ...                                 */
;*---------------------------------------------------------------------*/
(define (%connect-tree-will-callback! peer::%peer ep co)
   (with-access::%peer peer (%builtin)
      (if (not (%swing-jtree? %builtin))
	  (error "%connect-tree-will-callback!"
		 "Can't install event on non JTree widget"
		 %builtin)
	  (let ((adapter (%bglk-treewillexpandadapter-new
			  ep
			  co
			  wrap-event-descriptor)))
	     (%swing-jtree-add-willexpandlistener %builtin adapter)
	     peer))))

;*---------------------------------------------------------------------*/
;*    %install-widget-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define (%install-widget-callback! o s v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%connect-widget-callback! %peer %builtin s v))))

;*---------------------------------------------------------------------*/
;*    %uninstall-widget-callback! ...                                  */
;*---------------------------------------------------------------------*/
(define (%uninstall-widget-callback! o s oldv)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%connect-widget-callback! %peer %builtin s #f))))

;*---------------------------------------------------------------------*/
;*    %install-window-destroy-handler! ...                             */
;*---------------------------------------------------------------------*/
(define (%install-window-destroy-handler! frame::%peer v)
   (with-access::%peer frame (%builtin)
      (%bglk-windowadapter-add! %builtin
				#unspecified
				#unspecified
				v
				wrap-event-descriptor)
      v))

;*---------------------------------------------------------------------*/
;*    %install-canvas-item-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%install-canvas-item-callback! o s v)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-item %peer (%builtin %canvas)
	 (case s
	    ((enter)
	     ;; register that this canvas-item now wants press events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (enter-items)
		(set! enter-items (cons (cons o v) enter-items))))
	    ((leave)
	     ;; register that this canvas-item now wants press events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (leave-items)
		(set! leave-items (cons (cons o v) leave-items))))
	    ((click)
	     ;; register that this canvas-item now wants click events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (press-items)
		(set! press-items (cons (cons o v) press-items))))
;		(let ((new-v (lambda (e)
;				(if (=fx (%event-mouse-button e) 1)
;				    (v e)))))
;		   (set! press-items (cons (cons o new-v) press-items)))))
	    ((press)
	     ;; register that this canvas-item now wants press events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (press-items)
		(set! press-items (cons (cons o v) press-items))))
	    ((release)
	     ;; register that this canvas-item now wants release events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (release-items)
		(set! release-items (cons (cons o v) release-items))))
	    ((motion)
	     ;; register that this canvas-item now wants motion events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (motion-items)
		(set! motion-items (cons (cons o v) motion-items))))
	    ((key)
	     ;; register that this canvas-item now wants motion events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (key-items)
		(set! key-items (cons (cons o v) key-items))))
	    (else
	     (error "%install-canvas-item-handler!"
		    "Unknown event"
		    s))))))

;*---------------------------------------------------------------------*/
;*    %uninstall-canvas-item-callback! ...                             */
;*---------------------------------------------------------------------*/
(define (%uninstall-canvas-item-callback! o s oldv)
   (with-access::%bglk-object o (%peer)
      (with-access::%canvas-item %peer (%builtin %canvas)
	 (case s
	    ((enter)
	     ;; unregister that this canvas-item now wants press events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (enter-items)
		(let ((cell (assq o enter-items)))
		   (if (pair? cell)
		       (set! enter-items (remq! cell enter-items))))))
	    ((leave)
	     ;; unregister that this canvas-item now wants press events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (leave-items)
		(let ((cell (assq o leave-items)))
		   (if (pair? cell)
		       (set! leave-items (remq! cell leave-items))))))
	    ((click)
	     ;; register that this canvas-item now wants click events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (press-items)
		(let ((cell (assq o press-items)))
		   (if (pair? cell)
		       (set! press-items (remq! cell press-items))))))
	    ((press)
	     ;; unregister that this canvas-item now wants press events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (press-items)
		(let ((cell (assq o press-items)))
		   (if (pair? cell)
		       (set! press-items (remq! cell press-items))))))
	    ((release)
	     ;; unregister that this canvas-item now wants release events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (release-items)
		(let ((cell (assq o release-items)))
		   (if (pair? cell)
		       (set! release-items (remq! cell release-items))))))
	    ((motion)
	     ;; unregister that this canvas-item now wants motion events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (motion-items)
		(let ((cell (assq o motion-items)))
		   (if (pair? cell)
		       (set! motion-items (remq! cell motion-items))))))
	    ((key)
	     ;; unregister that this canvas-item now wants motion events
	     (with-access::%canvas (%bglk-object-%peer %canvas) (key-items)
		(let ((cell (assq o key-items)))
		   (if (pair? cell)
		       (set! key-items (remq! cell key-items))))))
	    (else
	     (error "%install-canvas-item-handler!"
		    "Unknown event"
		    s))))))

;*---------------------------------------------------------------------*/
;*    %install-menu-item-callback! ...                                 */
;*---------------------------------------------------------------------*/
(define (%install-menu-item-callback! o e v)
   (with-access::%bglk-object o (%peer)
      (%connect-menu-item-callback! %peer e v)))

;*---------------------------------------------------------------------*/
;*    %uninstall-menu-item-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%uninstall-menu-item-callback! o e oldv)
   (with-access::%bglk-object o (%peer)
      (%connect-menu-item-callback! %peer e #f)))

;*---------------------------------------------------------------------*/
;*    %install-tree-callback! ...                                      */
;*---------------------------------------------------------------------*/
(define (%install-tree-callback! o s v)
   (%install-widget-callback! o s v))

;*---------------------------------------------------------------------*/
;*    %uninstall-tree-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define (%uninstall-tree-callback! o s oldv)
   (%uninstall-widget-callback! o s oldv))

;*---------------------------------------------------------------------*/
;*    %install-tree-branch-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%install-tree-branch-callback! o s p)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %uninstall-tree-branch-callback! ...                             */
;*---------------------------------------------------------------------*/
(define (%uninstall-tree-branch-callback! o s p)
   #unspecified)


