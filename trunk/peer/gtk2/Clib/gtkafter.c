/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gtkafter.c            */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Tue Apr 10 16:18:24 2001                          */
/*    Last change :  Tue Jun 26 05:54:01 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    C part of the Biglook/Gtk after/timeout                          */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>
#include <gtk/gtk.h>

/*---------------------------------------------------------------------*/
/*    static int                                                       */
/*    bglk_timeout_func ...                                            */
/*    -------------------------------------------------------------    */
/*    Callback entry for Glib timeout connection.                      */
/*---------------------------------------------------------------------*/
int
bglk_timeout_func( gpointer p ) {
   return( PROCEDURE_ENTRY( (obj_t)p )( (obj_t)p, BEOA ) != BFALSE );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    registered_proc ...                                              */
/*---------------------------------------------------------------------*/
obj_t registered_proc = BUNSPEC;

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_register_proc ...                                           */
/*---------------------------------------------------------------------*/
static void
bglk_register_proc( obj_t proc ) {
   registered_proc = MAKE_PAIR( proc, registered_proc );
}

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    unregister_proc ...                                              */
/*---------------------------------------------------------------------*/
static void
bglk_unregister_proc( obj_t proc ) {
   if( CAR( registered_proc ) == proc ) {
      registered_proc = CDR( registered_proc );
   } else {
      obj_t run = registered_proc;

      while( CAR( CDR( run ) ) != proc ) {
	 run = CDR( run );
      }

      SET_CDR( run , CDR( CDR( run ) ) );
   }
}
   
/*---------------------------------------------------------------------*/
/*    guint                                                            */
/*    bglk_timeout_add ...                                             */
/*---------------------------------------------------------------------*/
guint
bglk_timeout_add( guint interval, obj_t proc ) {
   bglk_register_proc( proc );
   return g_timeout_add_full( G_PRIORITY_DEFAULT,
			      interval,
			      bglk_timeout_func,
			      proc,
			      (GDestroyNotify)bglk_unregister_proc );
}

/*---------------------------------------------------------------------*/
/*    guint                                                            */
/*    bglk_idle_add ...                                                */
/*---------------------------------------------------------------------*/
guint
bglk_idle_add( obj_t proc ) {
   bglk_register_proc( proc );
   return g_idle_add_full( G_PRIORITY_DEFAULT_IDLE,
			   bglk_timeout_func,
			   proc,
			   (GDestroyNotify)bglk_unregister_proc );
}
