;*=====================================================================*/
;*    .../prgm/project/biglook/biglook/Lwidget/colorselector.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Apr  9 17:06:53 2001                          */
;*    Last change :  Thu Jul 26 16:24:33 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The color-selector widget                                        */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/colorselector.texi@                        */
;*       @node Color-Selector@                                         */
;*    Examples:                                                        */
;*       @path ../../examples/colorselect/colorselect.scm@             */
;*    -------------------------------------------------------------    */
;*    Implementation: @label widget@                                   */
;*    null: @path ../../peer/null/Lwidget/_colorselector.scm@          */
;*    gtk: @path ../../peer/gtk/Lwidget/_colorselector.scm@            */
;*    swing: @path ../../peer/swing/Lwidget/_colorselector.scm@        */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_color-selector
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_widget
	    __biglook_entry
	    __biglook_event
	    __biglook_container
	    __biglook_layout
	    __biglook_window
	    __biglook_box
	    __biglook_frame
	    __biglook_label
	    __biglook_button
	    __biglook_color)
   
   (export  (class color-selector::widget
	       ;; the selected color
	       (color
		(get (lambda (o)
			(%color-selector-color o make-rgb-color)))
		(set %color-selector-color-set!)))

	    (class color-chooser::window
	       (initial-color (default #f))
	       (ok-command (default #unspecified))
	       (cancel-command (default #unspecified)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::color-selector ...                            */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::color-selector)
   (with-access::color-selector o (%peer)
      (set! %peer (%make-%color-selector o))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::color-chooser ...                             */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::color-chooser)
   (call-next-method)
   (let* ((fr (instantiate::frame
		 (title "Color selector")
		 (parent o)))
	  (cs (instantiate::color-selector
                 (parent fr)))
	  (co (instantiate::box
		 (parent `(,fr :expand #t :fill both))
		 (orientation 'horizontal)
		 (padding 10)))
	  (but (instantiate::button
		  (parent co)
		  (text "Accept!")
		  (command (lambda (b)
			      (with-access::color-chooser o (ok-command)
				 (if (procedure? ok-command)
				     (if (correct-arity? ok-command 1)
					 (ok-command (color-selector-color cs))
					 (error "color-chooser:ok-command"
						"wrong command arity (1 expected)"
						ok-command)))
				 (destroy o))))))
	  (but2 (instantiate::button
		   (parent co)
		   (text "Cancel!")
		   (command (lambda (b)
			       (with-access::color-chooser o (cancel-command)
				  (if (procedure? cancel-command)
				      (if (correct-arity? cancel-command 0)
					  (cancel-command)
					  (error "color-chooser:cancel-command"
						 "wrong command arity (0 expected)"
						 cancel-command)))
				  (destroy o)))))))
      (with-access::color-chooser o (initial-color)
	 (if (%color? initial-color)
	     (color-selector-color-set! cs initial-color)))
      o))
   

