;*=====================================================================*/
;*    .../prgm/project/biglook/peer/null/Lwidget/%bglk-object.scm      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Apr 12 11:29:15 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer bglk-object class.                                 */
;*    definition: @path ../../../biglook/Lwidget/bglk-object.scm@      */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%bglk-object
   
   (export (class %bglk-object
	      ;; the peer object associated with the Biglook object
	      (%peer (default #unspecified)))))
