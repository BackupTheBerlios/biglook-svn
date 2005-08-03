;*=====================================================================*/
;*    swt/Lwidget/_fileselector.scm                                    */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:43:24 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Fileselector implementation.                      */
;*    definition: @path ../../../biglook/Lwidget/fileselector.scm@     */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%file-selector
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer
	   __biglook_%after
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%event)
   
   (static (class %file-selector::%peer
	      (%ok-command (default #f))
	      (%cancel-command (default #f))))
	   
   (export (%make-%file-selector ::%bglk-object ::bstring)

	   (%file-selector-file::bstring ::%bglk-object)
	   (%file-selector-file-set! ::%bglk-object ::bstring)

	   (%file-selector-path::bstring ::%bglk-object)
	   (%file-selector-path-set! ::%bglk-object ::bstring)
	   
	   (%file-selector-ok-command ::%bglk-object)
	   (%file-selector-ok-command-set! ::%bglk-object ::procedure)
	   
	   (%file-selector-cancel-command ::%bglk-object)
	   (%file-selector-cancel-command-set! ::%bglk-object ::procedure)))

;*---------------------------------------------------------------------*/
;*    %make-%file-selector ...                                         */
;*---------------------------------------------------------------------*/
(define (%make-%file-selector o title)
   (let ((chooser (%swing-jfilechooser-new))
	 (str::%jstring (%bglk-bstring->jstring title)))
      (%swing-jfilechooser-title-set! chooser str)
      (%idle (lambda () (%bglk-show-filechooser chooser str)))
      (instantiate::%file-selector
	 (%bglk-object o)
	 (%builtin chooser))))

;*---------------------------------------------------------------------*/
;*    %file-selector-file ...                                          */
;*---------------------------------------------------------------------*/
(define (%file-selector-file o)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%bglk-jstring->bstring
       (%jfile-name (%swing-jfilechooser-file %builtin)))))

;*---------------------------------------------------------------------*/
;*    %file-selector-file-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%file-selector-file-set! o v)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%swing-jfilechooser-file-set! %builtin
				     (%jfile-new (%bglk-bstring->jstring v)))
      o))

;*---------------------------------------------------------------------*/
;*    %file-selector-path ...                                          */
;*---------------------------------------------------------------------*/
(define (%file-selector-path o)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%bglk-jstring->bstring
       (%jfile-name (%swing-jfilechooser-path %builtin)))))

;*---------------------------------------------------------------------*/
;*    %file-selector-path-set! ...                                     */
;*---------------------------------------------------------------------*/
(define (%file-selector-path-set! o v)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%swing-jfilechooser-path-set! %builtin
				     (%jfile-new (%bglk-bstring->jstring v)))
      o))

;*---------------------------------------------------------------------*/
;*    %file-selector-ok-command ...                                    */
;*---------------------------------------------------------------------*/
(define (%file-selector-ok-command o)
   (with-access::%file-selector (%bglk-object-%peer o) (%ok-command)
      %ok-command))

;*---------------------------------------------------------------------*/
;*    %file-selector-ok-command-set! ...                               */
;*---------------------------------------------------------------------*/
(define (%file-selector-ok-command-set! o v)
   (with-access::%file-selector (%bglk-object-%peer o) (%ok-command %builtin)
      (let* ((wrapper (lambda (event _)
			 (wrap-event-descriptor event o)))
	     (str (%bglk-bstring->jstring "ApproveSelection")))
	 (%bglk-actionadapter-add! %builtin v wrapper str)
	 ;; store the callback
	 (set! %ok-command v))))

;*---------------------------------------------------------------------*/
;*    %file-selector-cancel-command ...                                */
;*---------------------------------------------------------------------*/
(define (%file-selector-cancel-command o)
   (with-access::%file-selector (%bglk-object-%peer o) (%cancel-command)
      %cancel-command))

;*---------------------------------------------------------------------*/
;*    %file-selector-cancel-command-set! ...                           */
;*---------------------------------------------------------------------*/
(define (%file-selector-cancel-command-set! o v)
   (with-access::%file-selector (%bglk-object-%peer o) (%cancel-command %builtin)
      (let* ((wrapper (lambda (event _)
			 (wrap-event-descriptor event o)))
	     (str (%bglk-bstring->jstring "CancelSelection")))
	 (%bglk-actionadapter-add! %builtin v wrapper str)
	 ;; store the callback
	 (set! %cancel-command v))))
