;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Init/biglook_peer.scm      */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Oct 17 10:43:10 1998                          */
;*    Last change :  Sat Dec  1 08:22:07 2001 (serrano)                */
;*    -------------------------------------------------------------    */
;*    The initialization for the Biglook (GTK back-end) library.       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    GTK CC options                                                   */
;*---------------------------------------------------------------------*/
;; linking
(let ((gtk-ld-options "<gtk-config-libs> "))
   (set! *ld-options* (string-append *ld-options*
				     gtk-ld-options
				     " -L/usr/X11R6/lib ")))

;; compiling
(let ((gtk-cc-options "<gtk-config-cflags> ")
      (glib-cc-options "<glib-config-cflags> "))
   (set! *cc-options* (string-append gtk-cc-options
				     glib-cc-options
				     *cc-options*)))

(set! *cc-options* (string-append " -I" *peer-dir* " " *cc-options*))
(set! *additional-include-foreign* (cons "biglook_peer.h"
					 *additional-include-foreign*))

;*---------------------------------------------------------------------*/
;*    GNOMEUI CC options                                               */
;*---------------------------------------------------------------------*/
;; linking
(let ((gnome-ld-options "<gnome-config-libs> "))
   (set! *ld-options* (string-append *ld-options* gnome-ld-options)))

;; compiling
(let ((gnome-cc-options "<gnome-config-cflags> "))
   (set! *cc-options* (string-append gnome-cc-options *cc-options*)))

;*---------------------------------------------------------------------*/
;*    GdkPixbuf CC options                                             */
;*---------------------------------------------------------------------*/
;; linking
(let ((pixbuf-ld-options "<gdk-pixbuf-config-libs> "))
   (set! *ld-options* (string-append *ld-options* pixbuf-ld-options)))
  
;; compiling
(let ((pixbuf-cc-options "<gdk-pixbuf-config-cflags> "))
   (set! *cc-options* (string-append pixbuf-cc-options *cc-options*)))

;*---------------------------------------------------------------------*/
;*    Additional libraries                                             */
;*---------------------------------------------------------------------*/
(set! *bigloo-user-lib* (append '("-lm" "-lX11") *bigloo-user-lib*))

