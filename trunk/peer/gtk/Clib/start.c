/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/gtk/Clib/start.c               */
/*    -------------------------------------------------------------    */
/*    Author      :  Ciabrini, Parra, Epardaud                         */
/*    Creation    :  Tue Sep 19 12:07:29 2000                          */
/*    Last change :  Mon Jul 30 05:46:01 2001 (serrano)                */
/*    Copyright   :  2000-01 Ciabrini, Parra, Epardaud                 */
/*    -------------------------------------------------------------    */
/*    C machinery to start Biglook/GTK programs                        */
/*=====================================================================*/
#include <strings.h>
#include <bigloo.h>
#include <stdio.h>
#include <gtk/gtk.h>

/*---------------------------------------------------------------------*/
/*    Importations                                                     */
/*---------------------------------------------------------------------*/
extern obj_t biglook_peer_version();

/*---------------------------------------------------------------------*/
/*    Global variables                                                 */
/*---------------------------------------------------------------------*/
int biglook_mainloopp = 1;

/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    biglook_panic ...                                                */
/*---------------------------------------------------------------------*/
void
biglook_panic( char *fmt, ... ) {
  return;
}

/*---------------------------------------------------------------------*/
/*    void                                                             */
/*    bglk_gtk_start ...                                               */
/*---------------------------------------------------------------------*/
void
bglk_gtk_start( obj_t gtk_argv, int main_loop_p, char *argv0, char *name ) {
  int argc;
  char **argv;
  int len_argv = VECTOR_LENGTH( gtk_argv );
  char *peer_version = BSTRING_TO_STRING( biglook_peer_version );

  if( !VECTORP( gtk_argv ) )
    exit( 1 );

  /* convert scheme vector to an char*[] for gtk_init */
  argv = alloca( sizeof( char * ) * len_argv );

  for( argc = 0; argc < len_argv; argc++ )
    argv[ argc ] = BSTRING_TO_STRING( VECTOR_REF( gtk_argv, argc ));

  gnomelib_init( "biglook", peer_version );
  gnome_init( "biglook", peer_version, 1, argv );
  gtk_init( &argc, &argv );
}
	
	      

   

