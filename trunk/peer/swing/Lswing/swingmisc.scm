;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lswing/swingmisc.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Apr 19 21:09:35 2001                          */
;*    Last change :  Sun Jun 24 13:43:46 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The connection part of the Swing Biglook's peer                  */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%swing-misc
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object)
   
   (export (biglook-title-justify->swing::int ::symbol)
	   (swing-title-justify->biglook::symbol ::int)
	   
	   (biglook-position->swing::int ::symbol)
	   (swing-position->biglook::symbol ::int)
	   
	   (%jcomponent-shadow::symbol ::%bglk-object)
	   (%jcomponent-shadow-set! ::%bglk-object ::symbol)))

;*---------------------------------------------------------------------*/
;*    biglook-title-justify->swing ...                                 */
;*---------------------------------------------------------------------*/
(define (biglook-title-justify->swing v)
   (case v
      ((center) %swing-titledborder-CENTER)
      ((left) %swing-titledborder-LEFT)
      ((right) %swing-titledborder-RIGHT)
      (else (error "biglook-title-justify->swing" "Illegal justify value" v))))
   
;*---------------------------------------------------------------------*/
;*    swing-title-justify->biglook ...                                 */
;*---------------------------------------------------------------------*/
(define (swing-title-justify->biglook v)
   (cond
      ((=fx v %swing-titledborder-LEFT)
       'left)
      ((=fx v %swing-titledborder-RIGHT)
       'right)
      (else 
       'center)))
   
;*---------------------------------------------------------------------*/
;*    biglook-position->swing ...                                      */
;*---------------------------------------------------------------------*/
(define (biglook-position->swing v)
   (case v
      ((top) %swing-constants-TOP)
      ((bottom) %swing-constants-BOTTOM)
      ((left) %swing-constants-LEFT)
      ((right) %swing-constants-RIGHT)
      (else (error "biglook-position->swing" "Illegal position value" v))))
   
;*---------------------------------------------------------------------*/
;*    swing-position->biglook ...                                      */
;*---------------------------------------------------------------------*/
(define (swing-position->biglook v)
   (cond
      ((=fx v %swing-constants-LEFT) 'left)
      ((=fx v %swing-constants-RIGHT) 'right)
      ((=fx v %swing-constants-TOP) 'top)
      ((=fx v %swing-constants-BOTTOM) 'bottom)
      (else (error "swing-position->biglook" "Unknown position" v))))
   
;*---------------------------------------------------------------------*/
;*    %jcomponent-shadow ...                                           */
;*---------------------------------------------------------------------*/
(define (%jcomponent-shadow::symbol o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (let ((bd (%swing-jcomponent-border (%peer-%builtin %peer))))
	 (if (%bglk-border? bd)
	     (set! bd (%bglk-border-outside bd)))
	 (cond
	    ((%swing-etchedborder? bd)
	     (if (=fx (%swing-etchedborder-type bd)
		      %swing-etchedborder-LOWERED)
		 'etched-in
		 'etched-out))
	    ((%swing-bevelborder? bd)
	     (if (=fx (%swing-bevelborder-type bd)
		      %swing-bevelborder-LOWERED)
		 'shadow-in
		 'shadow-out))
	    ((%swing-emptyborder? bd)
	     'none)
	    (else
	     'none)))))

;*---------------------------------------------------------------------*/
;*    %jcomponent-shadow-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%jcomponent-shadow-set! o::%bglk-object v::symbol)
   (let ((new-bd::%swing-border (case v
				   ((etched-in etched)
				    (%bglk-border-etched-in-new))
				   ((etched-out)
				    (%bglk-border-etched-out-new))
				   ((shadow-in)
				    (%bglk-border-bevel-in-new))
				   ((in)
				    (%bglk-border-softbevel-in-new))
				   ((shadow-out)
				    (%bglk-border-bevel-out-new))
				   ((out)
				    (%bglk-border-softbevel-out-new))
				   ((none)
				    (%bglk-border-empty-new))
				   (else
				    (error "%jcomponent-shadow-set!"
					   "Illegal shadow"
					   v)))))
      (with-access::%bglk-object o (%peer)
	 (let ((bd (%swing-jcomponent-border (%peer-%builtin %peer))))
	    (%swing-jcomponent-border-set! (%peer-%builtin %peer)
					   (if (%bglk-border? bd)
					       (%bglk-border-copy bd new-bd)
					       new-bd))
	    o))))
