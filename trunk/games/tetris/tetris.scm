;*=====================================================================*/
;*    serrano/prgm/project/biglook/games/tetris/tetris.scm             */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Tue Jun  5 05:43:15 2001                          */
;*    Last change :  Thu Sep 19 11:51:48 2002 (serrano)                */
;*    Copyright   :  2001-02 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    A simple implementation of the "tetris" game.                    */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module mine
   (library biglook)
   (static (class block-image::canvas-image
	      (ax (get (lambda (o)
			  (with-access::block-image o (x)
			     (/fx x *tetris-square-size*))))
		  (set (lambda (o v)
			  (with-access::block-image o (x)
			     (set! x (*fx v *tetris-square-size*))))))
	      (ay (get (lambda (o)
			  (with-access::block-image o (y)
			     (/fx y *tetris-square-size*))))
		  (set (lambda (o v)
			  (with-access::block-image o (y)
			     (set! y (*fx v *tetris-square-size*)))))))
	   (class shape
	      (x::int (default 0))
	      (y::int (default 0))
	      (rotation::int (default 0))
	      (number::int read-only)
	      blocks::pair)
	   (class black-canvas::canvas)
	   (class game::black-canvas
	      (cells::vector read-only)))
   (main main))

;*---------------------------------------------------------------------*/
;*    Global parameters                                                */
;*---------------------------------------------------------------------*/
;; the dimension of the game (measured in block square)
(define *tetris-width* 11)
(define *tetris-height* 20)

;; the dimension of the square
(define *tetris-square-size* 16)

