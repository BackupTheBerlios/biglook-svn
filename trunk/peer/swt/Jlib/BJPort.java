/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/swing/Jlib/BJPort.java         */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Fri Aug 17 08:01:59 2001                          */
/*    Last change :  Fri Aug 17 09:24:34 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    Nonblocking IO Java implementation                               */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.io.*;
import javax.swing.*;
import javax.swing.tree.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    PortCondition                                                    */
/*---------------------------------------------------------------------*/
class PortCondition {
    boolean value = true;
}

/*---------------------------------------------------------------------*/
/*    BJPort ...                                                       */
/*---------------------------------------------------------------------*/
public class BJPort {
    private final static Hashtable table = new Hashtable();

    static void when_char_ready( final input_port port,
				 final RandomAccessFile rai, 
				 final procedure p ) {
	Thread watch = new Thread( new Runnable () {
		public void run() {
		    Thread th = java.lang.Thread.currentThread();
			
		    try {
			while( rai.getFilePointer() < rai.length() ) {
			    p.funcall1( port );
			    th.sleep( 10 );
			}
		    }
		    catch( Exception e ) { ; }
		}
	    });
	watch.start();
    }

    static void when_char_ready( final input_port port,
				 final InputStream in, 
				 final procedure p ) {
	final PortCondition pcond = new PortCondition();

	table.put( port, pcond );

	Thread watch = new Thread( new Runnable () {
		public void run() {
		    Thread th = java.lang.Thread.currentThread();

		    try {
			while( pcond.value  ) {
			    if( in.available() > 0 ) {
				p.funcall1( port );
				th.sleep( 10 );
			    } else { 
				th.sleep( 100 );
			    }
			}
		    }
		    catch( Exception e ) { ; }
		}
	    });
	watch.start();
    }

    static void when_char_ready( final input_string_port port, 
				 final procedure p ) {
	Thread watch = new Thread( new Runnable () {
		public void run() {
		    Thread th = java.lang.Thread.currentThread();
			
		    try {
			while( !foreign.RGC_BUFFER_EMPTY( (input_string_port)port ) ) {
			    p.funcall1( port );
			    th.sleep( 10 );
			}
		    }
		    catch( Exception e ) { ; }
		}
	    });
	watch.start();
    }

    public static void when_char_ready( final input_port port, 
					final procedure p ) { 
	if( port instanceof input_file_port ) {
	    when_char_ready( port, ((input_file_port)port).in, p );
	}
	if( port instanceof input_pipe_port ||
	    port instanceof input_socket_port ) {
	    InputStream in = (port instanceof input_pipe_port) ?
		((input_pipe_port)port).in :
		((input_socket_port)port).in;
	    when_char_ready( port, in, p );
	}
	if( port instanceof input_string_port ) {
	    when_char_ready( (input_string_port)port, p );
	}
    }

    public static void stop_char_ready( final input_port port ) {
	if( port instanceof input_pipe_port ||
	    port instanceof input_socket_port ) {
	    PortCondition pcond = (PortCondition)table.get( port );

	    if( pcond != null ) {
		pcond.value = false;
	    }
	}
    }
}
