;*=====================================================================*/
;*    serrano/prgm/project/biglook/games/mine/mine.scm                 */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Jun  5 05:43:15 2001                          */
;*    Last change :  Sun Jun 10 12:15:06 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    A simple implementation of the "mine" game.                      */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module mine
   (library biglook)
   (static  (class zone::button
	       (x::int read-only)
	       (y::int read-only)
	       (mine::bool (default #f))
	       (status::symbol (default 'veiled)))
	    (class indicator::gauge
	       (max::int (default 0))
	       (%unveiled::int (default 0))
	       (unveiled (get (lambda (o)
				 (indicator-%unveiled o)))
			 (set (lambda (o v)
				 (with-access::indicator o (max text value)
				    (let ((m (string-append
					      "Mines: "
					      (number->string v)
					      "/"
					      (number->string max))))
				       (set! text m)
				       (set! value
					     (inexact->exact (/ (*fx 100 v) max)))
				       (indicator-%unveiled-set! o v)))))))
	    (class field::grid
	       (zones::vector read-only)))
   (main main))

;*---------------------------------------------------------------------*/
;*    Global paramters                                                 */
;*---------------------------------------------------------------------*/
(define *columns* 15)
(define *rows* 15)

;*---------------------------------------------------------------------*/
;*    Global widgets                                                   */
;*---------------------------------------------------------------------*/
(define *indicator* #unspecified)

;*---------------------------------------------------------------------*/
;*    main ...                                                         */
;*---------------------------------------------------------------------*/
(define (main argv)
   (biglook-add-image-path! "images")
   (let* ((win (instantiate::window
		  (resizable #t)
		  (border-width 5)
		  (layout (instantiate::box
			     (padding 2)
			     (orientation 'horizontal)))
		  (title "Biglook Mine")))
	  (zones (let ((vec (make-vector *rows*)))
		    (let loop ((i 0))
		       (if (=fx i *rows*)
			   vec
			   (begin
			      (vector-set! vec i (make-vector *columns*))
			      (loop (+fx i 1)))))))
	  (grid (instantiate::field
		   (columns *columns*)
		   (rows *rows*)
		   (zones zones)
		   (row-spacing 0)
		   (column-spacing 0)
		   (parent `(,win :padding 2))))
	  (info (instantiate::box
		   (padding 10)
		   (parent win)))
	  (lbl (instantiate::label
		  (parent info)
		  (text "Remaining mines")))
	  (rem (instantiate::indicator
		  (parent info)
		  (width 50)
		  (value 0)
		  (max 10)))
	  (level (instantiate::combobox
		    (parent info)
		    (text "Beginner")
		    (items '("Beginner" "Intermediate" "Expert"))))
	  (hbox (instantiate::box
		   (orientation 'horizontal)
		   (parent `(,info :end #t))))
	  (new (instantiate::button
		  (parent `(,hbox :expand #t :fill #t))
		  (command (lambda (_)
			      (let ((level (combobox-text level)))
			      (fill-field grid
					  (cond
					     ((string=? level "Beginner")
					      1)
					     ((string=? level "Intermediate")
					      2)
					     (else
					      3))))))
		  (text "New")))
	  (quit (instantiate::button
		   (parent `(,hbox :expand #t :fill #t))
		   (text "Quit")
		   (command (lambda (_) (exit 0))))))
      (set! *indicator* rem)
      (start-game grid info)))

;*---------------------------------------------------------------------*/
;*    field-ref ...                                                    */
;*---------------------------------------------------------------------*/
(define (field-ref field x y)
   (with-access::field field (zones)
      (vector-ref (vector-ref zones y) x)))

;*---------------------------------------------------------------------*/
;*    start-game ...                                                   */
;*---------------------------------------------------------------------*/
(define (start-game field::field info::box)
   (fill-field field 1))

;*---------------------------------------------------------------------*/
;*    fill-field ...                                                   */
;*---------------------------------------------------------------------*/
(define (fill-field field::field level::int)
   ;; display the correct zone information
   (let ((mine-number (*fx (/fx (+fx *columns* *rows*) 4) (+fx 1 level))))
      (indicator-max-set! *indicator* mine-number)
      (indicator-unveiled-set! *indicator* 0)
      ;; cleanup the grid
      (container-remove-all! field)
      ;; fill the grid
      (let ((img (file->image "veil.xpm"))
	    (hld (instantiate::event-handler
		    (release (lambda (e)
				(let ((zone (event-widget e)))
				   (case (event-button e)
				      ((1)
				       ;; unveil zone
				       (unveil-zone field zone))
				      ((2)
				       ;; flag
				       (flag-zone zone)))))))))
	 (with-access::field field (columns rows)
	    (let loop ((y 0))
	       (if (=fx y rows)
		   ;; setup the zone
		   (fill-mines field mine-number)
		   (let laap ((x 0))
		      (if (=fx x columns)
			  (loop (+fx y 1))
			  (let ((i1 (duplicate-image img)))
			     (instantiate::zone
				(parent `(,field :expand #f :fill #f))
				(border-width 0)
				(relief 'none)
				(image (duplicate-image img))
				(x x)
				(y y)
				(width (image-width img))
				(height (image-height img))
				(event hld))
			     (laap (+fx x 1)))))))))))

;*---------------------------------------------------------------------*/
;*    flag-zone ...                                                    */
;*---------------------------------------------------------------------*/
(define (flag-zone zone)
   (with-access::zone zone (status)
      (case status
	 ((veiled)
	  (with-access::indicator *indicator* (unveiled)
	     (set! unveiled (+fx unveiled 1)))
	  (set! status 'flagged)
	  (zone-image-set! zone (file->image "flaged.xpm")))
	 ((flagged)
	  (with-access::indicator *indicator* (unveiled)
	     (set! unveiled (-fx unveiled 1)))
	  (set! status 'veiled)
	  (zone-image-set! zone (file->image "veil.xpm"))))))
	  
;*---------------------------------------------------------------------*/
;*    unveil-zone ...                                                  */
;*---------------------------------------------------------------------*/
(define (unveil-zone field zone)
   (with-access::zone zone (status mine)
      (if (memq status '(veiled flagged))
	  ;; we are unveilling one mine
	  (if mine
	      ;; we have lost
	      (begin
		 (unveil-all! field)
		 (zone-image-set! zone (file->image "lost.xpm")))
	      ;; we compute the number mine that are lying around
	      (let ((nb (compute-mine field zone)))
		 ;; the zone is unveil
		 (set! status 'unveiled)
		 (if (=fx nb 0)
		     (begin
			;; no mine at all
			(zone-image-set! zone (file->image "empty.xpm"))
			;; propage this info
			(around field zone unveil-zone))
		     (let ((image (string-append (number->string nb) ".xpm")))
			;; no mine at all
			(zone-image-set! zone (file->image image)))))))))

;*---------------------------------------------------------------------*/
;*    compute-mine ...                                                 */
;*---------------------------------------------------------------------*/
(define (compute-mine field zone)
   (let ((n 0))
      (around field zone (lambda (field zone)
			    (if (zone-mine zone)
				(set! n (+fx n 1)))))
      n))

;*---------------------------------------------------------------------*/
;*    around ...                                                       */
;*---------------------------------------------------------------------*/
(define (around field zone proc)
   (with-access::field field (columns rows)
      (with-access::zone zone (x y)
	 (if (and (>fx x 0) (>fx y 0))
	     (proc field (field-ref field (-fx x 1) (-fx y 1))))
	 (if (>fx x 0)
	     (proc field (field-ref field (-fx x 1) y)))
	 (if (and (>fx x 0) (<fx y (-fx rows 1)))
	     (proc field (field-ref field (-fx x 1) (+fx y 1))))
	 (if (<fx y (-fx rows 1))
	     (proc field (field-ref field x (+fx y 1))))
	 (if (and (<fx x (-fx columns 1)) (<fx y (-fx rows 1)))
	     (proc field (field-ref field (+fx x 1) (+fx y 1))))
	 (if (<fx x (-fx columns 1))
	     (proc field (field-ref field (+fx x 1) y)))
	 (if (and (<fx x (-fx columns 1)) (>fx y 0))
	     (proc field (field-ref field (+fx x 1) (-fx y 1))))
	 (if (>fx y 0)
	     (proc field (field-ref field x (-fx y 1)))))))

;*---------------------------------------------------------------------*/
;*    unveil-all! ...                                                  */
;*---------------------------------------------------------------------*/
(define (unveil-all! field)
   (with-access::field field (columns rows)
      (let loop ((y 0))
	 (if (<fx y rows)
	     (let liip ((x 0))
		(if (<fx x columns)
		    (let ((zone (field-ref field x y)))
		       (if (zone-mine zone)
			   (zone-image-set! zone
					    (file->image "images/bomb.xpm")))
		       (liip (+fx x 1)))
		    (loop (+fx y 1))))))))
	      
;*---------------------------------------------------------------------*/
;*    fill-mines ...                                                   */
;*---------------------------------------------------------------------*/
(define (fill-mines field::field mine-number::int)
   (with-access::field field (columns rows zones)
      (let loop ((i 0))
	 (if (=fx i mine-number)
	     field
	     (let liip ((x (random columns))
			(y (random rows)))

		(let ((zone (field-ref field x y)))
		   (if (zone-mine zone)
		       ;; there is already one zone
		       ;; on this zone find another one
		       (liip (random columns)
			     (random rows))
		       ;; set the zone
		       (begin
			  (zone-mine-set! zone #t)
			  (loop (+fx i 1))))))))))

;*---------------------------------------------------------------------*/
;*    container-add! ::field ...                                       */
;*---------------------------------------------------------------------*/
(define-method (container-add! c::field o::widget . options)
   (call-next-method)
   (with-access::zone o (x y)
      (with-access::field c (zones)
	 (vector-set! (vector-ref zones y) x o))))
      


