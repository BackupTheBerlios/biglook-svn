(let* ((win (instantiate::window
	       (title "Example of Biglook trees")))
       (hpane (instantiate::paned
		 (orientation 'horizontal)
		 (width 450)
		 (height 300)
		 (parent `(,win :expand #t :fill #t))))
       (left (instantiate::box
		 (parent hpane)))
       (right (instantiate::box
		  (parent hpane)))
       (class-tree (instantiate::tree
		      (parent `(,left :expand #t :fill #t))
		      (width 200)
		      (height 300)
		      (border-width 2)
		      (root object)
		      (node-label class-name)
		      (node-children class-subclasses)
		      (node-tooltips (lambda (o) "A class"))
		      (event (instantiate::event-handler
				(enter (lambda (e)
					  (print "Class: "
						 (find-runtime-type
						  (event-widget e))
						 " "
						 (tree-item-value
						  (event-widget e)))))))))
       (but (instantiate::button
	       (parent left)
	       (text "Close all")
	       (command (lambda (e)
			   (tree-close class-tree)))))
       (file-tree (instantiate::tree
		     (parent `(,right :expand #t :fill #t))
		     (border-width 2)
		     (auto-collapse #f)
		     (root '("/" "."))
		     (node-label directory-name)
		     (node-children directory-children)
		     (node-image scm-image)
		     (select-mode 'multiple)
		     (node-tooltips (lambda (o)
				       (if (directory? (tree-item-value o))
					   "Directory"
					   "File")))
		     (command (lambda (e)
				 (print (tree-item-value
					 (event-widget e)))))))
       (bentry (instantiate::box
		  (orientation 'horizontal)
		  (parent right)))
       (lbl (instantiate::label
	       (parent bentry)
	       (text "Find: ")))
       (entry (instantiate::file-entry
		 (parent bentry)
		 (command (lambda (e)
			     (let ((value (entry-text (event-widget e))))
				(tree-close file-tree)
				(tree-open file-tree
					   (lambda (val)
					      (substring=? val
							   value
							   (string-length val)))
					   #t)))))))
   (print "class-tree: " class-tree))

(define (directory-children data)
   (map (lambda (x)
	   (cond
	      ((char=? (string-ref data (-fx (string-length data) 1)) #\/)
	       (string-append data x))
	      (else
	       (make-file-name data x))))
	(directory->list data)))

(define (directory-name x)
   (if (string=? x "/")
       x
       (basename x)))

(define (scm-image value kind::symbol)
   (cond
      ((and (file-exists? value) (directory? value))
       (cond
	  ((string=? value (getenv "HOME"))
	   (duplicate-image *image-home*))
	  ((string=? value "/users")
	   (duplicate-image *image-user*))
	  (else
	   (tree-image value kind))))
      ((not (eq? kind 'leaf))
       #f)
      (else
       (let* ((suffix (suffix value))
	      (cell (assoc suffix *images-suffix*)))
	  (if (pair? cell)
	      (duplicate-image (cdr cell))
	      #f)))))

(define *image-home*
   (string->image "/* XPM */
/* Drawn  by Mark Donohoe for the K Desktop Environment */
/* See http://www.kde.org */
static char*kfm_home[]={
\"16 16 3 1\",
\"a c #ffffff\",
\"# c #000000\",
\". c None\",
\"................\",
\".......##.......\",
\"..#...####......\",
\"..#..#aaaa#.....\",
\"..#.#aaaaaa#....\",
\"..##aaaaaaaa#...\",
\"..#aaaaaaaaaa#..\",
\".#aaaaaaaaaaaa#.\",
\"###aaaaaaaaaa###\",
\"..#aaaaaaaaaa#..\",
\"..#aaa###aaaa#..\",
\"..#aaa#.#aaaa#..\",
\"..#aaa#.#aaaa#..\",
\"..#aaa#.#aaaa#..\",
\"..#aaa#.#aaaa#..\",
\"..#####.######..\"};"))

(define *image-user*
   (string->image "/* XPM */
/* Drawn  by Mark Donohoe and Nico Schirwing for the K Desktop Environment */
/* See http://www.kde.org */
static char*kdm[]={
\"16 16 9 1\",
\"# c #000000\",
\"b c #c0c0c0\",
\"a c #ffffff\",
\"c c #808080\",
\"g c #585858\",
\"f c #008080\",
\"e c #00c0c0\",
\"d c #c0ffff\",
\". c None\",
\".........####...\",
\"........#abbcc..\",
\"..####..#bbccc..\",
\".#ddee##bbccc#..\",
\".#ddeffabb##gc#.\",
\".#defffbaabbbbc#\",
\"#e#ff##bbbaaccc#\",
\"#deeffee#bbbccc#\",
\"#eddeeff#bbbccc#\",
\"#eeedfff#bb#c##.\",
\"#eeeefff#bbccc#.\",
\".#eeeff###bcc##.\",
\".#eef#f#..###...\",
\".#eefff#........\",
\".##eff#.........\",
\"...###..........\"};"))

(define *images-suffix*
   `(("scm" . ,(string->image "/* XPM */
static char * file_xpm[] = {
\"12 12 3 1\",
\" 	c None\",
\".	c black\",
\"X	c #FFFFCE\",
\" ........   \",
\" .XXXXXX.   \",
\" .XXXXXX... \",
\" .XX..XXXX. \",
\" .XXXX.XXX. \",
\" .XXXX.XXX. \",
\" .XXX.X.XX. \",
\" .XXX.X.XX. \",
\" .XX.XXX.X. \",
\" .XX.XXX.X. \",
\" .XXXXXXXX. \",
\" .......... \"};"))
     ("mp3" . ,(string->image "/* XPM */
static char*mini[]={
\"14 14 3 1\",
\"# c #0000ff\",
\". c None\",
\"a c #585858\",
\"......#.......\",
\"......#.......\",
\"......##......\",
\"......###.....\",
\"......####....\",
\"......#a###...\",
\"......#a.a#a..\",
\"......#a..#a..\",
\"......#a..a...\",
\"..###.#a......\",
\".######a......\",
\".######a......\",
\".#####a.......\",
\"..###a........\"};"))
     ("ps" . ,(string->image "/* XPM */
static char * mini_gv_xpm[] = {
\"16 14 3 1\",
\" 	c None\",
\".	c #000000000000\",
\"X	c #FFFFFFFFFFFF\",
\"     ....       \",
\"    .XXXX.      \",
\"   .XXXXXX.     \",
\"   .XXXXXX.     \",
\"  ..X.XX.X...   \",
\" .XXX.XX.X.XX.  \",
\" .XXXXXXXXXXX.  \",
\"  .XXXXXXXXX.   \",
\"   .XXXXXXX.    \",
\"   .XXXXXXX.    \",
\"   .XXXXXXX.    \",
\"  .XXXXXXXXX.   \",
\" .XXX.XXX.XXX.  \",
\"  ....X...X..   \"};"))
     ("dvi" . ,(string->image "/* XPM */
/* Drawn for the K Desktop Environment */
/* See http://www.kde.org */
static char*kghostview[]={
\"16 16 5 1\",
\"# c #000000\",
\"b c #c0c0c0\",
\"a c #ffffff\",
\"c c #c0c0c0\",
\". c None\",
\".###########....\",
\"#aaaaaaaaaaa#...\",
\"#abbbbabbbaa#...\",
\"#aaaaaaaaaaa#...\",
\"#abaab###baa#...\",
\"#aaab#aaa#ba#...\",
\"#aba#aabaa#a#...\",
\"#aaa#aabba#a#...\",
\"#aaa#aaaaa#a#...\",
\"#aaab#aaa##a#...\",
\"#ccacb####a##...\",
\"#cacccaaaa#a#...\",
\"#ccaacaaaaa#a#..\",
\"#caccaaaaaaa#a#.\",
\".###########.#a#\",
\"..............#.\"};"))
     ("info" . ,(string->image "/* XPM */
/* Drawn  by Nico Schirwing for the K Desktop Environment */
/* See http://www.kde.org */
static char*information_settings[]={
\"16 16 7 1\",
\"# c #000000\",
\"b c #c0c0c0\",
\"a c #ffffff\",
\"c c #a0a0a4\",
\"e c #000080\",
\"d c #0000ff\",
\". c None\",
\"......###.......\",
\".....#aaa#......\",
\".....#abb###....\",
\".....#bac#dd##..\",
\"....##b#b#dddd##\",
\"...#d#aab#dddd#.\",
\"..#dd#aab#ddd#b.\",
\".#ddd#aab#dd#bb#\",
\"#ddddd#b#dd#bb#.\",
\"##eddddddd#bb#..\",
\"#ab#edddd#bb#...\",
\"#aaab#ed#bb#....\",
\".##aaab#bb#.....\",
\"...##aacb#......\",
\".....##c#.......\",
\".......#........\"};"))
     ("a" . ,(string->image "/* XPM */
static char * exec_xpm[] = {
\"16 16 11 1\",
\"       c None\",
\".      c #000000\",
\"+      c #DCDCDC\",
\"@      c #A0A0A0\",
\"#      c #C3C3C3\",
\"$      c #808080\",
\"%      c #FFA858\",
\"&      c #FFDCA8\",
\"*      c #FFFFC0\",
\"=      c #FFFFFF\",
\"-      c #585858\",
\"       ..       \",
\"   .. .++. ..   \",
\"  .+@.@##@.@+.  \",
\"  .@+$@%%@$+@.  \",
\"   .$%%&%&%$.   \",
\" ..+@%&$$%&@+.. \",
\".+#@%&%@@&*%@#+.\",
\".$@+$&*&&=*$+@$.\",
\" .--+$&*=&$+--. \",
\"  .$#++$$++#$.  \",
\" .@=$-$++$-$=@. \",
\" .+@-..@@..-@+. \",
\"  ... .+=. ...  \",
\"      .-$.      \",
\"       ..       \",
\"                \"};"))
     ("so" . ,(string->image "/* XPM */
static char * exec_xpm[] = {
\"16 16 11 1\",
\"       c None\",
\".      c #000000\",
\"+      c #DCDCDC\",
\"@      c #A0A0A0\",
\"#      c #C3C3C3\",
\"$      c #808080\",
\"%      c #FFA858\",
\"&      c #FFDCA8\",
\"*      c #FFFFC0\",
\"=      c #FFFFFF\",
\"-      c #585858\",
\"       ..       \",
\"   .. .++. ..   \",
\"  .+@.@##@.@+.  \",
\"  .@+$@%%@$+@.  \",
\"   .$%%&%&%$.   \",
\" ..+@%&$$%&@+.. \",
\".+#@%&%@@&*%@#+.\",
\".$@+$&*&&=*$+@$.\",
\" .--+$&*=&$+--. \",
\"  .$#++$$++#$.  \",
\" .@=$-$++$-$=@. \",
\" .+@-..@@..-@+. \",
\"  ... .+=. ...  \",
\"      .-$.      \",
\"       ..       \",
\"                \"};"))))



