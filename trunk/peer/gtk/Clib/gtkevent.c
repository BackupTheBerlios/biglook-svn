/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gtkevent.c            */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Tue Apr 10 16:18:24 2001                          */
/*    Last change :  Fri Dec 13 15:51:48 2002 (serrano)                */
/*    Copyright   :  2001-02 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    C part of the Biglook/Gtk event handling                         */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>
#include "../Include/_event.h"

/*---------------------------------------------------------------------*/
/*    Importations from __biglook_%event (can't be in biglook_peer.h   */
/*    because of incompatible C types).                                */
/*---------------------------------------------------------------------*/
extern BgL_z52eventz52_bglt bglk_null_event_descriptor;
extern BgL_z52eventz52_bglt bglk_widget_event_descriptor;
extern BgL_z52eventz52_bglt bglk_mouse_event_descriptor;
extern BgL_z52eventz52_bglt bglk_key_event_descriptor;

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_event_type ...                                              */
/*---------------------------------------------------------------------*/
obj_t
bglk_event_type( GdkEvent *ev ) {
   if( !ev ) {
      return string_to_symbol( "click" );
   }
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_NOTHING: return string_to_symbol( "nothing" );
      case GDK_DELETE: return string_to_symbol( "delete" );
      case GDK_DESTROY: return string_to_symbol( "destroy" );
      case GDK_EXPOSE: return string_to_symbol( "expose" );
      case GDK_MOTION_NOTIFY: return string_to_symbol( "motion" );
      case GDK_BUTTON_PRESS: 
      case GDK_2BUTTON_PRESS:
      case GDK_3BUTTON_PRESS: return string_to_symbol( "press" );
      case GDK_BUTTON_RELEASE: return string_to_symbol( "release" );
      case GDK_KEY_PRESS: return string_to_symbol( "key-press" );
      case GDK_KEY_RELEASE: return string_to_symbol( "key-release" );
      case GDK_ENTER_NOTIFY: return string_to_symbol( "enter" );
      case GDK_LEAVE_NOTIFY: return string_to_symbol( "leave" );
      case GDK_FOCUS_CHANGE: return string_to_symbol(((GdkEventFocus *)ev)->in ? "focus-in" : "focus-out" );
      case GDK_CONFIGURE: return string_to_symbol( "configure" );
      case GDK_MAP: return string_to_symbol( "deiconify" );
      case GDK_UNMAP: return string_to_symbol( "iconify" );
      case GDK_PROPERTY_NOTIFY: return string_to_symbol( "property" );
      case GDK_SELECTION_CLEAR: return string_to_symbol( "selection-clear" );
      case GDK_SELECTION_REQUEST: return string_to_symbol( "selection-request" );
      case GDK_SELECTION_NOTIFY: return string_to_symbol( "selection" );
      case GDK_PROXIMITY_IN: return string_to_symbol( "proximity-in" );
      case GDK_PROXIMITY_OUT: return string_to_symbol( "proximity-out" );
      case GDK_DRAG_ENTER: return string_to_symbol( "drag-enter" );
      case GDK_DRAG_LEAVE: return string_to_symbol( "drag-leave" );
      case GDK_DRAG_MOTION: return string_to_symbol( "drag-motion" );
      case GDK_DRAG_STATUS: return string_to_symbol( "drag-status" );
      case GDK_DROP_START: return string_to_symbol( "drop-start" );
      case GDK_DROP_FINISHED: return string_to_symbol( "drop-finished" );
      case GDK_CLIENT_EVENT: return string_to_symbol( "client-event" );
      case GDK_VISIBILITY_NOTIFY: return string_to_symbol( "visibility" );
      case GDK_NO_EXPOSE: return string_to_symbol( "no-expose" );
      default: return string_to_symbol( "???" );
   }
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_event_time ...                                              */
/*---------------------------------------------------------------------*/
int
bglk_event_time( GdkEvent *ev ) {
   if( !ev ) {
      return -1;
   }
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_ENTER_NOTIFY:
      case GDK_LEAVE_NOTIFY: 
	 return ((GdkEventCrossing *)ev)->time;

      case GDK_BUTTON_PRESS: 
      case GDK_2BUTTON_PRESS: 
      case GDK_3BUTTON_PRESS: 
      case GDK_BUTTON_RELEASE:
	 return ((GdkEventButton *)ev)->time;
	 
      case GDK_MOTION_NOTIFY: 
	 return ((GdkEventMotion *)ev)->time;

      case GDK_KEY_PRESS:
	 return ((GdkEventKey *)ev)->time;

      default:
	 return 0;
   }
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_event_button ...                                            */
/*---------------------------------------------------------------------*/
int
bglk_event_button( GdkEvent *ev ) {
   if( !ev ) return -1;
   
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_BUTTON_PRESS: 
      case GDK_2BUTTON_PRESS: 
      case GDK_3BUTTON_PRESS: 
      case GDK_BUTTON_RELEASE:
	 return ((GdkEventButton *)ev)->button;

      case GDK_MOTION_NOTIFY: {
	 int state = ((GdkEventMotion *)ev)->state;

	 if( state & GDK_BUTTON1_MASK )
	    return 1;
	 if( state & GDK_BUTTON2_MASK )
	    return 2;
	 if( state & GDK_BUTTON3_MASK )
	    return 3;
	 return 0;
      }
	 
      default:
	 return 0;
   }
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_event_keyval ...                                            */
/*---------------------------------------------------------------------*/
int
bglk_event_keyval( GdkEvent *ev ) {
   int keyval;
   
   if( !ev ) return -1;
   
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_KEY_PRESS: 
	 switch (keyval = ((GdkEventKey *)ev)->keyval) {
	    case GDK_Return: return '\n';
	    default: return keyval;
	 }

      default:
	 return -1;
   }
}

