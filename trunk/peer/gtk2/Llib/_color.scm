;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Llib/_color.scm            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Dec 15 08:10:06 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Color implementation.                              */
;*    definition: @path ../../../biglook/Llib/color.scm@               */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%color

   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object)

   (extern (macro %%gtk-color-buffer::gdouble* "gtk_color_buffer")
	   (macro %%gdk-color-buffer::gdkcolor* "&gdk_color_buffer")
	   
	   (macro sprintf-color::int (::string ::string ::int ::int ::int)
		  "sprintf")
	   
	   (macro %%gdk-color-parse::bool (::string ::gdkcolor*)
		  "gdk_color_parse")
	   
	   (macro %%gtk-color-red::int (::gdouble*)
		  "GTK_COLOR_RED")
	   (macro %%gtk-color-green::int (::gdouble*)
		  "GTK_COLOR_GREEN")
	   (macro %%gtk-color-blue::int (::gdouble*)
		  "GTK_COLOR_BLUE")
	   (macro %%gtk-color-opacity::int (::gdouble*)
		  "GTK_COLOR_OPACITY")
	   (macro %%gtk-color-buffer-red-set!::void (::int)
		  "GTK_COLOR_BUFFER_RED_SET")
	   (macro %%gtk-color-buffer-green-set!::void (::int)
		  "GTK_COLOR_BUFFER_GREEN_SET")
	   (macro %%gtk-color-buffer-blue-set!::void (::int)
		  "GTK_COLOR_BUFFER_BLUE_SET")
	   (macro %%gtk-color-buffer-opacity-set!::void (::int)
		  "GTK_COLOR_BUFFER_OPACITY_SET")
	   
	   (macro %%gdk-color-red::int (::gdkcolor*)
		  "GDK_COLOR_RED")
	   (macro %%gdk-color-green::int (::gdkcolor*)
		  "GDK_COLOR_GREEN")
	   (macro %%gdk-color-blue::int (::gdkcolor*)
		  "GDK_COLOR_BLUE")
	   (macro %%gdk-color-opacity::int (::gdkcolor*)
		  "GDK_COLOR_OPACITY")
	   (macro %%gdk-color-buffer-red-set!::void (::int)
		  "GDK_COLOR_BUFFER_RED_SET")
	   (macro %%gdk-color-buffer-green-set!::void (::int)
		  "GDK_COLOR_BUFFER_GREEN_SET")
	   (macro %%gdk-color-buffer-blue-set!::void (::int)
		  "GDK_COLOR_BUFFER_BLUE_SET")
	   (macro %%gdk-color-buffer-opacity-set!::void (::int)
		  "GDK_COLOR_BUFFER_OPACITY_SET")
	   (macro %%bglk-gdkcolor?::bool (::gdkcolor*)
		  "(int)"))
   
   (export  (abstract-class %color)
	    
	    (class %rgb-color::%color
	       (%red::int (default 0))
	       (%green::int (default 0))
	       (%blue::int (default 0))
	       (%opacity::int (default 0)))
	    
	    (class %name-color::%color
	       (%name::bstring (default "white")))
	    
	    (%color-rgb-component ::obj)
	    (generic biglook-color->gtk::gdouble* ::%color)
	    (generic biglook-color->gdk::gdkcolor* ::%color)
	    (generic biglook-color->rgb-string::string ::%color)
	    (gdk-color->biglook::%color ::gdkcolor*)
	    (rgb-string-color->biglook::%color ::string)))

;*---------------------------------------------------------------------*/
;*    %color-rgb-component ...                                         */
;*---------------------------------------------------------------------*/
(define (%color-rgb-component v::obj)
   (if (%%gdk-color-parse (%name-color-%name v) %%gdk-color-buffer)
       (values (%%gdk-color-red %%gdk-color-buffer)
	       (%%gdk-color-green %%gdk-color-buffer)
	       (%%gdk-color-blue %%gdk-color-buffer))
       (values 0 0 0)))

;*---------------------------------------------------------------------*/
;*    biglook-color->gtk ::%color ...                                  */
;*---------------------------------------------------------------------*/
(define-generic (biglook-color->gtk o::%color)
   %%gtk-color-buffer)

;*---------------------------------------------------------------------*/
;*    biglook-color->gtk ::%rgb-color ...                              */
;*---------------------------------------------------------------------*/
(define-method (biglook-color->gtk o::%rgb-color)
   (with-access::%rgb-color o (%red %green %blue %opacity)
      (%%gtk-color-buffer-red-set! %red)
      (%%gtk-color-buffer-green-set! %green)
      (%%gtk-color-buffer-blue-set! %blue)
      (%%gtk-color-buffer-opacity-set! %opacity)
      %%gtk-color-buffer))

