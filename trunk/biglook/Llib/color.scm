;*=====================================================================*/
;*    biglook/Llib/color.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Oct 10 16:01:38 2000                          */
;*    Last change :  Thu Oct 14 17:03:16 2004 (dciabrin)               */
;*    Copyright   :  2000-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The base class for color                                         */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/color.texi@                                */
;*       @node Color@                                                  */
;*    Examples:                                                        */
;*       @path ../../demos/notepad/notepad.scm@                        */
;*    -------------------------------------------------------------    */
;*    Implementation: @label Color@                                    */
;*    null: @path ../../peer/null/Llib/_color.scm@                     */
;*    gtk: @path ../../peer/gtk/Llib/_color.scm@                       */
;*    swing: @path ../../peer/swing/Llib/_color.scm@                   */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_color
   
   (library biglook_peer)
   
   (export  (class rgb-color::%rgb-color
	       (red::int (get (lambda (x)
				 (rgb-color-%red x)))
			 (set (lambda (x v)
				 (rgb-color-%red-set! x v))))
	       (green::int (get (lambda (x)
				   (rgb-color-%green x)))
			   (set (lambda (x v)
				   (rgb-color-%green-set! x v))))
	       (blue::int (get (lambda (x)
				  (rgb-color-%blue x)))
			  (set (lambda (x v)
				  (rgb-color-%blue-set! x v))))
	       (opacity::int (get (lambda (x)
				     (rgb-color-%opacity x)))
			     (set (lambda (x v)
				     (rgb-color-%opacity-set! x v)))))
	    (class name-color::%name-color
	       (name::bstring (get (lambda (x)
				      (name-color-%name x)))
			      (set (lambda (x v)
				      (name-color-%name-set! x v)))))

	    (color?::bool ::obj)
	    
	    (name->color ::bstring)
	    (generic color->name::bstring ::object)
	    
	    (generic make-lighter-color ::object)
	    (generic make-darker-color ::object)))

;*---------------------------------------------------------------------*/
;*    color? ...                                                       */
;*---------------------------------------------------------------------*/
(define (color? o)
   (or (rgb-color? o) (name-color? o)))

