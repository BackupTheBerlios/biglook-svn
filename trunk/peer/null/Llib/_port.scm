;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/null/Llib/_port.scm            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Aug 16 09:29:21 2001                          */
;*    Last change :  Fri Aug 17 07:56:52 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Null port for Biglook file handling                              */
;*    definition: @path ../../../biglook/Llib/port.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%port
   
   (import __biglook_%error)
   
   (export (%when-char-ready ::input-port ::obj)
	   (%nonblocking ::input-port)))

;*---------------------------------------------------------------------*/
;*    %when-char-ready ...                                             */
;*---------------------------------------------------------------------*/
(define (%when-char-ready port pair)
   (not-implemented port "%when-char-ready"))

;*---------------------------------------------------------------------*/
;*    %nonblocking ...                                                 */
;*---------------------------------------------------------------------*/
(define (%nonblocking port)
   (not-implemented port "%nonblocking"))
   
