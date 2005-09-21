/*=====================================================================*/
/*    gtk2/Clib/gtkarg.c                                               */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Tue Apr 10 15:34:59 2001                          */
/*    Last change :  Wed Sep 21 13:30:05 2005 (dciabrin)               */
/*    Copyright   :  2001-05 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    GValue calls                                                     */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>
#include <string.h>

/*---------------------------------------------------------------------*/
/*    Importations                                                     */
/*---------------------------------------------------------------------*/
obj_t the_c_failure( char *proc, char *msg, obj_t obj) {
  return the_failure(string_to_bstring(proc),string_to_bstring(msg),obj);
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_g_property_get ...                                          */
/*---------------------------------------------------------------------*/
obj_t
bglk_g_property_get( GObject *gobj, char *name ) {
   GValue gval;
   GType type;

 loop:
   memset (&gval, 0, sizeof (GValue));
   /* We apparently need to set gval's type before calling g_object_get_property. */
   {
     GParamSpec *pspec;
     pspec = g_object_class_find_property (G_OBJECT_GET_CLASS(gobj), name);
     if (NULL == pspec)
       return BUNSPEC;

     g_value_init (&gval, pspec->value_type);
   }
   
   g_object_get_property( gobj, name, &gval );
   type = G_VALUE_TYPE( &gval);

   switch( type ) {
      case G_TYPE_INVALID:
      case G_TYPE_NONE:
	 return BUNSPEC;
	 
      case G_TYPE_STRING:
	 return string_to_bstring( g_value_get_string( &gval ) );

      case G_TYPE_DOUBLE:
	 return DOUBLE_TO_REAL( g_value_get_double( &gval ) );

      case G_TYPE_FLOAT:
	 return FLOAT_TO_REAL( g_value_get_float( &gval ) );

      case G_TYPE_UINT:
	 return BINT( g_value_get_uint( &gval ) );
	 
      case G_TYPE_INT:
	 return BINT( g_value_get_int( &gval ) );

      case G_TYPE_ULONG:
	 return BINT( g_value_get_ulong( &gval ) );
	 
      case G_TYPE_ENUM:
	 return BINT( g_value_get_enum( &gval ) );

      case G_TYPE_BOOLEAN:
	 return BBOOL( g_value_get_boolean( &gval ) );

      case G_TYPE_POINTER:
	 return g_value_get_pointer( &gval );

      default:
	 if( type == GTK_TYPE_CONTAINER ||
	     type == GDK_TYPE_PIXBUF ||
	     type == G_TYPE_OBJECT ) {
	    goto user_data;
	 } else {
	    if( (type == GTK_TYPE_JUSTIFICATION) ||
		(type == GTK_TYPE_POSITION_TYPE) ||
		(type == GTK_TYPE_RELIEF_STYLE) ||
	        (type == GTK_TYPE_SHADOW_TYPE) ||
	        (type == GTK_TYPE_PROGRESS_BAR_STYLE) ||
	        (type == GTK_TYPE_ANCHOR_TYPE) ||
	        (type == GTK_TYPE_POLICY_TYPE) ||
	        (type == GTK_TYPE_CORNER_TYPE) ||
	        (type == GTK_TYPE_SELECTION_MODE) ||
	        (type == GDK_TYPE_CAP_STYLE) ||
	        (type == GDK_TYPE_JOIN_STYLE) ||
	        (type == GDK_TYPE_LINE_STYLE) ) {
	       return BINT( g_value_get_enum( &gval ) );
	    } else {
	       if( type == GNOME_TYPE_CANVAS_POINTS ) {
		  return bglk_point_to_list( g_value_get_boxed ( &gval ) );
	       } else {
		  printf( "%s:%d:Unknown arg type `%s' -> %d\n",
			  __FILE__, __LINE__, name, G_VALUE_TYPE( &gval ) );
		  printf( "ENUM: %d\n", G_TYPE_ENUM );
		  printf( "FIXED: %d\n", GTK_TYPE_FIXED );
		  printf( "MISC: %d\n", GTK_TYPE_MISC );
	       }
	    }
	 }
   }
   return BUNSPEC;
   
 user_data:
   if( g_value_get_object( &gval ) ){
      gobj = g_value_get_object (&gval);
      name = "user-data";
      goto loop;
   } else {
      return BFALSE;
   }
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_g_property_set ...                                          */
/*---------------------------------------------------------------------*/
obj_t 
bglk_g_property_set( GObject *gobj, char *name, obj_t value ) {
   GValue gval;

   memset (&gval, 0, sizeof (GValue));

   if( STRINGP( value ) ) {
      g_value_init (&gval, G_TYPE_STRING);
      g_value_set_string (&gval, BSTRING_TO_STRING( value ));
   } else {
      if( REALP( value ) ) {
         g_value_init (&gval, G_TYPE_DOUBLE);
	 g_value_set_double (&gval, REAL_TO_DOUBLE( value));
      } else {
	 if( INTEGERP( value ) ) {
            g_value_init (&gval, G_TYPE_UINT);
	    g_value_set_uint (&gval, CINT( value ));
	 } else {
	    if( BOOLEANP( value ) ) {
               g_value_init (&gval, G_TYPE_BOOLEAN);
	       g_value_set_boolean (&gval, ((value != BFALSE) ? TRUE : FALSE));
	    } else {
	       if( OPAQUEP( value ) ) {
                  g_value_init (&gval, G_TYPE_OBJECT);
		  g_value_set_object (&gval, (GObject *)value);
	       } else {
		  printf( "%s:%d:Unknown arg type",  __FILE__, __LINE__ );
		  dprint( value );
	       }
	    }
	 }
      }
   }
   
   g_object_set_property ( gobj, name, &gval);
   return value;
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_g_property_type_set ...                                     */
/*---------------------------------------------------------------------*/
obj_t
bglk_g_property_type_set( GObject *gobj, char *name, obj_t value, int t ) {
   GValue gval;
   gint w, h;
   GtkRequisition *req;

   if ( GTK_IS_WINDOW( gobj ) ) {
       if ( !strcmp( name, "width-request" ) ) {

     	   gtk_widget_get_size_request (GTK_WIDGET( gobj ), &w, &h);
	   if( h > 0 )
	     gtk_window_resize (GTK_WINDOW( gobj ), CINT( value ), h);
	   else
	     {
	       req = (GtkRequisition*)malloc(sizeof(GtkRequisition)); 
	       gtk_widget_size_request( GTK_WIDGET( gobj ), req );
	       if( !req->height )
		 req->height = 1;
	       gtk_window_resize (GTK_WINDOW( gobj ), CINT( value ), req->height );
	       free(req );
	     }
    	 }
       if( !strcmp( name, "height-request" ) ) {
   	   gtk_widget_get_size_request (GTK_WIDGET( gobj ), &w, &h);
	   if( w > 0 )
	     gtk_window_resize (GTK_WINDOW( gobj ), w, CINT( value ));
	   else
	     {
	       req = (GtkRequisition*)malloc(sizeof(GtkRequisition)); 
	       gtk_widget_size_request (GTK_WIDGET( gobj ), req);
	       if( !req->width )
		 req->width = 1;
	       gtk_window_resize (GTK_WINDOW( gobj ), req->width, CINT( value ));
	       free (req);
	     }
   	 }
     }

   memset (&gval, 0, sizeof (GValue));

   switch( t ) {
      case G_TYPE_STRING:
	 if( STRINGP( value ) ) {
            g_value_init (&gval, G_TYPE_STRING);
	    g_value_set_string (&gval, BSTRING_TO_STRING( value ));
	 } else
	    the_c_failure( name, "string", value );
	 break;

      case G_TYPE_DOUBLE:
	 if( REALP( value ) ) {
            g_value_init (&gval, G_TYPE_DOUBLE);
	    g_value_set_double (&gval, REAL_TO_DOUBLE( value ));
	 } else
	    the_c_failure( name, "double", value );
	 break;

      case G_TYPE_FLOAT:
	 if( REALP( value ) ) {
            g_value_init (&gval, G_TYPE_FLOAT);
	    g_value_set_float (&gval, REAL_TO_FLOAT( value ));
	 } else
	    the_c_failure( name, "float", value );
	 break;

      case G_TYPE_UINT:
      case G_TYPE_INT:
	 if( INTEGERP( value ) ) {
            g_value_init (&gval, G_TYPE_UINT);
	    g_value_set_uint (&gval, CINT( value ));
	 } else
	    the_c_failure( name, "double", value );
	 break;

      case G_TYPE_ULONG:
	 if( INTEGERP( value ) ) {
            g_value_init (&gval, G_TYPE_ULONG);
	    g_value_set_ulong (&gval, CINT( value ));
	 } else
	    the_c_failure( name, "double", value );
	 break;

      case G_TYPE_ENUM:
	 if( INTEGERP( value ) ) {
            g_value_init (&gval, G_TYPE_ENUM);
	    g_value_set_enum (&gval, CINT( value ));
	 } else
	    the_c_failure( name, "enum", value );
	 break;

      case G_TYPE_BOOLEAN:
	 if( BOOLEANP( value ) ) {
            g_value_init (&gval, G_TYPE_BOOLEAN);
	    g_value_set_boolean (&gval, ((value != BFALSE) ? TRUE : FALSE));
	 } else
	    the_c_failure( name, "bool", value );
	 break;

      case G_TYPE_POINTER:
	 g_value_init (&gval, G_TYPE_POINTER);
	 g_value_set_pointer (&gval, (GObject *)value);
	 break;

      case G_TYPE_BOXED:
	 g_value_init (&gval, G_TYPE_BOXED);
	 g_value_set_boxed (&gval, (GtkObject *)value);
	 break;

      default:
	 g_value_init (&gval, t);
	 if( t == GTK_TYPE_CONTAINER ||
	     t == GDK_TYPE_PIXBUF ||
	     t == G_TYPE_OBJECT ) {
	    g_value_set_object (&gval, (GtkObject *)value);
	 } else {
	    if( (t == GTK_TYPE_JUSTIFICATION) ||
		(t == GTK_TYPE_POSITION_TYPE) ||
		(t == GTK_TYPE_RELIEF_STYLE) ||
		(t == GTK_TYPE_SHADOW_TYPE) ||
		(t == GTK_TYPE_PROGRESS_BAR_STYLE) ||
		(t == GTK_TYPE_ANCHOR_TYPE) ||
		(t == GTK_TYPE_POLICY_TYPE) ||
		(t == GTK_TYPE_CORNER_TYPE) ||
	        (t == GTK_TYPE_SELECTION_MODE) ) {
	       if( INTEGERP( value ) ) 
		  g_value_set_enum (&gval, CINT( value ));
	       else
		  the_c_failure( name, "enum", value );
	       break;
	    } else {
	       if( t == GNOME_TYPE_CANVAS_POINTS ) {
		  GnomeCanvasPoints *pts = bglk_list_to_point( value );

		  g_value_set_boxed ( &gval, pts );
		  g_object_set_property ( gobj, name, &gval );
		  
		  gnome_canvas_points_free( pts );
		  return value;	       
	       } else {
		  printf( "%s:%d:Unknown arg type for `%s' type: %d",
			  __FILE__, __LINE__, name, t );
	       }
	    }
	 }
   }

   g_object_set_property ( gobj, name, &gval );
   return value;
}
   
/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_g_property_gtkobject_set ...                                */
/*---------------------------------------------------------------------*/
obj_t
bglk_g_property_gtkobject_set( GObject *gobj, char *name, GtkObject *value ) {
   return bglk_g_property_type_set( gobj, name, (obj_t)value, G_TYPE_OBJECT );
}
