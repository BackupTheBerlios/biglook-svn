;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/gauge.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Mon May  7 20:07:51 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook Gauge widget                                             */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/gauge.texi@                                */
;*       @node Gauge@                                                  */
;*    Examples:                                                        */
;*       @path ../../examples/gauge/gauge.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label gauge@                                    */
;*    null: @path ../../peer/null/Lwidget/_gauge.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_gauge.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_gauge.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_gauge
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_image
	    __biglook_event)
   
   (export  (class gauge::widget
	       ;; user text
	       (text
		(get %gauge-text)
		(set %gauge-text-set!))
	       ;; gauge style
	       (style::obj
		(get %gauge-style)
		(set (lambda (o v)
			(let ((v (if (symbol? v)
				     (list v)
				     v)))
			   (%gauge-style-set! o v)))))
	       ;; value
	       (value::int
		(get %gauge-value)
		(set %gauge-value-set!)))))
	       
;*---------------------------------------------------------------------*/
;*    bglk-object-init ::gauge ...                                     */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::gauge)
   (with-access::gauge o (%peer)
      (set! %peer (%make-%gauge o))
      (call-next-method)
      o))

