;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Llib/_app.scm              */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Wed May 23 07:36:40 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer app implementation.                                */
;*    definition: @path ../../../biglook/Llib/app.scm@                 */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%app

   (import __biglook_%configure)

   (extern (%%gtk-start::int (::vector ::bool ::string ::string)
			     "bglk_gtk_start")
	   (%%gtk-main::int () "gtk_main")
	   (biglook-mainloop?::bool "biglook_mainloopp")
	   (macro %%gtk-rc-parse::void (::string)
		  "gtk_rc_parse"))
   
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
(define (%biglook-rc-parse rc)
   (let* ((rc-name (if (string=? (suffix rc) "gtk")
		       rc
		       (string-append rc ".gtk")))
	  (path (list "." (getenv "HOME") (%biglook-library-directory)))
	  (file (find-file/path rc-name path)))
      (if (and (string? file) (file-exists? file))
	  (begin
	     (%%gtk-rc-parse file)
	     file)
	  #f)))

;*---------------------------------------------------------------------*/
;*    %biglook-start ...                                               */
;*---------------------------------------------------------------------*/
(define (%biglook-start loop? argv0 name rc)
   ;; start gtk
   (%%gtk-start (list->vector (command-line)) loop? argv0 name)
   ;; parse standard rc file
   (cond
      ((string? rc)
       (if (not (%biglook-rc-parse rc))
	   (warning "biglook:" "Can't find RC file -- " rc)))
      (rc
       (%biglook-rc-parse ".biglookrc.gtk")))
   ;; register exit function
   (register-exit-function! (lambda (exit-value)
			       (if (and exit-value biglook-mainloop?)
				   (%%gtk-main)))))

;*---------------------------------------------------------------------*/
;*    %biglook-peer-special ...                                        */
;*---------------------------------------------------------------------*/
(define (%biglook-peer-special options)
   #unspecified)


