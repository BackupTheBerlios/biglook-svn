;*=====================================================================*/
;*    null/Lwidget/_tree.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri May  7 10:56:42 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Tree implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/tree.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%tree
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error)
   
   (static (class %tree::%peer))
   
   (export (%make-%tree-seed ::%bglk-object
			     ::procedure ::procedure
			     ::procedure ::procedure
			     ::procedure)
	   (%make-%tree-branch ::%bglk-object ::%bglk-object)
	   (%make-%tree-leaf ::%bglk-object ::%bglk-object)
	   
	   (%tree-branch-render ::%bglk-object ::symbol)
	   (%tree-leaf-render ::%bglk-object)

	   (%tree-seed-command ::%bglk-object)
	   (%tree-seed-command-set! ::%bglk-object ::procedure)
	   
	   (%tree-select-mode::symbol ::%bglk-object)
	   (%tree-select-mode-set! ::%bglk-object ::symbol)

	   (%tree-selection::pair-nil ::%bglk-object)
	   
	   (%tree-seed-event ::%bglk-object)
	   (%tree-seed-event-set! ::%bglk-object ::obj)
	   
	   (%tree-leaf-add! ::%bglk-object ::%bglk-object)
	   (%tree-branch-add! ::%bglk-object ::%bglk-object)
	   (%tree-seed-add! ::%bglk-object ::%bglk-object)

	   (%tree-coords->item ::%bglk-object ::int ::int)

	   (%tree-node-items ::%bglk-object)
	   (%tree-node-expand ::%bglk-object)
	   (%tree-node-select ::%bglk-object)
	   (%tree-node-collapse ::%bglk-object)
	   (%tree-node-remove-item! ::%bglk-object ::%bglk-object)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%tree-seed ...                                             */
;*---------------------------------------------------------------------*/
(define (%make-%tree-seed o::%bglk-object
			  expand::procedure
			  collapse::procedure
			  label::procedure
			  image::procedure
			  tooltips::procedure)
   (not-implemented o "%make-%tree-seed"))


;*---------------------------------------------------------------------*/
;*    %make-%tree-branch ...                                           */
;*---------------------------------------------------------------------*/
(define (%make-%tree-branch o::%bglk-object seed::%bglk-object)
   (not-implemented o "%make-%tree-branch"))

;*---------------------------------------------------------------------*/
;*    %make-%tree-leaf ...                                             */
;*---------------------------------------------------------------------*/
(define (%make-%tree-leaf o::%bglk-object seed::%bglk-object)
   (not-implemented o "%make-%tree-leaf"))

;*---------------------------------------------------------------------*/
;*    %tree-branch-render ...                                          */
;*---------------------------------------------------------------------*/
(define (%tree-branch-render o::%bglk-object kind::symbol)
   (not-implemented o "%tree-branch-render"))
   
;*---------------------------------------------------------------------*/
;*    %tree-leaf-render ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-leaf-render o::%bglk-object)
   (not-implemented o "%tree-leaf-render"))
   
;*---------------------------------------------------------------------*/
;*    %tree-seed-command ...                                           */
;*---------------------------------------------------------------------*/
(define (%tree-seed-command o::%bglk-object)
   (not-implemented o "%tree-seed-command"))

;*---------------------------------------------------------------------*/
;*    %tree-seed-command-set! ...                                      */
;*---------------------------------------------------------------------*/
(define (%tree-seed-command-set! o::%bglk-object v)
   (not-implemented o "%tree-seed-command-set!"))

;*---------------------------------------------------------------------*/
;*    %tree-select-mode ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-select-mode::symbol o::%bglk-object)
   (not-implemented o "%tree-select-mode"))

;*---------------------------------------------------------------------*/
;*    %tree-select-mode-set! ...                                       */
;*---------------------------------------------------------------------*/
(define (%tree-select-mode-set! o::%bglk-object v::symbol)
   (not-implemented o "%tree-select-mode-set!"))

;*---------------------------------------------------------------------*/
;*    %tree-selection ...                                              */
;*---------------------------------------------------------------------*/
(define (%tree-selection  o::%bglk-object)
   (not-implemented o "%tree-selection"))

;*---------------------------------------------------------------------*/
;*    %tree-seed-event ...                                             */
;*---------------------------------------------------------------------*/
(define (%tree-seed-event o::%bglk-object)
   (not-implemented o "%tree-seed-event"))

;*---------------------------------------------------------------------*/
;*    %tree-seed-event-set! ...                                        */
;*---------------------------------------------------------------------*/
(define (%tree-seed-event-set! o::%bglk-object v)
   (not-implemented o "%tree-seed-event-set!"))

;*---------------------------------------------------------------------*/
;*    %tree-branch-add! ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-branch-add! c::%bglk-object w::%bglk-object)
   (not-implemented c "%tree-branch-add!"))

;*---------------------------------------------------------------------*/
;*    %tree-seed-add! ...                                              */
;*---------------------------------------------------------------------*/
(define (%tree-seed-add! c::%bglk-object w::%bglk-object)
   (not-implemented c "%tree-seed-add!"))

;*---------------------------------------------------------------------*/
;*    %tree-leaf-add! ...                                              */
;*---------------------------------------------------------------------*/
(define (%tree-leaf-add! c::%bglk-object w::%bglk-object)
   (not-implemented c "%tree-leaf-add!"))

;*---------------------------------------------------------------------*/
;*    %tree-node-items ...                                             */
;*---------------------------------------------------------------------*/
(define (%tree-node-items c::%bglk-object)
   (not-implemented c "%tree-node-items"))

;*---------------------------------------------------------------------*/
;*    %tree-node-expand ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-node-expand c::%bglk-object)
   (not-implemented c "%tree-node-expand"))

;*---------------------------------------------------------------------*/
;*    %tree-node-select ...                                            */
;*---------------------------------------------------------------------*/
(define (%tree-node-select c::%bglk-object)
   (not-implemented c "%tree-node-select"))

;*---------------------------------------------------------------------*/
;*    %tree-node-collapse ...                                          */
;*---------------------------------------------------------------------*/
(define (%tree-node-collapse c::%bglk-object)
   (not-implemented c "%tree-node-collapse"))

;*---------------------------------------------------------------------*/
;*    %tree-node-remove-item! ...                                      */
;*---------------------------------------------------------------------*/
(define (%tree-node-remove-item! c::%bglk-object w::%bglk-object)
   (not-implemented c "%tree-node-remove-item"))

;*---------------------------------------------------------------------*/
;*    %tree-coords->item ...                                           */
;*---------------------------------------------------------------------*/
(define (%tree-coords->item t::%bglk-object x::int y::int)
   (not-implemented c "%tree-coords->item"))