/*=====================================================================*/
/*    .../project/biglook/peer/swing/Jlib/BJComponentAdapter.java      */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:49:55 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook ComponentAdapter                                     */
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
/*    BJComponentAdapter                                               */
/*---------------------------------------------------------------------*/
public class BJComponentAdapter extends java.awt.event.ComponentAdapter {
    public procedure configure_proc = null;
    public procedure wrapper = null;

    public BJComponentAdapter() {
	super();
    }

    private BJComponentAdapter( procedure configure, procedure w ) {
	super();
	configure_proc = configure;
	wrapper = w;
    }

    public static Object wrap_event( ComponentEvent e, procedure wrapper ) {
	Component ec = e.getComponent();
	Object receiver = Bglk.get_bglk_object( ec );
	
	return wrapper.funcall2( e, receiver );
    }
	
    public void componentResized( ComponentEvent e ) {
	if( configure_proc != null ) {
	    configure_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void componentMoved( ComponentEvent e ) {
	if( configure_proc != null ) {
	    configure_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public static BJComponentAdapter findAdapter( Component comp ) {
	ComponentListener[] mls = (ComponentListener[])(comp.getListeners( ComponentListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJComponentAdapter )
		    return (BJComponentAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    public static Object getComponentAdapterConfigure( Component comp ) {
	BJComponentAdapter a = findAdapter( comp );

	if( (a == null) || (a.configure_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.configure_proc;
	}
    }

    
    public static void addComponentAdapter( Component comp, Object c, procedure w ) {
	BJComponentAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure configure = null;

	    if( c instanceof procedure )
		configure = (procedure)c;

	    comp.addComponentListener( new BJComponentAdapter( configure, w ) );
	} else {
	    if( c instanceof procedure )
		a.configure_proc = (procedure)c;
	    else {
		if( c == foreign.BFALSE )
		    a.configure_proc = null;
	    }
	}
    }
}
