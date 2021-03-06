(define (demo)
   (let* ((win (instantiate::window
		  (title "An example of Biglook table")
		  (width 400)
		  (height 300)))
	  (scroll (instantiate::scroll
		     (parent `(,win :expand #t :fill #t))
		     (vpolicy 'always)))
	  (table (instantiate::table
		    (parent `(,scroll :expand #t :fill #t))
		    (row-height 20)
		    (rows 1000)
		    (width 400)
		    (height 300)
		    (shadow 'etched-in)
		    (columns '(col1 col2 col3 col4))
		    (columns-width '(60 80 50))
		    (select-mode 'extended)
		    (row-background row-background)
		    (row-foreground row-foreground)
		    (cell-value cell-value)
		    (command (lambda (e)
				(print "select-row: " (event-y e))
				(print "    column: " (event-x e)))))))
      (widget-visible-set! win #t)
      (print "table: " table)))

(define row-background
   (let ((light-gray (instantiate::rgb-color
			(red #xf0)
			(green #xf0)
			(blue #xf0)))
	 (dark-gray (instantiate::rgb-color
		       (red #xe0)
		       (green #xe0)
		       (blue #xe0))))
      (lambda (row)
	 (if (odd? row)
	     dark-gray
	     light-gray))))

(define row-foreground
   (let ((foreground (instantiate::rgb-color
			(red 40)
			(green 40)
			(blue 240))))
      (lambda (row)
	 (if (=fx (remainder row 5) 0)
	     foreground
	     #f))))

(define (cell-value o x y)
   (cond
      ((= x 0)
       (string-append "row: " (number->string y)))
      ((= x 1)
       (random 100))
      ((= x 2)
       (=fx (random 2) 1))
      ((= x 3)
       (image (random 100)))))
   
(define image
   (let* ((lst (map string->image 
		    `("/* XPM */
static char *magick[] = {
/* columns rows colors chars-per-pixel */
\"15 15 32 1\",
\"  c #010101\",
\". c #070709\",
\"X c #0c0c0d\",
\"o c #131314\",
\"O c #19191b\",
\"+ c #1f1f20\",
\"@ c #242425\",
\"# c #252529\",
\"$ c #2b2b2d\",
\"% c #343434\",
\"& c #3a3a3a\",
\"* c Gray26\",
\"= c #4b4b4c\",
\"- c Gray33\",
\"; c #5f5f5f\",
\": c #737374\",
\"> c #7e7e7f\",
\", c #89898a\",
\"< c #979798\",
\"1 c Gray62\",
\"2 c #a4a4a4\",
\"3 c Gray67\",
\"4 c Gray71\",
\"5 c #c5c5c5\",
\"6 c Gray80\",
\"7 c Gray84\",
\"8 c Gray85\",
\"9 c #e6e6e7\",
\"0 c #eeeeee\",
\"q c Gray96\",
\"w c #fefefe\",
\"e c None\",
/* pixels */
\"eeeeeo#@#+eeeee\",
\"eeeo$OoooXoXeee\",
\"eeXO.       .Xo\",
\"eXo       &33=.\",
\"eo        -ww9o\",
\"X.        -wqw:\",
\"O       . -www4\",
\"          =www7\",
\"     &31215www7\",
\"O    -wwwwwwww5\",
\"o    -wqwwwwww<\",
\"eX . -wwwwwwww%\",
\"  .@ ;wwwwwww> \",
\"   ,qwwwwwww,  \",
\"    *370072%   \"
};"
		      "/* XPM */
static char*gnu[]={
\"16 16 81 2\",
\".L c #965f30\",
\".F c #e5e6e5\",
\".Q c #90908a\",
\".E c #bcbdaa\",
\".k c #cb8345\",
\".o c #87572e\",
\".a c #77502f\",
\"#k c #6d706b\",
\"Qt c None\",
\".S c #373737\",
\".W c #a6a5c0\",
\"#o c #50463e\",
\".w c #9f8b7b\",
\".9 c #bbbbbb\",
\".C c #726961\",
\"#i c #532608\",
\"#a c #706f6e\",
\".J c #646571\",
\"#h c #4e2104\",
\"#j c #9b9b9c\",
\".b c #845832\",
\".0 c #4f4f4f\",
\"#b c #6c4427\",
\".q c #b17640\",
\".K c #969899\",
\".3 c #a3a491\",
\".Y c #9b9b97\",
\"#e c #270f00\",
\".u c #4d5053\",
\".Z c #c9cccf\",
\".6 c #c8c7cb\",
\".i c #d6955d\",
\"#c c #645449\",
\".R c #d3d3d4\",
\"#m c #6c3711\",
\".5 c #737474\",
\".z c #96663d\",
\"#f c #595959\",
\".O c #4742bb\",
\"## c #7c7c7c\",
\"#. c #222323\",
\".G c #c2c2c2\",
\".x c #414142\",
\".j c #c48852\",
\".h c #e49f5b\",
\".g c #6e4a2b\",
\".B c #9c6535\",
\".e c #0d0906\",
\".M c #a97e5b\",
\".8 c #e0e4e8\",
\".1 c #0d0d0d\",
\".U c #6d6f71\",
\"#g c #61605f\",
\".r c #525960\",
\".T c #a5a8ab\",
\".s c #848485\",
\".4 c #b8b8b5\",
\".f c #0b0603\",
\".P c #65657a\",
\".l c #563a22\",
\".t c #b8b2ae\",
\".D c #545554\",
\".d c #a16e41\",
\".I c #6c6b6b\",
\".y c #b97d48\",
\"#n c #42220b\",
\".c c #8f613b\",
\".7 c #efefef\",
\".v c #616060\",
\"#l c #110a05\",
\".# c #dcdcdc\",
\".A c #744a27\",
\".n c #321d0d\",
\".m c #010100\",
\".H c #8b8b8b\",
\".N c #383758\",
\".2 c #b0b0a9\",
\".p c #db9658\",
\".X c #4944b3\",
\"#d c #48372b\",
\".V c #898882\",
\"QtQtQt.#.#QtQt.#.#.#.#.#.#.#.#Qt\",
\"QtQt.#.#Qt.#.#.#.#.#.#.#.#.#.#.#\",
\".#.#Qt.#.#.#.#.#Qt.#.#.#.#.a.#.#\",
\".#Qt.#.#.#.#.#.b.#.c.d.eQt.f.d.#\",
\".#Qt.#.gQt.#.h.i.j.k.k.l.m.n.o.#\",
\".#.#.p.#.#.h.q.r.s.t.u.v.s.w.x.#\",
\".#.#.y.z.A.B.C.D.E.F.G.H.I.J.K.#\",
\".#Qt.#.L.M.K.I.N.O.P.Q.R.S.#.#.#\",
\".#Qt.#.D.T.U.V.W.X.J.Y.Z.0.mQt.#\",
\".#Qt.#.#.1.I.s.2.3.4.R.G.H.m.#.#\",
\".#.#Qt.#.s.5.5.s.6.7.8.Z.9#..#.#\",
\"Qt.#Qt.#.H.9#######a#b#c#d#e.#Qt\",
\"Qt.#Qt.#.#.G#f#f#g#..n#h#i.#.#.#\",
\"QtQt.#.#.##j.9#k.D.x#l#m#n.#.#.#\",
\"QtQtQt.#.#.#.s.R.s#d.m.#.#.#Qt.#\",
\"QtQtQtQt.#.#.##o.N.#.#.#.#.#QtQt\"};"
		      "/* XPM */
static char * mandrake_logo_xpm[] = {
\"16 16 18 1\",
\"       c None\",
\".      c #A0A0A0\",
\"+      c #808000\",
\"@      c #FFDCA8\",
\"#      c #C0C000\",
\"$      c #FFA858\",
\"%      c #C3C3C3\",
\"&      c #808080\",
\"*      c #303030\",
\"=      c #FFFFFF\",
\"-      c #DCDCDC\",
\";      c #585858\",
\">      c #404000\",
\",      c #FF8000\",
\"'      c #000000\",
\")      c #400000\",
\"!      c #FFC0C0\",
\"~      c #FFFFC0\",
\"       %#       \",
\"       !#.      \",
\"      .@@.      \",
\"      #@$.      \",
\"     .@#>$.     \",
\".....%%&>;.     \",
\"--@-@@.%.;#!%%#.\",
\"#@#@@@+$+>@@@@$.\",
\".,#$##*..*$#$+++\",
\" ..#$>;=~;*$++. \",
\"  .$#)%==-'+,.  \",
\"  .@#*%==@*+..  \",
\"  %@@)&==.'$#$  \",
\" .@@#*&--%',#$. \",
\" #$++;).&**+++..\",
\".$++.&+&&++&,++&\"};"
		      "/* XPM */
static char * mini_penguin_xpm[] = {
/* width height num_colors chars_per_pixel */
\"16 18 7 1\",
/* colors */
\"       s None  m none  c None\",
\".      c #808080\",
\"X      c black\",
\"o      c #c0c0c0\",
\"O      c #101010\",
\"+      c white\",
\"@      c #e0a008\",
/* pixels */
\"      .XX.      \",
\"     .XXXX.     \",
\"     XoXoXX     \",
\"     XOXX+X     \",
\"     X@@@oX     \",
\"     X@@@oX.    \",
\"     X@@++XX    \",
\"    X.+++++X.   \",
\"   .X++++++.X.  \",
\"   X+++o++++XX  \",
\"   X++oo++++XX. \",
\"  Xo++o+++++XXX \",
\"  @o++o+++++XXX \",
\" @@@+++++++@XX@ \",
\"@@@@@+++++o@@@@@\",
\"@@@@@+++++X@@@@@\",
\" @@@@@++XXX@@@@ \",
\"  @@@.XXXXX.@@  \"};"
		      "/* XPM */
static char *magick[] = {
/* columns rows colors chars-per-pixel */
\"16 16 30 1\",
\"  c Gray0\",
\". c #090909\",
\"X c Gray8\",
\"o c #1d1d1d\",
\"O c Gray15\",
\"+ c Gray18\",
\"@ c Gray20\",
\"# c #3c3c3c\",
\"$ c #434343\",
\"% c #4c4c4c\",
\"& c #535353\",
\"* c #5b5b5b\",
\"= c #656565\",
\"- c Gray42\",
\"; c #747474\",
\": c #7c7c7c\",
\"> c #848484\",
\", c #8b8b8b\",
\"< c #939393\",
\"1 c #9d9d9d\",
\"2 c Gray63\",
\"3 c Gray71\",
\"4 c #b9b9b9\",
\"5 c Gray76\",
\"6 c #cbcbcb\",
\"7 c #d5d5d5\",
\"8 c #d8d8d8\",
\"9 c Gray89\",
\"0 c Gray92\",
\"q c None\",
/* pixels */
\"qqqqq=O. O-qqqqq\",
\"qqq=     @# =qqq\",
\"qq#   &#32-<,&qq\",
\"q;.  ,>39401*@;q\",
\"q@Oo$060000907$q\",
\"1$$4-00000004<:<\",
\"*=,07000000001=&\",
\"#=>90000000009&$\",
\"$,3400000000;5*$\",
\"*>0000000000&&=&\",
\"1%=1000000<9OO&,\",
\"q#76099977-* o@q\",
\"q;+==17=6$X  .;q\",
\"qq#X:-O-O    #qq\",
\"qqq=        =qqq\",
\"qqqqq=O .O=qqqqq\"};"
		      "/* XPM */
static char * mini_gimp_xpm[] = {
\"16 13 87 1\",
\"       c None\",
\".      c #565143\",
\"+      c #928972\",
\"@      c #6D6653\",
\"#      c #454135\",
\"$      c #867D68\",
\"%      c #79715E\",
\"&      c #4A4539\",
\"*      c #6E6654\",
\"=      c #615A4A\",
\"-      c #6B675F\",
\";      c #968D78\",
\">      c #857D6A\",
\",      c #958F80\",
\"'      c #666152\",
\")      c #544F41\",
\"!      c #5C5646\",
\"~      c #696250\",
\"{      c #655E4D\",
\"]      c #5F5849\",
\"^      c #4E493B\",
\"/      c #E3E3E3\",
\"(      c #CCCAC5\",
\"_      c #E9E8E4\",
\":      c #F2F2F2\",
\"<      c #D9D8D4\",
\"[      c #766F5C\",
\"}      c #5F5848\",
\"|      c #514C3D\",
\"1      c #4A4538\",
\"2      c #484436\",
\"3      c #11100C\",
\"4      c #9A9A9A\",
\"5      c #3A3A3A\",
\"6      c #868279\",
\"7      c #7F7E7D\",
\"8      c #706E68\",
\"9      c #F0F0EF\",
\"0      c #7C7C7C\",
\"a      c #737373\",
\"b      c #746E5E\",
\"c      c #565041\",
\"d      c #433F33\",
\"e      c #3C382D\",
\"f      c #0E0D0A\",
\"g      c #101010\",
\"h      c #4F4F4F\",
\"i      c #424242\",
\"j      c #5E5B56\",
\"k      c #7B7460\",
\"l      c #847C66\",
\"m      c #A6A195\",
\"n      c #87857F\",
\"o      c #767166\",
\"p      c #5D5747\",
\"q      c #4D483A\",
\"r      c #403C30\",
\"s      c #2C2921\",
\"t      c #010000\",
\"u      c #414141\",
\"v      c #616160\",
\"w      c #6A6863\",
\"x      c #5F5948\",
\"y      c #6F6855\",
\"z      c #6E6755\",
\"A      c #67604F\",
\"B      c #585344\",
\"C      c #47443A\",
\"D      c #3B372C\",
\"E      c #000000\",
\"F      c #605D57\",
\"G      c #4C483D\",
\"H      c #464235\",
\"I      c #484337\",
\"J      c #423E33\",
\"K      c #3B372E\",
\"L      c #403E36\",
\"M      c #646157\",
\"N      c #3D392E\",
\"O      c #171511\",
\"P      c #080706\",
\"Q      c #0E0D0B\",
\"R      c #21201C\",
\"S      c #3B3932\",
\"T      c #413E37\",
\"U      c #201E19\",
\"V      c #070605\",
\"                \",
\"               .\",
\"    +         @#\",
\"    $%      &*= \",
\"    -;>,')!~{]^ \",
\"    /(_:<[}|123 \",
\" 4567890abcdef  \",
\"ghijklmnopqrst  \",
\" uvwxyzABCdDfE  \",
\"  FGHIJKLMNOE   \",
\"    PQRSTUVE    \",
\"      EEEEE     \",
\"                \"};"
		      "/* XPM */
static char *foo[] = {
/* width height num_colors chars_per_pixel */
\"    18    18      208            2\",
/* colors */
\".. c #f8fcf8\",
\".# c #a8a8a8\",
\".a c #d0d8d8\",
\".b c #d0d4d8\",
\".c c #d0d0d8\",
\".d c #c8ccd0\",
\".e c #c8c8d0\",
\".f c #c0c4c8\",
\".g c #c0c0c8\",
\".h c #b8bcc0\",
\".i c #b8b8c0\",
\".j c #b0b4b8\",
\".k c #a8a8b8\",
\".l c #a8a4b0\",
\".m c #9894a0\",
\".n c #808490\",
\".o c #000000\",
\".p c #c8c8d0\",
\".q c #909498\",
\".r c #888888\",
\".s c #707070\",
\".t c #383c38\",
\".u c #101010\",
\".v c #505050\",
\".w c #686c70\",
\".x c #908c98\",
\".y c #a0a4a8\",
\".z c #a0a4a8\",
\".A c #9090a0\",
\".B c #787c88\",
\".C c #b0b0b8\",
\".D c #787478\",
\".E c #787878\",
\".F c #504040\",
\".G c #400c08\",
\".H c #280400\",
\".I c #300400\",
\".J c #300800\",
\".K c #100000\",
\".L c #000400\",
\".M c #505458\",
\".N c #889098\",
\".O c #889098\",
\".P c #787888\",
\".Q c #b0b0b8\",
\".R c #606460\",
\".S c #505050\",
\".T c #000400\",
\".U c #901010\",
\".V c #b01410\",
\".W c #b01410\",
\".X c #a81810\",
\".Y c #600c08\",
\".Z c #881010\",
\".0 c #100000\",
\".1 c #303030\",
\".2 c #808088\",
\".3 c #707480\",
\".4 c #c8c4d0\",
\".5 c #707070\",
\".6 c #505450\",
\".7 c #200000\",
\".8 c #781008\",
\".9 c #480808\",
\"#. c #780c08\",
\"## c #b01818\",
\"#a c #b01418\",
\"#b c #b01818\",
\"#c c #580c08\",
\"#d c #484848\",
\"#e c #707078\",
\"#f c #888890\",
\"#g c #808480\",
\"#h c #380808\",
\"#i c #580808\",
\"#j c #400400\",
\"#k c #a01410\",
\"#l c #a81818\",
\"#m c #b01810\",
\"#n c #b01818\",
\"#o c #b01818\",
\"#p c #b01818\",
\"#q c #981410\",
\"#r c #000000\",
\"#s c #000400\",
\"#t c #585c60\",
\"#u c #787878\",
\"#v c #403430\",
\"#w c #b01810\",
\"#x c #b01818\",
\"#y c #700c08\",
\"#z c #080000\",
\"#A c #300000\",
\"#B c #600c08\",
\"#C c #b01818\",
\"#D c #b01818\",
\"#E c #a81810\",
\"#F c #280000\",
\"#G c #080000\",
\"#H c #404448\",
\"#I c #282828\",
\"#J c #000000\",
\"#K c #580808\",
\"#L c #a81410\",
\"#M c #981410\",
\"#N c #600c08\",
\"#O c #200400\",
\"#P c #680c08\",
\"#Q c #a81410\",
\"#R c #981410\",
\"#S c #180400\",
\"#T c #202428\",
\"#U c #400808\",
\"#V c #981810\",
\"#W c #a81410\",
\"#X c #a81410\",
\"#Y c #a01810\",
\"#Z c #b01818\",
\"#0 c #b01818\",
\"#1 c #380400\",
\"#2 c #080808\",
\"#3 c #080808\",
\"#4 c #585c58\",
\"#5 c #b0a8a8\",
\"#6 c #681c18\",
\"#7 c #981410\",
\"#8 c #b01810\",
\"#9 c #b01818\",
\"a. c #b01818\",
\"a# c #b01818\",
\"aa c #b01810\",
\"ab c #781008\",
\"ac c #000000\",
\"ad c #202020\",
\"ae c #707478\",
\"af c #707470\",
\"ag c #808080\",
\"ah c #585858\",
\"ai c #e0e4e0\",
\"aj c #e8e8e8\",
\"ak c #605858\",
\"al c #280400\",
\"am c #580808\",
\"an c #700c08\",
\"ao c #700c08\",
\"ap c #680c08\",
\"aq c #380800\",
\"ar c #000000\",
\"as c #505050\",
\"at c #989ca8\",
\"au c #d8d8d8\",
\"av c #f8fcf8\",
\"aw c #e8e8e8\",
\"ax c #d8dcd8\",
\"ay c #f8f8f8\",
\"az c #f8f8f8\",
\"aA c #e0e8e8\",
\"aB c #e0e0e0\",
\"aC c #e0e0e0\",
\"aD c #585c58\",
\"aE c #100c10\",
\"aF c #505058\",
\"aG c #a0a4b0\",
\"aH c #909498\",
\"aI c #f8f8f8\",
\"aJ c #f8fcf8\",
\"aK c #f8f8f8\",
\"aL c #c0c0c0\",
\"aM c #b8bcb8\",
\"aN c #f0f4f0\",
\"aO c #282c28\",
\"aP c #404440\",
\"aQ c #383838\",
\"aR c #484848\",
\"aS c #505058\",
\"aT c #9898a8\",
\"aU c #909498\",
\"aV c #f0f0f0\",
\"aW c #808480\",
\"aX c #a0a0a0\",
\"aY c #e8ece8\",
\"aZ c #686c70\",
\"a0 c #605868\",
\"a1 c #484c58\",
\"a2 c #888898\",
\"a3 c #808490\",
\"a4 c #808088\",
\"a5 c #c0c4c8\",
\"a6 c #f8f8f8\",
\"a7 c #f8f8f8\",
\"a8 c #f0f4f0\",
\"a9 c #d0d4d0\",
\"b. c #c0c0c0\",
\"b# c #606470\",
\"ba c #605c70\",
\"bb c #505460\",
\"bc c #404458\",
\"bd c #687078\",
\"be c #686870\",
\"bf c #686878\",
\"bg c #909498\",
\"bh c #a8aca8\",
\"bi c #a8aca8\",
\"bj c #98a0a0\",
\"bk c #606470\",
\"bl c #484c60\",
\"bm c #505060\",
\"bn c #404050\",
/* pixels */
\"...................................#\",
\"...a.b.c.d.e.f.g.h.h.i.j.k.l.l.m.n.o\",
\"...c.d.e.p.q.r.s.t.u.v.w.x.y.z.A.B.o\",
\"...d.e.C.D.E.F.G.H.I.J.K.L.M.N.O.P.o\",
\"...e.Q.R.S.T.U.V.W.X.Y.Z.0.o.1.2.3.o\",
\"...4.5.6.o.7.8.9#.###a#b#c.o.o#d#e.o\",
\"..#f#g#h#i#j#k#l#m#n#o#p#q#r.o#s#t.o\",
\"..#u#v#w#x#y#z#A#B#l#C#D#E#F#G.o#H.o\",
\"..#I#J#K#L#w#M#N#O#P#D#D.X#Q#R#S#T.o\",
\"...o.o#J#U#V#W#w#X#Y#Z#b#o#0#0#1#2.o\",
\"..#3.o.o#4#5#6#7#8#9a.a##9aaabacad.o\",
\"..aeafagahaiajakalamanaoapaqar.oas.o\",
\"..atauavawaxayazaAaBaCaBaD.o.oaEaF.o\",
\"..aGaHaIaJaKaKaKaJaLaMaNaOaPaQaRaS.o\",
\"..aGaTaUaVayayayaJavavaWaXaYaZa0a1.o\",
\"...Aa2a3a4a5a6a7aJava8a9b.b#babbbc.o\",
\"...B.P.3bdbebfbgbhbibjbkblbmbmbnbc.o\",
\".o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o\"};")))
	  (len (length lst)))
      (lambda (x)
	 (let ((zob (list-ref lst (remainder x len))))
	    zob))))

(demo)
	      






   
