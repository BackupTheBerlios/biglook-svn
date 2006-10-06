#include <bigloo.h>
#include <biglook_peer.h>
#include <string.h>

char*
bglk_gtk_text_buffer_get_text( GtkTextBuffer *buffer)
{
  GtkTextIter *start, *end;

  start = ( GtkTextIter* )malloc( sizeof( GtkTextIter ) );
  end = ( GtkTextIter* )malloc( sizeof( GtkTextIter ) );

  gtk_text_buffer_get_start_iter( buffer, start );
  gtk_text_buffer_get_end_iter( buffer, end );
  printf( "TEXT %d\n", strlen(gtk_text_buffer_get_text( buffer, start, end, TRUE ) ));
  return gtk_text_buffer_get_text( buffer, start, end, TRUE );
}

GtkTextIter*
bglk_gtk_get_iter_at_location( GtkTextView *text_view, int x, int y )
{
  GtkTextIter *iter;

  iter = ( GtkTextIter* )malloc( sizeof( GtkTextIter ) );
  gtk_text_view_get_iter_at_location( text_view, iter, x, y );

  return iter;
}

GtkTextIter*
bglk_gtk_get_iter_at_cursor( GtkTextBuffer *buffer )
{
  GtkTextIter *iter;
  GtkTextMark *mark;

  iter = ( GtkTextIter* )malloc( sizeof( GtkTextIter ) );
  mark = gtk_text_buffer_get_selection_bound( buffer );
  gtk_text_buffer_get_iter_at_mark( buffer, iter, mark );

  return iter;
}
  
GtkTextIter*
bglk_gtk_get_iter_at_offset( GtkTextBuffer *buffer, int offset )
{
  GtkTextIter *iter;

  iter = ( GtkTextIter* )malloc( sizeof( GtkTextIter ) );
  gtk_text_buffer_get_iter_at_offset( buffer, iter, offset );

  return iter;
}
