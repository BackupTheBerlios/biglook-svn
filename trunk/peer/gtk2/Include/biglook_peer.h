/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Include/biglook_peer.h     */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Tue Apr 10 14:52:35 2001                          */
/*    Last change :  Thu Aug 16 10:04:17 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Gtk peer C include file.                                     */
/*=====================================================================*/
#define GTK_ENABLE_BROKEN /* for GtkTree */
#include <gtk/gtk.h>
#include <gtk/gtktree.h>
#include <gtk/gtktreeitem.h>
#include <gdk-pixbuf/gdk-pixbuf.h>
#include <libgnomecanvas/libgnomecanvas.h>

/*---------------------------------------------------------------------*/
/*    Properties                                                       */
/*---------------------------------------------------------------------*/
extern obj_t bglk_g_property_get( GObject *, char * );
extern obj_t bglk_g_property_set( GObject *, char *, obj_t );
extern obj_t bglk_g_property_type_set( GObject *, char *, obj_t, int );
extern obj_t bglk_g_property_gtkobject_set( GObject *, char *, GtkObject * );

/*---------------------------------------------------------------------*/
/*    Event                                                            */
/*---------------------------------------------------------------------*/
extern obj_t bglk_g_object_get_user_data ( GObject * );
extern obj_t bglk_install_widget_event_handler( GtkObject *, obj_t, char * );
extern obj_t bglk_uninstall_widget_event_handler( GtkObject *, obj_t );
extern obj_t bglk_install_child_handler( GtkObject *, obj_t, char * );
extern obj_t bglk_uninstall_child_handler( GtkObject *, obj_t );
extern obj_t bglk_install_widget_signal_handler( GtkObject *, obj_t, char * );
extern obj_t bglk_uninstall_widget_signal_handler( GtkObject *, obj_t );
extern obj_t bglk_install_canvas_item_event_handler( GtkObject *, obj_t );
extern obj_t bglk_uninstall_canvas_item_event_handler( GtkObject *, obj_t );
extern obj_t bglk_install_menu_item_event_handler( GtkObject *, obj_t );
extern obj_t bglk_uninstall_menu_item_event_handler( GtkObject *, obj_t );
extern obj_t bglk_install_row_select_handler( GtkObject *, obj_t );
extern obj_t bglk_uninstall_row_select_handler( GtkObject *, obj_t );

extern obj_t bglk_event_type( GdkEvent * );
extern obj_t bglk_event_modifiers( GdkEvent * );
extern int bglk_event_time( GdkEvent * );
extern int bglk_event_button( GdkEvent * );
extern int bglk_event_x( GdkEvent * );
extern int bglk_event_y( GdkEvent * );
extern int bglk_event_keyval( GdkEvent * );
extern char bglk_event_char( GdkEvent * );
extern void bglk_toolbar_callback( GtkWidget*, gpointer );

/*---------------------------------------------------------------------*/
/*    Widgets                                                          */
/*---------------------------------------------------------------------*/
#define BGLK_GTK_WIDGET_WIDTH( w ) (((GtkWidget *)w)->allocation.width)
#define BGLK_GTK_WIDGET_HEIGHT( w ) (((GtkWidget *)w)->allocation.height)
#define BGLK_GTK_WIDGET_X( w ) (((GtkWidget *)w)->allocation.x)
#define BGLK_GTK_WIDGET_Y( w ) (((GtkWidget *)w)->allocation.y)

/*---------------------------------------------------------------------*/
/*    Containers                                                       */
/*---------------------------------------------------------------------*/
extern obj_t bglk_gtk_container_children( GtkContainer * );
extern obj_t bglk_gtk_viewport_children( GtkContainer * );

/*---------------------------------------------------------------------*/
/*    Image                                                            */
/*---------------------------------------------------------------------*/
extern GtkWidget *bglk_gtk_file_image_new( char * );
extern GtkWidget *bglk_gtk_data_image_new( char *, char * );
extern GtkWidget *bglk_gtk_image_duplicate( GtkObject * );
extern GdkPixbuf *bglk_gtk_image_to_pixbuf( GtkObject * );
#define BGLK_GTK_PIXBUF_TYPE_SET( o, s, p ) \
   bglk_g_property_type_set( (o), (s), (obj_t)(p), GDK_TYPE_PIXBUF )

#define BGLK_GTK_PIXMAP_PIXMAP( o ) \
   (GTK_PIXMAP( o )->pixmap)

#define BGLK_GTK_PIXMAP_BITMAP( o ) \
   (GTK_PIXMAP( o )->mask)

