/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gtklist.c             */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Mon May  7 08:40:28 2001                          */
/*    Last change :  Wed Nov 14 09:51:57 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    Glib list handling                                               */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>

/*---------------------------------------------------------------------*/
/*    static char *                                                    */
/*    bgk_gtk_glist_item_get_string ...                                */
/*---------------------------------------------------------------------*/
static char *
bglk_gtk_glist_item_get_string( GtkListItem * li ) {
   GtkWidget *label;
   char *ltext = NULL;

   label = GTK_BIN( li )->child;
   
   if( !label || !GTK_IS_LABEL( label ) )
      return NULL;
   gtk_label_get( GTK_LABEL( label ), &ltext );

   return ltext;
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_glist_strings ...                                       */
/*---------------------------------------------------------------------*/
obj_t
bglk_gtk_glist_strings( GList *lst ) {
   obj_t res = BNIL;
   
   while( lst ) {
      GtkListItem *li = GTK_LIST_ITEM( lst->data );
      char *str = bglk_gtk_glist_item_get_string( li );

      res = make_pair( string_to_bstring( str ), res );
      lst = lst->next;
   }

   return res;
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_glist_objs ...                                          */
/*---------------------------------------------------------------------*/
obj_t
bglk_gtk_glist_objs( GList *slist ) {
   obj_t res = BNIL;
   
   while( slist ) {
      GtkWidget *item;

      item = slist->data;
      res = make_pair( bglk_g_object_get_user_data( G_OBJECT( item ) ),
		       res );

      slist = slist->next;
   }

   return res;
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_list_selection ...                                      */
/*---------------------------------------------------------------------*/
obj_t
bglk_gtk_list_selection( GtkList *lst ) {
   GList *slist = lst->selection;
   obj_t res = BNIL;
   
   return bglk_gtk_glist_objs( slist );
}

/*---------------------------------------------------------------------*/
/*    GList *                                                          */
/*    bglk_glist_strings_new ...                                       */
/*---------------------------------------------------------------------*/
GList *
bglk_glist_strings_new( obj_t l ) {
   GList *res = 0L;

   while( PAIRP( l ) ) {
      res = g_list_append( res, BSTRING_TO_STRING( CAR( l ) ) );
      l = CDR( l );
   }
   
   return res;
}

void
bglk_gtk_list_add_view_column( GtkWidget *tree_view )
{
  GtkCellRenderer *renderer;
  GtkTreeViewColumn *column;

  renderer = gtk_cell_renderer_text_new ();
  column = gtk_tree_view_column_new_with_attributes (NULL,
						     renderer,
						     "text", 0,
						     NULL);
  gtk_tree_view_append_column (GTK_TREE_VIEW (tree_view), column);
}


GtkObject*
bglk_gtk_list_add_item( GtkListStore *list_store, char *str ){
  GtkTreeIter iter;

  gtk_list_store_append( list_store, &iter);
  gtk_list_store_set( list_store, &iter, 0, str, -1 );

  return NULL;
}

int
bglk_gtk_list_coords_to_row( GtkWidget *tree_view, int x, int y )
{
  int row, *indices;
  GtkTreePath *path;

  gtk_tree_view_get_path_at_pos( GTK_TREE_VIEW( tree_view ), x, y, &path, NULL, NULL, NULL);
  row = gtk_tree_path_get_indices( path )[0];
  gtk_tree_path_free( path );
  
  return row;
}

