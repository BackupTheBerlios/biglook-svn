;*=====================================================================*/
;*    peer/heap/%make-lib.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Oct 17 06:18:31 1998                          */
;*    Last change :  Tue Aug  2 11:56:34 2005 (dciabrin)               */
;*    -------------------------------------------------------------    */
;*    The Biglook peer library builder                                 */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __make-%biglook-lib
   
   (import
    ;; Llib
    __biglook_%configure
    __biglook_%app
    __biglook_%event
    __biglook_%callback
    __biglook_%color
    __biglook_%font
    __biglook_%after
    __biglook_%port
    __biglook_%cursor
    
    ;; Lwidget
    __biglook_%peer
    __biglook_%bglk-object
    __biglook_%widget
    __biglook_%image
    __biglook_%container
    __biglook_%box
    __biglook_%grid
    __biglook_%area
    __biglook_%window
    __biglook_%frame
    __biglook_%scroll
    __biglook_%notepad
    __biglook_%paned
    __biglook_%button
    __biglook_%check-button
    __biglook_%radio
    __biglook_%label
    __biglook_%entry
    __biglook_%listbox
    __biglook_%combobox
;    __biglook_%canvas
;    __biglook_%canvas-item
    __biglook_%gauge
    __biglook_%scale
    __biglook_%menu
    __biglook_%toolbar
    __biglook_%file-selector
    __biglook_%color-selector
    __biglook_%tree
    __biglook_%table
    __biglook_%text
    ))
