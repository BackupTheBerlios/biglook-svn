#include <bigloo.h>
#include <biglook_peer.h>

void
bglk_menu_popup( GtkMenu *menu )
{
  gtk_menu_popup( menu, NULL, NULL, NULL, NULL, 0, gtk_get_current_event_time() ); 

  return;
}
