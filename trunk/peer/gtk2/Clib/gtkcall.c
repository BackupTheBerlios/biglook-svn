/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gtkcall.c             */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Tue Apr 10 16:18:24 2001                          */
/*    Last change :  Wed Oct 10 14:53:22 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    C part of the Biglook->Gtk glue                                  */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>
#include <gtk/gtk.h>

/*---------------------------------------------------------------------*/
/*    gtk_color_buffer                                                 */
/*---------------------------------------------------------------------*/
double gtk_color_buffer[ 4 ];
GdkColor gdk_color_buffer;

/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    bglk_gtk_container_remove_all ...                                */
/*    -------------------------------------------------------------    */
/*    Removes all the children (even the non Biglook widgets) from     */
/*    a container.                                                     */
/*---------------------------------------------------------------------*/
void
bglk_gtk_container_remove_all( GtkContainer *c ) {
   GList *lst = gtk_container_children( c );
   obj_t res = BNIL;

   while( lst ) {
      GtkWidget *widget;
      obj_t obj;

      widget = GTK_WIDGET( lst->data );
      gtk_container_remove( c, widget );
      lst = lst->next;
   }
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_container_children ...                                  */
/*---------------------------------------------------------------------*/
obj_t
bglk_gtk_container_children( GtkContainer *c ) {
   GList *lst = gtk_container_get_children( c );
   obj_t res = BNIL;

   while( lst ) {
      GObject *data;
      GValue gval;
      obj_t obj;

      memset (&gval, 0, sizeof(GValue));
      g_value_init (&gval, G_TYPE_POINTER);

      data = G_OBJECT( lst->data );
      g_object_get_property ( data, "user-data", &gval );

      obj = (G_VALUE_HOLDS_POINTER( &gval ) ?
	     (obj_t)g_value_get_pointer( &gval ) :
	     BUNSPEC);

      if( obj ) res = MAKE_PAIR( obj, res );
      lst = lst->next;
   }

   return res;
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_viewport_children ...                                   */
/*---------------------------------------------------------------------*/
obj_t
bglk_gtk_viewport_children( GtkContainer *c ) {
   GList *lst = gtk_container_get_children( c );

   if( lst )
      return bglk_gtk_container_children( lst->data );
   else
      return BNIL;
}

