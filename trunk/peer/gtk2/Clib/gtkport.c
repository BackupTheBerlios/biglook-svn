/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/gtkport.c             */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Thu Feb 17 13:10:54 2000                          */
/*    Last change :  Fri Aug 31 09:19:35 2001 (serrano)                */
/*    -------------------------------------------------------------    */
/*    The handling of non blocking Bigloo input ports.                 */
/*=====================================================================*/
#include <bigloo.h>
#include <gdk/gdk.h>

/*---------------------------------------------------------------------*/
/*    static constants                                                 */
/*---------------------------------------------------------------------*/
#define BUFFER_SIZE 1024

/*---------------------------------------------------------------------*/
/*    static functions                                                 */
/*---------------------------------------------------------------------*/
static int event_handler_feof( FILE * );
static int event_handler_fgetc( FILE * );
static int event_handler_fread( char *, long, long, FILE * );
static void event_handler_setup( int );
static void fill_buffer( FILE * );

/*---------------------------------------------------------------------*/
/*    static variables                                                 */
/*---------------------------------------------------------------------*/
static int event_handler_num = 0;
static int *feofs = 0L;
static int *filled = 0;
static int *bufidx = 0;
static int *bufsiz = 0;
static int *count = 0;
static char **buffers = 0L;

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    bglk_invoke_callback ...                                         */
/*---------------------------------------------------------------------*/
static void
bglk_invoke_callback( obj_t p ) {
   obj_t ip = CAR( p );
   
   if( !PROCEDURE_CORRECT_ARITYP( CDR( (obj_t)p ), 1 ) ) {
      fprintf( stderr, "*** INTERNAL-ERROR:Illegal file callback:%s:%d\n",
	       __FILE__, __LINE__ );
      exit( -1 );
   }

   if( INPUT_PORT( ip ).kindof == KINDOF_CLOSED ) {
      bglk_unregister_port_callback( ip );
   } else {
      PROCEDURE_ENTRY( CDR( p ) )( CDR( p ), ip, BEOA );
   
      if( INPUT_PORT( ip ).kindof == KINDOF_CLOSED ) {
	 bglk_unregister_port_callback( ip );
      } else {
	 if( INPUT_PORT( ip ).eof || feof( INPUT_PORT( ip ).file ) ) {
	    PROCEDURE_ENTRY( CDR( p ) )( CDR( p ), ip, BEOA );

	    /* flushout everything left in the buffer */
	    while( !INPUT_PORT( ip ).eof &&
		   INPUT_PORT( ip ).kindof != KINDOF_CLOSED )  {
	       PROCEDURE_ENTRY( CDR( p ) )( CDR( p ), ip, BEOA );
	    }
	 
	    bglk_unregister_port_callback( ip );
	 }
      }
   }
}

/*---------------------------------------------------------------------*/
/*    int                                                              */
/*    bglk_add_input_port_handler ...                                  */
/*---------------------------------------------------------------------*/
int
bglk_add_input_port_handler( obj_t port, int condition, obj_t callback ) {
   FILE *f;
   f = INPUT_PORT( port ).file;

   return gdk_input_add( fileno( f ),
			 condition,
			 (GdkInputFunction)bglk_invoke_callback,
			 (gpointer)callback );
}

/*---------------------------------------------------------------------*/
/*    obj_t                                                            */
/*    bglk_add_input_port_events ...                                   */
/*    -------------------------------------------------------------    */
/*    Declares the input port as a Biglook event receipient.           */
/*---------------------------------------------------------------------*/
obj_t
bglk_add_input_port_events( obj_t port ) {
   int n;
   FILE *f;

   switch( (int)INPUT_PORT( port ).kindof ) {
      case (int)KINDOF_CONSOLE:
      case (int)KINDOF_SOCKET:
	 f = INPUT_PORT( port ).file;
	 n = fileno( f );
	 event_handler_setup( n );
	 INPUT_PORT( port ).syseof = event_handler_feof;
	 INPUT_PORT( port ).sysread = event_handler_fgetc;

	 gdk_input_add( n,
			GDK_INPUT_READ,
			(GdkInputFunction) fill_buffer, 
			(gpointer)f );
	 return BUNSPEC;
	 
      case (int)KINDOF_FILE:
      case (int)KINDOF_PIPE:
	 f = INPUT_PORT( port ).file;
	 n = fileno( f );
	 event_handler_setup( n );
	 INPUT_PORT( port ).syseof = event_handler_feof;
	 INPUT_PORT( port ).sysread = event_handler_fread;
	 gdk_input_add( n,
			GDK_INPUT_READ,
			(GdkInputFunction) fill_buffer, 
			(gpointer)f );
	 return BUNSPEC;

      default:
	 return BUNSPEC;
   }
}

