;*=====================================================================*/
;*    .../prgm/project/biglook/peer/null/Lwidget/_fileselector.scm     */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Mon May 21 17:20:30 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Fileselector implementation.                       */
;*    definition: @path ../../../biglook/Lwidget/fileselector.scm@     */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%file-selector
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color)
   
   (static (class %file-selector::%peer))
	   
   (export (%make-%file-selector ::%bglk-object ::bstring)

	   (%file-selector-file::bstring ::%bglk-object)
	   (%file-selector-file-set! ::%bglk-object ::bstring)
	   
	   (%file-selector-path::bstring ::%bglk-object)
	   (%file-selector-path-set! ::%bglk-object ::bstring)
	   
	   (%file-selector-ok-command ::%bglk-object)
	   (%file-selector-ok-command-set! ::%bglk-object ::procedure)
	   
	   (%file-selector-cancel-command ::%bglk-object)
	   (%file-selector-cancel-command-set! ::%bglk-object ::procedure)))

;*---------------------------------------------------------------------*/
;*    %make-%file-selector ...                                         */
;*---------------------------------------------------------------------*/
(define (%make-%file-selector o title)
   (not-implemented o "%make-%file-selector"))

;*---------------------------------------------------------------------*/
;*    %file-selector-file ...                                          */
;*---------------------------------------------------------------------*/
(define (%file-selector-file o)
   (not-implemented o "%file-selector-file"))

;*---------------------------------------------------------------------*/
;*    %file-selector-file-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%file-selector-file-set! o v)
   (not-implemented o "%file-selector-file-set!"))

;*---------------------------------------------------------------------*/
;*    %file-selector-path ...                                          */
;*---------------------------------------------------------------------*/
(define (%file-selector-path o)
   (not-implemented o "%file-selector-path"))

;*---------------------------------------------------------------------*/
;*    %file-selector-path-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%file-selector-path-set! o v)
   (not-implemented o "%file-selector-path-set!"))

;*---------------------------------------------------------------------*/
;*    %file-selector-ok-command ...                                    */
;*---------------------------------------------------------------------*/
(define (%file-selector-ok-command o)
   (not-implemented o "%file-selector-ok-command"))

;*---------------------------------------------------------------------*/
;*    %file-selector-ok-command-set! ...                               */
;*---------------------------------------------------------------------*/
(define (%file-selector-ok-command-set! o v)
   (not-implemented o "%file-selector-ok-command-set!"))

;*---------------------------------------------------------------------*/
;*    %file-selector-cancel-command ...                                */
;*---------------------------------------------------------------------*/
(define (%file-selector-cancel-command o)
   (not-implemented o "%file-selector-cancel-command"))

;*---------------------------------------------------------------------*/
;*    %file-selector-cancel-command-set! ...                           */
;*---------------------------------------------------------------------*/
(define (%file-selector-cancel-command-set! o v)
   (not-implemented o "%file-selector-cancel-command-set!"))
