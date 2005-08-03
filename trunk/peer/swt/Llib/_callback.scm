;*=====================================================================*/
;*    swt/Llib/_callback.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 23:14:55 2005 (dciabrin)               */
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
	   __biglook_%swt
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%event)
   
   (use    __biglook_%container
	   __biglook_%canvas)
   
   (export (%connect-widget-callback! ::%peer ::%jobject ::symbol ::obj)
	   (generic %connect-menu-item-callback! ::%peer ::symbol ::obj)
	   (%connect-toolbar-item-callback! ::%peer ::obj)
	   (%connect-tree-will-callback! ::%peer ::procedure ::procedure)
	   
	   ;; public installersx/deinstallers
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
   (print "%connect-widget-callback!")
   (if (%swt-widget? builtin)
       (case s
	  ((destroy)
	   ;; destroy
	   (if (not (%swt-shell? builtin))
	       (error "install-widget-event-handler!"
		      "Can't install event on non window widget"
		      s)
	       (%install-window-destroy-handler! peer v)))

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
(define (%install-window-destroy-handler! window::%peer handler)
   ;(print "%install-window-destroy-handler!")
   (let ((sa (%bglk-shelladapter-new wrap-event-descriptor)))
      (with-access::%peer window (%builtin)
	 (%swt-shell-add-shell-listener! %builtin sa))
      handler))

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
		(let ((new-v (lambda (e)
				(if (=fx (%event-mouse-button e) 1)
				    (v e)))))
		   (set! press-items (cons (cons o new-v) press-items)))))
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


