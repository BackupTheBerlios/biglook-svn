;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/radio.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Tue Jun 24 16:32:20 2003 (serrano)                */
;*    Copyright   :  2000-03 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Radio Button widget                                      */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/radio.texi@                                */
;*       @node Radio Button@                                           */
;*    Examples:                                                        */
;*       @path ../../examples/radio/radio.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label radio@                                    */
;*    null: @path ../../peer/null/Lwidget/_radio.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_radio.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_radio.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_radio
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event
	    __biglook_layout
	    __biglook_frame
	    __biglook_box
	    __biglook_button
	    __biglook_check-button)

   (static  (class radio-button::check-button
	       (%radio::radio read-only)))
	       
   (export  (class radio::frame
	       ;; the contained widgets
	       (children::pair-nil
		(get %radio-children)
		read-only)
	       ;; texts
	       (texts::pair read-only)
	       ;; texts orientation
	       (orientation::symbol read-only (default 'vertical))
	       ;; active
	       (active::bool
		(get %radio-active?)
		(set %radio-active?-set!))
	       ;; value
	       (value::bstring
		(get %radio-value)
		(set %radio-value-set!))
	       ;; command
	       (command
		(get (lambda (o)
			(let ((children (radio-children o)))
			   (if (null? children)
			       #f
			       (button-command (car children))))))
		(set (lambda (o v)
			(let ((new-v (lambda (e)
					(let ((button (event-widget e)))
					   (if (radio-button-on button)
					       (v e))))))
			   (for-each (lambda (b)
					(button-command-set! b new-v))
				     (radio-children o))))))
	       ;; tooltips
	       (tooltips
		(get %radio-tooltips)
		(set %radio-tooltips-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::radio ...                                     */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::radio)
   (with-access::radio o (%peer orientation texts padding layout)
      ;; first, we allocate the appropriate frame
      (let ((frame (case orientation
		      ((vertical)
		       (instantiate::frame))
		      ((horizontal)
		       (let* ((frame (instantiate::frame
					(layout #f)))
			      (box (instantiate::box
				      (homogeneous #f)
				      (orientation 'horizontal)
				      (parent frame))))
			  (frame-layout-set! frame box)
			  frame))
		      (else
		       (error "make-radio"
			      "Illegal orientation"
			      orientation)))))
	 ;; create the radio
	 (set! %peer (%make-%radio o frame))
	 ;; and then add all the buttons
	 (for-each (lambda (text)
		      (instantiate::radio-button
			 (%radio o)
			 (text text)
			 (parent frame)))
		   texts)
	 ;; and then we proceed to a regular initialization
	 (set! layout #f)
	 (call-next-method)
	 o)))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::radio-button ...                              */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::radio-button)
   (with-access::radio-button o (%peer %radio parent)
      (set! %peer (%make-%radio-button o %radio))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::radio ...                                       */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::radio widget . options)
   (%radio-add! container widget))
