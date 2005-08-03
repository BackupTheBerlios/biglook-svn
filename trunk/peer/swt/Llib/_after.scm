;*=====================================================================*/
;*    swt/Llib/_after.scm                                              */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Fri May  4 14:47:33 2001                          */
;*    Last change :  Tue Aug  2 21:38:01 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing implemenation of after and timeout                     */
;*    definition: @path ../../../biglook/Llib/after.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%after

   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer)
   
   (export  (%after ::int ::procedure)
	    (%timeout ::int ::procedure)
	    (%idle ::procedure)))

;*---------------------------------------------------------------------*/
;*    %after ...                                                       */
;*---------------------------------------------------------------------*/
(define (%after interval::int proc::procedure)
   (let* ((listener (%bglk-timeradapter-new proc))
	  (timer (%swing-timer-new interval listener)))
      (%swing-timer-is-repeat-set! timer #f)
      (%swing-timer-start timer)
      proc))

;*---------------------------------------------------------------------*/
;*    %timeout ...                                                     */
;*---------------------------------------------------------------------*/
(define (%timeout interval::int proc::procedure)
   (let* ((listener (%bglk-timeradapter-new proc))
	  (timer (%swing-timer-new interval listener)))
      (%swing-timer-start timer)
      proc))

;*---------------------------------------------------------------------*/
;*    %idle ...                                                        */
;*---------------------------------------------------------------------*/
(define (%idle proc::procedure)
   ;; apply proc in another thread
   (%bglk-idle proc)
   proc)
