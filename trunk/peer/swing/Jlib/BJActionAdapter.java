/*=====================================================================*/
/*    swing/Jlib/BJActionAdapter.java                                  */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Thu May 17 15:09:33 2001                          */
/*    Last change :  Tue May 11 12:01:12 2004 (dciabrin)               */
/*    Copyright   :  2001-04 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    Action adapter                                                   */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJActionAdapter ...                                              */
/*---------------------------------------------------------------------*/
public class BJActionAdapter extends javax.swing.AbstractAction {
    public procedure action_proc = null;
    public procedure wrapper = null;
    public boolean everything = false;
    Hashtable events = new Hashtable();

    private BJActionAdapter( procedure p, procedure w, String e ) {
	if( (e == null) || (e.length() == 0) ) {
	    everything = true;
	    action_proc = p;
	}
	else
	    events.put( e, p );
	wrapper = w;
    }

    public void actionPerformed( ActionEvent e ) {
	//System.out.println( "action: " + e.getActionCommand() 
	//		    + " " + e.getModifiers() );
	if( everything ) {
	    if( action_proc != null ) {
		Component ec = (Component)e.getSource();
		Object receiver = Bglk.get_bglk_object( ec );
		action_proc.funcall1( wrapper.funcall2( e, receiver ) );
	    }
	} else {
	    procedure proc = (procedure)events.get( e.getActionCommand() );
	    if( proc != null ) {
		Component ec = (Component)e.getSource();
		Object receiver = Bglk.get_bglk_object( ec );
		proc.funcall1( wrapper.funcall2( e, receiver ) );
	    }
	}
    }

    public static BJActionAdapter findAdapter( Component comp ) {
	ActionListener[] mls = (ActionListener[])(comp.getListeners( ActionListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJActionAdapter )
		    return (BJActionAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    public static Object getActionAdapterProc( Component comp, String e ) {
	BJActionAdapter a = findAdapter( comp );

	if( (a == null) || (a.action_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.action_proc;
	}
    }

    public static void addActionAdapter( Component comp, 
				  Object p, 
				  procedure w,
				  String e ) { 
	BJActionAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure action = null;
	    BJActionAdapter na;

	    if( p instanceof procedure )
		action = (procedure)p;

	    na = new BJActionAdapter( action, w, e );

	    if( comp instanceof JFileChooser ) {
		((JFileChooser)comp).addActionListener( na );
	    } else {
		if( comp instanceof AbstractButton ) {
		    ((AbstractButton)comp).addActionListener( na );
		} else {
		    if( comp instanceof JComboBox ) {
			((JComboBox)comp).addActionListener( na );
		    } else {
			System.err.println( "*** ERROR:addActionAdapter: " );
			System.err.print( "Illegal component -- " );
			System.err.println( comp.getClass().getName() );
		    }
		}
	    }
	} else {
	    if( (e == null) || (e.length() == 0) ) {
		if( p instanceof procedure )
		    a.action_proc = (procedure)p;
		else {
		    if( p == foreign.BFALSE )
			a.action_proc = null;
		}
	    } else {
		if( p instanceof procedure ) {
		    a.events.put( e, p );
		} else {
		    if( p == foreign.BFALSE )
			a.events.put( e, null );
		}
	    }
	}
    }
}
