;*=====================================================================*/
;*    biglook/Misc/make-lib.scm                                        */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Oct 17 06:18:31 1998                          */
;*    Last change :  Wed Nov  5 12:11:19 2003 (dciabrin)               */
;*    -------------------------------------------------------------    */
;*    The Biglook peer library builder                                 */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __make-biglook-lib

   (library biglook_peer)
   
   (import
    ;; Llib
    __biglook_configure
    __biglook_app
    __biglook_event
    __biglook_color
    __biglook_font
    __biglook_after
    __biglook_port
    __biglook_cursor

    ;; Lwidget
    __biglook_bglk-object
    __biglook_widget
    __biglook_image
    __biglook_container
    __biglook_grid
    __biglook_area
    __biglook_box
    __biglook_layout
    __biglook_window
    __biglook_frame
    __biglook_scroll
    __biglook_notepad
    __biglook_paned
    __biglook_button
    __biglook_check-button
    __biglook_radio
    __biglook_canvas
    __biglook_canvas-item
    __biglook_label
    __biglook_entry
    __biglook_listbox
    __biglook_combobox
    __biglook_gauge
    __biglook_scale
    __biglook_menu
    __biglook_toolbar
    __biglook_file-selector
    __biglook_color-selector
    __biglook_tree
    __biglook_table
    __biglook_text
    ))

	   
   