/*---------------------------------------------------------------------*/
/*    char                                                             */
/*    bglk_event_char ...                                              */
/*---------------------------------------------------------------------*/
char
bglk_event_char( GdkEvent *ev ) {
   int keyval;
   
   if( !ev ) return -1;
   
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_KEY_PRESS: 
	 switch (keyval = ((GdkEventKey *)ev)->keyval) {
	    case GDK_Return:
	       return '\n';
	    case GDK_Tab:
	       return '\t';
	    default:
	       return ((keyval < 255) ? keyval : 0);
	 }

      default:
	 return 0;
   }
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_event_modifiers ...                                         */
/*---------------------------------------------------------------------*/
obj_t
bglk_event_modifiers( GdkEvent *ev ) {
   int mods;
   obj_t res = BNIL;
   
   if( !ev ) return BNIL;
   
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_ENTER_NOTIFY:
      case GDK_LEAVE_NOTIFY: 
	 mods = ((GdkEventCrossing *)ev)->state;
	 break;

      case GDK_BUTTON_PRESS: 
      case GDK_2BUTTON_PRESS: 
      case GDK_3BUTTON_PRESS: 
      case GDK_BUTTON_RELEASE:
	 mods = ((GdkEventButton *)ev)->state;
	 break;

      case GDK_MOTION_NOTIFY: 
	 mods = ((GdkEventMotion *)ev)->state;
	 break;
	    
      case GDK_KEY_PRESS:
	 mods = ((GdkEventKey *)ev)->state;
	 break;
	    
      default:
	 mods = 0;
   }

   if( mods & GDK_SHIFT_MASK )
      res = MAKE_PAIR( string_to_symbol( "shift" ), res );
   
   if( mods & GDK_LOCK_MASK )
      res = MAKE_PAIR( string_to_symbol( "lock" ), res );
      
   if( mods & GDK_CONTROL_MASK )
      res = MAKE_PAIR( string_to_symbol( "control" ), res );
	 
   if( mods & GDK_MOD1_MASK )
      res = MAKE_PAIR( string_to_symbol( "mod1" ), res );
	    
   if( mods & GDK_MOD2_MASK )
      res = MAKE_PAIR( string_to_symbol( "mod2" ), res );
	       
   if( mods & GDK_MOD3_MASK )
      res = MAKE_PAIR( string_to_symbol( "mod3" ), res );
		  
   if( mods & GDK_MOD4_MASK )
      res = MAKE_PAIR( string_to_symbol( "mod4" ), res );
		     
   if( mods & GDK_MOD5_MASK )
      res = MAKE_PAIR( string_to_symbol( "mod5" ), res );
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_event_x ...                                                 */
/*---------------------------------------------------------------------*/
int
bglk_event_x( GdkEvent *ev ) {
   if( !ev ) return -1;
   
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_ENTER_NOTIFY:
      case GDK_LEAVE_NOTIFY: 
	 return ((GdkEventCrossing *)ev)->x;

      case GDK_BUTTON_PRESS: 
      case GDK_2BUTTON_PRESS: 
      case GDK_3BUTTON_PRESS: 
      case GDK_BUTTON_RELEASE:
	 return ((GdkEventButton *)ev)->x;
	 
      case GDK_MOTION_NOTIFY: 
	 return ((GdkEventMotion *)ev)->x;

      case GDK_CONFIGURE: 
	 return ((GdkEventConfigure *)ev)->x;

      default:
	 return -1;
   }
}
   
