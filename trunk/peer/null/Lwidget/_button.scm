;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_button.scm       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sat Jul 14 15:15:42 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Button implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/button.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%button
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static (class %button::%peer))
	   
   (export (%make-%button ::%bglk-object)
	   
	   (%button-command ::%bglk-object)
	   (%button-command-set! ::%bglk-object ::obj)
	   
	   (%button-text ::%bglk-object)
	   (%button-text-set! ::%bglk-object ::bstring)
	   
	   (%button-image ::%bglk-object)
	   (%button-image-set! ::%bglk-object ::%bglk-object)
	   
	   (%button-border-width::int ::%bglk-object)
	   (%button-border-width-set! ::%bglk-object ::int)
	   
	   (%button-relief::symbol ::%bglk-object)
	   (%button-relief-set! ::%bglk-object ::symbol)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%button ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%button o::%bglk-object)
   (not-implemented o "%make-%button"))

;*---------------------------------------------------------------------*/
;*    %button-command ...                                              */
;*---------------------------------------------------------------------*/
(define (%button-command o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-command")))

;*---------------------------------------------------------------------*/
;*    %button-command-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%button-command-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-command-set!")))

;*---------------------------------------------------------------------*/
;*    %button-text ...                                                 */
;*---------------------------------------------------------------------*/
(define (%button-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-text")))

;*---------------------------------------------------------------------*/
;*    %button-text-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%button-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-text-set!")))

;*---------------------------------------------------------------------*/
;*    %button-image ...                                                */
;*---------------------------------------------------------------------*/
(define (%button-image o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-image")))

;*---------------------------------------------------------------------*/
;*    %button-image-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%button-image-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-image-set!")))

;*---------------------------------------------------------------------*/
;*    %button-border-width ...                                         */
;*---------------------------------------------------------------------*/
(define (%button-border-width::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-border-width")))
  
;*---------------------------------------------------------------------*/
;*    %button-border-width-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%button-border-width-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-border-width-set!")))
  
;*---------------------------------------------------------------------*/
;*    %button-relief ...                                               */
;*---------------------------------------------------------------------*/
(define (%button-relief o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-relief")))
  
;*---------------------------------------------------------------------*/
;*    %button-relief-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%button-relief-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%button-relief-set!")))
  
   
