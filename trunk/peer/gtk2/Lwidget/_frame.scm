;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_frame.scm         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Thu Jun 14 15:04:31 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Null peer Frame implementation.                              */
;*    definition: @path ../../../biglook/Lwidget/frame.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%frame
   
   (import __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%error
	   __biglook_%gtk-misc
	   __biglook_%widget
	   __biglook_%container
	   __biglook_%color)

   (extern (macro %%gtk-frame-new::gtkwidget* (::long)
		  "gtk_frame_new"))

   (static (class %frame::%container))

   (export (%make-%frame ::%bglk-object)

	   (%frame-add! ::%bglk-object ::%bglk-object)
	   
	   (%frame-title ::%bglk-object)
	   (%frame-title-set! ::%bglk-object ::bstring)
	   
	   (%frame-title-justify::symbol ::%bglk-object)
	   (%frame-title-justify-set! ::%bglk-object ::symbol)
	   
	   (%frame-shadow::symbol ::%bglk-object)
	   (%frame-shadow-set! ::%bglk-object ::symbol)))

;*---------------------------------------------------------------------*/
;*    %make-%frame ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%frame o::%bglk-object)
   (instantiate::%frame
      (%bglk-object o)
      (%builtin (gtkobject (%%gtk-frame-new 0)))))

;*---------------------------------------------------------------------*/
;*    %frame-add! ...                                                  */
;*---------------------------------------------------------------------*/
(define (%frame-add! o::%bglk-object w::%bglk-object)
   (with-access::%frame (%bglk-object-%peer o) (%gc-children)
      (set! %gc-children (cons w %gc-children))
      (%container-add! o w)))

;*---------------------------------------------------------------------*/
;*    %frame-title ...                                                 */
;*---------------------------------------------------------------------*/
(define (%frame-title o::%bglk-object)
   (g-property-get o "label"))

;*---------------------------------------------------------------------*/
;*    %frame-title-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%frame-title-set! o::%bglk-object v::bstring)
   (g-property-set! o "label" v))

;*---------------------------------------------------------------------*/
;*    %frame-title-justify ...                                         */
;*---------------------------------------------------------------------*/
(define (%frame-title-justify::symbol o::%bglk-object)
   (gtk-title-justify->biglook (g-property-get o "label-xalign")))

;*---------------------------------------------------------------------*/
;*    %frame-title-justify-set! ...                                    */
;*---------------------------------------------------------------------*/
(define (%frame-title-justify-set! o::%bglk-object v::symbol)
   (g-property-type-set! o
			 "label-xalign"
			 (biglook-title-justify->gtk v)
			 G-TYPE-FLOAT))

;*---------------------------------------------------------------------*/
;*    %frame-shadow ...                                                */
;*---------------------------------------------------------------------*/
(define (%frame-shadow::symbol o::%bglk-object)
   (gtk-shadow->biglook (g-property-get o "shadow-type")))

;*---------------------------------------------------------------------*/
;*    %frame-shadow-set! ...                                           */
;*---------------------------------------------------------------------*/
(define (%frame-shadow-set! o::%bglk-object v::symbol)
  (g-property-type-set! o "shadow-type" (biglook-shadow->gtk v) GTK-TYPE-SHADOW-TYPE))
   
