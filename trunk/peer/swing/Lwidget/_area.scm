;*=====================================================================*/
;*    swing/Lwidget/_area.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri Nov  7 19:11:48 2003 (braun)                  */
;*    Copyright   :  2001-03 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Label implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/area.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%area
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%container)
   
   (static (class %area::%container))
	   
   (export (%make-%area ::%bglk-object)
	   
	   (%area-horizontal-spacing::int ::%bglk-object)
	   (%area-horizontal-spacing-set! ::%bglk-object ::int)
	   
	   (%area-vertical-spacing::int ::%bglk-object)
	   (%area-vertical-spacing-set! ::%bglk-object ::int)
	   
	   (%area-add! ::%bglk-object ::%bglk-object ::symbol)))

;*---------------------------------------------------------------------*/
;*    %make-%area ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%area o::%bglk-object)
   (let* ((layout-manager::%awt-layoutmanager (%awt-borderlayout-new))
	  (panel::%swing-jpanel (%swing-jpanel-new))
	  (listener::%awt-componentlistener (%bglk-jcomponentadapter-new)))
      (%awt-container-layout-set! panel layout-manager)
      (%awt-component-add-componentlistener! panel listener)
      (instantiate::%area
	 (%builtin panel)
	 (%bglk-object o))))

;*---------------------------------------------------------------------*/
;*    %area-horizontal-spacing ...                                     */
;*---------------------------------------------------------------------*/
(define (%area-horizontal-spacing::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (let ((bdl::%awt-borderlayout (%awt-container-layout %builtin)))
	    (%awt-borderlayout-hgap bdl)))))

;*---------------------------------------------------------------------*/
;*    %area-horizontal-spacing-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%area-horizontal-spacing-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (let ((bdl::%awt-borderlayout (%awt-container-layout %builtin)))
	    (%awt-borderlayout-hgap-set! bdl v)
	    o))))

;*---------------------------------------------------------------------*/
;*    %area-vertical-spacing ...                                       */
;*---------------------------------------------------------------------*/
(define (%area-vertical-spacing::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (let ((bdl::%awt-borderlayout (%awt-container-layout %builtin)))
	    (%awt-borderlayout-vgap bdl)))))

;*---------------------------------------------------------------------*/
;*    %area-vertical-spacing-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%area-vertical-spacing-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%peer %peer (%builtin)
	 (let ((bdl::%awt-borderlayout (%awt-container-layout %builtin)))
	    (%awt-borderlayout-vgap-set! bdl v)
	    o))))

;*---------------------------------------------------------------------*/
;*    %area-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%area-add! c::%bglk-object w::%bglk-object zone::symbol)
   (%container-option-add! c w (cond
				  ((eq? zone 'north)
				   %awt-borderlayout-NORTH)
				  ((eq? zone 'west)
				   %awt-borderlayout-WEST)
				  ((eq? zone 'center)
				   %awt-borderlayout-CENTER)
				  ((eq? zone 'east)
				   %awt-borderlayout-EAST)
				  ((eq? zone 'south)
				   %awt-borderlayout-SOUTH)
				  (else
				   (error "%area-add!" "Illegal zone" zone)))))


