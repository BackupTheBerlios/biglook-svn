;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_box.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Jun 20 08:02:45 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Jvm peer Label implementation.                               */
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
      (%builtin (%swing-box-horizontal-new))))

;*---------------------------------------------------------------------*/
;*    %make-%vbox ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%vbox o::%bglk-object)
   (instantiate::%vbox
      (%bglk-object o)
      (%builtin (%swing-box-vertical-new))))

;*---------------------------------------------------------------------*/
;*    %vbox-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%vbox-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (with-access::%box (%bglk-object-%peer c) (glued %builtin)
      (if (>fx padding 0)
	  (let ((area (%swing-box-rigid-area (%awt-dimension-new 1 padding))))
	     (%awt-container-add! %builtin area)
	     c))
      (if (and (not top) (not glued))
	  (let ((glue (%swing-box-vertical-glue)))
	     (%awt-container-add! %builtin glue)
	     (set! glued #t)))
      (%container-add! c w)
      (if (>fx padding 0)
	  (let ((area (%swing-box-rigid-area (%awt-dimension-new 1 padding))))
	     (%awt-container-add! %builtin area)
	     c))))

;*---------------------------------------------------------------------*/
;*    %hbox-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%hbox-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (with-access::%box (%bglk-object-%peer c) (glued %builtin)
      (if (>fx padding 0)
	  (let ((area (%swing-box-rigid-area (%awt-dimension-new padding 1))))
	     (%awt-container-add! %builtin area)
	     c))
      (if (and (not top) (not glued))
	  (let ((glue (%swing-box-horizontal-glue)))
	     (%awt-container-add! %builtin glue)
	     (set! glued #t)))
      (%container-add! c w)
      (if (>fx padding 0)
	  (let ((area (%swing-box-rigid-area (%awt-dimension-new padding 1))))
	     (%awt-container-add! %builtin area)
	     c))))

;*---------------------------------------------------------------------*/
;*    %box-homogenous ...                                              */
;*---------------------------------------------------------------------*/
(define (%box-homogenous o::%bglk-object)
   #t)

;*---------------------------------------------------------------------*/
;*    %box-homogenous-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%box-homogenous-set! o::%bglk-object v)
   #unspecified)