;*---------------------------------------------------------------------*/
;*    biglook-color->gtk ::%name-color ...                             */
;*---------------------------------------------------------------------*/
(define-method (biglook-color->gtk o::%name-color)
   (if (%%gdk-color-parse (%name-color-%name o) %%gdk-color-buffer)
       (begin
	  (%%gtk-color-buffer-red-set!
	   (%%gdk-color-red %%gdk-color-buffer))
	  (%%gtk-color-buffer-green-set!
	   (%%gdk-color-green %%gdk-color-buffer))
	  (%%gtk-color-buffer-blue-set!
	   (%%gdk-color-blue %%gdk-color-buffer))
	  (%%gtk-color-buffer-opacity-set!
	   (%%gdk-color-opacity %%gdk-color-buffer))
	  %%gtk-color-buffer)
       %%gtk-color-buffer))

;*---------------------------------------------------------------------*/
;*    biglook-color->gdk ::%color ...                                  */
;*---------------------------------------------------------------------*/
(define-generic (biglook-color->gdk o::%color)
   %%gdk-color-buffer)

;*---------------------------------------------------------------------*/
;*    biglook-color->gdk ::%rgb-color ...                              */
;*---------------------------------------------------------------------*/
(define-method (biglook-color->gdk o::%rgb-color)
   (with-access::%rgb-color o (%red %green %blue %opacity)
      (%%gdk-color-buffer-red-set! %red)
      (%%gdk-color-buffer-green-set! %green)
      (%%gdk-color-buffer-blue-set! %blue)
      (%%gdk-color-buffer-opacity-set! %opacity)
      %%gdk-color-buffer))

;*---------------------------------------------------------------------*/
;*    biglook-color->gdk ::%name-color ...                             */
;*---------------------------------------------------------------------*/
(define-method (biglook-color->gdk o::%name-color)
   (if (%%gdk-color-parse (%name-color-%name o) %%gdk-color-buffer)
       (begin
	  (%%gdk-color-buffer-red-set!
	   (%%gdk-color-red %%gdk-color-buffer))
	  (%%gdk-color-buffer-green-set!
	   (%%gdk-color-green %%gdk-color-buffer))
	  (%%gdk-color-buffer-blue-set!
	   (%%gdk-color-blue %%gdk-color-buffer))
	  (%%gdk-color-buffer-opacity-set!
	   (%%gdk-color-opacity %%gdk-color-buffer))
	  %%gdk-color-buffer)
       %%gdk-color-buffer))

;*---------------------------------------------------------------------*/
;*    gdk-color->biglook ...                                           */
;*---------------------------------------------------------------------*/
(define (gdk-color->biglook::%color v::gdkcolor*)
   (instantiate::%rgb-color
      (%red (%%gdk-color-red v))
      (%green (%%gdk-color-green v))
      (%blue (%%gdk-color-blue v))
      (%opacity (%%gdk-color-opacity v))))
   
;*---------------------------------------------------------------------*/
;*    rgb->rgb-string ...                                              */
;*---------------------------------------------------------------------*/
(define (rgb->rgb-string red green blue)
   (let ((new-string (make-string 7)))
      (sprintf-color new-string "#%02x%02x%02x" red green blue)
      new-string))

;*---------------------------------------------------------------------*/
;*    biglook-color->rgb-string ::%color ...                           */
;*    -------------------------------------------------------------    */
;*    This can't a be a generic because of module initialization       */
;*    problem. We can't use classes defined in __BIGLOOK_COLOR         */
;*    because the current module only *USES* it.                       */
;*---------------------------------------------------------------------*/
(define-generic (biglook-color->rgb-string::string v::%color)
   "none")

;*---------------------------------------------------------------------*/
;*    biglook-color->rgb-string::string ::%rgb-color ...               */
;*---------------------------------------------------------------------*/
(define-method (biglook-color->rgb-string::string v::%rgb-color)
   (with-access::%rgb-color v (%red %green %blue %opacity)
      (rgb->rgb-string %red %green %blue)))

;*---------------------------------------------------------------------*/
;*    biglook-color->rgb-string::string ::%name-color ...              */
;*---------------------------------------------------------------------*/
(define-method (biglook-color->rgb-string::string v::%name-color)
   (with-access::%name-color v (%name)
      %name))

;*---------------------------------------------------------------------*/
;*    rgb-string-color->biglook ...                                    */
;*---------------------------------------------------------------------*/
(define (rgb-string-color->biglook::%color s::string)
   (define (char->num c)
      (case c
	 ((#\a) 10)
	 ((#\b) 11)
	 ((#\c) 12)
	 ((#\d) 13)
	 ((#\e) 14)
	 ((#\f) 15)
	 (else (-fx (char->integer c) (char->integer #\0)))))
   (define (string-component off)
      (+fx (*fx 16 (char->num (string-ref s off)))
	   (char->num (string-ref s (+fx off 1)))))
   (if (char=? (string-ref s 0) #\#)
       (instantiate::%rgb-color
	  (%red (string-component 1))
	  (%green (string-component 3))
	  (%blue (string-component 5)))
       (instantiate::%name-color
	  (%name s))))

