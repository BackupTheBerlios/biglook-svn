;*=====================================================================*/
;*    biglook/Lwidget/menu.scm                                         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Fri Nov 21 17:37:21 2003 (dciabrin)               */
;*    Copyright   :  2000-03 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Menu widget                                              */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/menu.texi@                                 */
;*       @node Menu@                                                   */
;*    Examples:                                                        */
;*       @path ../../examples/menubar/menubar.scm@                     */
;*    -------------------------------------------------------------    */
;*    Implementation: @label menu@                                     */
;*    null: @path ../../peer/null/Lwidget/_menu.scm@                   */
;*    gtk: @path ../../peer/gtk/Lwidget/_menu.scm@                     */
;*    swing: @path ../../peer/swing/Lwidget/_menu.scm@                 */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*---------------------------------------------------------------------*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_menu
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_event)
   
   (export  (class menubar::container
	       (shadow::symbol
		(get %menubar-shadow)
		(set %menubar-shadow-set!))
	       (easy
		(get (lambda (o)
			#unspecified))
		(set (lambda (o v)
			(%menubar-easy-set! o v)))))

	    (class popup-menu::container
	       (easy
		(get (lambda (o)
			#unspecified))
		(set (lambda (o v)
			(easy-popup-menu o v)))))

	    (class menu::container
	       ;; title
	       (title::bstring read-only)
	       ;; justification
	       (justify::symbol read-only (default 'left))
	       ;; tearoff
	       (tearoff::bool
		(get %menu-tearoff)
		(set %menu-tearoff-set!))
	       ;; active
	       (active::bool
		(get %widget-active?)
		(set %widget-active?-set!)))
	    
	    (class menu-separator::widget)
	    
	    (abstract-class menu-item::widget
	       ;; command (special case of callback)
	       (command
		(get %menu-item-command)
		(set (lambda (o v)
			(cond
			   ((not v)
			    (%menu-item-command-set! o v))
			   ((procedure? v)
			    (if (not (correct-arity? v 1))
				(error "menu-item-command-set!"
				       "Illegal command arity"
				       v)
				(%menu-item-command-set! o v)))
			   (else
			    (error "menu-item-command-set!"
				   "Illegal command value (should be #f or a procedure)"
				   v))))))
	       ;; active
	       (active::bool
		(get %widget-active?)
		(set %widget-active?-set!)))
	    
	    (class menu-label::menu-item
	       ;; menu item text
	       (text::bstring read-only))
	    
	    (class menu-check-button::menu-item
	       ;; menu item text
	       (text::bstring read-only)
	       ;; on
	       (on::bool
		(get %menu-check-button-on?)
		(set %menu-check-button-on?-set!)))
	    
	    (class menu-radio::menu-item
	       ;; radio texts
	       (texts::pair read-only)
	       ;; value
	       (value::bstring
		(get %menu-radio-value)
		(set %menu-radio-value-set!)))

	    (popup-menu-show! ::popup-menu ::widget ::pair)
	    ))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::menubar ...                                   */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::menubar)
   (with-access::menubar o (%peer)
      (set! %peer (%make-%menubar o))
      ;; the layout initialization
      (call-next-method)
      ;; we are done
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::popup-menu ...                                */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::popup-menu)
   (with-access::popup-menu o (%peer)
      (set! %peer (%make-%popup-menu o))
      ;; the layout initialization
      (call-next-method)
      ;; we are done
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::menu ...                                      */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::menu)
   (with-access::menu o (title %peer justify)
      (set! %peer (%make-%menu o title justify))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::menu-separator ...                            */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::menu-separator)
   (with-access::menu-separator o (%peer)
      (set! %peer (%make-%menu-separator o))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::menu-label ...                                */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::menu-label)
   (with-access::menu-label o (text %peer)
      (set! %peer (%make-%menu-label o text))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::menu-check-button ...                         */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::menu-check-button)
   (with-access::menu-check-button o (text %peer)
      (set! %peer (%make-%menu-check-button o text))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::menu-radio ...                                */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::menu-radio)
   (with-access::menu-radio o (texts %peer)
      (set! %peer (%make-%menu-radio o texts))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::menubar ...                                     */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::menubar widget . options)
   (let-options options ((:justify 'left))
      (%menubar-add! container widget justify)))

;*---------------------------------------------------------------------*/
;*    container-add! ::popup-menu ...                                  */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::popup-menu widget . options)
   (%popup-menu-add! container widget 'no-options))
   
;*---------------------------------------------------------------------*/
;*    container-add! ::menu ...                                        */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::menu widget . options)
   (%menu-add! container widget options))
   
;*---------------------------------------------------------------------*/
;*    install-callback! ::menu-item ...                                */
;*---------------------------------------------------------------------*/
(define-method (install-callback! w::menu-item evt::symbol proc)
   (cond
      ((procedure? proc)
       (%install-menu-item-callback! w evt proc))
      ((not proc)
       #unspecified)
      (else
       (error "install-callback!(menu-item)"
	      "Illegal callback (should be #f or a procedure)"
	      proc))))

;*---------------------------------------------------------------------*/
;*    uninstall-callback! ::menu-item ...                              */
;*---------------------------------------------------------------------*/
(define-method (uninstall-callback! w::menu-item evt::symbol proc)
   ;; uninstall is not a user function, we don't have to check any error here
   (if (procedure? proc)
       (%uninstall-menu-item-callback! w evt proc)))

;*---------------------------------------------------------------------*/
;*    %menubar-easy-set! ...                                           */
;*    -------------------------------------------------------------    */
;*    This function allocates a menubar from a list specification.     */
;*---------------------------------------------------------------------*/
(define (%menubar-easy-set! parent::menubar items::pair-nil)
   (let loop ((menus items)
	      (justify 'left))
      (if (pair? menus)
	  (let ((descr (car menus)))
	     (match-case descr
		(:fill
		 (loop (cdr menus) 'right))
		((:menu (and (? string?) ?menu) . ?items)
		 (let ((menu (instantiate::menu
				(title menu)
				(parent parent)
				(justify justify))))
		    (easy-menu menu items))
		 (loop (cdr menus) justify))
		(else
		 (error "easy-menubar" "Illegal item" descr)))))))

;*---------------------------------------------------------------------*/
;*    %popup-menu-easy-set! ...                                        */
;*    -------------------------------------------------------------    */
;*    This function allocates a menubar from a list specification.     */
;*---------------------------------------------------------------------*/
(define (%popup-menu-easy-set! parent::popup-menu items::pair-nil)
   (let loop ((menus items)
	      (justify 'left))
      (if (pair? menus)
	  (let ((descr (car menus)))
	     (match-case descr
		(:fill
		 (loop (cdr menus) 'right))
		((:menu (and (? string?) ?menu) . ?items)
		 (let ((menu (instantiate::menu
				(title menu)
				(parent parent)
				(justify justify))))
		    (easy-menu menu items))
		 (loop (cdr menus) justify))
		(else
		 (error "easy-popup-menu" "Illegal item" descr)))))))

(define (easy-menu parent::menu items::pair-nil)
   (easy-menu-container parent items))

(define (easy-popup-menu parent::popup-menu items::pair-nil)
   (easy-menu-container parent items))

;*---------------------------------------------------------------------*/
;*    easy-menu ...                                                    */
;*---------------------------------------------------------------------*/
(define (easy-menu-container parent::container items::pair-nil)
   ;; plain label
   (define (easy-label item)
      (let-options item ((:label "label")
			 (:active #t)
			 (:command (lambda (_) _)))
	 (instantiate::menu-label
	    (parent parent)
	    (active active)
	    (text label)
	    (command command))))
   ;; check buttons
   (define (easy-check item)
      (let-options item ((:check "check")
			 (:on #f)
			 (:active #t)
			 (:command (lambda (_) _)))
	 (instantiate::menu-check-button
	    (parent parent)
	    (text check)
	    (on on)
	    (active active)
	    (command command))))
   ;; radio buttons
   (define (easy-radio item)
      (let-options (cdr item) ((:value #f)
			       (:active #t)
			       (:command (lambda (_) _))
			       (texts '()))
	 (if (null? texts)
	     (error "easy-menu" "Illegal radio entry" item)
	     (let ((texts (reverse texts)))
		(instantiate::menu-radio
		   (parent parent)
		   (texts texts)
		   (active active)
		   (value (if (member value texts) value (car texts)))
		   (command command))))))
   ;; sub menu
   (define (easy-submenu item)
      (let-options item ((:menu "menu")
			 (:active #t)
			 (rest '()))
	 (let ((submenu (instantiate::menu
			   (parent parent)
			   (active active)
			   (title menu))))
	    (easy-menu submenu rest))))
   ;; main loop
   (let loop ((items items))
      (if (pair? items)
	  (let ((item (car items)))
	     (match-case item
;		(:tearoff
;		 (menu-tearoff-set! parent #t)
;		 (loop (cdr items)))
		(:separator
		 (instantiate::menu-separator
		    (parent parent))
		 (loop (cdr items)))
		((:label . ?-)
		 (easy-label item)
		 (loop (cdr items)))
		((:check . ?-)
		 (easy-check item)
		 (loop (cdr items)))
		((:radio . ?-)
		 (easy-radio item)
		 (loop (cdr items)))
		((:menu . ?-)
		 (easy-submenu item)
		 (loop (cdr items)))
		(else
		 (error "easy-menu" "Illegal item" item)))))))
      

;*---------------------------------------------------------------------*/
;*    popup-menu-show! ...                                             */
;*---------------------------------------------------------------------*/
(define (popup-menu-show! o::popup-menu caller::widget pos::pair)
   (%popup-menu-show! o caller pos))