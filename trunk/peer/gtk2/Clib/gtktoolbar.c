/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gtktoolbar.c          */
/*    -------------------------------------------------------------    */
/*    Author      :  George Bronnikov                                  */
/*    Creation    :  Tue Jan 13 20:14:13 2004                          */
/*    Last change :  Tue Jan 13 20:14:13 2004		               */
/*    Copyright   :  2001-02 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    C part of the Biglook/Gtk toolbar handling                       */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>
#include "../Include/_event.h"
#include <string.h>

int 
bglk_toolbar_space_size ( GtkToolbar *_tb ){
  GValue val;
  memset (&val, 0, sizeof (GValue));
  g_value_init( &val, G_TYPE_INT );
  gtk_widget_style_get_property ( GTK_WIDGET(_tb), "space-size", &val );
  return g_value_get_int (&val);
}

GtkReliefStyle
bglk_toolbar_button_relief ( GtkToolbar *_tb ){
  GValue val;
  
  memset (&val, 0, sizeof (GValue));
  g_value_init( &val, G_TYPE_INT );
  gtk_widget_style_get_property ( GTK_WIDGET(_tb), "button-relief", &val );
  return (GtkReliefStyle)g_value_get_int (&val);
}
