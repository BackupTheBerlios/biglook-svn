;*=====================================================================*/
;*    swing/Lwidget/_widget.scm                                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Dec  9 14:52:12 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Jvm peer Widget implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/widget.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%widget
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%color
   	   __biglook_%cursor
	   )
   
   (export (class %widget::%peer)
	   
	   (%widget-parent ::%bglk-object)
	   
	   (%widget-event::obj ::%bglk-object)
	   (%widget-event-set! ::%bglk-object ::obj)
	   
	   (%widget-width::int ::%bglk-object)
	   (%widget-width-set! ::%bglk-object ::int)
	   
	   (%widget-height::int ::%bglk-object)
	   (%widget-height-set! ::%bglk-object ::int)
	   
	   (%widget-tooltips::obj ::%bglk-object)
	   (%widget-tooltips-set! ::%bglk-object ::obj)

	   (%widget-active?::bool ::%bglk-object)
	   (%widget-active?-set! ::%bglk-object ::bool)

	   (%widget-name::bstring ::%bglk-object)
	   (%widget-name-set! ::%bglk-object ::bstring)
	   
	   (%widget-visible::bool ::%bglk-object)
	   (%widget-visible-set! ::%bglk-object ::bool)

	   (generic %%widget-visible::bool ::%peer)
	   (generic %%widget-visible-set! ::%peer ::bool)

	   (%widget-enabled::bool ::%bglk-object)
	   (%widget-enabled-set! ::%bglk-object ::bool)

	   (%widget-can-focus?::bool ::%bglk-object)
	   (%widget-can-focus?-set! ::%bglk-object ::bool)

	   (%widget-cursor ::%bglk-object)
	   (%widget-cursor-set! ::%bglk-object ::obj)

	   (%repaint-widget ::%bglk-object)
	   (%destroy-widget ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %widget-parent ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-parent o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (let loop ((p (%awt-component-parent %builtin)))
		(if (foreign-null? p)
		    #f
		    (let ((bglkobj (%bglk-get-object p)))
		       (if bglkobj
			   bglkobj
			   (loop (%awt-component-parent p))))))))))

;*---------------------------------------------------------------------*/
;*    %widget-event ...                                                */
;*---------------------------------------------------------------------*/
(define (%widget-event o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%event)
      %event))

;*---------------------------------------------------------------------*/
;*    %widget-event-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-event-set! o::%bglk-object v)
   (with-access::%peer (%bglk-object-%peer o) (%event)
      (set! %event v)))

;*---------------------------------------------------------------------*/
;*    %widget-width ...                                                */
;*---------------------------------------------------------------------*/
(define (%widget-width::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (cond
	  ((%awt-component? %builtin)
	   (%awt-component-width %builtin))
	  ;; BCV: width seems to be disliked by JDK1.5 BCV
	  ;; check to abstract flag for the definition of width
	  ((%awt-geom-dimension2D? %builtin)
	   (flonum->fixnum (%awt-geom-dimension2D-width %builtin)))
	  (else
	   -1)))))

;*---------------------------------------------------------------------*/
;*    %widget-width-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-width-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (let ((dim (%awt-dimension-new v (%widget-height o)))
		   (builtin %builtin))
		(%awt-component-dimension-set! builtin dim)
		(if (%swing-jcomponent? builtin)
		    (begin
		       (%swing-jcomponent-preferred-size-set! builtin dim)
		       (%swing-jcomponent-minimum-size-set! builtin dim)
		       o))
		o)))))

;*---------------------------------------------------------------------*/
;*    %widget-height ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-height::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (cond
	    ((%awt-component? %builtin)
	     (%awt-component-height %builtin))
	    ((%awt-geom-dimension2D? %builtin)
	     (flonum->fixnum (%awt-geom-dimension2D-height %builtin)))
	    (else
	     -1)))))

;*---------------------------------------------------------------------*/
;*    %widget-height-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%widget-height-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (let ((dim (%awt-dimension-new (%widget-width o) v))
		   (builtin %builtin))
		(%awt-component-dimension-set! builtin dim)
		(if (%swing-jcomponent? builtin)
		    (begin
		       (%swing-jcomponent-preferred-size-set! builtin dim)
		       (%swing-jcomponent-minimum-size-set! builtin dim)
		       o))
		o)))))

