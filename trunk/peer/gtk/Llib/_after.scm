;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Llib/_after.scm            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Fri May  4 14:47:33 2001                          */
;*    Last change :  Tue Sep  4 08:14:00 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk implemenation of after and timeout                       */
;*    definition: @path ../../../biglook/Llib/after.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%after
   
   (import __biglook_%peer
	   __biglook_%bglk-object)
   
   (extern (macro %%bglk-timeout-add::uint (::uint ::obj)
		  "bglk_timeout_add")
	   (macro %%bglk-idle-add::uint (::obj)
		  "bglk_idle_add")
	   (macro %%g-source-remove::int (::uint)
		  "g_source_remove")
	   (macro %%g-source-remove-by-user-data::int (::gpointer)
		  "g_source_remove_by_user_data")
	   (macro %%g-idle-remove-by-data::int (::gpointer)
		  "g_idle_remove_by_data"))
   
   (export (%after ::int ::procedure)
	   (%timeout ::int ::procedure)
	   (%idle ::procedure)))

;*---------------------------------------------------------------------*/
;*    %after ...                                                       */
;*---------------------------------------------------------------------*/
(define (%after interval::int proc::procedure)
   (%timeout interval (lambda () (proc) #f)))

;*---------------------------------------------------------------------*/
;*    %timeout ...                                                     */
;*---------------------------------------------------------------------*/
(define (%timeout interval::int proc::procedure)
   (%%bglk-timeout-add interval proc))

;*---------------------------------------------------------------------*/
;*    %idle ...                                                        */
;*---------------------------------------------------------------------*/
(define (%idle proc::procedure)
   (%%bglk-idle-add proc))

