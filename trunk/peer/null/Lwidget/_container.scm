;*=====================================================================*/
;*    .../prgm/project/biglook/peer/null/Lwidget/_container.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed May 16 17:10:25 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Container implementation.                          */
;*    definition: @path ../../../biglook/Lwidget/container.scm@        */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%container
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (export (class %container::%peer)
	   
	   (%container-add!::obj ::%bglk-object ::%bglk-object)
	   (%container-remove!::obj ::%bglk-object ::%bglk-object)
	   
	   (%container-children::obj ::%bglk-object)
	   
	   (%container-border-width::int ::%bglk-object)
	   (%container-border-width-set! ::%bglk-object ::int)))
	   
;*---------------------------------------------------------------------*/
;*    %container-add! ...                                              */
;*---------------------------------------------------------------------*/
(define (%container-add! c::%bglk-object w::%bglk-object)
   (not-implemented c "%container-add!"))

;*---------------------------------------------------------------------*/
;*    %container-remove! ...                                           */
;*---------------------------------------------------------------------*/
(define (%container-remove! c::%bglk-object w::%bglk-object)
   (not-implemented c "%container-remove!"))

;*---------------------------------------------------------------------*/
;*    %container-children ...                                          */
;*---------------------------------------------------------------------*/
(define (%container-children o::%bglk-object)
   (not-implemented o "%container-children"))

;*---------------------------------------------------------------------*/
;*    %container-border-width ...                                      */
;*---------------------------------------------------------------------*/
(define (%container-border-width o::%bglk-object)
   (not-implemented o "%container-border-width"))
  
;*---------------------------------------------------------------------*/
;*    %container-border-width-set! ...                                 */
;*---------------------------------------------------------------------*/
(define (%container-border-width-set! o::%bglk-object v)
   (not-implemented o "%container-border-width-set!"))
   
