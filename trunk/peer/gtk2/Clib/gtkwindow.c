#include <bigloo.h>
#include <biglook_peer.h>
#include "../Include/_event.h"

int 
bglk_window_x (GtkWidget *w)
{
  gint x;
  gint y;
  gtk_window_get_position (GTK_WINDOW(w), &x, &y);
  return x;
}

int 
bglk_window_y (GtkWidget *w)
{
  gint x;
  gint y;
  gtk_window_get_position (GTK_WINDOW(w), &x, &y);
  return y;
}

void
bglk_window_reshow_with_initial_size( GtkWidget *w ) {
  int x, y;
  GtkWidget *mainwin;
  GtkRequisition *req;

  req = (GtkRequisition*)malloc(sizeof(GtkRequisition)); 
  
  for( mainwin = w; mainwin->parent != NULL; mainwin = mainwin->parent )
    ;

  if( GTK_IS_WINDOW( mainwin ) ) {
    gtk_widget_get_size_request( mainwin, &x, &y );
    if( x > 0 && y > 0 )
      return;
    
    gtk_widget_size_request( mainwin, req );
    
    if( req->width > 0 && req->height > 0)
      gtk_window_resize( GTK_WINDOW( mainwin ), req->width, req->height );
    
    if( x > 0 )
      gtk_widget_set_size_request( mainwin, x, -1 );
    else
      gtk_widget_set_size_request( mainwin, -1, y );
  }
  free( req );
}
