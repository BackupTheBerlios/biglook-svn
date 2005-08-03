(module __biglook_cursor

   (library biglook_peer)

   (export (class cursor::%cursor
	      (style::symbol
	       (get (lambda (x) (%cursor-style x)))
	       (set (lambda (x v) (%cursor-style-set! x v)))))))
