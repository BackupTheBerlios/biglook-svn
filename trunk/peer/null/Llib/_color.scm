;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Llib/_color.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Dec 15 08:06:07 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Color implementation.                              */
;*    definition: @path ../../../biglook/Llib/color.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%color

   (import __biglook_%error)
   
   (export  (abstract-class %color)
	    
	    (class %rgb-color::%color
	       (%red::int (default 0))
	       (%green::int (default 0))
	       (%blue::int (default 0))
	       (%opacity::int (default 0)))
	    
	    (class %name-color::%color
	       (%name::bstring (default "white")))
	    
	    (%color-rgb-component ::obj)))

;*---------------------------------------------------------------------*/
;*    %color-rgb-component ...                                         */
;*---------------------------------------------------------------------*/
(define (%color-rgb-component v::obj)
   (not-implemented v "%color-rgb-component"))