/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_event_y ...                                                 */
/*---------------------------------------------------------------------*/
int
bglk_event_y( GdkEvent *ev ) {
   if( !ev ) return -1;
   
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_ENTER_NOTIFY:
      case GDK_LEAVE_NOTIFY: 
	 return ((GdkEventCrossing *)ev)->y;

      case GDK_BUTTON_PRESS: 
      case GDK_2BUTTON_PRESS: 
      case GDK_3BUTTON_PRESS: 
      case GDK_BUTTON_RELEASE:
	 return ((GdkEventButton *)ev)->y;
	 
      case GDK_MOTION_NOTIFY: 
	 return ((GdkEventMotion *)ev)->y;

      case GDK_CONFIGURE: 
	 return ((GdkEventConfigure *)ev)->y;

      default:
	 return -1;
   }
}
   
/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_event_width ...                                             */
/*---------------------------------------------------------------------*/
int
bglk_event_width( GdkEvent *ev ) {
   if( !ev ) return -1;
   
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_CONFIGURE: 
	 return ((GdkEventConfigure *)ev)->width;

      default:
	 return -1;
   }
}
   
/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_event_height ...                                            */
/*---------------------------------------------------------------------*/
int
bglk_event_height( GdkEvent *ev ) {
   if( !ev ) return -1;
   
   switch( ((GdkEventAny *)ev)->type ) {
      case GDK_CONFIGURE: 
	 return ((GdkEventConfigure *)ev)->height;

      default:
	 return -1;
   }
}
   
/*---------------------------------------------------------------------*/
/*    static obj_t                                                     */
/*    bglk_event_wrap ...                                              */
/*---------------------------------------------------------------------*/
static obj_t
bglk_event_wrap( GdkEvent *ev, obj_t receiver ) {
   if( !ev ) {
      bglk_null_event_descriptor->BgL_z52eventz52 = ev;
      bglk_null_event_descriptor->BgL_z52widgetz52 = receiver;
      return (obj_t)bglk_null_event_descriptor;
   } else {
      switch( ev->type ) {
	 case GDK_ENTER_NOTIFY:
	 case GDK_LEAVE_NOTIFY: 
	 case GDK_BUTTON_PRESS: 
	 case GDK_2BUTTON_PRESS: 
	 case GDK_3BUTTON_PRESS: 
	 case GDK_BUTTON_RELEASE:
	 case GDK_MOTION_NOTIFY:
	    bglk_mouse_event_descriptor->BgL_z52eventz52 = ev;
	    bglk_mouse_event_descriptor->BgL_z52widgetz52 = receiver;
	    return (obj_t)bglk_mouse_event_descriptor;

	 case GDK_KEY_PRESS:
	    bglk_key_event_descriptor->BgL_z52eventz52 = ev;
	    bglk_key_event_descriptor->BgL_z52widgetz52 = receiver;
	    return (obj_t)bglk_key_event_descriptor;

	 default: 
	    bglk_widget_event_descriptor->BgL_z52eventz52 = ev;
	    bglk_widget_event_descriptor->BgL_z52widgetz52 = receiver;
	    return (obj_t)bglk_widget_event_descriptor;
      }
   }
}
   
