;*=====================================================================*/
;*    swing/Lwidget/_text.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Damien Ciabrini                                   */
;*    Creation    :  Wed Nov  5 11:57:38 2003                          */
;*    Last change :  Tue Mar 23 09:09:57 2004 (dciabrin)               */
;*    Copyright   :  2003-04 Damien Ciabrini, see LICENCE file         */
;*    -------------------------------------------------------------    */
;*    The Jvm peer Text implementation.                                */
;*    definition: @path ../../../biglook/Lwidget/window.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%text
   
   (import __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%font
	   __biglook_%error)

   (static (class %text::%widget))

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
;*    %peer-init ...                                                   */
;*---------------------------------------------------------------------*/
(define-method (%peer-init peer::%text)
   (call-next-method)
   peer)


;*---------------------------------------------------------------------*/
;*    %make-%window ...                                                */
;*---------------------------------------------------------------------*/
(define (%make-%text o::%bglk-object)
   (let ((text (instantiate::%text
		  (%builtin (%swing-jtextpane-new))
		  (%bglk-object o))))
      text))

(define (%text-background o::%bglk-object)
   #f)

(define (%text-background-set! o::%bglk-object col::%rgb-color)
   (let ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%swing-jcomponent-background-set! builtin
					 (biglook-color->swing col))
      o))

(define (%text-font o::%bglk-object)
   #f)

(define (%text-font-set! o::%bglk-object f::%font)
   (let ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%swing-jcomponent-font-set! builtin
				   (%biglook-font->swing f))
      o))

(define (%text-text::bstring o::%bglk-object)
   (let ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%bglk-jstring->bstring (%swing-jtextcomponent-text builtin))))

(define (%text-text-set! o::%bglk-object s::bstring)
   (let ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%swing-jtextcomponent-text-set! builtin (%bglk-bstring->jstring s))
      o))

(define (%text-editable?::bool o::%bglk-object)
   (let ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%swing-jtextcomponent-editable? builtin)))

(define (%text-editable?-set! o::%bglk-object b::bool)
   (let ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%swing-jtextcomponent-editable?-set! builtin b)
      o))

(define (%text-pixels-coords->caret-location::int o::%bglk-object
						  coords::pair)
   (let ((builtin (%peer-%builtin (%bglk-object-%peer o)))
	 (p (%awt-point-new (car coords) (cdr coords))))
      (%swing-jtextcomponent-view->model builtin p)))

(define (%text-caret->line/column::pair o::%bglk-object caret::int)
   (let* ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%bglk-text-caret->line/column builtin caret)))

(define (%text-caret-pos::int o::%bglk-object)
   (let* ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%swing-jtextcomponent-caret-position builtin)))

(define (%text-caret-pos-set! o::%bglk-object pos::int)
   (let* ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%swing-jtextcomponent-caret-position-set! builtin pos)
      o))

(define (%text-insert-string o::%bglk-object str::bstring)
   (let* ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (%swing-jtextpane-replace-selection builtin (%bglk-bstring->jstring str))
      o))

(define (%text-put-props! o::%bglk-object start::int end::int props::pair-nil)
   (let* ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (not-implemented o "%text-put-props!")))
