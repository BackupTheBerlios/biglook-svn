/*=====================================================================*/
/*    .../prgm/project/biglook/peer/swing/Jlib/BJKeyAdapter.java       */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sun Jul 22 12:01:14 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook KeyAdapter                                           */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJKeyAdapter ...                                                 */
/*---------------------------------------------------------------------*/
public class BJKeyAdapter extends java.awt.event.KeyAdapter {
    public procedure press_proc = null;
    public procedure return_proc = null;
    public procedure wrapper = null;

    private BJKeyAdapter( procedure p, procedure r, procedure w ) {
	press_proc = p;
	return_proc = r;
	wrapper = w;
    }

    static Object wrap_event( KeyEvent e, procedure wrapper ) {
	Component ec = e.getComponent();
	Object receiver = Bglk.get_bglk_object( ec );
	
	return wrapper.funcall2( e, receiver );
    }
	
    public void keyPressed( KeyEvent e ) {
	if( press_proc != null ) {
	    press_proc.funcall1( wrap_event( e, wrapper ) );
	}
	if( (e.getKeyChar() == '\n') && (return_proc != null) ) {
	    return_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    static BJKeyAdapter findPressAdapter( Component comp ) {
	KeyListener[] mls = (KeyListener[])(comp.getListeners( KeyListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJKeyAdapter && 
		    (((BJKeyAdapter)(mls[ i ])).press_proc != null) )
		    return (BJKeyAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    static BJKeyAdapter findReturnAdapter( Component comp ) {
	KeyListener[] mls = (KeyListener[])(comp.getListeners( KeyListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJKeyAdapter && 
		    (((BJKeyAdapter)(mls[ i ])).return_proc != null) )
		    return (BJKeyAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    static Object getKeyAdapterPress( Component comp ) {
	BJKeyAdapter a = findPressAdapter( comp );

	if( (a == null) || (a.press_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.press_proc;
	}
    }

    static void addKeyAdapter( Component comp, Object p, procedure w ) { 
	BJKeyAdapter a = findPressAdapter( comp );

	if( a == null ) {
	    procedure press = null;
	    if( p instanceof procedure )
		press = (procedure)p;
	    comp.addKeyListener( new BJKeyAdapter( press, null, w ) );
	} else {
	    if( p instanceof procedure )
		a.press_proc = (procedure)p;
	    else {
		if( p == foreign.BFALSE )
		    a.press_proc = null;
	    }
	}
    }

    static void addKeyReturnAdapter( Component comp, Object p, procedure w ) { 
	BJKeyAdapter a = findReturnAdapter( comp );

	if( a == null ) {
	    procedure ret = null;
	    if( p instanceof procedure )
		ret = (procedure)p;
	    comp.addKeyListener( new BJKeyAdapter( null, ret, w ) );
	} else {
	    if( p instanceof procedure )
		a.return_proc = (procedure)p;
	    else {
		if( p == foreign.BFALSE )
		    a.return_proc = null;
	    }
	}
    }
}