/*---------------------------------------------------------------------*/
/*    static void                                                      */
/*    event_handler_setup ...                                          */
/*---------------------------------------------------------------------*/
static void
event_handler_setup( int n ) {
   if( n >= event_handler_num ) {
      int i, m = n + 1;

      feofs = realloc( feofs, m * sizeof( int ) );
      filled = realloc( filled, m * sizeof( int ) );
      bufidx = realloc( bufidx, m * sizeof( int ) );
      bufsiz = realloc( bufsiz, m * sizeof( int ) );
      count = realloc( count , m * sizeof( int ) );
      buffers = realloc( buffers, m * sizeof( char * ) );

      for( i = event_handler_num; i < m; i++ ) {
	 bufsiz[ i ] = 0L;
	 buffers[ i ] = 0L;
      }
      
      event_handler_num = n;
   }

   feofs[ n ] = 0;
   filled[ n ] = 0;
   count[ n ] = -1;
   bufidx[ n ] = 0;

   if( !buffers[ n ] ) {
      buffers[ n ] = (char *)malloc( BUFFER_SIZE + 1 );
      bufsiz[ n ] = BUFFER_SIZE;
   }
}

      
/*---------------------------------------------------------------------*/
/*    static int                                                       */
/*    event_handler_feof ...                                           */
/*---------------------------------------------------------------------*/
static int
event_handler_feof( FILE *file ) {
   int n = fileno( file );

   return feofs[ n ] || feof( file );
}

/*---------------------------------------------------------------------*/
/*    static int                                                       */
/*    event_handler_fgetc ...                                          */
/*---------------------------------------------------------------------*/
static int
event_handler_fgetc( FILE *file ) {
   int n = fileno( file );

   if( bufidx[ n ] < count[ n ] ) {
      return buffers[ n ][ bufidx[ n ]++ ];
   }
   else {
      filled[ n ] = 0;
      while( !filled[ n ] ) {
	 if( !g_main_iteration( 0 ) ) return EOF;
      }
   }

   if( count[ n ] <= 0 ) {
      return EOF;
   }
   else {
      bufidx[ n ] = 1;
      return buffers[ n ][ 0 ];
   }
}
  
/*---------------------------------------------------------------------*/
/*    static int                                                       */
/*    event_handler_fread ...                                          */
/*---------------------------------------------------------------------*/
static int
event_handler_fread( char *ptr, long size, long nmemb, FILE *file ) {
   int n = fileno( file );
   long sz = size * nmemb;
   long i = 0;

   for( i = 0; i < sz; i++ ) {
      int c = event_handler_fgetc( file );

      if( EOF == c )
	 return i;
      else
	 ptr[ i ] = c;
   }

   return i;
}
  
/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    fill_buffer ...                                                  */
/*---------------------------------------------------------------------*/
static void
fill_buffer( FILE *f ) {
   int fd = fileno( f );

   if( (bufidx[ fd ] == count[ fd ]) || !filled[ fd ] ) {
      feofs[ fd ] = 0;

      for ( ; ; ) {
	 count[ fd ] = read( fd, buffers[ fd ], BUFFER_SIZE );
	 buffers[ fd ][ count[fd] ] = 0;

	 if( !count[ fd ] ) feofs[ fd ] = 1;
	 if( count[ fd ] != -1 || errno != EINTR ) break;
      }
      filled[ fd ] = 1;
   } else {
      if( count[ fd ] == bufsiz[ fd ] ) {
	 bufsiz[ fd ] += BUFFER_SIZE;
	 buffers[ fd ] = realloc( buffers[ fd ], bufsiz[ fd ] + 1 );
      }
      
      count[ fd ] += read( fd,
			   &(buffers[ fd ][ count[ fd ] ]),
			   (bufsiz[ fd ] - count[ fd ] ));
   }
}

