;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_canvas.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Jun 10 09:48:40 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Canvas implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/canvas.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%canvas
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error)

   (export (%make-%canvas ::%bglk-object)

	   (%canvas-width::int ::%bglk-object)
	   (%canvas-width-set! ::%bglk-object ::int)
	   
	   (%canvas-height::int ::%bglk-object)
	   (%canvas-height-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-x::int ::%bglk-object)
	   (%canvas-scroll-x-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-y::int ::%bglk-object)
	   (%canvas-scroll-y-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-width::int ::%bglk-object)
	   (%canvas-scroll-width-set! ::%bglk-object ::int)
	   
	   (%canvas-scroll-height::int ::%bglk-object)
	   (%canvas-scroll-height-set! ::%bglk-object ::int)
	   
	   (%canvas-add! ::%bglk-object ::%bglk-object ::pair-nil)))

;*---------------------------------------------------------------------*/
;*    %make-%canvas ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%canvas o::%bglk-object)
   (not-implemented o "%make-%canvas"))

;*---------------------------------------------------------------------*/
;*    %canvas-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%canvas-add! c::%bglk-object w::%bglk-object options)
   (not-implemented c "%canvas-add!"))
   
;*---------------------------------------------------------------------*/
;*    %canvas-width ...                                                */
;*---------------------------------------------------------------------*/
(define (%canvas-width::int o::%bglk-object)
   (not-implemented o "%canvas-width"))

;*---------------------------------------------------------------------*/
;*    %canvas-width-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%canvas-width-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-width-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-height ...                                               */
;*---------------------------------------------------------------------*/
(define (%canvas-height::int o::%bglk-object)
   (not-implemented o "%canvas-height"))

;*---------------------------------------------------------------------*/
;*    %canvas-height-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%canvas-height-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-height-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-x ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-x::int o::%bglk-object)
   (not-implemented o "%canvas-scroll-x"))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-x-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-x-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-scroll-x-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-y ...                                             */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-y::int o::%bglk-object)
   (not-implemented o "%canvas-scroll-y"))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-y-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-y-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-scroll-y-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-width::int o::%bglk-object)
   (not-implemented o "%canvas-scroll-width"))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-width-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-scroll-width-set!"))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-height ...                                        */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-height::int o::%bglk-object)
   (not-implemented o "%canvas-scroll-height"))

;*---------------------------------------------------------------------*/
;*    %canvas-scroll-height-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%canvas-scroll-height-set! o::%bglk-object v::int)
   (not-implemented o "%canvas-scroll-height-set!"))