/*---------------------------------------------------------------------*/
/*    Canvas                                                           */
/*---------------------------------------------------------------------*/
extern GtkObject *bglk_gnome_canvas_item_new( GnomeCanvasGroup *, int, obj_t );
extern GnomeCanvasPoints *bglk_list_to_point( obj_t );
extern obj_t bglk_point_to_list( GnomeCanvasPoints * );
extern int bglk_gnome_canvas_get_scroll_region_width( GnomeCanvas * );
extern int bglk_gnome_canvas_get_scroll_region_height( GnomeCanvas * );
extern void bglk_gnome_canvas_scroll_region_width_set( GnomeCanvas *, int );
extern void bglk_gnome_canvas_scroll_region_height_set( GnomeCanvas *, int );

#define BGLK_GNOME_CANVAS_ITEM_VISIBLE( _i ) \
   ((GNOME_CANVAS_ITEM( (_i) )->object.flags) & GNOME_CANVAS_ITEM_VISIBLE)

/*---------------------------------------------------------------------*/
/*    Window                                                           */
/*---------------------------------------------------------------------*/
extern int bglk_window_x (GtkWidget *w);
extern int bglk_window_y (GtkWidget *w);
extern void bglk_window_set_x (GtkWidget *w, int x);
extern void bglk_window_set_y (GtkWidget *w, int y);

/*---------------------------------------------------------------------*/
/*    Colors                                                           */
/*---------------------------------------------------------------------*/
/*--- gtk color -------------------------------------------------------*/
extern double gtk_color_buffer[ 4 ];

#define GTK_COLOR_RED( _buf ) ((int)(_buf[ 0 ] * 255))
#define GTK_COLOR_GREEN( _buf ) ((int)(_buf[ 1 ] * 255))
#define GTK_COLOR_BLUE( _buf ) ((int)(_buf[ 2 ] * 255))
#define GTK_COLOR_OPACITY( _buf ) ((int)(_buf[ 3 ] * 255))

#define GTK_COLOR_BUFFER_RED_SET( _c ) \
  (gtk_color_buffer[ 0 ]=((double)_c/255))
#define GTK_COLOR_BUFFER_GREEN_SET( _c ) \
  (gtk_color_buffer[ 1 ]=((double)_c/255))
#define GTK_COLOR_BUFFER_BLUE_SET( _c ) \
  (gtk_color_buffer[ 2 ]=((double)_c/255))
#define GTK_COLOR_BUFFER_OPACITY_SET( _c ) \
  (gtk_color_buffer[ 3 ]=((double)_c/255))

/*--- gdk color -------------------------------------------------------*/
extern GdkColor gdk_color_buffer;

#define GDK_COLOR_RED( _buf ) ((_buf)->red >> 8)
#define GDK_COLOR_GREEN( _buf ) ((_buf)->green >> 8)
#define GDK_COLOR_BLUE( _buf ) ((_buf)->blue >> 8)
#define GDK_COLOR_OPACITY( _buf ) ((_buf)->pixel >> 8)

#define GDK_COLOR_BUFFER_RED_SET( _c ) \
  (gdk_color_buffer.red = (_c << 8))
#define GDK_COLOR_BUFFER_GREEN_SET( _c ) \
  (gdk_color_buffer.green = (_c << 8))
#define GDK_COLOR_BUFFER_BLUE_SET( _c ) \
  (gdk_color_buffer.blue = (_c << 8))
#define GDK_COLOR_BUFFER_OPACITY_SET( _c ) \
  (gdk_color_buffer.pixel = (_c << 8))

/*---------------------------------------------------------------------*/
/*    Tooltips                                                         */
/*---------------------------------------------------------------------*/
#define BGLK_TOOLTIPS_TEXT(o) \
   ((gtk_tooltips_data_get(o))->tip_text)
#define BGLK_TOOLTIPS_BACKGROUND(o) \
   ((gtk_tooltips_data_get(o))->tooltips->background)
#define BGLK_TOOLTIPS_FOREGROUND(o) \
   ((gtk_tooltips_data_get(o))->tooltips->foreground)
#define BGLK_TOOLTIPS_BACKGROUND_SET(o,c) \
   (gtk_tooltips_set_colors((gtk_tooltips_data_get(o))->tooltips,c,0L))
#define BGLK_TOOLTIPS_P(o) \
    ((int)(gtk_tooltips_data_get(o)))

/*---------------------------------------------------------------------*/
/*    After                                                            */
/*---------------------------------------------------------------------*/
extern int bglk_gtk_timeout_func( gpointer );

