;*=====================================================================*/
;*    swt/Lwidget/_colorselector.scm                                   */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:43:35 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Null peer Colorselector implementation.                      */
;*    definition: @path ../../../biglook/Lwidget/colorselector.scm@    */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%color-selector
   
   (import __biglook_%error
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%after)
   
   (static (class %color-selector::%peer))
	   
   (export (%make-%color-selector ::%bglk-object)

	   (%color-selector-color::%color ::%bglk-object ::procedure)
	   (%color-selector-color-set! ::%bglk-object ::%color)))

;*---------------------------------------------------------------------*/
;*    %make-%color-selector ...                                        */
;*---------------------------------------------------------------------*/
(define (%make-%color-selector o)
   (instantiate::%color-selector
      (%bglk-object o)
      (%builtin (%swing-jcolorchooser-new))))

;*---------------------------------------------------------------------*/
;*    %color-selector-color ...                                        */
;*---------------------------------------------------------------------*/
(define (%color-selector-color o make-color)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (let ((col (swing-color->biglook (%swing-jcolorchooser-color %builtin))))
	 (make-color (%rgb-color-%red col)
		     (%rgb-color-%green col)
		     (%rgb-color-%blue col)
		     (%rgb-color-%opacity col)))))

;*---------------------------------------------------------------------*/
;*    %color-selector-color-set! ...                                   */
;*---------------------------------------------------------------------*/
(define (%color-selector-color-set! o v)
   (with-access::%peer (%bglk-object-%peer o) (%builtin)
      (%swing-jcolorchooser-color-set! %builtin (biglook-color->swing v))
      o))