;*---------------------------------------------------------------------*/
;*    %widget-tooltips ...                                             */
;*---------------------------------------------------------------------*/
(define (%widget-tooltips o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (let ((component %builtin))
		(if (%swing-jcomponent? component)
		    (let ((tooltip (%swing-jcomponent-tooltip component)))
		       (if (%swing-jtooltip? tooltip)
			   (%bglk-jstring->bstring tooltip)
			   #f))
		    #f))
	     #f))))

;*---------------------------------------------------------------------*/
;*    %widget-tooltips-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%widget-tooltips-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (if v
		 (begin
		    (%swing-jcomponent-tooltip-set! %builtin
						    (%bglk-bstring->jstring v))
		    o))))))

;*---------------------------------------------------------------------*/
;*    %widget-active? ...                                              */
;*---------------------------------------------------------------------*/
(define (%widget-active? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (%awt-component-enabled? %builtin)
	     #t))))

;*---------------------------------------------------------------------*/
;*    %widget-active?-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-active?-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (begin
		(%awt-component-enabled?-set! %builtin v)
		o)))))

;*---------------------------------------------------------------------*/
;*    %widget-name ...                                                 */
;*---------------------------------------------------------------------*/
(define (%widget-name o::%bglk-object)
   "biglook")

;*---------------------------------------------------------------------*/
;*    %widget-name-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%widget-name-set! o::%bglk-object v)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %widget-visible ...                                              */
;*---------------------------------------------------------------------*/
(define (%widget-visible o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%%widget-visible %peer)))

;*---------------------------------------------------------------------*/
;*    %widget-visible-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-visible-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (%%widget-visible-set! %peer v)))

;*---------------------------------------------------------------------*/
;*    %%widget-visible ...                                             */
;*---------------------------------------------------------------------*/
(define-generic (%%widget-visible::bool o::%peer)
   (with-access::%peer o (%builtin)
      (if (%awt-component? %builtin)
	  (%awt-component-visible %builtin)
	  #f)))
   

;*---------------------------------------------------------------------*/
;*    %%widget-visible-set! ...                                        */
;*---------------------------------------------------------------------*/
(define-generic (%%widget-visible-set! o::%peer v::bool)
   (with-access::%peer o (%builtin)
      (if (%awt-component? %builtin)
	  (begin
	     (%awt-component-visible-set! %builtin v)
	     o))))

;*---------------------------------------------------------------------*/
;*    %widget-enabled ...                                              */
;*---------------------------------------------------------------------*/
(define (%widget-enabled o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%swing-jcomponent? %builtin)
	     (%awt-component-enabled? %builtin)
	     #t))))

;*---------------------------------------------------------------------*/
;*    %widget-enabled-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-enabled-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%swing-jcomponent? %builtin)
	     (begin
		(%swing-jcomponent-enabled-set! %builtin v)
		o)))))

;*---------------------------------------------------------------------*/
;*    %widget-can-focus? ...                                           */
;*---------------------------------------------------------------------*/
(define (%widget-can-focus?::bool o::%bglk-object)
   (not-implemented o "can_focus"))

;*---------------------------------------------------------------------*/
;*    %widget-can-focus?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%widget-can-focus?-set! o::%bglk-object v::bool)
   (not-implemented o "can_focus"))

;*---------------------------------------------------------------------*/
;*    %destroy-widget ...                                              */
;*---------------------------------------------------------------------*/
(define (%destroy-widget o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (begin
		(%awt-component-removenotify %builtin)
		o)))))

;*---------------------------------------------------------------------*/
;*    %destroy-widget ...                                              */
;*---------------------------------------------------------------------*/
(define (%repaint-widget o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (begin
		(%awt-component-repaint! %builtin)
		o)))))

;*---------------------------------------------------------------------*/
;*    %widget-cursor ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-cursor o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%awt-component-cursor %builtin))))

;*---------------------------------------------------------------------*/
;*    %widget-can-focus?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%widget-cursor-set! o::%bglk-object v::obj)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (%awt-component-cursor-set! %builtin (%cursor-%peer v))
	 o)))
