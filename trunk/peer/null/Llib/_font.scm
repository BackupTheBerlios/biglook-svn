;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Llib/%font.scm            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Apr 22 14:27:04 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Font implementation.                               */
;*    definition: @path ../../../biglook/Llib/font.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%font
   
   (import __biglook_%error)
   
   (export (class %font
              ;; the family  (e.g. helvetica, times)
              (family::bstring
	       (default "helvetica"))
              ;; the weight (e.g. bold, medium)
              (weight::symbol
	       (default 'bold))
              ;; the slant (e.g. roman, italic, oblique)
              (slant::symbol
	       (default 'roman))
              ;; width (e.g. condensed, normal)
              (width::symbol
	       (default 'normal))
              ;; pixel size (e.g. 12)
              (size::int
	       (default 12)))))
