;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/swing/Llib/_color.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Sun Dec 15 08:10:51 2002 (serrano)                */
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
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%peer)
   
   (export  (abstract-class %color)
	    
	    (class %rgb-color::%color
	       (%red::int (default 0))
	       (%green::int (default 0))
	       (%blue::int (default 0))
	       (%opacity::int (default 0)))
	    
	    (class %name-color::%color
	       (%name::bstring (default "white")))
	    
	    (%color-rgb-component ::obj)

	    (generic biglook-color->swing::%awt-color ::%color)
	    (swing-color->biglook::%color ::%awt-color)))

;*---------------------------------------------------------------------*/
;*    %color-rgb-component ...                                         */
;*---------------------------------------------------------------------*/
(define (%color-rgb-component v::obj)
   (if (not (%name-color v))
       (values 0 0 0)
       (let ((rc (swing-color->biglook (biglook-color->swing v))))
	  (with-access::%rgb-color rc (%red %green %blue)
	     (values %red %green %blue)))))

;*---------------------------------------------------------------------*/
;*    biglook-color->swing ::%awt-color ...                            */
;*---------------------------------------------------------------------*/
(define-generic (biglook-color->swing::%awt-color o::%color)
   %awt-color-BLACK)

;*---------------------------------------------------------------------*/
;*    biglook-color->swing::%awt-color ::%rgb-color ...                */
;*---------------------------------------------------------------------*/
(define-method (biglook-color->swing::%awt-color o::%rgb-color)
   (with-access::%rgb-color o (%red %green %blue %opacity)
      (%awt-color-new %red %green %blue (-fx #xff %opacity))))

;*---------------------------------------------------------------------*/
;*    biglook-color->swing::%awt-color ::%name-color ...               */
;*---------------------------------------------------------------------*/
(define-method (biglook-color->swing::%awt-color o::%name-color)
   (with-access::%name-color o (%name)
      (%awt-color-find (%bglk-bstring->jstring %name) %awt-color-BLACK)))

;*---------------------------------------------------------------------*/
;*    swing-color->biglook ...                                         */
;*---------------------------------------------------------------------*/
(define (swing-color->biglook::%color v::%awt-color)
   (instantiate::%rgb-color
      (%red (%awt-color-red v))
      (%green (%awt-color-green v))
      (%blue (%awt-color-blue v))
      (%opacity (-fx #xff (%awt-color-alpha v)))))
