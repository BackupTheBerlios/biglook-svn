;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_area.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed May 16 07:11:55 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Label implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/area.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%area
   
   (import __biglook_%error
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
   (not-implemented o "%make-%area"))

;*---------------------------------------------------------------------*/
;*    %area-horizontal-spacing ...                                     */
;*---------------------------------------------------------------------*/
(define (%area-horizontal-spacing::int o::%bglk-object)
   (not-implemented o "%area-horizontal-spacing"))

;*---------------------------------------------------------------------*/
;*    %area-horizontal-spacing-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%area-horizontal-spacing-set! o::%bglk-object v::int)
   (not-implemented o "%area-horizontal-spacing-set!"))

;*---------------------------------------------------------------------*/
;*    %area-vertical-spacing ...                                       */
;*---------------------------------------------------------------------*/
(define (%area-vertical-spacing::int o::%bglk-object)
   (not-implemented o "%area-vertical-spacing"))

;*---------------------------------------------------------------------*/
;*    %area-vertical-spacing-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%area-vertical-spacing-set! o::%bglk-object v::int)
   (not-implemented o "%area-vertical-spacing-set!"))

;*---------------------------------------------------------------------*/
;*    %area-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%area-add! container::%bglk-object widget::%bglk-object loc::symbol)
   (not-implemented container "%area-add!"))

