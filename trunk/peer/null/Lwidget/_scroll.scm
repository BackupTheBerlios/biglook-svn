;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_scroll.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Jun 13 06:21:32 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Label implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/scroll.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%scroll
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object)
   
   (static (class %scroll::%peer))
	   
   (export (%make-%scroll ::%bglk-object)

	   (%scroll-hfraction::double ::%bglk-object)
	   (%scroll-hfraction-set! ::%bglk-object ::double)
	    
	   (%scroll-vfraction::double ::%bglk-object)
	   (%scroll-vfraction-set! ::%bglk-object ::double)
	    
	   (%scroll-hside ::%bglk-object)
	   (%scroll-hside-set! ::%bglk-object ::obj)
	   
	   (%scroll-vside ::%bglk-object)
	   (%scroll-vside-set! ::%bglk-object ::obj)
	   
	   (%scroll-hpolicy ::%bglk-object)
	   (%scroll-hpolicy-set! ::%bglk-object ::obj)
	   
	   (%scroll-vpolicy ::%bglk-object)
	   (%scroll-vpolicy-set! ::%bglk-object ::obj)

	   (%scroll-hpage-size::int ::%bglk-object)
	   (%scroll-vpage-size::int ::%bglk-object)
	   
	   (%scroll-add! ::%bglk-object ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %make-%scroll ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%scroll o::%bglk-object)
   (not-implemented o "%make-%scroll"))

;*---------------------------------------------------------------------*/
;*    %scroll-hfraction ...                                            */
;*---------------------------------------------------------------------*/
(define (%scroll-hfraction o::%bglk-object)
   (not-implemented o "%scroll-hfraction"))
   
;*---------------------------------------------------------------------*/
;*    %scroll-hfraction-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%scroll-hfraction-set! o::%bglk-object v)
   (not-implemented o "%scroll-hfraction-set!"))
   
;*---------------------------------------------------------------------*/
;*    %scroll-vfraction ...                                            */
;*---------------------------------------------------------------------*/
(define (%scroll-vfraction o::%bglk-object)
   (not-implemented o "%scroll-vfraction"))
   
;*---------------------------------------------------------------------*/
;*    %scroll-vfraction-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%scroll-vfraction-set! o::%bglk-object v)
   (not-implemented o "%scroll-vfraction-set!"))
   
;*---------------------------------------------------------------------*/
;*    %scroll-hside ...                                                */
;*---------------------------------------------------------------------*/
(define (%scroll-hside o::%bglk-object)
   (not-implemented o "%scroll-hside"))

;*---------------------------------------------------------------------*/
;*    %scroll-hside-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-hside-set! o::%bglk-object v)
   (not-implemented o "%scroll-hside-set!"))

;*---------------------------------------------------------------------*/
;*    %scroll-vside ...                                                */
;*---------------------------------------------------------------------*/
(define (%scroll-vside o::%bglk-object)
   (not-implemented o "%scroll-vside"))

;*---------------------------------------------------------------------*/
;*    %scroll-vside-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-vside-set! o::%bglk-object v)
   (not-implemented o "%scroll-vside-set!"))

;*---------------------------------------------------------------------*/
;*    %scroll-hpolicy ...                                              */
;*---------------------------------------------------------------------*/
(define (%scroll-hpolicy o::%bglk-object)
   (not-implemented o "%scroll-hpolicy"))

;*---------------------------------------------------------------------*/
;*    %scroll-hpolicy-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%scroll-hpolicy-set! o::%bglk-object v)
   (not-implemented o "%scroll-hpolicy-set!"))

;*---------------------------------------------------------------------*/
;*    %scroll-vpolicy ...                                              */
;*---------------------------------------------------------------------*/
(define (%scroll-vpolicy o::%bglk-object)
   (not-implemented o "%scroll-vpolicy"))

;*---------------------------------------------------------------------*/
;*    %scroll-vpolicy-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%scroll-vpolicy-set! o::%bglk-object v)
   (not-implemented o "%scroll-vpolicy-set!"))

;*---------------------------------------------------------------------*/
;*    %scroll-hpage-size ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-hpage-size o::%bglk-object)
   (not-implemented o "%scroll-hpage-size"))

;*---------------------------------------------------------------------*/
;*    %scroll-vpage-size ...                                           */
;*---------------------------------------------------------------------*/
(define (%scroll-vpage-size o::%bglk-object)
   (not-implemented o "%scroll-vpage-size"))

;*---------------------------------------------------------------------*/
;*    %scroll-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%scroll-add! container::%bglk-object widget::%bglk-object)
   (not-implemented container "%scroll-add!"))

