;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/_entry.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed Oct 10 15:27:19 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Entry implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/entry.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%entry
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (export (class %entry::%entry)

	   (%make-%entry ::%bglk-object)
	   
	   (%entry-command ::%bglk-object)
	   (%entry-command-set! ::%bglk-object ::obj)
	   
	   (%entry-text::bstring ::%bglk-object)
	   (%entry-text-set! ::%bglk-object ::bstring)
	   
	   (%entry-active?::bool ::%bglk-object)
	   (%entry-active?-set! ::%bglk-object ::bool)
	   
	   (%entry-width::int ::%bglk-object)
	   (%entry-width-set! ::%bglk-object ::int)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%entry ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%entry o::%bglk-object)
   (not-implemented o "%peer-init(entry)"))

;*---------------------------------------------------------------------*/
;*    %entry-command ...                                               */
;*---------------------------------------------------------------------*/
(define (%entry-command o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%entry-command")))

;*---------------------------------------------------------------------*/
;*    %entry-command-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%entry-command-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%entry-command-set!")))

;*---------------------------------------------------------------------*/
;*    %entry-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%entry-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%entry-text")))

;*---------------------------------------------------------------------*/
;*    %entry-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%entry-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%entry-text-set!")))

;*---------------------------------------------------------------------*/
;*    %entry-active? ...                                               */
;*---------------------------------------------------------------------*/
(define (%entry-active? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%entry-active?")))

;*---------------------------------------------------------------------*/
;*    %entry-active?-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%entry-active?-set! o::%bglk-object v::bool)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%entry-active?-set!")))

;*---------------------------------------------------------------------*/
;*    %entry-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%entry-width::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%entry-width")))

;*---------------------------------------------------------------------*/
;*    %entry-width-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%entry-width-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (not-implemented %peer "%entry-width-set!")))

