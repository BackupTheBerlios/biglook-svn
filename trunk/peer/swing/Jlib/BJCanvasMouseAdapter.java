/*=====================================================================*/
/*    swing/Jlib/BJCanvasMouseAdapter.java                             */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Thu Nov 25 17:55:07 2004 (dciabrin)               */
/*    Copyright   :  2001-04 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    The Biglook Canvas MouseAdapter                                  */
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
/*    BJCanvasMouseAdapter ...                                         */
/*---------------------------------------------------------------------*/
public class BJCanvasMouseAdapter extends MouseAdapter {
    procedure bglk_press;
    procedure bglk_release;

    public BJCanvasMouseAdapter( procedure press, procedure release ) {
	super();
	bglk_press = press;
	bglk_release = release;
    }

    public void mousePressed( MouseEvent e ) {
	bglk_press.funcall1( e );
    }

    public void mouseReleased( MouseEvent e ) {
	bglk_release.funcall1( e );
    }

    public void mouseEntered( MouseEvent e ) {
    }

    public void mouseExited( MouseEvent e ) {
    }

    public static BJCanvasMouseAdapter findAdapter( BJCanvas comp ) {
	MouseListener[] mls = (MouseListener[])(comp.getListeners( MouseListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJCanvasMouseAdapter )
		    return (BJCanvasMouseAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    public static Object getCanvasMouseAdapterPress( BJCanvas comp ) {
	BJCanvasMouseAdapter a = findAdapter( comp );

	if( (a == null) || (a.bglk_press == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.bglk_press;
	}
    }

    public static Object getCanvasMouseAdapterRelease( BJCanvas comp ) {
	BJCanvasMouseAdapter a = findAdapter( comp );

	if( (a == null) || (a.bglk_release == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.bglk_release;
	}
    }

    public static void addCanvasMouseAdapter( BJCanvas comp, Object p, Object r ) {
	BJCanvasMouseAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure press = null;
	    procedure release = null;

	    if( p instanceof procedure )
		press = (procedure)p;

	    if( r instanceof procedure )
		release = (procedure)r;

	    comp.addMouseListener( new BJCanvasMouseAdapter( press, release ) );
	} else {
	    // press
	    if( p instanceof procedure )
		a.bglk_press = (procedure)p;
	    else {
		if( p == foreign.BFALSE )
		    a.bglk_press = null;
	    }
	    // release
	    if( p instanceof procedure )
		a.bglk_release = (procedure)p;
	    else {
		if( p == foreign.BFALSE )
		    a.bglk_release = null;
	    }
	}
    }
}
