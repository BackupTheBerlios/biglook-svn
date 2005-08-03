;*=====================================================================*/
;*    swt/Llib/_font.scm                                               */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:37:39 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Font implementation.                              */
;*    definition: @path ../../../biglook/Llib/font.scm@                */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%font
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer)
   
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

	   (%biglook-font->swing::%awt-font ::%font)
	   (%swing-font->biglook::%font ::%awt-font)))

;*---------------------------------------------------------------------*/
;*    %biglook-font->swing ...                                         */
;*---------------------------------------------------------------------*/
(define (%biglook-font->swing bf::%font)
   (with-access::%font bf (family size weight slant)
      (let ((style 0))
	 (if (eq? weight 'bold)
	     (set! style (+ style %awt-font-BOLD)))
	 (if (eq? slant 'italic)
	     (set! style (+ style %awt-font-ITALIC)))
	 (%awt-font-new (%bglk-bstring->jstring family) style size))))

;*---------------------------------------------------------------------*/
;*    %swing-font->biglook ...                                         */
;*---------------------------------------------------------------------*/
(define (%swing-font->biglook af::%awt-font)
   (let ((size (%awt-font-size af))
	 (name (%awt-font-name af)))
      (instantiate::%font
	 (family (%bglk-jstring->bstring name))
	 (size size)
	 (weight (if (%awt-font-bold? af)
		     'bold
		     'medium))
	 (slant (if (%awt-font-italic? af)
		    'italic
		    'roman)))))
