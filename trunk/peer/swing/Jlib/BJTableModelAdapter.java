/*=====================================================================*/
/*    swing/Jlib/BJTableModelAdapter.java                              */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Tue Apr 13 18:20:18 2004 (dciabrin)               */
/*    Copyright   :  2001-04 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    The Biglook TableModelAdapter                                    */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.table.*;
import javax.swing.event.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJTableModelAdapter ...                                          */
/*---------------------------------------------------------------------*/
public class BJTableModelAdapter implements TableModelListener {
    public procedure proc = null;
    public procedure wrapper = null;
    public Object bglk_object;
    //private int last = -1;

    private BJTableModelAdapter( Object o, procedure p, procedure w ) {
	bglk_object = o;
	proc = p;
	wrapper = w;
    }
    
    /*
    static Object getListSelectionAdapterProc( DefaultListSelectionModel comp ) {
	BJListSelectionAdapter a = findAdapter( comp );

	if( (a == null) || (a.proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.proc;
	}
    }	
    */

    public static Object wrap_event( Object receiver,
			      TableModelEvent event, 
			      procedure wrapper ) {
	int x, y;
	return wrapper.funcall2( event, receiver );
    }
    
    public static BJTableModelAdapter findAdapter( TableModel comp ) {
	TableModelListener[] mls = (TableModelListener[])(((AbstractTableModel)comp).getListeners( BJTableModelAdapter.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJTableModelAdapter )
		    return (BJTableModelAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    public static void addTableModelAdapter( TableModel comp, 
				      Object o, 
				      Object p, 
				      procedure w ) { 
	BJTableModelAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure proc = null;
	    if( p instanceof procedure )
		proc = (procedure)p;
	    comp.addTableModelListener( new BJTableModelAdapter( o, proc, w ));
	} else {
	    if( p instanceof procedure )
		a.proc = (procedure)p;
	    else {
		if( p == foreign.BFALSE )
		    a.proc = null;
	    }
	}
    }

    public void tableChanged( TableModelEvent e ) {
	TableModel tm = (TableModel)e.getSource();
	if ((e.getType()==TableModelEvent.UPDATE) &&
	    (e.getColumn()!=TableModelEvent.ALL_COLUMNS)) {
	    proc.funcall1( wrap_event( bglk_object, e, wrapper ) );
	}
    }
}
