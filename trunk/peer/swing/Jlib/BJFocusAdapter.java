/*=====================================================================*/
/*    .../prgm/project/biglook/peer/swing/Jlib/BJFocusAdapter.java     */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:50:02 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook FocusAdapter                                         */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.Bglk;

/*---------------------------------------------------------------------*/
/*    BJFocusAdapter                                                   */
/*---------------------------------------------------------------------*/
public class BJFocusAdapter extends java.awt.event.FocusAdapter {
    public procedure in_proc = null;
    public procedure out_proc = null;
    public procedure wrapper = null;

    private BJFocusAdapter( procedure in, procedure out, procedure w ) {
	super();
	in_proc = in;
	out_proc = out;
	wrapper = w;
    }

    public static Object wrap_event( FocusEvent e, procedure wrapper ) {
	Component ec = e.getComponent();
	Object receiver = Bglk.get_bglk_object( ec );
	
	return wrapper.funcall2( e, receiver );
    }
	
    public void focusGained( FocusEvent e ) {
	if( in_proc != null ) {
	    in_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void focusLost( FocusEvent e ) {
	if( out_proc != null ) {
	    out_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public static BJFocusAdapter findAdapter( Component comp ) {
	FocusListener[] mls = (FocusListener[])(comp.getListeners( FocusListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJFocusAdapter )
		    return (BJFocusAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    public static Object getFocusAdapterIn( Component comp ) {
	BJFocusAdapter a = findAdapter( comp );

	if( (a == null) || (a.in_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.in_proc;
	}
    }

    public static Object getFocusAdapterOut( Component comp ) {
	BJFocusAdapter a = findAdapter( comp );

	if( (a == null) || (a.out_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.out_proc;
	}
    }	

    public static void addFocusAdapter( Component comp, Object i, Object o, procedure w ) {
	BJFocusAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure in = null;
	    procedure out = null;

	    if( i instanceof procedure )
		in = (procedure)i;
	    if( o instanceof procedure )
		out = (procedure)o;

	    comp.addFocusListener( new BJFocusAdapter( in, out, w ) );
	} else {
	    // in
	    if( i instanceof procedure )
		a.in_proc = (procedure)i;
	    else {
		if( i == foreign.BFALSE )
		    a.in_proc = null;
	    }
	    // out
	    if( o instanceof procedure )
		a.out_proc = (procedure)o;
	    else {
		if( o == foreign.BFALSE )
		    a.out_proc = null;
	    }
	}
    }
}
