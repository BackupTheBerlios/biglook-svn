/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gnomecanvas.c         */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Sun Oct 29 16:44:49 2000                          */
/*    Last change :  Sun Jun 10 09:54:26 2001 (serrano)                */
/*    Copyright   :  2000-01 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    The C connection to gnome                                        */
/*=====================================================================*/
#include <gtk/gtk.h>
#include <gnome.h>
#include <bigloo.h>
#include <biglook_peer.h>

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gnome_canvas_get_scroll_region ...                          */
/*---------------------------------------------------------------------*/
obj_t
bglk_gnome_canvas_get_scroll_region( GnomeCanvas *canvas ) {
   double d1, d2, d3, d4;
   obj_t lst;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );

   lst = MAKE_PAIR( DOUBLE_TO_REAL( d4 ), BNIL );
   lst = MAKE_PAIR( DOUBLE_TO_REAL( d3 ), lst );
   lst = MAKE_PAIR( DOUBLE_TO_REAL( d2 ), lst );
   lst = MAKE_PAIR( DOUBLE_TO_REAL( d1 ), lst );
   
   return lst;
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_gnome_canvas_get_scroll_region_x ...                        */
/*---------------------------------------------------------------------*/
int
bglk_gnome_canvas_get_scroll_region_x( GnomeCanvas *canvas ) {
   double d1, d2, d3, d4;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );

   return (int)d1;
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_gnome_canvas_get_scroll_region_y ...                        */
/*---------------------------------------------------------------------*/
int
bglk_gnome_canvas_get_scroll_region_y( GnomeCanvas *canvas ) {
   double d1, d2, d3, d4;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );

   return (int)d2;
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_gnome_canvas_get_scroll_region_width ...                    */
/*---------------------------------------------------------------------*/
int
bglk_gnome_canvas_get_scroll_region_width( GnomeCanvas *canvas ) {
   double d1, d2, d3, d4;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );

   return (int)(d3 - d1);
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_gnome_canvas_get_scroll_region_height ...                   */
/*---------------------------------------------------------------------*/
int
bglk_gnome_canvas_get_scroll_region_height( GnomeCanvas *canvas ) {
   double d1, d2, d3, d4;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );

   return (int)(d4 - d2);
}

/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    bglk_gnome_canvas_scroll_region_x_set ...                        */
/*---------------------------------------------------------------------*/
void
bglk_gnome_canvas_scroll_region_x_set( GnomeCanvas *canvas, int x ) {
   double d1, d2, d3, d4;
   obj_t lst;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );
   gnome_canvas_set_scroll_region( canvas, (double)x, d2, d3 + (double)x, d4 );
}
   
/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    bglk_gnome_canvas_scroll_region_y_set ...                        */
/*---------------------------------------------------------------------*/
void
bglk_gnome_canvas_scroll_region_y_set( GnomeCanvas *canvas, int y ) {
   double d1, d2, d3, d4;
   obj_t lst;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );
   gnome_canvas_set_scroll_region( canvas, d1, (double)y, d3, d4 + (double)y );
}
   
/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    bglk_gnome_canvas_scroll_region_width_set ...                    */
/*---------------------------------------------------------------------*/
void
bglk_gnome_canvas_scroll_region_width_set( GnomeCanvas *canvas, int width ) {
   double d1, d2, d3, d4;
   obj_t lst;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );
   gnome_canvas_set_scroll_region( canvas, d1, d2, d1 + (double)width, d4 );
}
   
/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    bglk_gnome_canvas_scroll_region_height_set ...                    */
/*---------------------------------------------------------------------*/
void
bglk_gnome_canvas_scroll_region_height_set( GnomeCanvas *canvas, int height ) {
   double d1, d2, d3, d4;
   obj_t lst;

   gnome_canvas_get_scroll_region( canvas, &d1, &d2, &d3, &d4 );
   gnome_canvas_set_scroll_region( canvas, d1, d2, d3, d2 + (double)height );
}
   
/*---------------------------------------------------------------------*/
/*    GnomeCanvasPoints*                                               */
/*    bglk_list_to_point ...                                           */
/*---------------------------------------------------------------------*/
GnomeCanvasPoints *
bglk_list_to_point( obj_t lst ) {
   GnomeCanvasPoints *points;
   int i;

   points = gnome_canvas_points_new( bgl_list_length( lst ) / 2 );

   for( i = 0; PAIRP( lst ); lst = CDR( CDR( lst ) ), i += 2 ) {
      obj_t aux = CAR( lst );
      points->coords[ i ] =
	 INTEGERP( aux ) ? (double)CINT( aux ) : REAL_TO_DOUBLE( aux );
      aux = CAR( CDR( lst ) );
      points->coords[ i + 1 ] = 
	 INTEGERP( aux ) ? (double)CINT( aux ) : REAL_TO_DOUBLE( aux );
   }

   return points;
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_point_to_list ...                                           */
/*---------------------------------------------------------------------*/
obj_t
bglk_point_to_list( GnomeCanvasPoints *points ) {
   int i;
   int len = 2 * points->num_points;
   obj_t lst;

   for( i = len - 2; i >=0; i -= 2 ) {
      lst = MAKE_PAIR( DOUBLE_TO_REAL( points->coords[ i + 1 ] ), lst );
      lst = MAKE_PAIR( DOUBLE_TO_REAL( points->coords[ i ] ), lst );
   }

   return lst;
}

/*---------------------------------------------------------------------*/
/*    GtkObject *                                                      */
/*    bglk_gnome_canvas_item_new ...                                   */
/*---------------------------------------------------------------------*/
GtkObject *
bglk_gnome_canvas_item_new( GnomeCanvasGroup *parent, int type, obj_t lst ) {
   GnomeCanvasItem* citem;
   guint argc = bgl_list_length( lst ) / 2;
   GtkArg *argv = alloca( sizeof( GtkArg ) * argc );
   int i;

   /* Decode the Biglook argument to construct a gtk argument list */
   for( i = 0; PAIRP( lst ); i++, lst = CDR( lst ) ) {
      argv[ i ].name = BSTRING_TO_STRING( CAR( lst ) );
      lst = CDR( lst );
      if( STRINGP( CAR( lst ) ) ) {
	 argv[ i ].type = GTK_TYPE_STRING;
	 GTK_VALUE_STRING( argv[ i ] ) = BSTRING_TO_STRING( CAR( lst ) );
      } else {
	 if( REALP( CAR( lst ) ) ) {
	    argv[ i ].type = GTK_TYPE_DOUBLE;
	    GTK_VALUE_DOUBLE( argv[ i ] ) = REAL_TO_DOUBLE( CAR( lst ) );
	 } else {
	    if( INTEGERP( CAR( lst ) ) ) {
	       argv[ i ].type = GTK_TYPE_UINT;
	       GTK_VALUE_UINT( argv[ i ] ) = CINT( CAR( lst ) );
	    } else {
	       if( PAIRP( CAR( lst ) ) ) {
		  argv[ i ].type = GTK_TYPE_GNOME_CANVAS_POINTS;
		  GTK_VALUE_POINTER( argv[ i ] ) = bglk_list_to_point( CAR( lst ) );
	       }
	    }
	 }
      }
   }

   /* alloc the gtk object */
   citem = (GnomeCanvasItem *)gnome_canvas_item_newv( parent,
						      (GtkType)type,
						      argc,
						      argv );

   return (GtkObject *)citem;
}
