;*=====================================================================*/
;*    swing/Lwidget/_scroll.scm                                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Nov 30 12:06:17 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Label implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/scroll.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%scroll
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%container)
   
   (static (class %scroll::%container))
	   
   (export (%make-%scroll ::%bglk-object)

	   (%scroll-hfraction::double ::%bglk-object)
	   (%scroll-hfraction-set! ::%bglk-object ::double)
	   
	   (%scroll-vfraction::double ::%bglk-object)
	   (%scroll-vfraction-set! ::%bglk-object ::double)
	   
	   (%scroll-hside ::%bglk-object)
	   (%scroll-hside-set! ::%bglk-object ::obj)
	   
	   (%scroll-vside ::%bglk-object)
	   (%scroll-vside-set! ::%bglk-object ::obj)
	   
	   (%scroll-hpolicy ::%bglk-object)
	   (%scroll-hpolicy-set! ::%bglk-object ::obj)
	   
	   (%scroll-vpolicy ::%bglk-object)
	   (%scroll-vpolicy-set! ::%bglk-object ::obj)
	   
	   (%scroll-hpage-size::int ::%bglk-object)
	   (%scroll-vpage-size::int ::%bglk-object)
	   
	   (%scroll-add! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%scroll ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%scroll o::%bglk-object)
   (let* ((win (%swing-jscrollpane-new/policy
		%swing-jscrollpaneconstants-v-needed
		%swing-jscrollpaneconstants-h-needed)))
      (instantiate::%scroll
	 (%bglk-object o)
	 (%builtin win))))

;*---------------------------------------------------------------------*/
;*    scrollbar-fraction ...                                           */
;*---------------------------------------------------------------------*/
(define (scrollbar-fraction scrollbar)
   (let* ((range (-fx (-fx (%swing-jscrollbar-maximum scrollbar)
			   (%swing-jscrollbar-minimum scrollbar))
		      (%swing-jscrollbar-visible scrollbar)))
	  (value (%swing-jscrollbar-value scrollbar)))
      (if (>fx value 0)
	  (/fl (fixnum->flonum value) (fixnum->flonum range))
	  0.0)))

;*---------------------------------------------------------------------*/
;*    scrollbar-fraction-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (scrollbar-fraction-set! scrollbar v)
   (let* ((range (-fx (-fx (%swing-jscrollbar-maximum scrollbar)
			   (%swing-jscrollbar-minimum scrollbar))
		      (%swing-jscrollbar-visible scrollbar)))
	  (v (cond
		((>fl v 1.0)
		 1.0)
		((<fl v 0.0)
		 0.0)
		(else
		 v)))
	  (actual (if (> range 0)
		      (flonum->fixnum (*fl v (fixnum->flonum range)))
		      (flonum->fixnum
		       (*fl v (fixnum->flonum
			       (%swing-jscrollbar-maximum scrollbar)))))))
      (%swing-jscrollbar-value-set! scrollbar actual)
      v))

;*---------------------------------------------------------------------*/
;*    %scroll-hfraction ...                                            */
;*---------------------------------------------------------------------*/
(define (%scroll-hfraction o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((scrollbar (%swing-jscrollpane-hscrollbar %builtin)))
	    ;; We must ensure that the scrollpane and its viewport
	    ;; are in sync, to be sure that hfraction's max-value
	    ;; reflect the real size of the scrollpane's child.
	    (if (not (%awt-component-valid? %builtin))
		(let* ((viewport (%swing-jscrollpane-viewport %builtin))
		       (child (%swing-jviewport-view viewport)))
		   (%swing-jscrollbar-maximum-set!
		    scrollbar (%awt-component-width child)) #t))
	    (scrollbar-fraction scrollbar)))))

;*---------------------------------------------------------------------*/
;*    %scroll-hfraction-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%scroll-hfraction-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((scrollbar (%swing-jscrollpane-hscrollbar %builtin)))
	    ;; We must ensure that the scrollpane and its viewport
	    ;; are in sync, to be sure that hfraction's max-value
	    ;; reflect the real size of the scrollpane's child.
	    (if (not (%awt-component-valid? %builtin))
		(let* ((viewport (%swing-jscrollpane-viewport %builtin))
		       (child (%swing-jviewport-view viewport)))
		   (%swing-jscrollbar-maximum-set!
		    scrollbar (%awt-component-width child)) #t))
	    (scrollbar-fraction-set! scrollbar v)))))
   
;*---------------------------------------------------------------------*/
;*    %scroll-vfraction ...                                            */
;*---------------------------------------------------------------------*/
(define (%scroll-vfraction o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((scrollbar (%swing-jscrollpane-vscrollbar %builtin)))
	    ;; We must ensure that the scrollpane and its viewport
	    ;; are in sync, to be sure that vfraction's max-value
	    ;; reflect the real size of the scrollpane's child.
	    (if (not (%awt-component-valid? %builtin))
		(let* ((viewport (%swing-jscrollpane-viewport %builtin))
		       (child (%swing-jviewport-view viewport)))
		   (%swing-jscrollbar-maximum-set!
		    scrollbar (%awt-component-height child)) #t))
	    (scrollbar-fraction scrollbar)))))
   