/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_event_callback ...                                          */
/*---------------------------------------------------------------------*/
static void bglk_event_callback( GtkWidget* w, GdkEvent *ev, gpointer p ) {
   obj_t proc = (obj_t)p;
   obj_t bobj = BREF( gtk_object_get_user_data( GTK_OBJECT( w ) ) );

   PROCEDURE_ENTRY( proc )( proc, bglk_event_wrap( ev, bobj ), BEOA );
}

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_child_callback ...                                          */
/*---------------------------------------------------------------------*/
static void bglk_child_callback( GtkWidget* w, GtkWidget *c, gpointer p ) {
   obj_t proc = (obj_t)p;
   obj_t bobj = BREF( gtk_object_get_user_data( GTK_OBJECT( c ) ) );

   PROCEDURE_ENTRY( proc )( proc, bglk_event_wrap( 0L, bobj ), BEOA );
}

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_signal_callback ...                                         */
/*---------------------------------------------------------------------*/
static void bglk_signal_callback( GtkWidget* w, gpointer p ) {
   obj_t proc = (obj_t)p;
   obj_t bobj = BREF( gtk_object_get_user_data( GTK_OBJECT( w ) ) );

   PROCEDURE_ENTRY( proc )( proc, bglk_event_wrap( 0L, bobj ), BEOA );
}

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_canvas_item_event_callback ...                              */
/*    -------------------------------------------------------------    */
/*    This is the generic call back for canvas item. Canvas item       */
/*    are handled specially because they can only be bound to the      */
/*    gtk "event" signal. In consequence, when this signal is received */
/*    we have to check by hand the mask of the user signal.            */
/*---------------------------------------------------------------------*/
static void bglk_canvas_item_event_callback( GtkWidget* w,
					     GdkEvent *ev,
					     gpointer p ) {
   obj_t pair = (obj_t)p;
   int mask = CINT( CDR( pair ) );
   int type = ev->type;

   if( (mask & (1 << type)) == (1 << type) ) {
      obj_t proc = CAR( pair );
      obj_t bobj = BREF( gtk_object_get_user_data( GTK_OBJECT( w ) ) );
      
      if( PROCEDUREP( proc ) && PROCEDURE_CORRECT_ARITYP( proc, 1 ) ) 
	 PROCEDURE_ENTRY( proc )( proc, bglk_event_wrap( ev, bobj ), BEOA );
   }
}