;*---------------------------------------------------------------------*/
;*    integer->string-2 ...                                            */
;*---------------------------------------------------------------------*/
(define (integer->string-2 comp)
   (if (>=fx comp 16)
       (integer->string comp 16)
       (string #\0 (string-ref "0123456789abcdef" comp))))

;*---------------------------------------------------------------------*/
;*    object-display ::rgb-color ...                                   */
;*---------------------------------------------------------------------*/
(define-method (object-display col::rgb-color . port)
   (with-output-to-port (if (pair? port)
			    (car port)
			    (current-output-port))
      (lambda ()
	 (with-access::rgb-color col (red green blue)
	    (display* "#|rgb-color [red: #x" (integer->string-2 red)
		      "] [green: #x" (integer->string-2 green)
		      "] [blue: #x" (integer->string-2 blue) "]|")))))

;*---------------------------------------------------------------------*/
;*    object-equal? ::rgb-color ...                                    */
;*---------------------------------------------------------------------*/
(define-method (object-equal? col::rgb-color obj)
   (with-access::rgb-color col (red green blue)
      (and (rgb-color? obj)
	   (=fx (rgb-color-red obj) red)
	   (=fx (rgb-color-green obj) green)
	   (=fx (rgb-color-blue obj) blue))))

;*---------------------------------------------------------------------*/
;*    name->color ...                                                  */
;*---------------------------------------------------------------------*/
(define (name->color name::bstring)
   (if (and (=fx (string-length name) 7)
	    (char=? (string-ref name 0) #\#))
       (instantiate::rgb-color
	  (red (string->integer (substring name 1 3) 16))
	  (green (string->integer (substring name 3 5) 16))
	  (blue (string->integer (substring name 5 7) 16)))
       (instantiate::name-color
	  (name name))))

;*---------------------------------------------------------------------*/
;*    color->name ...                                                  */
;*---------------------------------------------------------------------*/
(define-generic (color->name color::object))

;*---------------------------------------------------------------------*/
;*    color->name ::rgb-color ...                                      */
;*---------------------------------------------------------------------*/
(define-method (color->name color::rgb-color)
   (with-access::rgb-color color (red green blue)
      (string-append "#"
		     (integer->string-2 red)
		     (integer->string-2 green)
		     (integer->string-2 blue))))

;*---------------------------------------------------------------------*/
;*    color->name ::name-color ...                                     */
;*---------------------------------------------------------------------*/
(define-method (color->name color::name-color)
   (name-color-name color))

;*---------------------------------------------------------------------*/
;*    dotimes ...                                                      */
;*---------------------------------------------------------------------*/
(define-macro (dotimes binding . body)
   (if (list? binding)
       ;; binding is a list
       (let ((var   #f) (count #f) (result #f))
	  (case (length binding)
	     ((2)  (set! var    (car binding))
		   (set! count  (cadr binding)))
	     ((3)  (set! var    (car binding))
		   (set! count  (cadr binding))
		   (set! result (caddr binding)))
	     (else (error "dotimes" "bad binding construct" binding)))
	  `(do ((,var 0 (+ ,var 1)))
		 ((= ,var ,count) ,result)
	      ,@body))
       ;; binding is ill-formed
       (error "dotimes" "binding is not a list: " binding)))

;*---------------------------------------------------------------------*/
;*    make-rgb-lighter ...                                             */
;*---------------------------------------------------------------------*/
(define (make-rgb-lighter red green blue)
   ;; Make a lighter color: to do this, round each color component
   ;; up by 15% or 1/3 of the way to full white, whichever is greater.
   (let ((rgb (vector red green blue))
	 (light (make-vector 3)))
      (dotimes (i 3)
	       (let* ((c (vector-ref rgb i))
		      (inc1 (* c 0.15))
		      (inc2 (/ (- 255 c) 3)))
		  (set! c (+ c (max inc1 inc2)))
		  (vector-set! light i (inexact->exact (min c 255)))))
      (instantiate::rgb-color
	 (red (vector-ref light 0))
	 (green (vector-ref light 1))
	 (blue (vector-ref light 2)))))

;*---------------------------------------------------------------------*/
;*    make-lighter-color ...                                           */
;*---------------------------------------------------------------------*/
(define-generic (make-lighter-color v::object))

;*---------------------------------------------------------------------*/
;*    make-lighter-color ::rgb-color ...                               */
;*---------------------------------------------------------------------*/
(define-method (make-lighter-color v::rgb-color)
   (with-access::rgb-color v (red green blue)
      (make-rgb-lighter red green blue)))

;*---------------------------------------------------------------------*/
;*    make-lighter-color ::name-color ...                              */
;*---------------------------------------------------------------------*/
(define-method (make-lighter-color v::name-color)
   (multiple-value-bind (red green blue)
      (%color-rgb-component v)
      (make-rgb-lighter red green blue)))

;*---------------------------------------------------------------------*/
;*    make-rgb-darker ...                                              */
;*---------------------------------------------------------------------*/
(define (make-rgb-darker red green blue)
      (instantiate::rgb-color
	 (red (/fx (* 9 red) 10))
	 (green (/fx (* 9 green) 10))
	 (blue (/fx (* 9 blue) 10))))

;*---------------------------------------------------------------------*/
;*    make-darker-color ...                                            */
;*---------------------------------------------------------------------*/
(define-generic (make-darker-color v::object))

;*---------------------------------------------------------------------*/
;*    make-darker-color ::rgb-color ...                                */
;*---------------------------------------------------------------------*/
(define-method (make-darker-color v::rgb-color)
   (with-access::rgb-color v (red green blue)
      (make-rgb-darker red green blue)))

;*---------------------------------------------------------------------*/
;*    make-darker-color ::name-color ...                               */
;*---------------------------------------------------------------------*/
(define-method (make-darker-color v::name-color)
   (multiple-value-bind (red green blue)
      (%color-rgb-component v)
      (make-rgb-darker red green blue)))


	   
