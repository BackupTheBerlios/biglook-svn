;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Lwidget/_grid.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon Jul 16 10:10:34 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Swing peer Grid implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/grid.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%grid
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%container
	   __biglook_%callback)
   
   (static (class %grid::%container
	      (%columns::int (default 1))
	      (%rows::int (default 1))))
	   
   (export (%make-%grid ::%bglk-object)
	   
	   (%grid-rows::int ::%bglk-object)
	   (%grid-rows-set! ::%bglk-object ::int)
	   
	   (%grid-columns::int ::%bglk-object)
	   (%grid-columns-set! ::%bglk-object ::int)
	   
	   (%grid-row-spacing::int ::%bglk-object)
	   (%grid-row-spacing-set! ::%bglk-object ::int)
	   
	   (%grid-column-spacing::int ::%bglk-object)
	   (%grid-column-spacing-set! ::%bglk-object ::int)
	   
	   (%grid-add! ::%bglk-object ::%bglk-object
		       ::int ::int ::int ::int
		       ::int ::int
		       ::bool ::obj)))

;*---------------------------------------------------------------------*/
;*    %make-%grid ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%grid o::%bglk-object)
   (let* ((layout-manager::%awt-layoutmanager (%awt-gridbaglayout-new))
	  (panel::%awt-panel (%awt-panel-new)) 
	  (listener::%awt-componentlistener (%bglk-jcomponentadapter-new))
	  (peer (instantiate::%grid
		   (%builtin panel)
		   (%bglk-object o))))
      (%connect-widget-callback! peer panel 'configure #unspecified)
      (%awt-container-layout-set! panel layout-manager)
      peer))

;*---------------------------------------------------------------------*/
;*    %grid-rows ...                                                   */
;*---------------------------------------------------------------------*/
(define (%grid-rows::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%grid %peer (%rows)
	 %rows)))

;*---------------------------------------------------------------------*/
;*    %grid-rows-set! ...                                              */
;*---------------------------------------------------------------------*/
(define (%grid-rows-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%grid %peer (%rows)
	 (set! %rows v))))

;*---------------------------------------------------------------------*/
;*    %grid-columns ...                                                */
;*---------------------------------------------------------------------*/
(define (%grid-columns::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%grid %peer (%columns)
	 %columns)))

;*---------------------------------------------------------------------*/
;*    %grid-columns-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%grid-columns-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (with-access::%grid %peer (%columns)
	 (set! %columns v))))

;*---------------------------------------------------------------------*/
;*    %grid-row-spacing ...                                            */
;*---------------------------------------------------------------------*/
(define (%grid-row-spacing::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      0))
;*       (%%jgridlayout-vgap (%%jcontainer-layout (%peer-%builtin %peer))))) */

;*---------------------------------------------------------------------*/
;*    %grid-row-spacing-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%grid-row-spacing-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
;*       (%%jgridlayout-vgap-set! (%%jcontainer-layout (%peer-%builtin %peer)) v) */
      o))

;*---------------------------------------------------------------------*/
;*    %grid-column-spacing ...                                         */
;*---------------------------------------------------------------------*/
(define (%grid-column-spacing::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      0))
;*       (%%jgridlayout-hgap (%%jcontainer-layout (%peer-%builtin %peer))))) */

;*---------------------------------------------------------------------*/
;*    %grid-column-spacing-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%grid-column-spacing-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
;*       (%%jgridlayout-hgap-set! (%%jcontainer-layout (%peer-%builtin %peer)) v) */
      o))

;*---------------------------------------------------------------------*/
;*    %grid-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%grid-add! c::%bglk-object w::%bglk-object
		    column::int columnspan::int
		    row::int rowspan::int
		    padx::int pady::int
		    expand::bool fill::obj)
   (with-access::%bglk-object c (%peer)
      (%bglk-jgridbaglayoutadd! (%peer-%builtin %peer)
				(%peer-%builtin (%bglk-object-%peer w))
				column columnspan
				row rowspan
				expand
				(memq fill '(#t both x))
				(memq fill '(#t both y)))
      c))

