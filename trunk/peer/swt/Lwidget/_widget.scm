;*=====================================================================*/
;*    swt/Lwidget/_widget.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Oct  8 16:52:04 2003 (dciabrin)               */
;*    Copyright   :  2001-03 Manuel Serrano                            */
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
	   __biglook_%color)
   
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

	   (%widget-can-focus?::bool ::%bglk-object)
	   (%widget-can-focus?-set! ::%bglk-object ::bool)

	   (%destroy-widget ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %widget-parent ...                                               */
;*---------------------------------------------------------------------*/
(define (%widget-parent o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (%bglk-get-object (%awt-component-parent %builtin))))))

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
	  ((%awt-geom-dimension2D? %builtin)
	   (%awt-geom-dimension2D-width %builtin))
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
	     (%awt-geom-dimension2D-height %builtin))
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
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (%awt-component-visible %builtin)
	     #t))))

;*---------------------------------------------------------------------*/
;*    %widget-visible-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%widget-visible-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (if (%awt-component? %builtin)
	     (begin
		(%awt-component-visible-set! %builtin v)
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
