(module __biglook_%cursor

   (import __biglook_%error
	   __biglook_%awt)

   (export (class %cursor
	      (%cursor-init)
	      (%peer (default #unspecified)))

	   (%cursor-style::symbol  c::%cursor)
	   (%cursor-style-set! c::%cursor v::symbol)))

(define (%cursor-init c::%cursor)
   (with-access::%cursor c (%peer)
      (set! %peer (%awt-cursor-new))
      c))

(define (%cursor-style::symbol c::%cursor)
   (with-access::%cursor c (%peer)
      (case (%awt-cursor-type %peer)
	 ((%awt-cursor-CROSSHAIR_CURSOR) 'crosshair)
	 ((%awt-cursor-DEFAULT_CURSOR) 'default)
	 ((%awt-cursor-E_RESIZE_CURSOR) 'e_resize)
	 ((%awt-cursor-HAND_CURSOR) 'hand)
	 ((%awt-cursor-MOVE_CURSOR) 'move)
	 ((%awt-cursor-N_RESIZE_CURSOR) 'n_resize)
	 ((%awt-cursor-NE_RESIZE_CURSOR) 'ne_resize)
	 ((%awt-cursor-NW_RESIZE_CURSOR) 'nw_resize)
	 ((%awt-cursor-S_RESIZE_CURSOR) 's_resize)
	 ((%awt-cursor-SE_RESIZE_CURSOR) 'se_resize)
	 ((%awt-cursor-SW_RESIZE_CURSOR) 'sw_resize)
	 ((%awt-cursor-TEXT_CURSOR) 'text)
	 ((%awt-cursor-W_RESIZE_CURSOR) 'w_resize)
	 ((%awt-cursor-WAIT_CURSOR) 'wait)
	 (else 'custom))))

(define (%cursor-style-set! c::%cursor v::symbol)
   (with-access::%cursor c (%peer)
      (set! %peer (%awt-cursor-new/type
		   (case v
		      ((crosshair) %awt-cursor-CROSSHAIR_CURSOR)
		      ((default) %awt-cursor-DEFAULT_CURSOR)
		      ((e_resize) %awt-cursor-E_RESIZE_CURSOR)
		      ((hand) %awt-cursor-HAND_CURSOR)
		      ((move) %awt-cursor-MOVE_CURSOR)
		      ((n_resize) %awt-cursor-N_RESIZE_CURSOR)
		      ((ne_resize) %awt-cursor-NE_RESIZE_CURSOR)
		      ((nw_resize) %awt-cursor-NW_RESIZE_CURSOR)
		      ((s_resize) %awt-cursor-S_RESIZE_CURSOR)
		      ((se_resize) %awt-cursor-SE_RESIZE_CURSOR)
		      ((sw_resize) %awt-cursor-SW_RESIZE_CURSOR)
		      ((text) %awt-cursor-TEXT_CURSOR)
		      ((w_resize) %awt-cursor-W_RESIZE_CURSOR)
		      ((wait) %awt-cursor-WAIT_CURSOR)
		      (else (error "%cursor-style-set!"
				   "cursor style not allowed" v)))))
      c))
