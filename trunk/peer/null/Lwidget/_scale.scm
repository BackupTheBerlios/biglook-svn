;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_scale.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon May 21 06:32:34 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Scale implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/scale.scm@            */
;*=====================================================================*/
 
;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%scale
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static  (class %scale::%peer))
   
   (export  (%make-%hscale ::%bglk-object)
	    (%make-%vscale ::%bglk-object)

	    (%scale-command ::%bglk-object)
	    (%scale-command-set! ::%bglk-object ::obj)
	    
	    (%scale-value::int ::%bglk-object)
	    (%scale-value-set! ::%bglk-object ::int)
	    
	    (%scale-show-value?::bool ::%bglk-object)
	    (%scale-show-value?-set! ::%bglk-object ::bool)
	    
	    (%scale-from::int ::%bglk-object)
	    (%scale-from-set! ::%bglk-object ::int)
	    
	    (%scale-to::int ::%bglk-object)
	    (%scale-to-set! ::%bglk-object ::int)))
	    
;*---------------------------------------------------------------------*/
;*    %make-%hscale ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%hscale o)
   (not-implemented o "%make-%hscale"))

;*---------------------------------------------------------------------*/
;*    %make-%vscale ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%vscale o)
   (not-implemented o "%make-%vscale"))

;*---------------------------------------------------------------------*/
;*    %scale-command ...                                               */
;*---------------------------------------------------------------------*/
(define (%scale-command o::%bglk-object)
   (not-implemented o "%scale-command"))
   
;*---------------------------------------------------------------------*/
;*    %scale-command-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%scale-command-set! o::%bglk-object v)
   (not-implemented o "%scale-command-set!"))
   
;*---------------------------------------------------------------------*/
;*    %scale-value ...                                                 */
;*---------------------------------------------------------------------*/
(define (%scale-value o::%bglk-object)
   (not-implemented o "%scale-value"))
   
;*---------------------------------------------------------------------*/
;*    %scale-value-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%scale-value-set! o::%bglk-object v)
   (not-implemented o "%scale-value-set!"))
   
;*---------------------------------------------------------------------*/
;*    %scale-show-value? ...                                           */
;*---------------------------------------------------------------------*/
(define (%scale-show-value? o::%bglk-object)
   (not-implemented o "%scale-show-value?"))
   
;*---------------------------------------------------------------------*/
;*    %scale-show-value?-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%scale-show-value?-set! o::%bglk-object v)
   (not-implemented o "%scale-show-value?-set!"))
   
;*---------------------------------------------------------------------*/
;*    %scale-from ...                                                  */
;*---------------------------------------------------------------------*/
(define (%scale-from o::%bglk-object)
   (not-implemented o "%scale-from"))

;*---------------------------------------------------------------------*/
;*    %scale-from-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%scale-from-set! o::%bglk-object v::int)
   (not-implemented o "%scale-from-set!"))

;*---------------------------------------------------------------------*/
;*    %scale-to ...                                                    */
;*---------------------------------------------------------------------*/
(define (%scale-to o::%bglk-object)
   (not-implemented o "%scale-to"))

;*---------------------------------------------------------------------*/
;*    %scale-to-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%scale-to-set! o::%bglk-object v::int)
   (not-implemented o "%scale-to-set!"))

