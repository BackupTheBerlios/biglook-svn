/*=====================================================================*/
/*    gtk/Clib/gtkarg.c                                                */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Tue Apr 10 15:34:59 2001                          */
/*    Last change :  Wed Sep 21 13:34:53 2005 (dciabrin)               */
/*    Copyright   :  2001-05 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    Gtk arg calls                                                    */
/*=====================================================================*/
#include <bigloo.h>
#include <biglook_peer.h>

/*---------------------------------------------------------------------*/
/*    Importations                                                     */
/*---------------------------------------------------------------------*/
obj_t the_c_failure( char *proc, char *msg, obj_t obj) {
  return the_failure(string_to_bstring(proc),string_to_bstring(msg),obj);
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_arg_get ...                                             */
/*---------------------------------------------------------------------*/
obj_t
bglk_gtk_arg_get( GtkObject *gobj, char *name ) {
   GtkArg arg;

   arg.name = name;
   gtk_object_arg_get( gobj, &arg, NULL );

 loop:
   switch( arg.type ) {
      case GTK_TYPE_INVALID:
      case GTK_TYPE_NONE:
	 return BUNSPEC;
	 
      case GTK_TYPE_STRING:
	 return string_to_bstring( GTK_VALUE_STRING( arg ) );

      case GTK_TYPE_DOUBLE:
	 return DOUBLE_TO_REAL( GTK_VALUE_DOUBLE( arg ) );

      case GTK_TYPE_FLOAT:
	 return FLOAT_TO_REAL( GTK_VALUE_FLOAT( arg ) );

      case GTK_TYPE_UINT:
	 return BINT( GTK_VALUE_UINT( arg ) );
	 
      case GTK_TYPE_INT:
	 return BINT( GTK_VALUE_INT( arg ) );

      case GTK_TYPE_ULONG:
	 return BINT( GTK_VALUE_ULONG( arg ) );
	 
      case GTK_TYPE_ENUM:
	 return BINT( GTK_VALUE_ENUM( arg ) );

      case GTK_TYPE_BOOL:
	 return BBOOL( GTK_VALUE_BOOL( arg ) );

      case GTK_TYPE_OBJECT:
	 goto user_data;
	 break;

      case GTK_TYPE_POINTER:
	 return GTK_VALUE_POINTER( arg );

      default:
	 if( arg.type == GTK_TYPE_CONTAINER ) {
	    goto user_data;
	 } else {
	    if( (arg.type == GTK_TYPE_JUSTIFICATION) ||
		(arg.type == GTK_TYPE_POSITION_TYPE) ||
		(arg.type == GTK_TYPE_RELIEF_STYLE) ||
	        (arg.type == GTK_TYPE_SHADOW_TYPE) ||
	        (arg.type == GTK_TYPE_PROGRESS_BAR_STYLE) ||
	        (arg.type == GTK_TYPE_ANCHOR_TYPE) ||
	        (arg.type == GTK_TYPE_POLICY_TYPE) ||
	        (arg.type == GTK_TYPE_CORNER_TYPE) ||
	        (arg.type == GTK_TYPE_SELECTION_MODE) ||
	        (arg.type == GTK_TYPE_GDK_CAP_STYLE) ||
	        (arg.type == GTK_TYPE_GDK_JOIN_STYLE) ||
	        (arg.type == GTK_TYPE_GDK_LINE_STYLE) ) {
	       return BINT( GTK_VALUE_ENUM( arg ) );
	    } else {
	       if( arg.type == GTK_TYPE_GNOME_CANVAS_POINTS ) {
		  return bglk_point_to_list( GTK_VALUE_POINTER( arg ) );
	       } else {
		  printf( "%s:%d:Unknown arg type `%s' -> %d\n",
			  __FILE__, __LINE__, name, arg.type );
		  printf( "ENUM: %d\n", GTK_TYPE_ENUM );
		  printf( "DATA: %d\n", GTK_TYPE_DATA );
		  printf( "FIXED: %d\n", GTK_TYPE_FIXED );
		  printf( "MISC: %d\n", GTK_TYPE_MISC );
	       }
	    }
	 }
   }
   return BUNSPEC;
   
 user_data:
   if( GTK_VALUE_POINTER( arg ) ){
      arg.name = "user_data";
      gtk_object_arg_get( GTK_VALUE_OBJECT( arg ), &arg, NULL );
      goto loop;
   } else {
      return BFALSE;
   }
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_arg_set ...                                             */
/*---------------------------------------------------------------------*/
obj_t 
bglk_gtk_arg_set( GtkObject *gobj, char *name, obj_t value ) {
   GtkArg arg;

   arg.name = name;
   
   if( STRINGP( value ) ) {
      arg.type = GTK_TYPE_STRING;
      GTK_VALUE_STRING( arg ) = BSTRING_TO_STRING( value );
   } else {
      if( REALP( value ) ) {
	 arg.type = GTK_TYPE_DOUBLE;
	 GTK_VALUE_DOUBLE( arg ) = REAL_TO_DOUBLE( value );
      } else {
	 if( INTEGERP( value ) ) {
	    arg.type = GTK_TYPE_UINT;
	    GTK_VALUE_UINT( arg ) = CINT( value );
	 } else {
	    if( BOOLEANP( value ) ) {
	       arg.type = GTK_TYPE_BOOL;
	       GTK_VALUE_UINT( arg ) = ((value != BFALSE) ? TRUE : FALSE);
	    } else {
	       if( OPAQUEP( value ) ) {
		  arg.type = GTK_TYPE_OBJECT;
		  GTK_VALUE_OBJECT( arg ) = (GtkObject *)value;
	       } else {
		  printf( "%s:%d:Unknown arg type",  __FILE__, __LINE__ );
		  dprint( value );
	       }
	    }
	 }
      }
   }

   gtk_object_arg_set( gobj, &arg, NULL );
   return value;
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_arg_type_set ...                                        */
/*---------------------------------------------------------------------*/
obj_t
bglk_gtk_arg_type_set( GtkObject *gobj, char *name, obj_t value, int t ) {
   GtkArg arg;

   arg.name = name;
   arg.type = (GtkType)t;

   switch( t ) {
      case GTK_TYPE_STRING:
	 if( STRINGP( value ) ) 
	    GTK_VALUE_STRING( arg ) = BSTRING_TO_STRING( value );
	 else
	    the_c_failure( name, "string", value );
	 break;

      case GTK_TYPE_DOUBLE:
	 if( REALP( value ) ) 
	    GTK_VALUE_DOUBLE( arg ) = REAL_TO_DOUBLE( value );
	 else
	    the_c_failure( name, "double", value );
	 break;

      case GTK_TYPE_FLOAT:
	 if( REALP( value ) ) 
	    GTK_VALUE_FLOAT( arg ) = REAL_TO_FLOAT( value );
	 else
	    the_c_failure( name, "float", value );
	 break;

      case GTK_TYPE_UINT:
      case GTK_TYPE_INT:
	 if( INTEGERP( value ) ) 
	    GTK_VALUE_UINT( arg ) = CINT( value );
	 else
	    the_c_failure( name, "double", value );
	 break;

      case GTK_TYPE_ULONG:
	 if( INTEGERP( value ) ) 
	    GTK_VALUE_ULONG( arg ) = CINT( value );
	 else
	    the_c_failure( name, "double", value );
	 break;

      case GTK_TYPE_ENUM:
	 if( INTEGERP( value ) ) 
	    GTK_VALUE_ENUM( arg ) = CINT( value );
	 else
	    the_c_failure( name, "enum", value );
	 break;

      case GTK_TYPE_BOOL:
	 if( BOOLEANP( value ) )
	    GTK_VALUE_UINT( arg ) = ((value != BFALSE) ? TRUE : FALSE);
	 else
	    the_c_failure( name, "bool", value );
	 break;

      case GTK_TYPE_OBJECT:
	 GTK_VALUE_OBJECT( arg ) = (GtkObject *)value;
	 break;
	    
      case GTK_TYPE_POINTER:
	 GTK_VALUE_POINTER( arg ) = (GtkObject *)value;
	 break;

      case GTK_TYPE_BOXED:
	 GTK_VALUE_BOXED( arg ) = (GtkObject *)value;
	 break;

      default:
	 if( t == GTK_TYPE_CONTAINER ) {
	    GTK_VALUE_OBJECT( arg ) = (GtkObject *)value;
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
		  GTK_VALUE_ENUM( arg ) = CINT( value );
	       else
		  the_c_failure( name, "enum", value );
	       break;
	    } else {
	       if( t == GTK_TYPE_GNOME_CANVAS_POINTS ) {
		  GnomeCanvasPoints *pts = bglk_list_to_point( value );
		  GTK_VALUE_POINTER( arg ) = (GtkObject *)pts;
		  
		  gtk_object_arg_set( gobj, &arg, NULL );
		  
		  gnome_canvas_points_free( pts );
		  return value;
	       } else {
		  printf( "%s:%d:Unknown arg type for `%s' type: %d",
			  __FILE__, __LINE__, name, t );
		  dprint( value );
	       }
	    }
	 }
   }

   gtk_object_arg_set( gobj, &arg, NULL );
   return value;
}
   
/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_gtk_arg_gtkobject_set ...                                   */
/*---------------------------------------------------------------------*/
obj_t
bglk_gtk_arg_gtkobject_set( GtkObject *gobj, char *name, GtkObject *value ) {
   return bglk_gtk_arg_type_set( gobj, name, (obj_t)value, GTK_TYPE_OBJECT );
}