/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    bglk_toolbar_callback ...                                        */
/*---------------------------------------------------------------------*/
void
bglk_toolbar_callback( GtkWidget* w, gpointer p ) {
   obj_t bobj = BREF( gtk_object_get_user_data( GTK_OBJECT( w ) ) );
   
   PROCEDURE_ENTRY( p )( p, bglk_event_wrap( 0L, bobj ), BEOA );
}

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_menu_item_event_callback ...                                */
/*---------------------------------------------------------------------*/
static void bglk_menu_item_event_callback( GtkWidget* w, gpointer proc ) {
   obj_t bobj = BREF( gtk_object_get_user_data( GTK_OBJECT( w ) ) );

   /* we launch the Bigloo callback iff the radio is active      */
   /* otherwise we would launch two callbacks per activate event */
   if( !GTK_IS_RADIO_MENU_ITEM( w ) ||BGLK_CHECK_MENU_ITEM_ACTIVE( w ) )
      PROCEDURE_ENTRY( proc )( proc, bglk_event_wrap( 0L, bobj ), BEOA );
}
/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_select_row_callback ...                                     */
/*---------------------------------------------------------------------*/
static void
bglk_select_row_callback( GtkCList *w,
			  int y, int x,
			  GdkEventButton *ev,
			  gpointer user_data ) {
   obj_t proc = (obj_t)user_data;
   obj_t bobj = BREF( gtk_object_get_user_data( GTK_OBJECT( w ) ) );

   /* affect the x and y field so that EVENT-X and EVENT-Y */
   /* will provide the selected row and the clicked column */
   if( ev ) {
      ev->y = y;
      ev->x = column_from_xpixel( w, ev->x );
   }

   PROCEDURE_ENTRY( proc )( proc,
			    bglk_event_wrap( (GdkEvent *)ev, bobj ),
			    BEOA );
}

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_click_column_callback ...                                   */
/*---------------------------------------------------------------------*/
static void
bglk_click_column_callback( GtkCList *clist, int y, gpointer user_data) {
   printf( "bglk_click_column: %d\n", y );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_install_widget_event_handler ...                            */
/*---------------------------------------------------------------------*/
obj_t
bglk_install_widget_event_handler( GtkObject *o, obj_t p, char *name ) {
   gtk_signal_connect_after( o, name, bglk_event_callback, p );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_uninstall_widget_event_handler ...                          */
/*---------------------------------------------------------------------*/
obj_t
bglk_uninstall_widget_event_handler( GtkObject *o, obj_t p ) {
   gtk_signal_disconnect_by_func( o, bglk_event_callback, p );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_install_widget_signal_handler ...                           */
/*---------------------------------------------------------------------*/
obj_t
bglk_install_widget_signal_handler( GtkObject *o, obj_t p, char *name ) {
   gtk_signal_connect( o, name, bglk_signal_callback, p );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_uninstall_widget_signal_handler ...                         */
/*---------------------------------------------------------------------*/
obj_t
bglk_uninstall_widget_signal_handler( GtkObject *o, obj_t p ) {
   gtk_signal_disconnect_by_func( o, bglk_signal_callback, p );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_install_child_handler ...                                   */
/*---------------------------------------------------------------------*/
obj_t
bglk_install_child_handler( GtkObject *o, obj_t p, char *name ) {
   gtk_signal_connect_after( o, name, bglk_child_callback, p );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_uninstall_child_handler ...                                 */
/*---------------------------------------------------------------------*/
obj_t
bglk_uninstall_child_handler( GtkObject *o, obj_t p ) {
   gtk_signal_disconnect_by_func( o, bglk_child_callback, p );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_install_canvas_item_event_handler ...                       */
/*    -------------------------------------------------------------    */
/*    See bglk_canvas_item_event_callback.                             */
/*---------------------------------------------------------------------*/
obj_t
bglk_install_canvas_item_event_handler( GtkObject *o, obj_t pair ) {
   gtk_signal_connect( o, "event", bglk_canvas_item_event_callback, pair );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_uninstall_canvas_item_event_handler ...                     */
/*    -------------------------------------------------------------    */
/*    See bglk_canvas_item_event_callback.                             */
/*---------------------------------------------------------------------*/
obj_t
bglk_uninstall_canvas_item_event_handler( GtkObject *o, obj_t pair ) {
   gtk_signal_disconnect_by_func( o, bglk_canvas_item_event_callback, pair );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_install_menu_item_event_handler ...                         */
/*    -------------------------------------------------------------    */
/*    See bglk_menu_item_event_callback.                               */
/*---------------------------------------------------------------------*/
obj_t bglk_install_menu_item_event_handler( GtkObject *o, obj_t p ) {
   gtk_signal_connect( o, "activate", bglk_menu_item_event_callback, p );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_uninstall_menu_item_event_handler ...                       */
/*    -------------------------------------------------------------    */
/*    See bglk_menu_item_event_callback.                               */
/*---------------------------------------------------------------------*/
obj_t bglk_uninstall_menu_item_event_handler( GtkObject *o, obj_t p ) {
   gtk_signal_disconnect_by_func( o, bglk_menu_item_event_callback, p );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_install_row_select_handler ...                              */
/*---------------------------------------------------------------------*/
obj_t
bglk_install_row_select_handler( GtkObject *o, obj_t p ) {
   gtk_signal_connect( o, "select_row", bglk_select_row_callback, p );
   return p;
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_uninstall_row_select_handler ...                            */
/*---------------------------------------------------------------------*/
obj_t
bglk_uninstall_row_select_handler( GtkObject *o, obj_t p ) {
   gtk_signal_disconnect_by_func( o, bglk_select_row_callback, p );
   return p;
}

