;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_window.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri Jun  8 16:59:44 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Window implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/window.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%window
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error)
   
   (export (%make-%window ::%bglk-object ::bool ::bool ::bool)
	   (%make-%applet ::%bglk-object)

	   (%window-add! ::%bglk-object ::%bglk-object)
	   (%applet-add! ::%bglk-object ::%bglk-object)

	   (%update ::pair-nil)
	   (%deiconify ::%bglk-object)
	   (%iconify ::%bglk-object)
	   
	   (%window-x::int ::%bglk-object)
	   (%window-x-set! ::%bglk-object ::int)
	   (%window-y::int ::%bglk-object)
	   (%window-y-set! ::%bglk-object ::int)
	   (%window-title ::%bglk-object)
	   (%window-title-set! ::%bglk-object ::bstring)))

;*---------------------------------------------------------------------*/
;*    %make-%window ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%window o::%bglk-object transient auto-resize modal)
   (not-implemented o "%make-%window"))

;*---------------------------------------------------------------------*/
;*    %make-%applet ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%applet o::%bglk-object)
   (not-implemented o "%make-%applet"))

;*---------------------------------------------------------------------*/
;*    %window-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%window-add! o::%bglk-object w::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%window-add!")))

;*---------------------------------------------------------------------*/
;*    %applet-add! ...                                                 */
;*---------------------------------------------------------------------*/
(define (%applet-add! o::%bglk-object w::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%applet-add!")))

;*---------------------------------------------------------------------*/
;*    %window-x ...                                                    */
;*---------------------------------------------------------------------*/
(define (%window-x::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%window-x")))

;*---------------------------------------------------------------------*/
;*    %window-x-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%window-x-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%window-x-set!")))

;*---------------------------------------------------------------------*/
;*    %window-y ...                                                    */
;*---------------------------------------------------------------------*/
(define (%window-y::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%window-y")))

;*---------------------------------------------------------------------*/
;*    %window-y-set! ...                                               */
;*---------------------------------------------------------------------*/
(define (%window-y-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%window-y-set!")))

;*---------------------------------------------------------------------*/
;*    %window-title ...                                                */
;*---------------------------------------------------------------------*/
(define (%window-title o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%window-title")))

;*---------------------------------------------------------------------*/
;*    %window-title-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%window-title-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%window-title-set!")))

;*---------------------------------------------------------------------*/
;*    %update ...                                                      */
;*---------------------------------------------------------------------*/
(define (%update o::pair-nil)
   (not-implemented o "%update"))

;*---------------------------------------------------------------------*/
;*    %deiconify ...                                                   */
;*---------------------------------------------------------------------*/
(define (%deiconify o::%bglk-object)
   (not-implemented o "%deiconify"))
   
;*---------------------------------------------------------------------*/
;*    %iconify ...                                                     */
;*---------------------------------------------------------------------*/
(define (%iconify o::%bglk-object)
   (not-implemented o "%iconify"))
   
   
   
