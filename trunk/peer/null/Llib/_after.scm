;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Llib/%after.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Fri May  4 14:47:33 2001                          */
;*    Last change :  Sun May  6 05:38:48 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The null implemenation of after and timeout                      */
;*    definition: @path ../../../biglook/Llib/after.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%after

   (import __biglook_%error)
   
   (export  (%after ::int ::procedure)
	    (%timeout ::int ::procedure)
	    (%idle ::procedure)))

;*---------------------------------------------------------------------*/
;*    %after ...                                                       */
;*---------------------------------------------------------------------*/
(define (%after interval::int proc::procedure)
   (not-implemented interval "%after"))

;*---------------------------------------------------------------------*/
;*    %timeout ...                                                     */
;*---------------------------------------------------------------------*/
(define (%timeout interval::int proc::procedure)
   (not-implemented interval "%timeout"))

;*---------------------------------------------------------------------*/
;*    %idle ...                                                        */
;*---------------------------------------------------------------------*/
(define (%idle proc::procedure)
   (not-implemented proc "%idle"))
