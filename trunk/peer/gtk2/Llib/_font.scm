;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Llib/_font.scm             */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sat Jul  7 10:07:32 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Font implementation.                                */
;*    definition: @path ../../../biglook/Llib/font.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%font
   
   (import __biglook_%error)
   
   (export (class %font
              ;; the family  (e.g. helvetica, times)
              (family::bstring
	       (default "helvetica"))
              ;; the weight (e.g. bold, medium)
              (weight::symbol
	       (default 'bold))
              ;; the slant (e.g. roman, italic, oblique)
              (slant::symbol
	       (default 'roman))
              ;; width (e.g. condensed, normal)
              (width::symbol
	       (default 'normal))
              ;; pixel size (e.g. 12)
              (size::int
	       (default 12)))
	   
	   (%xfld->biglook-font::%font ::bstring)
	   (%biglook-font->xfld ::%font)))

;*---------------------------------------------------------------------*/
;*    %xfld->biglook-font ...                                          */
;*---------------------------------------------------------------------*/
(define (%xfld->biglook-font::%font s::bstring)
   (define len (string-length s))
   (define (find-dash num)
      (let loop ((i 0)
                 (d (- num)))
         (cond
            ((=fx i len)
             (values 0 0))
            ((char=? (string-ref s i) #\-)
             (cond
                ((>fx d 0)
                 (values d i))
                ((=fx d 0)
                 (loop (+fx i 1) (+fx i 1)))
                (else
                 (loop (+fx i 1) (+fx d 1)))))
            (else
             (loop (+fx i 1) d)))))
   (define (fetch-xlfd-slot num)
      (multiple-value-bind (start stop)
         (find-dash num)
         (if (=fx stop 0)
             "*"
             (substring s start stop))))
   (instantiate::%font
      (family (fetch-xlfd-slot 1))
      (weight (string->symbol (fetch-xlfd-slot 2)))
      (slant (string->symbol (fetch-xlfd-slot 3)))
      (width (string->symbol (fetch-xlfd-slot 4)))
      (size (string->integer (fetch-xlfd-slot 7)))))
       
;*---------------------------------------------------------------------*/
;*    %biglook-font->xfld ...                                          */
;*---------------------------------------------------------------------*/
(define (%biglook-font->xfld f::%font)
   (define (slant->xlfd slant)
      (case slant
         ((*)
          "*-")
         ((roman)
          "r-")
         ((italic)
          "i-")
         ((oblique)
          "o-")
         (else
          (error "biglook-font->xfld" "Illegal slant" slant))))
   (with-access::%font f (family weight slant width size)
      (string-append "-*-"
                     family "-"
                     (symbol->string weight) "-"
                     (slant->xlfd slant)
                     (symbol->string width) "--"
                     (if (integer? size) (integer->string size) "*")
                     "-*-*-*-*-*-*-*")))
