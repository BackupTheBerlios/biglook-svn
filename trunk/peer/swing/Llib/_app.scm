;*=====================================================================*/
;*    swing/Llib/_app.scm                                              */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Apr  8 21:25:15 2004 (braun)                  */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer app implementation.                               */
;*    definition: @path ../../../biglook/Llib/app.scm@                 */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%app

   (import __biglook_%configure
	   
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%error
	   __biglook_%color
	   ;__biglook_%cursor
	   __biglook_%window)
   
   (java   (class %bglk
 	      (method static main::int () "jvm_main")
	      "bigloo.biglook.peer.Jlib.Bglk"))
   
   (export (%biglook-version)
	   (%biglook-info)
	   (%biglook-rc-parse ::bstring)
	   (%biglook-start ::bool ::bstring ::bstring ::obj)
	   (%biglook-peer-special ::pair-nil)))

;*---------------------------------------------------------------------*/
;*    %biglook-version ...                                             */
;*---------------------------------------------------------------------*/
(define (%biglook-version)
   (%biglook-peer-version))

;*---------------------------------------------------------------------*/
;*    %biglook-info ...                                                */
;*---------------------------------------------------------------------*/
(define (%biglook-info)
   (%biglook-peer-name))

;*---------------------------------------------------------------------*/
;*    %biglook-rc-parse ...                                            */
;*---------------------------------------------------------------------*/
(define (%biglook-rc-parse rc-name)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %biglook-start ...                                               */
;*---------------------------------------------------------------------*/
(define (%biglook-start loop? argv0 name rc)
   (register-exit-function! (lambda (exit-value)
			       (%update '())
			       ;(if (
			       (if (and loop? exit-value)
				   (%bglk-main)))))

;*---------------------------------------------------------------------*/
;*    %biglook-peer-special ...                                        */
;*---------------------------------------------------------------------*/
(define (%biglook-peer-special options)
   #unspecified)
