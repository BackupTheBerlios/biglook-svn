(module __biglook_%cursor

   (import __biglook_%error)

   (export (class %cursor
	      (%peer (default #unspecified)))

	   (%cursor-style::symbol ::%cursor)
	   (%cursor-style-set! ::%cursor ::symbol)))

(define (%cursor-style::symbol c::%cursor)
   (not-implemented c "%color-style"))

(define (%cursor-style-set! c::%cursor v::symbol)
   (not-implemented c "%color-style-set!"))
