;*=====================================================================*/
;*    swing/Lwidget/_text.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Damien Ciabrini                                   */
;*    Creation    :  Wed Nov  5 11:57:38 2003                          */
;*    Last change :  Tue Mar 23 09:09:57 2004 (dciabrin)               */
;*    Copyright   :  2003-04 Damien Ciabrini, see LICENCE file         */
;*    -------------------------------------------------------------    */
;*    The Jvm peer Text implementation.                                */
;*    definition: @path ../../../biglook/Lwidget/window.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%text
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%gtk-misc
	   __biglook_%color
	   __biglook_%font
	   __biglook_%error)

   (static (class %text::%widget))

   (extern (macro %%gtk-text-view-new::gtkwidget* ()
		  "gtk_text_view_new")
	   (macro %%gtk-text-view-get-buffer::gtktextbuffer* (::gtktextview*)
		  "gtk_text_view_get_buffer")
	   (macro %%gtk-text-view-get-editable::bool (::gtktextview*)
		  "gtk_text_view_get_editable")
	   (macro %%gtk-text-view-set-editable::void (::gtktextview* ::bool)
		  "gtk_text_view_set_editable")

	   (macro %%gtk-text-buffer-set-text::void (::gtktextbuffer* ::string ::int)
		  "gtk_text_buffer_set_text")
	   (macro %%gtk-text-buffer-place-cursor::void (::gtktextbuffer* ::gtktextiter*)
		  "gtk_text_buffer_place_cursor")
	   (macro %%gtk-text-buffer-insert-at-cursor::void (::gtktextbuffer* ::string ::int)
		  "gtk_text_buffer_insert_at_cursor")

	   (macro %bglk-gtk-text-buffer-get-text::string (::gtktextbuffer*)
		  "bglk_gtk_text_buffer_get_text")
	   (macro %bglk-gtk-get-iter-at-location::gtktextiter* (::gtktextview* ::int ::int)
		  "bglk_gtk_get_iter_at_location")
	   (macro %bglk-gtk-get-iter-at-cursor::gtktextiter* (::gtktextbuffer*)
		  "bglk_gtk_get_iter_at_cursor")
	   (macro %bglk-gtk-get-iter-at-offset::gtktextiter* (::gtktextbuffer* ::int)
		  "bglk_gtk_get_iter_at_offset")

	   (macro %%gtk-text-iter-get-offset::int (::gtktextiter*)
		  "gtk_text_iter_get_offset")
	   (macro %%gtk-text-iter-get-line::int (::gtktextiter*)
		  "gtk_text_iter_get_line")
	   (macro %%gtk-text-iter-get-line-offset::int (::gtktextiter*)
		  "gtk_text_iter_get_line_offset")
)


   (export (%make-%text ::%bglk-object)

	   (%text-background ::%bglk-object)
	   (%text-background-set! ::%bglk-object ::%rgb-color)

	   (%text-text::bstring ::%bglk-object)
	   (%text-text-set! ::%bglk-object ::bstring)

	   (%text-font ::%bglk-object)
	   (%text-font-set! ::%bglk-object ::%font)

	   (%text-editable?::bool ::%bglk-object)
	   (%text-editable?-set! ::%bglk-object ::bool)

	   (%text-caret-pos::int ::%bglk-object)
	   (%text-caret-pos-set! ::%bglk-object ::int)

	   (%text-pixels-coords->caret-location::int ::%bglk-object ::pair)
	   (%text-caret->line/column::pair ::%bglk-object ::int)

	   (%text-insert-string ::%bglk-object ::bstring)
	   (%text-put-props! ::%bglk-object ::int ::int ::pair-nil)
	   ))


(define (%make-%text o::%bglk-object)
   (let ((text (instantiate::%text
		  (%builtin (gtkobject (%%gtk-text-view-new)))
		  (%bglk-object o))))
      text))

(define (%text-background o::%bglk-object)
   #f)

(define (%text-background-set! o::%bglk-object col::%rgb-color)
      o)

(define (%text-font o::%bglk-object)
   #f)

(define (%text-font-set! o::%bglk-object f::%font)
  (with-access::%peer (%bglk-object-%peer o) (%builtin)
    (with-access::%font f (family weight slant width size)
       (let ((font (%%pango-font (string-append  family " "
						 (symbol->string weight) " "
						 (symbol->string slant) " "
						 (symbol->string width) " " 
						 (if (integer? size) (integer->string size))))))
	 (%%gtk-widget-modify-font! (gtkwidget %builtin) font)
	 o))))

(define (%text-text::bstring o::%bglk-object)
  (with-access::%peer (%bglk-object-%peer o) (%builtin)
     (%bglk-gtk-text-buffer-get-text (%%gtk-text-view-get-buffer (gtktextview %builtin)))))
      

(define (%text-text-set! o::%bglk-object s::bstring)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-text-buffer-set-text (%%gtk-text-view-get-buffer (gtktextview %builtin)) s -1)
      o))

(define (%text-editable?::bool o::%bglk-object)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-text-view-get-editable (gtktextview %builtin))))
 
(define (%text-editable?-set! o::%bglk-object b::bool)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%%gtk-text-view-set-editable (gtktextview %builtin) b))
   #unspecified)

(define (%text-pixels-coords->caret-location::int o::%bglk-object
						  coords::pair)
  (with-access::%peer (%bglk-object-%peer o) (%builtin)
     (let ((iter (%bglk-gtk-get-iter-at-location (gtktextview %builtin)
							   (car coords)
							   (cdr coords))))
       (%%gtk-text-iter-get-offset iter))))

(define (%text-caret->line/column::pair o::%bglk-object caret::int)
  (with-access::%peer (%bglk-object-%peer o) (%builtin)
     (let* ((buffer (%%gtk-text-view-get-buffer (gtktextview %builtin)))
	    (iter (%bglk-gtk-get-iter-at-cursor buffer)))
       (cons (%%gtk-text-iter-get-line iter)
	     (%%gtk-text-iter-get-line-offset iter)))))


(define (%text-caret-pos::int o::%bglk-object)
  (with-access::%peer (%bglk-object-%peer o) (%builtin)
     (let* ((buffer (%%gtk-text-view-get-buffer (gtktextview %builtin)))
	    (iter (%bglk-gtk-get-iter-at-cursor buffer)))
       (%%gtk-text-iter-get-offset iter))))


(define (%text-caret-pos-set! o::%bglk-object pos::int)
  (with-access::%peer (%bglk-object-%peer o) (%builtin)
     (let* ((buffer (%%gtk-text-view-get-buffer (gtktextview %builtin)))
	    (iter (%bglk-gtk-get-iter-at-offset buffer pos)))
     (%%gtk-text-buffer-place-cursor buffer iter)))
  #unspecified)

(define (%text-insert-string o::%bglk-object str::bstring)
  (with-access::%peer (%bglk-object-%peer o) (%builtin)
     (%%gtk-text-buffer-insert-at-cursor (%%gtk-text-view-get-buffer (gtktextview %builtin)) str -1))
  #unspecified)


(define (%text-put-props! o::%bglk-object start::int end::int props::pair-nil)
   (let* ((builtin (%peer-%builtin (%bglk-object-%peer o))))
      (not-implemented o "%text-put-props!")))
