/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gtktable.c            */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Mon May  7 08:40:28 2001                          */
/*    Last change :  Sun Jun  3 10:35:10 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    Gtk clist handling                                               */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>

/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    bglk_gtk_clist_add_row ...                                       */
/*---------------------------------------------------------------------*/
void
bglk_gtk_clist_add_row( GtkCList *clist, int column ) {
   gchar **row = alloca( sizeof( char * ) * column );
   int i;
   
   for( i = 0; i < column; i++ )
      row[ i ] = "";
   
   gtk_clist_append( clist, row );
}
/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    column_from_xpixel ...                                           */
/*    -------------------------------------------------------------    */
/*    This code is a copy of the plain GTK function of the             */
/*    gtkclist.c implementation: COLUMN_FROM_XPIXEL.                   */
/*---------------------------------------------------------------------*/
int
column_from_xpixel( GtkCList * clist, int x ) {
   int i, cx;
#   define CELL_SPACING 1
#   define COLUMN_INSET 3

   for( i = 0; i < clist->columns; i++ )
      if( clist->column[ i ].visible ) {
	 cx = clist->column[ i ].area.x + clist->hoffset;

	 if( x >= (cx - (COLUMN_INSET + CELL_SPACING)) &&
	     x <= (cx + clist->column[ i ].area.width + COLUMN_INSET) )
	    return i;
      }

   return -1;
}
