;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Lwidget/%box.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue May  1 09:22:09 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Label implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/box.scm@              */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%box
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object)
   
   (export (%make-%hbox ::%bglk-object)
	   (%make-%vbox ::%bglk-object)
	   
	   (%vbox-add! ::%bglk-object ::%bglk-object ::bool ::bool ::int ::bool)
	   (%hbox-add! ::%bglk-object ::%bglk-object ::bool ::bool ::int ::bool)
	   (%box-homogenous::bool ::%bglk-object)
	   (%box-homogenous-set! ::%bglk-object ::bool)))

;*---------------------------------------------------------------------*/
;*    %make-%hbox ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%hbox o::%bglk-object)
   (not-implemented o "%make-%hbox"))

;*---------------------------------------------------------------------*/
;*    %make-%vbox ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%vbox o::%bglk-object)
   (not-implemented o "%make-%vbox"))

;*---------------------------------------------------------------------*/
;*    %vbox-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%vbox-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (not-implemented c "%vbox-add!"))

;*---------------------------------------------------------------------*/
;*    %hbox-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%hbox-add! c::%bglk-object w::%bglk-object expand fill padding top)
   (not-implemented c "%hbox-add!"))

;*---------------------------------------------------------------------*/
;*    %box-homogenous ...                                              */
;*---------------------------------------------------------------------*/
(define (%box-homogenous o::%bglk-object)
   (not-implemented o "%box-homogeneous"))

;*---------------------------------------------------------------------*/
;*    %box-homogenous-set! ...                                         */
;*---------------------------------------------------------------------*/
(define (%box-homogenous-set! o::%bglk-object v)
   (not-implemented o "%box-homogeneous-set!"))

