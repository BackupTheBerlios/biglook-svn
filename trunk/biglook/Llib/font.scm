;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Llib/font.scm               */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Oct 10 16:01:38 2000                          */
;*    Last change :  Mon May  7 20:05:11 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The base class for font                                          */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/font.texi@                                 */
;*       @node Font@                                                   */
;*    Examples:                                                        */
;*       @path ../../examples/notepad/notepad.scm@                     */
;*    -------------------------------------------------------------    */
;*    Implementation: @label Font@                                     */
;*    null: @path ../../peer/null/Llib/_font.scm@                      */
;*    gtk: @path ../../peer/gtk/Llib/_font.scm@                        */
;*    swing: @path ../../peer/swing/Llib/_font.scm@                    */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_font
   
   (library biglook_peer)
   
   (export (class font::%font)))
