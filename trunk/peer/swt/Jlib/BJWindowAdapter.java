/*=====================================================================*/
/*    .../project/biglook/peer/swing/Jlib/BJWindowAdapter.java         */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:51:39 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook WindowAdapter                                        */
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
/*    BJWindowAdapter ...                                              */
/*---------------------------------------------------------------------*/
public class BJWindowAdapter extends java.awt.event.WindowAdapter {
    public procedure deiconified_proc = null;
    public procedure iconified_proc = null;
    public procedure destroy_proc = null;
    public procedure wrapper = null;

    private BJWindowAdapter( procedure iconified, 
			     procedure deiconified,
			     procedure destroy,
			     procedure w ) {
	super();

	deiconified_proc = deiconified;
	iconified_proc = iconified;
	destroy_proc = destroy;
	wrapper = w;
    }

    static Object wrap_event( WindowEvent e, procedure wrapper ) {
	Component ec = e.getComponent();
	Object receiver = Bglk.get_bglk_object( ec );
	
	return wrapper.funcall2( e, receiver );
    }

    public void windowClosing( WindowEvent e ) {
	e.getWindow().dispose();
    }

    public void windowClosed( WindowEvent e ) {
	if( destroy_proc != null ) {
	    destroy_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void windowIconified( WindowEvent e ) {
	if( iconified_proc != null ) {
	    iconified_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void windowDeiconified( WindowEvent e ) {
	if( deiconified_proc != null ) {
	    deiconified_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    static Object getWindowAdapterIconify( Window comp ) {
	BJWindowAdapter a = findAdapter( comp );

	if( (a == null) || (a.iconified_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.iconified_proc;
	}
    }

    static Object getWindowAdapterDeiconify( Window comp ) {
	BJWindowAdapter a = findAdapter( comp );

	if( (a == null) || (a.deiconified_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.deiconified_proc;
	}
    }

    static Object getWindowAdapterDestroy( Window comp ) {
	BJWindowAdapter a = findAdapter( comp );

	if( (a == null) || (a.destroy_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.destroy_proc;
	}
    }

    static BJWindowAdapter findAdapter( Window comp ) {
	WindowListener[] mls = (WindowListener[])(comp.getListeners( BJWindowAdapter.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJWindowAdapter )
		    return (BJWindowAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    static void addWindowAdapter( Window comp,
				  Object i, Object di, Object de, 
				  procedure w ) {
	BJWindowAdapter a = findAdapter( comp );
	
	if( a == null ) {
	    procedure iconify = null;
	    procedure deiconify = null;
	    procedure destroy = null;

	    if( i instanceof procedure )
		iconify = (procedure)i;
	    if( di instanceof procedure )
		deiconify = (procedure)di;
	    if( de instanceof procedure )
		destroy = (procedure)de;

	    comp.addWindowListener( new BJWindowAdapter( iconify, 
							 deiconify,
							 destroy,
							 w ) );
	} else {
	    // iconify
	    if( i instanceof procedure )
		a.iconified_proc = (procedure)i;
	    else {
		if( i == foreign.BFALSE )
		    a.iconified_proc = null;
	    }
	    // deiconify
	    if( di instanceof procedure )
		a.deiconified_proc = (procedure)di;
	    else {
		if( di == foreign.BFALSE )
		    a.deiconified_proc = null;
	    }
	    // destroy
	    if( de instanceof procedure )
		a.destroy_proc = (procedure)de;
	    else {
		if( de == foreign.BFALSE )
		    a.destroy_proc = null;
	    }
	}
    }
}
