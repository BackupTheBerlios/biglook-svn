/*=====================================================================*/
/*    .../biglook/peer/swing/Jlib/BJCanvasMouseMotionAdapter.java      */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:49:38 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
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
/*    BJCanvasMouseMotionAdapter ...                                   */
/*---------------------------------------------------------------------*/
public class BJCanvasMouseMotionAdapter extends MouseMotionAdapter {
    procedure bglk_mm;

    BJCanvasMouseMotionAdapter( procedure mm ) {
	super();
	bglk_mm = mm;
    }

    public void mouseMoved( MouseEvent e ) {
	bglk_mm.funcall1( e );
    }

    public void mouseDragged( MouseEvent e ) {
	bglk_mm.funcall1( e );
    }

    static BJCanvasMouseMotionAdapter findAdapter( BJCanvas comp ) {
	MouseMotionListener[] mls = (MouseMotionListener[])(comp.getListeners( MouseMotionListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJCanvasMouseMotionAdapter )
		    return (BJCanvasMouseMotionAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    static Object getCanvasMouseMotionAdapterProc( BJCanvas comp ) {
	BJCanvasMouseMotionAdapter a = findAdapter( comp );

	if( (a == null) || (a.bglk_mm == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.bglk_mm;
	}
    }

    static void addCanvasMouseMotionAdapter( BJCanvas comp, Object p ) {
	BJCanvasMouseMotionAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure proc = null;

	    if( p instanceof procedure )
		proc = (procedure)p;

	    comp.addMouseMotionListener( new BJCanvasMouseMotionAdapter( proc ) );
	} else {
	    // drag
	    if( p instanceof procedure )
		a.bglk_mm = (procedure)p;
	    else {
		if( p == foreign.BFALSE )
		    a.bglk_mm = null;
	    }
	}
    }
}
