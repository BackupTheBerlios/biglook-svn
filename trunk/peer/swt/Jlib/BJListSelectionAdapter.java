/*=====================================================================*/
/*    .../biglook/peer/swing/Jlib/BJListSelectionAdapter.java          */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 15:45:38 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook ListSelectionAdapter                                 */
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
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJListSelectionAdapter ...                                       */
/*---------------------------------------------------------------------*/
public class BJListSelectionAdapter implements ListSelectionListener {
    public procedure proc = null;
    public procedure wrapper = null;
    public Object bglk_object;
    private int last = -1;

    private BJListSelectionAdapter( Object o, procedure p, procedure w ) {
	bglk_object = o;
	proc = p;
	wrapper = w;
    }

    static Object wrap_event( Object receiver,
			      ListSelectionEvent event, 
			      procedure wrapper ) {
	int x, y;
	return wrapper.funcall2( event, receiver );
    }

    public void valueChanged( ListSelectionEvent e ) {
	ListSelectionModel lsm = (ListSelectionModel)e.getSource();
	if( !lsm.isSelectionEmpty() ) {
	    int current = lsm.getMinSelectionIndex();

	    if( current != last ) {
		last = current;
		proc.funcall1( wrap_event( bglk_object, e, wrapper ) );
	    }
	}
    }

    static BJListSelectionAdapter findAdapter( DefaultListSelectionModel comp ) {
	ListSelectionListener[] mls = (ListSelectionListener[])(comp.getListeners( BJListSelectionAdapter.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJListSelectionAdapter )
		    return (BJListSelectionAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    static Object getListSelectionAdapterProc( DefaultListSelectionModel comp ) {
	BJListSelectionAdapter a = findAdapter( comp );

	if( (a == null) || (a.proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.proc;
	}
    }	

    static void addListSelectionAdapter( DefaultListSelectionModel comp, 
					 Object o, 
					 Object p, 
					 procedure w ) { 
	BJListSelectionAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure proc = null;
	    if( p instanceof procedure )
		proc = (procedure)p;
	    comp.addListSelectionListener( new BJListSelectionAdapter( o, proc, w ) );
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
