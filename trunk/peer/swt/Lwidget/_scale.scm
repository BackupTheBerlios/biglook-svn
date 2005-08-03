;*=====================================================================*/
;*    swt/Lwidget/_scale.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:42:27 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Scale implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/scale.scm@            */
;*=====================================================================*/
 
;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%scale
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%callback)
   
   (static  (class %scale::%peer
	       (%command (default #f))))
   
   (export  (%make-%hscale ::%bglk-object)
	    (%make-%vscale ::%bglk-object)

	    (%scale-command ::%bglk-object)
	    (%scale-command-set! ::%bglk-object ::obj)
	    
	    (%scale-value::int ::%bglk-object)
	    (%scale-value-set! ::%bglk-object ::int)
	    
	    (%scale-show-value?::bool ::%bglk-object)
	    (%scale-show-value?-set! ::%bglk-object ::bool)
	    
	    (%scale-from::int ::%bglk-object)
	    (%scale-from-set! ::%bglk-object ::int)
	    
	    (%scale-to::int ::%bglk-object)
	    (%scale-to-set! ::%bglk-object ::int)))


;*---------------------------------------------------------------------*/
;*    %make-%scale ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%scale o slider::%swing-jslider)
   ;; default visual configuration of the Swing slider
   (%swing-jslider-paint-labels-set! slider #t)
   (%swing-jslider-paint-ticks-set! slider #t)
   (%swing-jslider-paint-track-set! slider #t)
   (%swing-jslider-snap-to-ticks-set! slider #t)
   ;; we now allocate the Biglook peer
   (instantiate::%scale
      (%bglk-object o)
      (%builtin slider)))

;*---------------------------------------------------------------------*/
;*    %make-%hscale ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%hscale o)
   (%make-%scale o (%swing-jslider-new %swing-constants-HORIZONTAL)))

;*---------------------------------------------------------------------*/
;*    %make-%vscale ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%vscale o)
   (%make-%scale o (%swing-jslider-new %swing-constants-VERTICAL)))

;*---------------------------------------------------------------------*/
;*    %scale-command ...                                               */
;*---------------------------------------------------------------------*/
(define (%scale-command o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%command)
	 %command)))
   
;*---------------------------------------------------------------------*/
;*    %scale-command-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%scale-command-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin %command)
	 (set! %command v)
	 (%install-widget-callback! o 'jslider-change v))))

;*---------------------------------------------------------------------*/
;*    %scale-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%scale-value o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin)
	 (%swing-jslider-value %builtin))))
   
;*---------------------------------------------------------------------*/
;*    %scale-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%scale-value-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin)
	 (%swing-jslider-value-set! %builtin v)
	 o)))
   
;*---------------------------------------------------------------------*/
;*    %scale-show-value? ...                                           */
;*---------------------------------------------------------------------*/
(define (%scale-show-value? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin)
	 (>fx (%swing-jslider-major-ticks %builtin) 0))))
   
;*---------------------------------------------------------------------*/
;*    %scale-show-value?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%scale-show-value?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin)
	 (if v
	     (begin
		(%swing-jslider-major-ticks-set! %builtin 2)
		(%swing-jslider-minor-ticks-set! %builtin 1)
		o)
	     (begin
		(%swing-jslider-major-ticks-set! %builtin 0)
		(%swing-jslider-minor-ticks-set! %builtin 0)
		o)))))
   
;*---------------------------------------------------------------------*/
;*    %scale-from ...                                                  */
;*---------------------------------------------------------------------*/
(define (%scale-from o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin)
	 (%swing-jslider-minimum %builtin))))

;*---------------------------------------------------------------------*/
;*    %scale-from-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%scale-from-set! o::%bglk-object from::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin)
	 (%swing-jslider-minimum-set! %builtin from)
	 o)))

;*---------------------------------------------------------------------*/
;*    %scale-to ...                                                    */
;*---------------------------------------------------------------------*/
(define (%scale-to o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin) 
	 (%swing-jslider-maximum %builtin))))

;*---------------------------------------------------------------------*/
;*    %scale-to-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%scale-to-set! o::%bglk-object to::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%scale %peer (%builtin)
	 (%swing-jslider-maximum-set! %builtin to)
	 o)))

