;*=====================================================================*/
;*    null/Lwidget/_text.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Damien Ciabrini                                   */
;*    Creation    :  Wed Nov  5 11:57:38 2003                          */
;*    Last change :  Thu Dec 18 16:01:36 2003 (dciabrin)               */
;*    Copyright   :  2003 Damien Ciabrini, see LICENCE file            */
;*    -------------------------------------------------------------    */
;*    The Jvm peer Text implementation.                                */
;*    definition: @path ../../../biglook/Lwidget/window.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%text
   
   (import __biglook_%peer
	   __biglook_%font
	   __biglook_%color
	   __biglook_%bglk-object
	   __biglook_%error)

   (export (%make-%text ::%bglk-object)

	   (%text-background ::%bglk-object)
	   (%text-background-set! ::%bglk-object ::%rgb-color)

	   (%text-text::bstring ::%bglk-object)
	   (%text-text-set! ::%bglk-object ::bstring)

	   (%text-font ::%bglk-object)
	   (%text-font-set! ::%bglk-object ::%font)

	   (%text-editable?::bool ::%bglk-object)
	   (%text-editable?-set! ::%bglk-object ::bool)

	   (%text-caret-pos::int ::%bglk-object)
	   (%text-caret-pos-set! ::%bglk-object ::int)

	   (%text-pixels-coords->caret-location::int ::%bglk-object ::pair)
	   (%text-caret->line/column::pair ::%bglk-object ::int)

	   (%text-insert-string ::%bglk-object ::bstring)
	   (%text-put-props! ::%bglk-object ::int ::int ::pair-nil)
	   ))


;*---------------------------------------------------------------------*/
;*    %make-%window ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%text o::%bglk-object)
   (not-implemented o "%make-%text"))

(define (%text-background o::%bglk-object)
   (not-implemented o "%text-background"))

(define (%text-background-set! o::%bglk-object c::%rgb-color)
   (not-implemented o "%text-background-set!"))

(define (%text-font o::%bglk-object)
   (not-implemented o "%text-font"))

(define (%text-font-set! o::%bglk-object c::%font)
   (not-implemented o "%text-font-set!"))

(define (%text-text::bstring o::%bglk-object)
   (not-implemented o "%text-text"))

(define (%text-text-set! o::%bglk-object s::bstring)
   (not-implemented o "%text-text-set!"))

(define (%text-editable?::bool o::%bglk-object)
   (not-implemented o "%text-editable?"))

(define (%text-editable?-set! o::%bglk-object b::bool)
   (not-implemented o "%text-editable?-set!"))

(define (%text-caret-pos::int o::%bglk-object)
   (not-implemented o "%text-caret-pos"))

(define (%text-caret-pos-set! o::%bglk-object pos::int)
   (not-implemented o "%text-caret-pos-set!"))

(define (%text-pixels-coords->caret-location::int o::%bglk-object coords::pair)
   (not-implemented o "%text-pixels-coords->caret-location"))

(define (%text-caret->line/column::pair o::%bglk-object caret::int)
   (not-implemented o "%text-caret->line/column"))

(define (%text-insert-string o::%bglk-object str::bstring)
   (not-implemented o "%text-insert-string"))

(define (%text-put-props! o::%bglk-object start::int end::int props::pair-nil)
   (not-implemented o "%text-put-props!"))
