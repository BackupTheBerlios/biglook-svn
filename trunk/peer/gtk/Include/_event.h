/*===========================================================================*/
/*   (Llib/_event.scm)                                                       */
/*   Bigloo (2.6e)                                                           */
/*   Inria -- Sophia Antipolis (c)       Thu Apr 15 14:49:49 CEST 2004       */
/*===========================================================================*/
/* COMPILATION: (bigloo -hgen Llib/_event.scm -o Include/_event.h)*/

/* Object type definitions */
typedef struct BgL_z52peerz52_bgl {
   header_t header;
   obj_t widening;
   GtkObject* BgL_z52builtinz52;
   obj_t BgL_z52eventz52;
} *BgL_z52peerz52_bglt;

typedef struct BgL_z52bglkzd2objectz80_bgl {
   header_t header;
   obj_t widening;
   obj_t BgL_z52peerz52;
} *BgL_z52bglkzd2objectz80_bglt;

typedef struct BgL_z52eventz52_bgl {
   header_t header;
   obj_t widening;
   GdkEvent* BgL_z52eventz52;
   obj_t BgL_z52widgetz52;
} *BgL_z52eventz52_bglt;


