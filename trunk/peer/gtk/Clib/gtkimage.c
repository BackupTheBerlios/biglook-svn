/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gtkimage.c            */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Mon Apr 16 07:15:47 2001                          */
/*    Last change :  Wed May 30 05:14:15 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    Gtk Image creation                                               */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>

/*---------------------------------------------------------------------*/
/*    static GtkWidget *                                               */
/*    gtk_pixbuf_to_gdk_pixmap ...                                     */
/*---------------------------------------------------------------------*/
static GtkWidget *
gtk_pixbuf_to_gdk_pixmap( GdkPixbuf *pixbuf ) {
    GtkWidget *pixmapwid;
    GdkPixmap *pixmap;
    GdkBitmap *mask;
    
    gdk_pixbuf_render_pixmap_and_mask( pixbuf, &pixmap, &mask, 1 );
    pixmapwid = gtk_pixmap_new( pixmap, mask );
    gtk_object_set_data( (GtkObject *)pixmapwid, "PIXBUF", pixbuf );

    gtk_object_ref( (GtkObject *)pixmapwid );
    gtk_widget_show( pixmapwid );

    return pixmapwid;
}

/*---------------------------------------------------------------------*/
/*    char **                                                          */
/*    buffer_to_data ...                                               */
/*---------------------------------------------------------------------*/
char **
buffer_to_data( char *buffer ) {
   char **line = 0L;
   int size = 0;
   char *runner = buffer;
   int buflen = 0;
   char *tmp;
   char *aux;
   int i;

   /* the compute the image size */
   while( *runner ) {
      buflen++;
      if( *runner == '"' ) size++;
      runner++;
   }
   size >>= 1;

   tmp = (char *)malloc( buflen + 1 );
   memcpy( tmp, buffer, buflen );
   
   /* we allocate the buffer */
   line = (char **)malloc( sizeof( char * ) * (2 + size) );
   line[ 0 ] = tmp;
   line[ size + 1 ] = 0L;

   /* we start collecting the strings */
   runner = (char *)strtok( tmp, "\"" );

   i = 1;
   while( line[ i++ ] = (char *)strtok( 0L, "\"" ) ) {
      strtok( 0L, "\"" );
   }

   return line + 1;
}

/*---------------------------------------------------------------------*/
/*    GtkWidget *                                                      */
/*    bglk_gtk_file_image_new ...                                      */
/*---------------------------------------------------------------------*/
GtkWidget *
bglk_gtk_file_image_new( char *filename ) {
   GdkPixbuf *pixbuf;
   pixbuf = gdk_pixbuf_new_from_file( filename );

   return gtk_pixbuf_to_gdk_pixmap( pixbuf );
}

/*---------------------------------------------------------------------*/
/*    GtkWidget *                                                      */
/*    bglk_gtk_data_image_new ...                                      */
/*---------------------------------------------------------------------*/
GtkWidget *
bglk_gtk_data_image_new( char *buffer, char *mask ) {
   GdkPixbuf *pixbuf;
   char **data = buffer_to_data( buffer );
   
   pixbuf = gdk_pixbuf_new_from_xpm_data( (const char **)data );

   free( data[ -1 ] );
   free( data - 1 );
   
   return gtk_pixbuf_to_gdk_pixmap( pixbuf );
}

/*---------------------------------------------------------------------*/
/*    GdkPixbuf *                                                      */
/*    bglk_image_to_pixbuf ...                                         */
/*---------------------------------------------------------------------*/
GdkPixbuf *
bglk_gtk_image_to_pixbuf( GtkObject *img ) {
   return gtk_object_get_data( img, "PIXBUF" );
}

/*---------------------------------------------------------------------*/
/*    GtkWidget *                                                      */
/*    bglk_gtk_image_duplicate ...                                     */
/*---------------------------------------------------------------------*/
GtkWidget *
bglk_gtk_image_duplicate( GtkObject *img ) {
   return gtk_pixbuf_to_gdk_pixmap( bglk_gtk_image_to_pixbuf( img ) );
}
   