;*---------------------------------------------------------------------*/
;*    %scroll-vfraction-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%scroll-vfraction-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((scrollbar (%swing-jscrollpane-vscrollbar %builtin)))
	    ;; We must ensure that the scrollpane and its viewport
	    ;; are in sync, to be sure that vfraction's max-value
	    ;; reflect the real size of the scrollpane's child.
	    (if (not (%awt-component-valid? %builtin))
		(let* ((viewport (%swing-jscrollpane-viewport %builtin))
		       (child (%swing-jviewport-view viewport)))
		   (%swing-jscrollbar-maximum-set!
		    scrollbar (%awt-component-height child)) #t))
	    (scrollbar-fraction-set! scrollbar v)))))
   
;*---------------------------------------------------------------------*/
;*    %scroll-hside ...                                                */
;*---------------------------------------------------------------------*/
(define (%scroll-hside o::%bglk-object)
   'bottom)

;*---------------------------------------------------------------------*/
;*    %scroll-hside-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-hside-set! o::%bglk-object v)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %scroll-vside ...                                                */
;*---------------------------------------------------------------------*/
(define (%scroll-vside o::%bglk-object)
   'right)

;*---------------------------------------------------------------------*/
;*    %scroll-vside-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-vside-set! o::%bglk-object v)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %scroll-hpolicy ...                                              */
;*---------------------------------------------------------------------*/
(define (%scroll-hpolicy o::%bglk-object)
   (with-access::%scroll (%bglk-object-%peer o) (%builtin)
      (let ((policy (%swing-jscrollpane-hpolicy %builtin)))
	 (cond
	    ((=fx policy %swing-jscrollpaneconstants-h-always)
	     'always)
	    ((=fx policy %swing-jscrollpaneconstants-h-never)
	     'never)
	    ((=fx policy %swing-jscrollpaneconstants-h-needed)
	     'automatic)
	    (else
	     (error "%scroll-hpolicy" "Unknown policy" policy))))))

;*---------------------------------------------------------------------*/
;*    %scroll-hpolicy-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%scroll-hpolicy-set! o::%bglk-object v)
   (with-access::%scroll (%bglk-object-%peer o) (%builtin)
      (%swing-jscrollpane-hpolicy-set!
       %builtin
       (case v
	  ((always)
	   %swing-jscrollpaneconstants-h-always)
 	  ((never)
	   %swing-jscrollpaneconstants-h-never)
	  ((automatic)
	   %swing-jscrollpaneconstants-h-needed)
	  (else
	   (error "%scroll-hpolicy-set!" "Illegal policy" v))))
      o))

;*---------------------------------------------------------------------*/
;*    %scroll-vpolicy ...                                              */
;*---------------------------------------------------------------------*/
(define (%scroll-vpolicy o::%bglk-object)
   (with-access::%scroll (%bglk-object-%peer o) (%builtin)
      (let ((policy (%swing-jscrollpane-vpolicy %builtin)))
	 (cond
	    ((=fx policy %swing-jscrollpaneconstants-v-always)
	     'always)
	    ((=fx policy %swing-jscrollpaneconstants-v-never)
	     'never)
	    ((=fx policy %swing-jscrollpaneconstants-v-needed)
	     'automatic)
	    (else
	     (error "%scroll-vpolicy" "Unknown policy" policy))))))

;*---------------------------------------------------------------------*/
;*    %scroll-vpolicy-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%scroll-vpolicy-set! o::%bglk-object v)
   (with-access::%scroll (%bglk-object-%peer o) (%builtin)
      (%swing-jscrollpane-vpolicy-set!
       %builtin
       (case v
	  ((always)
	   %swing-jscrollpaneconstants-v-always)
	  ((never)
	   %swing-jscrollpaneconstants-v-never)
	  ((automatic)
	   %swing-jscrollpaneconstants-v-needed)
	  (else
	   (error "%scroll-vpolicy-set!" "Illegal policy" v))))
      o))

;*---------------------------------------------------------------------*/
;*    %scroll-hpage-size ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-hpage-size o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((scrollbar (%swing-jscrollpane-hscrollbar %builtin)))
	    (%swing-jscrollbar-visible scrollbar)))))

;*---------------------------------------------------------------------*/
;*    %scroll-vpage-size ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-vpage-size o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%scroll %peer (%builtin)
	 (let ((scrollbar (%swing-jscrollpane-vscrollbar %builtin)))
	    (%swing-jscrollbar-visible scrollbar)))))

;*---------------------------------------------------------------------*/
;*    %scroll-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%scroll-add! c::%bglk-object w::%bglk-object)
   (with-access::%scroll (%bglk-object-%peer c) (%builtin)
      (%swing-jscrollpane-view-set! %builtin (%peer-%builtin (%bglk-object-%peer w)))
      c))

;*---------------------------------------------------------------------*/
;*    %%container-children ::%scroll ...                               */
;*---------------------------------------------------------------------*/
(define-method (%%container-children peer::%scroll)
   (let* ((c (%peer-%builtin peer))
	  (child (%swing-jviewport-view (%swing-jscrollpane-viewport c)))
	  (bglkobj (%bglk-get-object child)))
      (if (not bglkobj)
	  '()
	  (list bglkobj))))


;*---------------------------------------------------------------------*/
;*    %%container-remove ::%scroll ...                                 */
;*---------------------------------------------------------------------*/
(define-method (%%container-remove! c::%scroll w::%bglk-object)
   (let* ((b (%peer-%builtin c))
	  (viewport (%swing-jscrollpane-viewport b)))
      (%awt-container-remove! viewport (%peer-%builtin (%bglk-object-%peer w)))
      (%swing-jcomponent-revalidate b)
      w))
