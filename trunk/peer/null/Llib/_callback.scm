;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Llib/_callback.scm        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Jul 31 07:00:31 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer callback: implementation.                          */
;*    definition: @path ../../../biglook/Llib/event.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%callback
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%event)
   
   (export (%install-widget-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-widget-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-canvas-item-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-canvas-item-callback! ::%bglk-object ::symbol ::obj)
	   
	   (%install-tree-branch-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-tree-branch-callback! ::%bglk-object ::symbol ::procedure)
	   
	   (%install-tree-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-tree-callback! ::%bglk-object ::symbol ::procedure)

	   (%install-menu-item-callback! ::%bglk-object ::symbol ::procedure)
	   (%uninstall-menu-item-callback! ::%bglk-object ::symbol ::procedure)))

;*---------------------------------------------------------------------*/
;*    %install-widget-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define (%install-widget-callback! o sym::symbol p)
   (not-implemented o "%install-widget-callback!"))

;*---------------------------------------------------------------------*/
;*    %uninstall-widget-callback! ...                                  */
;*---------------------------------------------------------------------*/
(define (%uninstall-widget-callback! o sym::symbol p)
   (not-implemented o "%uninstall-widget-callback!"))

;*---------------------------------------------------------------------*/
;*    %uninstall-canvas-item-callback! ...                             */
;*---------------------------------------------------------------------*/
(define (%uninstall-canvas-item-callback! o s p)
   (not-implemented o "%uninstall-canvas-item-callback!"))

;*---------------------------------------------------------------------*/
;*    %install-canvas-item-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%install-canvas-item-callback! o s p)
   (not-implemented o "%install-canvas-item-callback!"))

;*---------------------------------------------------------------------*/
;*    %install-tree-callback! ...                                      */
;*---------------------------------------------------------------------*/
(define (%install-tree-callback! o s p)
   (not-implemented o "%install-tree-callback!"))

;*---------------------------------------------------------------------*/
;*    %uninstall-tree-callback! ...                                    */
;*---------------------------------------------------------------------*/
(define (%uninstall-tree-callback! o s p)
   (not-implemented o "%uninstall-tree-callback!"))

;*---------------------------------------------------------------------*/
;*    %install-tree-branch-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%install-tree-branch-callback! o s p)
   (not-implemented o "%install-tree-branch-callback!"))

;*---------------------------------------------------------------------*/
;*    %uninstall-tree-branch-callback! ...                             */
;*---------------------------------------------------------------------*/
(define (%uninstall-tree-branch-callback! o s p)
   (not-implemented o "%uninstall-tree-branch-callback!"))

;*---------------------------------------------------------------------*/
;*    %install-menu-item-callback! ...                                 */
;*---------------------------------------------------------------------*/
(define (%install-menu-item-callback! o s p)
   (not-implemented o "%install-menu-item-callback!"))

;*---------------------------------------------------------------------*/
;*    %uninstall-menu-item-callback! ...                               */
;*---------------------------------------------------------------------*/
(define (%uninstall-menu-item-callback! o s p)
   (not-implemented o "%uninstall-menu-item-callback!"))

