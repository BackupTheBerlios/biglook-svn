;*=====================================================================*/
;*    swing/Lwidget/_box.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Jun 23 17:12:58 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Jvm peer Box implementation.                                 */
;*    definition: @path ../../../biglook/Lwidget/box.scm@              */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%box
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%container) 

   (static (class %box::%container
	      (glued::bool (default #f)))

	   (class %hbox::%box)
	   (class %vbox::%box))
	   
   (export (%make-%hbox ::%bglk-object)
	   (%make-%vbox ::%bglk-object)
	   
	   (%vbox-add! ::%bglk-object ::%bglk-object ::bool ::bool ::int ::bool)
	   (%hbox-add! ::%bglk-object ::%bglk-object ::bool ::bool ::int ::bool)
	   (%box-homogenous::bool ::%bglk-object)
	   (%box-homogenous-set! ::%bglk-object ::bool)))

;*---------------------------------------------------------------------*/
;*    %make-%hbox ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%hbox o::%bglk-object)
   (instantiate::%hbox
      (%bglk-object o)
      (%builtin (%bglk-box-new %swing-boxlayout-X-AXIS))))

;*---------------------------------------------------------------------*/
;*    %make-%vbox ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%vbox o::%bglk-object)
   (instantiate::%vbox
      (%bglk-object o)
      (%builtin (%bglk-box-new %swing-boxlayout-Y-AXIS))))

;*---------------------------------------------------------------------*/
;*    %vbox-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%vbox-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (with-access::%box (%bglk-object-%peer c) (glued %builtin)
      (let ((constraints 0))
	 (if expand (set! constraints (+ constraints %bglk-box-EXPAND)))
	 (if fill (set! constraints (+ constraints %bglk-box-FILL)))
	 (if (> padding 0) (set! constraints (cons constraints padding)))
	 (%awt-container-add/constraint!
	  %builtin (%peer-%builtin (%bglk-object-%peer w)) constraints)
	 c))
   )

;*---------------------------------------------------------------------*/
;*    %hbox-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%hbox-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (with-access::%box (%bglk-object-%peer c) (glued %builtin)
      (let ((constraints 0))
	 (if expand (set! constraints (+ constraints %bglk-box-EXPAND)))
	 (if fill (set! constraints (+ constraints %bglk-box-FILL)))
	 (if (> padding 0) (set! constraints (cons constraints padding)))
	 (%awt-container-add/constraint!
	  %builtin (%peer-%builtin (%bglk-object-%peer w)) constraints)
	 c))
   )

;*---------------------------------------------------------------------*/
;*    %box-homogenous ...                                              */
;*---------------------------------------------------------------------*/
(define (%box-homogenous o::%bglk-object)
   #f)

;*---------------------------------------------------------------------*/
;*    %box-homogenous-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%box-homogenous-set! o::%bglk-object v)
   #unspecified)

;(define-method (%%container-remove! o::%box w::%bglk-object)
;   (print "wefiojo"))
