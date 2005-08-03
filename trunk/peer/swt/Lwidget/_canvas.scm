;*=====================================================================*/
;*    swt/Lwidget/_canvas.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:41:57 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Canvas implementation.                            */
;*    definition: @path ../../../biglook/Lwidget/canvas.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%canvas
   
   (import __biglook_%peer
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%container
	   __biglook_%widget
	   __biglook_%event)

   (export (class %canvas::%container
	      ;; the list of objects that belongs to that canvas
	      (children::pair-nil (default '()))
	      ;; the list of objects that have registered a motion hook
	      (motion-items::pair-nil (default '()))
	      ;; the list of objects that have registered a release hook
	      (release-items::pair-nil (default '()))
	      ;; the list of objects that have press a press hook
	      (press-items::pair-nil (default '()))
	      ;; the list of items registered for enter interaction
	      (enter-items::pair-nil (default '()))
	      ;; the list of items registered for leave interaction
	      (leave-items::pair-nil (default '()))
	      ;; the list of items registered for keyboard interaction
	      (key-items::pair-nil (default '())))

	   (class %canvas-item::%peer
	      (%canvas::%bglk-object read-only)
	      (%entered?::bool (default #f))
	      (%exited?::bool (default #f)))
	   
	   (generic %canvas-item-draw ::%canvas-item ::%awt-graphics)
	   (generic %canvas-item-contains?::bool ::%canvas-item ::int ::int)
	   
	   (%make-%canvas ::%bglk-object)

	   (%canvas-width::int ::%bglk-object)
	   (%canvas-width-set! ::%bglk-object ::int)
	   
	   (%canvas-height::int ::%bglk-object)
	   (%canvas-height-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-x::int ::%bglk-object)
	   (%canvas-scroll-x-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-y::int ::%bglk-object)
	   (%canvas-scroll-y-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-width::int ::%bglk-object)
	   (%canvas-scroll-width-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-height::int ::%bglk-object)
	   (%canvas-scroll-height-set! ::%bglk-object ::int)
	   
	   (%canvas-add! ::%bglk-object ::%bglk-object ::pair-nil)))

;*---------------------------------------------------------------------*/
;*    %make-%canvas ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%canvas o::%bglk-object)
   (let* ((canvas (%bglk-canvas-new %canvas-paint))
	  (peer (instantiate::%canvas
		   (%builtin canvas)
		   (%bglk-object o))))
      ;; connect the Biglook object and the canvas
      (%bglk-canvas-peer-set! canvas peer)
      (let ((move-listener (lambda (event)
			      (%canvas-motion-listener peer event)))
	    (press-listener (lambda (event)
			       (%canvas-press-listener peer event)))
	    (release-listener (lambda (event)
				 (%canvas-release-listener peer event))))
	 ;; install the canvas event listener
	 (%bglk-canvas-mousemotionadapter-add! canvas move-listener)
	 (%bglk-canvas-mouseadapter-add! canvas press-listener release-listener)
	 ;; return the peer object
	 peer)))

;*---------------------------------------------------------------------*/
;*    %canvas-mouse-at ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-mouse-at items::pair-nil event::%awt-mouseevent)
   (let ((x (%awt-mouseevent-x event))
	 (y (%awt-mouseevent-y event)))
      (for-each (lambda (item.callback)
		   (let* ((i (car item.callback))
			  (%i (%bglk-object-%peer i)))
		      (with-access::%canvas-item %i (%builtin)
			 (if (%canvas-item-contains? %i x y)
			     (let ((evt (wrap-mouse-descriptor event i)))
				((cdr item.callback) evt))))))
		items)))
   
;*---------------------------------------------------------------------*/
;*    %canvas-motion-listener ...                                      */
;*---------------------------------------------------------------------*/
(define (%canvas-motion-listener o::%canvas event::%awt-mouseevent)
   (with-access::%canvas o (motion-items enter-items leave-items)
      ;; first, we scan for motion events
      (%canvas-mouse-at motion-items event)
      (let ((x (%awt-mouseevent-x event))
	    (y (%awt-mouseevent-y event)))
	 ;; enter
	 (for-each (lambda (item.callback)
		      (let* ((i (car item.callback))
			     (%i (%bglk-object-%peer i)))
			 (with-access::%canvas-item %i (%builtin %entered?)
			    (if (%canvas-item-contains? %i x y)
				(if (not %entered?)
				    (let ((e (wrap-mouse-descriptor event i)))
				       (set! %entered? #t)
				       ((cdr item.callback) e)))
				(set! %entered? #f)))))
		   enter-items)
	 ;; leave
	 (for-each (lambda (item.callback)
		      (let* ((i (car item.callback))
			     (%i (%bglk-object-%peer i)))
			 (with-access::%canvas-item %i (%builtin %exited?)
			    (if (not (%canvas-item-contains? %i x y))
				(if (not %exited?)
				    (let ((e (wrap-mouse-descriptor event i)))
				       (set! %exited? #t)
				       ((cdr item.callback) e)))
				(set! %exited? #f)))))
		   leave-items))))

;*---------------------------------------------------------------------*/
;*    %canvas-press-listener ...                                       */
;*---------------------------------------------------------------------*/
(define (%canvas-press-listener o::%canvas event::%awt-mouseevent)
   (with-access::%canvas o (press-items)
      (%canvas-mouse-at press-items event)))

;*---------------------------------------------------------------------*/
;*    %canvas-release-listener ...                                     */
;*---------------------------------------------------------------------*/
(define (%canvas-release-listener o::%canvas event::%awt-mouseevent)
   (with-access::%canvas o (release-items)
      (%canvas-mouse-at release-items event)))

;*---------------------------------------------------------------------*/
;*    %canvas-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%canvas-add! c::%bglk-object w::%bglk-object options)
   (%container-add! c w))

;*---------------------------------------------------------------------*/
;*    %canvas-paint ...                                                */
;*---------------------------------------------------------------------*/
(define (%canvas-paint c::%canvas g::%awt-graphics)
   (with-access::%canvas c (children)
      (for-each (lambda (ci)
		   (if (%peer? (%bglk-object-%peer ci))
		       (%canvas-item-draw (%bglk-object-%peer ci) g)))
		children)))

;*---------------------------------------------------------------------*/
;*    %peer-init ::%canvas-item ...                                    */
;*---------------------------------------------------------------------*/
(define-method (%peer-init ci::%canvas-item)
   (with-access::%canvas-item ci (%canvas)
      (with-access::%bglk-object %canvas (%peer)
	 (let ((g (%awt-component-graphics (%peer-%builtin %peer))))
	    (%canvas-item-draw ci g)))))
   
;*---------------------------------------------------------------------*/
;*    %canvas-item-draw ...                                            */
;*---------------------------------------------------------------------*/
(define-generic (%canvas-item-draw ci::%canvas-item g::%awt-graphics)
   (error "container-add!(canvas)"
	  "Illegal canvas item"
	  (%peer-%bglk-object ci)))

;*---------------------------------------------------------------------*/
;*    %canvas-item-contains? ...                                       */
;*---------------------------------------------------------------------*/
(define-generic (%canvas-item-contains?::bool ci::%canvas-item x::int y::int)
   #f)

;*---------------------------------------------------------------------*/
;*    %canvas-width ...                                                */
;*---------------------------------------------------------------------*/
(define (%canvas-width::int o::%bglk-object)
   (%widget-width o))

;*---------------------------------------------------------------------*/
;*    %canvas-width-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-width-set! o::%bglk-object v::int)
   (%widget-width-set! o v))

;*---------------------------------------------------------------------*/
;*    %canvas-height ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-height::int o::%bglk-object)
   (%widget-height o))

;*---------------------------------------------------------------------*/
;*    %canvas-height-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-height-set! o::%bglk-object v::int)
   (%widget-height-set! o v))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-x ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-x::int o::%bglk-object)
   -1)

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-x-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-x-set! o::%bglk-object v::int)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-y ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-y::int o::%bglk-object)
   -1)

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-y-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-y-set! o::%bglk-object v::int)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-width::int o::%bglk-object)
   (%widget-width o))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-width-set! o::%bglk-object v::int)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-height ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-height::int o::%bglk-object)
   (%widget-height o))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-height-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-height-set! o::%bglk-object v::int)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %%container-children ::%canvas ...                               */
;*---------------------------------------------------------------------*/
(define-method (%%container-children o::%canvas)
   (with-access::%canvas o (children)
      children))

;*---------------------------------------------------------------------*/
;*    %%container-remove! ::%canvas ...                                */
;*---------------------------------------------------------------------*/
(define-method (%%container-remove! o::%canvas w)
   (with-access::%canvas o (children)
      (set! children (remq! w children))))
