;*=====================================================================*/
;*    swt/Lwidget/_image.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:39:15 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Image implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/image.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%image
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%xpm)
   
   (export (class %image::%peer
	      (%icon::%swing-imageicon read-only))

	   (%make-%file-image ::%bglk-object ::bstring)
	   (%make-%data-image ::%bglk-object ::bstring ::bstring)
	   (%duplicate-image ::%bglk-object)

	   (%image-width::int ::%bglk-object)
	   (%image-height::int ::%bglk-object)

	   (%delete-image ::%bglk-object)))

;*---------------------------------------------------------------------*/
;*    %peer-init ::%image ...                                          */
;*---------------------------------------------------------------------*/
(define-method (%peer-init o::%image)
   #unspecified)

;*---------------------------------------------------------------------*/
;*    %make-%file-image ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%file-image o::%bglk-object filename::bstring)
   (let* ((image::%awt-image (if (string=? (suffix filename) "xpm")
				 (let* ((port (open-input-file filename))
					(xpm (make-xpm-image port))
					(res (%awt-toolkit-create-image
					      (%awt-toolkit-default)
					      xpm)))
				    (close-input-port port)
				    res)
				 (%awt-toolkit-create-file-image
				  (%awt-toolkit-default)
				  (%bglk-bstring->jstring filename))))
	  (image-icon::%swing-imageicon (%swing-imageicon-new/image image))
	  (lbl::%swing-jlabel (%swing-jlabel-new/icon image-icon)))
      (instantiate::%image
	 (%bglk-object o)
	 (%icon image-icon)
	 (%builtin lbl))))

;*---------------------------------------------------------------------*/
;*    %make-%data-image ...                                            */
;*---------------------------------------------------------------------*/
(define (%make-%data-image o::%bglk-object data::bstring mask::bstring)
   (let* ((image::%awt-image (if (substring=? data "/* XPM */" 8)
				 (let* ((port (open-input-string data))
					(xpm (make-xpm-image port))
					(res (%awt-toolkit-create-image
					      (%awt-toolkit-default)
					      xpm)))
				    (close-input-port port)
				    res)
				 (%awt-toolkit-create-data-image
				  (%awt-toolkit-default)
				  data)))
	  (image-icon::%swing-imageicon (%swing-imageicon-new/image image))
	  (lbl::%swing-jlabel (%swing-jlabel-new/icon image-icon)))
      (instantiate::%image
	 (%bglk-object o)
	 (%icon image-icon)
	 (%builtin lbl))))

;*---------------------------------------------------------------------*/
;*    %duplicate-image ...                                             */
;*---------------------------------------------------------------------*/
(define (%duplicate-image o::%bglk-object)
   (with-access::%image (%bglk-object-%peer o) (%icon)
      (let ((lbl::%swing-jlabel (%swing-jlabel-new/icon %icon)))
	 (instantiate::%image
	    (%bglk-object o)
	    (%icon %icon)
	    (%builtin lbl)))))

;*---------------------------------------------------------------------*/
;*    %image-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%image-width::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%swing-imageicon-width (%image-%icon %peer))))

;*---------------------------------------------------------------------*/
;*    %image-height ...                                                */
;*---------------------------------------------------------------------*/
(define (%image-height::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%swing-imageicon-height (%image-%icon %peer))))

;*---------------------------------------------------------------------*/
;*    %delete-image ...                                                */
;*---------------------------------------------------------------------*/
(define (%delete-image o::%bglk-object)
   #unspecified)
