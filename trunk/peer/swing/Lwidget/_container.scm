;*=====================================================================*/
;*    swing/Lwidget/_container.scm                                     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Nov 30 16:26:31 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Container implementation.                          */
;*    definition: @path ../../../biglook/Lwidget/container.scm@        */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%container
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
   	   ;__biglook_%cursor
	   )
   
   (export (class %container::%peer)
	   
	   (%container-awt-add!::obj ::%awt-container ::%bglk-object)
	   
	   (%container-add!::obj ::%bglk-object ::%bglk-object)
	   (%container-option-add! ::%bglk-object ::%bglk-object ::%jobject)
	   
	   (%container-remove!::obj ::%bglk-object ::%bglk-object)
	   (generic %%container-remove! ::%peer ::%bglk-object)
	   
	   (%container-children::obj ::%bglk-object)
	   (generic %%container-children ::%peer)
	   
	   (%container-border-width::int ::%bglk-object)
	   (%container-border-width-set! ::%bglk-object ::int)))
	   
;*---------------------------------------------------------------------*/
;*    %container-awt-add! ...                                          */
;*---------------------------------------------------------------------*/
(define (%container-awt-add! c::%awt-container w::%bglk-object)
   (%awt-container-add! c (%peer-%builtin (%bglk-object-%peer w)))
   w)

;*---------------------------------------------------------------------*/
;*    %container-awt-option-add! ...                                   */
;*---------------------------------------------------------------------*/
(define (%container-awt-option-add! c::%awt-container w::%bglk-object opt)
   (%awt-container-option-add! c (%peer-%builtin (%bglk-object-%peer w)) opt)
   w)

;*---------------------------------------------------------------------*/
;*    %container-add! ...                                              */
;*---------------------------------------------------------------------*/
(define (%container-add! c::%bglk-object w::%bglk-object)
   (%container-awt-add! (%peer-%builtin (%bglk-object-%peer c)) w)
   w)

;*---------------------------------------------------------------------*/
;*    %container-option-add! ...                                       */
;*---------------------------------------------------------------------*/
(define (%container-option-add! c::%bglk-object w::%bglk-object opt)
   (%container-awt-option-add! (%peer-%builtin (%bglk-object-%peer c)) w opt)
   w)

;*---------------------------------------------------------------------*/
;*    %container-remove! ...                                           */
;*---------------------------------------------------------------------*/
(define (%container-remove! c::%bglk-object w::%bglk-object)
;   (print "%container-remove! " (find-runtime-type c)
;	  " " (find-runtime-type w))
;   (print "%container-remove! "
;	  (find-runtime-type (%bglk-object-%peer c)) " "
;	  (find-runtime-type (%bglk-object-%peer w)))
   (%%container-remove!  (%bglk-object-%peer c) w))

;*---------------------------------------------------------------------*/
;*    %%container-remove! ::%bglk-object ...                           */
;*---------------------------------------------------------------------*/
(define-generic (%%container-remove! c::%peer w::%bglk-object)
;   (print "---- REMOVE ---- " (find-runtime-type (%peer-%builtin c))
;	  " " (find-runtime-type (%peer-%builtin (%bglk-object-%peer w))))
   (%awt-container-remove! (%peer-%builtin c)
			   (%peer-%builtin (%bglk-object-%peer w)))
   (%swing-jcomponent-revalidate (%peer-%builtin c))
   w)

;*---------------------------------------------------------------------*/
;*    %container-children ...                                          */
;*---------------------------------------------------------------------*/
(define (%container-children o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (if (not (%container? %peer))
	  '()
	  (%%container-children %peer))))

;*---------------------------------------------------------------------*/
;*    %%container-children ::%peer ...                                 */
;*---------------------------------------------------------------------*/
(define-generic (%%container-children peer::%peer)
   (let ((c (%peer-%builtin peer)))
      (let loop ((num (-fx (%awt-container-children-number c) 1))
		 (res '()))
	 (if (>=fx num 0)
	     (let ((child (%bglk-get-object (%awt-container-child c num))))
		(loop (-fx num 1)
		      (if (%bglk-object? child) (cons child res) res)))
	     (begin
		(print (map (lambda (x) (find-runtime-type x)) res))
		(reverse! res))))))

;*---------------------------------------------------------------------*/
;*    %container-border-width ...                                      */
;*---------------------------------------------------------------------*/
(define (%container-border-width o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (not (%awt-container? %builtin))
	     0
	     (let ((inset (%awt-container-insets %builtin)))
		(%awt-insets-bottom inset))))))
  
;*---------------------------------------------------------------------*/
;*    %container-border-width-set! ...                                 */
;*---------------------------------------------------------------------*/
(define (%container-border-width-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-container? %builtin)
	     (let ((inset (%awt-container-insets %builtin)))
		(%awt-insets-bottom-set! inset v)
		(%awt-insets-top-set! inset v)
		(%awt-insets-left-set! inset v)
		(%awt-insets-right-set! inset v)
		o)))))
   
