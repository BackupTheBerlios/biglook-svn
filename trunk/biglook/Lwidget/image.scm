;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/image.scm           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Oct  3 14:11:45 2000                          */
;*    Last change :  Thu Nov  8 11:59:23 2001 (serrano)                */
;*    Copyright   :  2000-01 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Biglook image handling                                           */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/image.texi@                                */
;*       @node Image@                                                  */
;*    Examples:                                                        */
;*       @path ../../examples/image/image.scm@                         */
;*    -------------------------------------------------------------    */
;*    Implementation: @label image@                                    */
;*    null: @path ../../peer/null/Lwidget/_image.scm@                  */
;*    gtk: @path ../../peer/gtk/Lwidget/_image.scm@                    */
;*    swing: @path ../../peer/swing/Lwidget/_image.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_image

   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_container
	    __biglook_widget
	    __biglook_configure)
   
   (export (abstract-class image::widget
	      (width::int read-only (get %image-width))
 	      (height::int read-only (get %image-height)))

	   (class file-image::image
	      (file::bstring read-only))

	   (class data-image::image
	      (data::bstring read-only)
	      (mask::bstring read-only (default "")))

	   (image-exists?::bool ::bstring)
	   (file->image::file-image ::bstring)
	   (string->image::data-image ::bstring)
	   (delete-image ::image)
	   (generic duplicate-image ::image)
	   
	   (biglook-image-path::pair-nil)
	   (biglook-add-image-path! ::bstring)))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::file-image ...                                */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::file-image)
   (with-access::file-image o (%peer file)
      (let ((fullfile (find-file/path file (biglook-image-path))))
	 (if (or (not (string? fullfile)) (not (file-exists? fullfile)))
	     (error "instantiate ::file-image" "Can't find image file" file)
	     (begin
		(set! %peer (%make-%file-image o fullfile))
		o)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::data-image ...                                */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::data-image)
   (with-access::data-image o (%peer data mask)
      (if (eq? %peer #unspecified)
	  (set! %peer (%make-%data-image o data mask)))
      o))

;*---------------------------------------------------------------------*/
;*    image-exists? ...                                                */
;*---------------------------------------------------------------------*/
(define (image-exists? file)
   (let ((fname (find-file/path file (biglook-image-path))))
      (file-exists? fname)))

;*---------------------------------------------------------------------*/
;*    *image-path* ...                                                 */
;*---------------------------------------------------------------------*/
(define *image-path*
   (cons* ""
	  "."
	  (make-file-name (biglook-library-directory) "images")
	  (make-file-name (biglook-library-directory) "images/emacs")
	  (build-path-from-shell-variable "BIGLOOK_IMAGE_PATH")))

;*---------------------------------------------------------------------*/
;*    biglook-image-path ...                                           */
;*---------------------------------------------------------------------*/
(define (biglook-image-path)
   *image-path*)

;*---------------------------------------------------------------------*/
;*    biglook-add-image-path! ...                                      */
;*---------------------------------------------------------------------*/
(define (biglook-add-image-path! path::bstring)
   (set! *image-path* (cons path *image-path*)))

;*---------------------------------------------------------------------*/
;*    build-path-from-shell-variable ...                               */
;*---------------------------------------------------------------------*/
(define (build-path-from-shell-variable var)
   (let ((val (getenv var)))
      (if (string? val)
	  (string-case val
	     ((+ (out #\:))
	      (let* ((str (the-string))
		     (res (ignore)))
		 (cons str res)))
	     (#\:
	      (ignore))
	     (else
	      '()))
	  '())))

;*---------------------------------------------------------------------*/
;*    file->image ...                                                  */
;*---------------------------------------------------------------------*/
(define (file->image file::bstring)
   (instantiate::file-image
      (file file)))

;*---------------------------------------------------------------------*/
;*    string->image ...                                                */
;*---------------------------------------------------------------------*/
(define (string->image file::bstring)
   (instantiate::data-image
      (data file)))

;*---------------------------------------------------------------------*/
;*    delete-image ...                                                 */
;*---------------------------------------------------------------------*/
(define (delete-image o::image)
   (%delete-image o))

;*---------------------------------------------------------------------*/
;*    duplicate-image ...                                              */
;*---------------------------------------------------------------------*/
(define-generic (duplicate-image o::image))

;*---------------------------------------------------------------------*/
;*    duplicate-image ::file-image ...                                 */
;*---------------------------------------------------------------------*/
(define-method (duplicate-image o::file-image)
   (instantiate::file-image
      (%peer (%duplicate-image o))
      (file (file-image-file o))))

;*---------------------------------------------------------------------*/
;*    duplicate-image ::data-image ...                                 */
;*---------------------------------------------------------------------*/
(define-method (duplicate-image o::data-image)
   (instantiate::data-image
      (%peer (%duplicate-image o))
      (data (data-image-data o))
      (mask (data-image-mask o))))

	   