;; All shapes and their rotations
(define *shapes*
   '#(#(#(#(X X _ _) #(X X _ _) #(X X _ _) #(X X _ _))
	#(#(X X _ _) #(X X _ _) #(X X _ _) #(X X _ _))
	#(#(_ _ _ _) #(_ _ _ _) #(_ _ _ _) #(_ _ _ _))
	#(#(_ _ _ _) #(_ _ _ _) #(_ _ _ _) #(_ _ _ _)))
      
      #(#(#(X X X _) #(_ X _ _) #(X _ _ _) #(X X _ _))
	#(#(_ _ X _) #(_ X _ _) #(X X X _) #(X _ _ _))
	#(#(_ _ _ _) #(X X _ _) #(_ _ _ _) #(X _ _ _))
	#(#(_ _ _ _) #(_ _ _ _) #(_ _ _ _) #(_ _ _ _)))
      
      #(#(#(X X X _) #(X X _ _) #(_ _ X _) #(X _ _ _))
	#(#(X _ _ _) #(_ X _ _) #(X X X _) #(X _ _ _))
	#(#(_ _ _ _) #(_ X _ _) #(_ _ _ _) #(X X _ _))
	#(#(_ _ _ _) #(_ _ _ _) #(_ _ _ _) #(_ _ _ _)))
      
      #(#(#(X X _ _) #(_ X _ _) #(X X _ _) #(_ X _ _))
	#(#(_ X X _) #(X X _ _) #(_ X X _) #(X X _ _))
	#(#(_ _ _ _) #(X _ _ _) #(_ _ _ _) #(X _ _ _))
	#(#(_ _ _ _) #(_ _ _ _) #(_ _ _ _) #(_ _ _ _)))
      
      #(#(#(_ X X _) #(X _ _ _) #(_ X X _) #(X _ _ _))
	#(#(X X _ _) #(X X _ _) #(X X _ _) #(X X _ _))
	#(#(_ _ _ _) #(_ X _ _) #(_ _ _ _) #(_ X _ _))
	#(#(_ _ _ _) #(_ _ _ _) #(_ _ _ _) #(_ _ _ _)))
      
      #(#(#(_ X _ _) #(X _ _ _) #(X X X _) #(_ X _ _))
	#(#(X X X _) #(X X _ _) #(_ X _ _) #(X X _ _))
	#(#(_ _ _ _) #(X _ _ _) #(_ _ _ _) #(_ X _ _))
	#(#(_ _ _ _) #(_ _ _ _) #(_ _ _ _) #(_ _ _ _)))
      
      #(#(#(X X X X) #(X _ _ _) #(X X X X) #(X _ _ _))
	#(#(_ _ _ _) #(X _ _ _) #(_ _ _ _) #(X _ _ _))
	#(#(_ _ _ _) #(X _ _ _) #(_ _ _ _) #(X _ _ _))
	#(#(_ _ _ _) #(X _ _ _) #(_ _ _ _) #(X _ _ _)))))

;; All shapes width
(define *shapes-width*
   '#(#(2 2 2 2)
      #(3 2 3 2)
      #(3 2 3 2)
      #(3 2 3 2)
      #(3 2 3 2)
      #(3 2 3 2)
      #(4 1 4 1)))
      
;; Shapes color
(define *shapes-color*
   (vector (instantiate::rgb-color (blue 255))
	   (instantiate::rgb-color (red 178) (blue 255))
	   (instantiate::rgb-color (red 255) (green 255))
	   (instantiate::rgb-color (red 255) (blue 255))
	   (instantiate::rgb-color (green 255) (blue 255))
	   (instantiate::rgb-color (green 255))
	   (instantiate::rgb-color (red 255))))

;; Border color
(define *border-color*
   (instantiate::rgb-color (red 127) (green 127) (blue 127)))

;; Refresh interval
(define *timeout* 20)

;; Scoring
(define *speed* 10)
(define *rows-removed* 0)

(define *rows-widget* #unspecified)
(define *speed-widget* #unspecified)
(define *level-widget* #unspecified)

;; Timeout control
(define *lost* #f)
(define *abort* #f)

;*---------------------------------------------------------------------*/
;*    make-square-image ...                                            */
;*---------------------------------------------------------------------*/
(define (make-square-image color::rgb-color)
   (define (integer->2chars int)
      (if (=fx int 0)
	  "00"
	  (let ((s (integer->string int 16)))
	     (if (=fx (string-length s) 1)
		 (string-append "0" s)
		 s))))
   (define (rgb-color->string color)
      (with-access::rgb-color color (red green blue)
	 (string-append "#"
			(integer->2chars red) 
			(integer->2chars green) 
			(integer->2chars blue) )))
   (let ((col1 (rgb-color->string (make-darker-color color)))
	 (col2 (rgb-color->string color))
	 (col3 (rgb-color->string (make-lighter-color color)))
	 (ssize (integer->string *tetris-square-size*)))
      (string-append "/* XPM */
static char *noname[] = {
/* width height ncolors chars_per_pixel */
\"" ssize " " ssize " 3 1\",
/* colors */
\"+ c " col1 "\",
\". c " col2 "\",
\"- c " col3 "\",
/* pixels */
\"---------------+\",
\"--------------++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"--............++\",
\"-+++++++++++++++\",
\"++++++++++++++++\"
};")))

;*---------------------------------------------------------------------*/
;*    create-game ...                                                  */
;*    -------------------------------------------------------------    */
;*    The display is composed of a simple canvas.                      */
;*---------------------------------------------------------------------*/
(define (create-game parent::container)
   (let ((vec (let ((vec (make-vector *tetris-height*)))
		 (let loop ((i 0))
		    (if (<fx i *tetris-height*)
			(begin
			   (vector-set! vec i (make-vector *tetris-width* #f))
			   (loop (+fx i 1)))
			vec)))))
      (instantiate::game
	 (parent parent)
	 (width (*fx *tetris-square-size* *tetris-width*))
	 (height (*fx *tetris-square-size* *tetris-height*))
	 (cells vec))))

;*---------------------------------------------------------------------*/
;*    setup-game! ...                                                  */
;*---------------------------------------------------------------------*/
(define (setup-game! canvas score)
   ;; remove everything that is currently displayed in the canvas
   (for-each destroy (canvas-children canvas))
   ;; remove everything that is currently displayed in the score canvas
   (for-each destroy (canvas-children score))
   ;; initialize the score
   (set! *rows-removed* 0)
   (let ((level (combobox-text *level-widget*)))
      (cond
	 ((string=? level "Beginner")
	  (set! *speed* 10))
	 ((string=? level "Intermediate")
	  (set! *speed* 9))
	 ((string=? level "Expert")
	  (set! *speed* 8))))
   (set-score! *rows-removed* *speed*)
   ;; initialize the cells vectors
   (with-access::game canvas (cells)
      (let loop ((i 0))
	 (if (<fx i *tetris-height*)
	     (let ((vec (vector-ref cells i)))
		(let liip ((j 0))
		   (if (<fx j *tetris-width*)
		       (begin
			  (vector-set! vec j #f)
			  (liip (+fx j 1)))
		       (loop (+fx i 1))))))))
   ;; draw the limit of the game
   (let ((square (string->image (make-square-image *border-color*))))
      ;; once the canvas is built, fill it with the surronding images
      (let loop ((y 0))
	 (if (<fx y *tetris-height*)
	     (begin
		(instantiate::block-image
		   (canvas canvas)
		   (image (duplicate-image square))
		   (ax 0)
		   (ay y))
		(instantiate::block-image
		   (canvas canvas)
		   (image (duplicate-image square))
		   (ax (-fx *tetris-width* 1))
		   (ay y))
		(loop (+fx y 1)))
	     (let loop ((x 1))
		(if (<fx x (-fx *tetris-width* 1))
		    (begin
		       (instantiate::block-image
			  (canvas canvas)
			  (image (duplicate-image square))
			  (ax x)
			  (ay (-fx *tetris-height* 1)))
		       (loop (+fx x 1))))))))
   canvas)

;*---------------------------------------------------------------------*/
;*    make-score-display ...                                           */
;*---------------------------------------------------------------------*/
(define (make-score-display parent::container)
   (let* ((box (instantiate::box
		  (parent parent)
		  (padding 2)))
	  (next (instantiate::label
		   (parent box)
		   (text "Next shape")))
	  (border (instantiate::frame
		     (parent box)
		     (shadow 'in)))
	  (canv (instantiate::black-canvas
		   (parent border)
		   (width 150)
		   (height 80)))
	  (level (instantiate::combobox
		    (parent `(,box :padding 20))
		    (text "Beginner")
		    (can-focus #f)
		    (items '("Beginner" "Intermediate" "Expert"))))
	  (speed (instantiate::label
		    (parent box)
		    (text "Speed: 0")))
	  (rows (instantiate::label
		   (parent box)
		   (text "Rows: 0")))
	  (hbox (instantiate::box
		   (orientation 'horizontal)
		   (parent `(,box :end #t))))
	  (new (instantiate::button
		  (parent `(,hbox :expand #t :fill #t))
		  (can-focus #f)
		  (command (lambda (_)
			      (set! *lost* #f)
			      (set! *abort* #t)))
		  (text "New")))
	  (quit (instantiate::button
		   (parent `(,hbox :expand #t :fill #t))
		   (text "Quit")
		   (can-focus #f)
		   (command (lambda (_) (exit 0))))))
      (set! *rows-widget* rows)
      (set! *speed-widget* speed)
      (set! *level-widget* level)
      canv))

;*---------------------------------------------------------------------*/
;*    new-shape ...                                                    */
;*    -------------------------------------------------------------    */
;*    Create a new shape, that is, select randomly a shape,            */
;*    allocates an instance, prepare the instance images and           */
;*    rotation, set the position of the shape.                         */
;*---------------------------------------------------------------------*/
(define (new-shape canvas num)
   (let* ((img (make-square-image (vector-ref *shapes-color* num)))
	  (blocks (list (instantiate::block-image
			   (canvas canvas)
			   (image (string->image img)))
			(instantiate::block-image
			   (canvas canvas)
			   (image (string->image img)))
			(instantiate::block-image
			   (canvas canvas)
			   (image (string->image img)))
			(instantiate::block-image
			   (canvas canvas)
			   (image (string->image img))))))
      (instantiate::shape
	 (x (/fx *tetris-width* 2))
	 (y 0)
	 (blocks blocks)
	 (number num))))

;*---------------------------------------------------------------------*/
;*    set-score! ...                                                   */
;*---------------------------------------------------------------------*/
(define (set-score! rows speed)
   (set! *rows-removed* rows)
   (set! *speed* speed)
   (with-access::label *rows-widget* (text)
      (set! text (string-append "Rows: " (integer->string rows))))
   (with-access::label *speed-widget* (text)
      (set! text (string-append "Speed: " (integer->string (-fx 11 speed))))))

;*---------------------------------------------------------------------*/
;*    display-shape ...                                                */
;*---------------------------------------------------------------------*/
(define (display-shape shape::shape x y)
   (with-access::shape shape (rotation blocks number)
      (let ((rotations (vector-ref *shapes* number)))
	 (let loop ((dy 0)
		    (blocks blocks))
	    (if (pair? blocks)
		(let* ((line (vector-ref rotations dy))
		       (rline (vector-ref line rotation)))
		   (let liip ((dx 0)
			      (blocks blocks))
		      (if (and (pair? blocks) (<fx dx 4))
			  (begin
			     (if (eq? (vector-ref rline dx) 'X)
				 (with-access::block-image (car blocks) (ax ay)
				    (set! ax (+fx x dx))
				    (set! ay (+fx y dy))
				    (liip (+fx dx 1)
					  (cdr blocks)))
				 (liip (+fx dx 1)
				       blocks)))
			  (loop (+fx dy 1)
				blocks)))))))))

;*---------------------------------------------------------------------*/
;*    horizontal-move-shape ...                                        */
;*---------------------------------------------------------------------*/
(define (horizontal-move-shape shape game dx)
   (with-access::shape shape (x y number rotation)
      (if (shape-fits? shape game (+fx x dx) y)
	  (set! x (+fx x dx)))))

;*---------------------------------------------------------------------*/
;*    rotate-shape ...                                                 */
;*---------------------------------------------------------------------*/
(define (rotate-shape shape game dr)
   (with-access::shape shape (x y number rotation)
      (let* ((r (cond
		   ((=fx dr -1)
		    (if (=fx rotation 0)
			3
			(-fx rotation 1)))
		   ((=fx dr 1)
		    (if (=fx rotation 3)
			0
			(+fx rotation 1)))))
	     (o rotation))
	 (set! rotation r)
	 (if (not (shape-fits? shape game x y))
	     (set! rotation o)))))

;*---------------------------------------------------------------------*/
;*    drop-shape ...                                                   */
;*---------------------------------------------------------------------*/
(define (drop-shape shape game)
   (with-access::shape shape (x y)
      (let loop ((ny (+fx y 1)))
	 (if (shape-fits? shape game x ny)
	     (loop (+fx ny 1))
	     (set! y (-fx ny 1))))))

;*---------------------------------------------------------------------*/
;*    shape-fits? ...                                                  */
;*    -------------------------------------------------------------    */
;*    This predicate returns #t iff it is possible to fell down        */
;*    one more step for this shape.                                    */
;*    -------------------------------------------------------------    */
;*    This answer is #t iff all the "below" position are free.         */
;*---------------------------------------------------------------------*/
(define (shape-fits? shape game x y)
   (with-access::shape shape (rotation blocks number)
      (let ((w (vector-ref (vector-ref *shapes-width* number) rotation)))
	 (and (>fx x 0)
	      (<fx x (-fx *tetris-width* w))
	      (let ((rotations (vector-ref *shapes* number))
		    (cells (game-cells game)))
		 (let loop ((dy 0)
			    (blocks blocks))
		    (cond
		       ((null? blocks)
			#t)
		       ((>=fx (+fx y dy) (-fx *tetris-height* 1))
			#f)
		       (else
			(let* ((line (vector-ref rotations dy))
			       (rline (vector-ref line rotation)))
			   (let liip ((dx 0)
				      (blocks blocks))
			      (if (and (pair? blocks) (<fx dx 4))
				  (if (eq? (vector-ref rline dx) 'X)
				      ;; we have to check if (DX, DY+1)
				      ;; is free
				      (let ((x (+fx x dx))
					    (y (+fx y dy)))
					 (if (not (vector-ref (vector-ref cells y) x))
					     (liip (+fx dx 1) (cdr blocks))
					     #f))
				      (liip (+fx dx 1) blocks))
				  (loop (+fx dy 1) blocks))))))))))))

;*---------------------------------------------------------------------*/
;*    remove-completed-lines! ...                                      */
;*---------------------------------------------------------------------*/
(define (remove-completed-lines! game)
   (with-access::game game (cells)
      (define (remove-line! lnum)
	 ;; increment the score
	 (set-score! (+fx 1 *rows-removed*)
		     (if (and (>fx *speed* 0)
			      (=fx (remainder (+fx 1 *rows-removed*) 15) 0))
			 (-fx *speed* 1)
			 *speed*))
	 ;; column by column, remove the current blocks and translate
	 ;; all the ones that are on top
	 (let loop ((x 1))
	    (if (<fx x (-fx *tetris-width* 1))
		(begin
		   (destroy (vector-ref (vector-ref cells lnum) x))
		   (let liip ((y lnum))
		      (if (>fx y 0)
			  (let* ((y1 (-fx y 1))
				 (t (vector-ref (vector-ref cells y1) x)))
			     (vector-set! (vector-ref cells y) x t)
			     (if (widget? t)
				 (with-access::block-image t (ay)
				    (set! ay (+fx ay 1))
				    (vector-set! (vector-ref cells y1) x #f)))
			     (liip (-fx y 1)))
			  (loop (+fx x 1))))))))
      (define (line-completed? lnum)
	 (let ((vec (vector-ref cells lnum)))
	    (let loop ((i 1))
	       (cond
		  ((=fx i (-fx *tetris-width* 1))
		   #t)
		  ((widget? (vector-ref vec i))
		   (loop (+fx i 1)))
		  (else
		   #f)))))
      (let iterate ()
	 (let loop ((y (-fx *tetris-height* 1)))
	    (if (>fx y 0)
		(if (line-completed? y)
		    (begin
		       (remove-line! y)
		       (iterate))
		    (loop (-fx y 1))))))))
		
;*---------------------------------------------------------------------*/
;*    still-shape! ...                                                 */
;*    -------------------------------------------------------------    */
;*    When a shape has reached is lowest line, we have to mark it      */
;*    the game cells and we have to remove all completed lines.        */
;*---------------------------------------------------------------------*/
(define (still-shape! shape game)
   (with-access::shape shape (rotation blocks number x y)
      (let ((rotations (vector-ref *shapes* number))
	    (cells (game-cells game)))
	 (let loop ((dy 0)
		    (blocks blocks))
	    (if (pair? blocks)
		(let* ((line (vector-ref rotations dy))
		       (rline (vector-ref line rotation)))
		   (let liip ((dx 0)
			      (blocks blocks))
		      (if (and (pair? blocks) (<fx dx 4))
			  (if (eq? (vector-ref rline dx) 'X)
			      (let ((x (+fx x dx))
				    (y (+fx y dy)))
				 (vector-set! (vector-ref cells y)
					      x
					      (car blocks))
				 (liip (+fx dx 1) (cdr blocks)))
			      (liip (+fx dx 1) blocks))
			  (loop (+fx dy 1) blocks))))))))
   (remove-completed-lines! game))

;*---------------------------------------------------------------------*/
;*    main ...                                                         */
;*---------------------------------------------------------------------*/
(define (main argv)
   (let* ((win (instantiate::window
		  (title "Biglook Tetris")
		  (resizable #t)
		  (border-width 5)
		  (layout (instantiate::box
			     (padding 2)
			     (orientation 'horizontal)))))
	  (game (create-game win))
	  (shape #unspecified)
	  (drop #f)
	  (e-handler (instantiate::event-handler
			(key (lambda (e)
				(with-access::event e (keyval)
 				   (case keyval
				      ((96 110 65456 65454 32)
				       ;; space
				       (set! drop #t)
				       (drop-shape shape game))
				      ((97 65457)
				       ;; left
				       (horizontal-move-shape shape game -1))
				      ((99 65459)
				       ;; right
				       (horizontal-move-shape shape game +1))
				      ((98 65458)
				       ;; down
				       (rotate-shape shape game -1))
				      ((101 65461)
				       ;; up
				       (rotate-shape shape game +1))))))))
	  (score (make-score-display win)))
      ;; the window handler
      (window-event-set! win e-handler)
      (canvas-event-set! game e-handler)
      (let loop ()
	 ;; prepare the canvas for gaming
	 (setup-game! game score)
	 ;; the main loop
	 (let* ((num (random (vector-length *shapes*)))
		(next (random (vector-length *shapes*)))
		(tick 0))
	    ;; create the current shape
	    (set! shape (new-shape game num))
	    (display-shape (new-shape score next) 3 1)
	    ;; one game tick
	    (define (dotick)
	       (cond
		  (*lost*
		   #t)
		  (*abort*
		   (after 30 loop)
		   (set! *abort* #f)
		   #f)
		  (else
		   (with-access::shape shape (x y)
		      (display-shape shape x y)
		      (set! tick (+fx tick 1))
		      (if (or drop (>=fx tick *speed*))
			  (if (shape-fits? shape game x (+fx y 1))
			      (begin
				 (set! drop #f)
				 (set! y (+fx y 1))
				 (set! tick 0)
				 #t)
			      (begin
				 (set! drop #f)
				 ;; It is impossible to go one line below.
				 ;; We stop, we check if the game ends, we
				 ;; check for completed lines and
				 ;; we go with the next shape
				 (if (>fx y 0)
				     (let ((n (random (vector-length *shapes*))))
					(still-shape! shape game)
					;; prepare the next shape display
					(for-each (lambda (o)
						     (destroy o))
						  (container-children score))
					(set! shape (new-shape game next))
					(set! next n)
					(display-shape (new-shape score n) 3 1)
					#t)
				     (begin
					(set! *lost* #t)
					#t))))
			  #t)))))
	    (timeout *timeout* dotick)))))