/*---------------------------------------------------------------------*/
/*    Lists                                                            */
/*---------------------------------------------------------------------*/
#define BGLK_LIST_GET_SELECTION_MODE( _l ) ((GTK_LIST( _l ))->selection_mode)
#define BGLK_LIST_DATA( _l ) ((GTK_LIST( _l ))->data)
extern obj_t bglk_gtk_list_selection( GtkList * );
extern obj_t bglk_gtk_glist_strings( GList * );
extern obj_t bglk_gtk_glist_objs( GList * );
extern GList *bglk_glist_strings_new( obj_t );

/*---------------------------------------------------------------------*/
/*    Combobox                                                         */
/*---------------------------------------------------------------------*/
#define BGLK_GTK_COMBO_ENTRY( _combo ) \
   GTK_ENTRY( (GTK_COMBO(_combo))->entry )
#define BGLK_GTK_COMBO_LIST( _combo ) \
   (GTK_LIST( GTK_COMBO(_combo)->list )->children)

/*---------------------------------------------------------------------*/
/*    Adjustment                                                       */
/*---------------------------------------------------------------------*/
#define BGLK_ADJUSTMENT_LOWER( _adj) ((_adj)->lower)
#define BGLK_ADJUSTMENT_LOWER_SET( _adj, _val ) ((_adj)->lower = _val)
#define BGLK_ADJUSTMENT_UPPER( _adj) ((_adj)->upper)
#define BGLK_ADJUSTMENT_UPPER_SET( _adj, _val ) ((_adj)->upper = _val)
#define BGLK_ADJUSTMENT_VALUE( _adj) ((_adj)->value)
#define BGLK_ADJUSTMENT_STEP_INCREMENT( _adj) ((_adj)->step_increment)
#define BGLK_ADJUSTMENT_STEP_INCREMENT_SET( _adj, _val ) ((_adj)->step_increment = _val)
#define BGLK_ADJUSTMENT_PAGE_INCREMENT( _adj) ((_adj)->page_increment)
#define BGLK_ADJUSTMENT_PAGE_INCREMENT_SET( _adj, _val ) ((_adj)->page_increment = _val)
#define BGLK_ADJUSTMENT_PAGE_SIZE( _adj) ((_adj)->page_size)
#define BGLK_ADJUSTMENT_PAGE_SIZE_SET( _adj, _val ) ((_adj)->page_size = _val)

/*---------------------------------------------------------------------*/
/*    Paned                                                            */
/*---------------------------------------------------------------------*/
#define BGLK_PANED_POSITION( _paned ) ((_paned)->child1_size)

/*---------------------------------------------------------------------*/
/*    Menu                                                             */
/*---------------------------------------------------------------------*/
#define BGLK_CHECK_MENU_ITEM_ACTIVE( _cmi ) \
   (((GtkCheckMenuItem *)_cmi)->active)

/*---------------------------------------------------------------------*/
/*    Toolbar                                                          */
/*---------------------------------------------------------------------*/
extern int bglk_toolbar_space_size ( GtkToolbar *_tb );
extern GtkReliefStyle bglk_toolbar_button_relief ( GtkToolbar *_tb );

#define BGLK_HANDLE_BOX_GET_SHADOW_TYPE( _hd ) \
   (((GtkHandleBox *)_hd)->shadow_type)

/*---------------------------------------------------------------------*/
/*    File selection                                                   */
/*---------------------------------------------------------------------*/
#define BGLK_FILE_SELECTION_OK_BUTTON( _fs ) \
    ((GtkObject *)(((GtkFileSelection *)(_fs))->ok_button))
#define BGLK_FILE_SELECTION_CANCEL_BUTTON( _fs ) \
    ((GtkObject *)(((GtkFileSelection *)(_fs))->cancel_button))

/*---------------------------------------------------------------------*/
/*    Clist                                                            */
/*---------------------------------------------------------------------*/
#define BIGLOOK_CLIST_SHADOW_TYPE( _cl ) \
   (((GtkCList *)_cl)->shadow_type)
#define BIGLOOK_CLIST_ROW_HEIGHT( _cl ) \
   (GTK_CLIST_ROW_HEIGHT_SET(((GtkCList *)_cl)) ? \
      (((GtkCList *)_cl)->row_height) : \
      -1)

extern void bglk_gtk_clist_add_row( GtkCList *, int );
extern int column_from_xpixel( GtkCList *, int );

/*---------------------------------------------------------------------*/
/*    Main loop                                                        */
/*---------------------------------------------------------------------*/
extern guint bglk_timeout_add( guint, obj_t );
extern guint bglk_idle_add( obj_t );

/*---------------------------------------------------------------------*/
/*    Ports                                                            */
/*---------------------------------------------------------------------*/
#define BIGLOOK_READABLE GDK_INPUT_READ
#define BIGLOOK_WRITABLE GDK_INPUT_WRITE
#define BIGLOOK_EXCEPTION GDK_INPUT_EXCEPTION
