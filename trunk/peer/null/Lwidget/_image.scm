;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_image.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed May 30 05:11:06 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Image implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/image.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%image
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static (class %file-image::%peer)
	   (class %data-image::%peer))

   (export (%make-%file-image ::%bglk-object ::bstring)
	   (%make-%data-image ::%bglk-object ::bstring ::bstring)
	   (%duplicate-image ::%bglk-object)
	   
	   (%image-width::int ::%bglk-object)
	   (%image-height::int ::%bglk-object)

	   (%delete-image ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%file-image ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%file-image o::%bglk-object filename::bstring)
   (not-implemented o "%make-%file-image"))

;*---------------------------------------------------------------------*/
;*    %make-%data-image ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%data-image o::%bglk-object data::bstring mask::bstring)
   (not-implemented o "%make-%data-image"))

;*---------------------------------------------------------------------*/
;*    %duplicate-image ...                                             */
;*---------------------------------------------------------------------*/
(define (%duplicate-image o::%bglk-object)
   (not-implemented o "%duplicate-image"))

;*---------------------------------------------------------------------*/
;*    %image-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%image-width::int o::%bglk-object)
   (not-implemented o "%image-width"))

;*---------------------------------------------------------------------*/
;*    %image-height ...                                                */
;*---------------------------------------------------------------------*/
(define (%image-height::int o::%bglk-object)
   (not-implemented o "%image-height"))

;*---------------------------------------------------------------------*/
;*    %delete-image ...                                                */
;*---------------------------------------------------------------------*/
(define (%delete-image o::%bglk-object)
   (not-implemented o "%delete-image"))

