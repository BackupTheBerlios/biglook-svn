/*=====================================================================*/
/*    .../project/biglook/peer/swing/Jlib/BJChangeAdapter.java         */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:49:47 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook ChangeAdapter                                        */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.Bglk;

/*---------------------------------------------------------------------*/
/*    BJChangeAdapter ...                                              */
/*---------------------------------------------------------------------*/
public class BJChangeAdapter implements javax.swing.event.ChangeListener {
    public procedure proc = null;
    public procedure wrapper = null;

    private BJChangeAdapter( procedure p, procedure w ) {
	proc = p;
	wrapper = w;
    }

    public static Object wrap_event( ChangeEvent e, procedure wrapper ) {
	Object ec = e.getSource();
	Object receiver = Bglk.get_bglk_object( ec );
	
	return wrapper.funcall2( e, receiver );
    }

    public void stateChanged( ChangeEvent e ) {
	proc.funcall1( wrap_event( e, wrapper ) );
    }

    public static BJChangeAdapter findAdapter( JSlider comp ) {
	ChangeListener[] mls = (ChangeListener[])(comp.getListeners( ChangeListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJChangeAdapter )
		    return (BJChangeAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    public static Object getChangeAdapterProc( JSlider comp ) {
	BJChangeAdapter a = findAdapter( comp );

	if( (a == null) || (a.proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.proc;
	}
    }	

    public static void addChangeAdapter( JSlider comp, Object p, procedure w ) { 
	BJChangeAdapter a = findAdapter( comp );
	
	if( a == null ) {
	    procedure proc = null;
	    if( p instanceof procedure )
		proc = (procedure)p;
	    comp.addChangeListener( new BJChangeAdapter( proc, w ) );
	} else {
	    if( p instanceof procedure )
		a.proc = (procedure)p;
	    else {
		if( p == foreign.BFALSE )
		    a.proc = null;
	    }
	}
    }
}
