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
   char *name;
   GValue gval;
   int i;

   /* alloc the gtk object */
   citem = (GnomeCanvasItem *)gnome_canvas_item_new( parent,
						     (GtkType)type,
						     NULL);
   /* Decode the Biglook argument */
   /* !!! Since the item is already created, this can be slow.
      I haven't found a way to do it without relying on gtkcanvas code, though. -- goga */
   for( i = 0; PAIRP( lst ); i++, lst = CDR( lst ) ) {
     memset (&gval, 0, sizeof (GValue));
     
     name = BSTRING_TO_STRING( CAR( lst ) );
     lst = CDR( lst );
     if( STRINGP( CAR( lst ) ) ) {
       g_value_init (&gval, G_TYPE_STRING);
	g_value_set_string ( &gval, BSTRING_TO_STRING( CAR( lst ) ) );
      } else {
	 if( REALP( CAR( lst ) ) ) {
	   g_value_init (&gval, G_TYPE_DOUBLE);
	   g_value_set_double ( &gval, REAL_TO_DOUBLE( CAR( lst ) ) );
	 } else {
	    if( INTEGERP( CAR( lst ) ) ) {
	      g_value_init (&gval, G_TYPE_UINT);
	      g_value_set_uint ( &gval, CINT( CAR( lst ) ) );
	    } else {
	       if( PAIRP( CAR( lst ) ) ) {
		  g_value_init (&gval, GNOME_TYPE_CANVAS_POINTS);
		  g_value_set_pointer (&gval,  bglk_list_to_point( CAR( lst ) ) );
	       }
	    }
	 }
      }
      g_object_set_property (citem, name, &gval);
   }

   return (GtkObject *)citem;
}

void
gnome_canvas_add_widget (GObject *item, GtkWidget *w) {
  GtkRequisition *req;

  req = (GtkRequisition*)malloc(sizeof(GtkRequisition)); 

  gtk_widget_size_request (w, req);
  gnome_canvas_item_set (GNOME_CANVAS_ITEM (item), 
			 "widget", w,
			 "width", (double)req->width,
			 "height", (double)req->height,
			 NULL);
}

void
gnome_canvas_text_font_set (GObject *item, char *family, char *width, int weight, int slant, int size) {
  PangoWeight pango_weight;
  PangoStyle pango_style; 

  switch (weight) {
    case 0:
    case 1:
      pango_weight = PANGO_WEIGHT_BOLD;
      break;
    case 2:
      pango_weight = PANGO_WEIGHT_NORMAL;
      break;
    }

  switch (slant) {
    case 0:
    case 1:
      pango_style = PANGO_STYLE_NORMAL;
      break;
    case 2:
      pango_style = PANGO_STYLE_ITALIC;
      break;
    case 3:
      pango_style = PANGO_STYLE_OBLIQUE;
      break;
    }

  gnome_canvas_item_set (GNOME_CANVAS_ITEM (item),
			 "family", family,
			 "font", width,
			 "weight", pango_weight,
			 "style", pango_style,
			 "size-points", (double)size, 
			 NULL);
}
