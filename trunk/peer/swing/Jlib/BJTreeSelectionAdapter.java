/*=====================================================================*/
/*    .../biglook/peer/swing/Jlib/BJTreeSelectionAdapter.java          */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:51:23 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook TreeSelectionAdapter                                 */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.tree.*;
import javax.swing.*;
import javax.swing.event.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJTreeSelectionAdapter ...                                       */
/*---------------------------------------------------------------------*/
public class BJTreeSelectionAdapter implements TreeSelectionListener {
    public procedure proc = null;
    public procedure wrapper = null;

    private BJTreeSelectionAdapter( procedure p, procedure w ) {
	proc = p;
	wrapper = w;
    }

    static Object wrap_event( TreeSelectionEvent event, procedure wrapper ) {
	TreePath the_path = event.getPath();
	int size = the_path.getPathCount();
	Object[] path  = the_path.getPath();
	Object receiver = Bglk.get_bglk_object( path[ size - 1 ] );
	
	return wrapper.funcall2( event, receiver );
    }

    public void valueChanged( TreeSelectionEvent e ) {
	proc.funcall1( wrap_event( e, wrapper ) );
    }

    static BJTreeSelectionAdapter findAdapter( JTree comp ) {
	TreeSelectionListener[] mls = (TreeSelectionListener[])(comp.getListeners( TreeSelectionListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJTreeSelectionAdapter )
		    return (BJTreeSelectionAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    static Object getTreeSelectionAdapterProc( JTree comp ) {
	BJTreeSelectionAdapter a = findAdapter( comp );

	if( (a == null) || (a.proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.proc;
	}
    }	

    static void addTreeSelectionAdapter( JTree comp, Object p, procedure w ) { 
	BJTreeSelectionAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure proc = null;
	    if( p instanceof procedure )
		proc = (procedure)p;
	    comp.addTreeSelectionListener( new BJTreeSelectionAdapter( proc, w ) );
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
