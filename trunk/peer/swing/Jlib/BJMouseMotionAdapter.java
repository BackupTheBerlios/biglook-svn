/*=====================================================================*/
/*    .../biglook/peer/swing/Jlib/BJMouseMotionAdapter.java            */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:50:33 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook MouseAdapter                                         */
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
/*    BJMouseMotionAdapter ...                                         */
/*---------------------------------------------------------------------*/
public class BJMouseMotionAdapter extends java.awt.event.MouseMotionAdapter {
    private procedure drag_proc = null;
    private procedure move_proc = null;
    private procedure wrapper = null;

    private BJMouseMotionAdapter( procedure d, procedure m, procedure w ) {
	drag_proc = d;
	move_proc = m;
	wrapper = w;
    }

    static Object wrap_event( MouseEvent e, procedure wrapper ) {
	Component ec = e.getComponent();
	Object receiver = Bglk.get_bglk_object( ec );
	
	return wrapper.funcall2( e, receiver );
    }
	
    public void mouseDragged( MouseEvent e ) {
	if( drag_proc != null ) {
	    drag_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void mouseMoved( MouseEvent e ) {
	if( move_proc != null ) {
	    move_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    static BJMouseMotionAdapter findAdapter( Component comp ) {
	MouseMotionListener[] mls = (MouseMotionListener[])(comp.getListeners( MouseMotionListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJMouseMotionAdapter )
		    return (BJMouseMotionAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    static Object getMouseMotionAdapterDrag( Component comp ) {
	BJMouseMotionAdapter a = findAdapter( comp );

	if( (a == null) || (a.drag_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.drag_proc;
	}
    }

    static Object getMouseMotionAdapterMove( Component comp ) {
	BJMouseMotionAdapter a = findAdapter( comp );

	if( (a == null) || (a.move_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.move_proc;
	}
    }

    static void addMouseMotionAdapter( Component comp,
				       Object d, Object m, 
				       procedure w ) {
	BJMouseMotionAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure drag = null;
	    procedure move = null;

	    if( d instanceof procedure )
		drag = (procedure)d;
	    if( m instanceof procedure )
		move = (procedure)m;

	    comp.addMouseMotionListener( new BJMouseMotionAdapter( drag, 
								   move, 
								   w ) );
	} else {
	    // drag
	    if( d instanceof procedure )
		a.drag_proc = (procedure)d;
	    else {
		if( d == foreign.BFALSE )
		    a.drag_proc = null;
	    }
	    // move
	    if( m instanceof procedure )
		a.move_proc = (procedure)d;
	    else {
		if( m == foreign.BFALSE )
		    a.move_proc = null;
	    }
	}
    }
}
