/*=====================================================================*/
/*    swing/Jlib/BJMouseAdapter.java                                   */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Tue May  4 10:53:44 2004 (dciabrin)               */
/*    Copyright   :  2001-04 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    The Biglook MouseAdapter                                        */
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
/*    BJMouseAdapter ...                                               */
/*---------------------------------------------------------------------*/
public class BJMouseAdapter extends java.awt.event.MouseAdapter {
    public procedure press_proc = null;
    public procedure release_proc = null;
    public procedure enter_proc = null;
    public procedure leave_proc = null;
    public procedure click_proc = null;
    public procedure command_proc = null;
    public procedure wrapper = null;

    private BJMouseAdapter( procedure p, procedure r, 
			    procedure e, procedure l, 
			    procedure c, procedure cmd,
			    procedure w ) {
	super();
	press_proc = p;
	release_proc = r;
	enter_proc = e;
	leave_proc = l;
	click_proc = c;
	command_proc = cmd;
	wrapper = w;
    }

    public static Object wrap_event( MouseEvent e, procedure wrapper ) {
	Component ec = e.getComponent();
	Object receiver = Bglk.get_bglk_object( ec );
	
	return wrapper.funcall2( e, receiver );
    }
	
    public void mousePressed( MouseEvent e ) {
	if( press_proc != null ) {
	    press_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void mouseReleased( MouseEvent e ) {
	if( release_proc != null ) {
	    release_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void mouseEntered( MouseEvent e ) {
	if( enter_proc != null ) {
	    enter_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void mouseExited( MouseEvent e ) {
	if( leave_proc != null ) {
	    leave_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public void mouseClicked( MouseEvent e ) {
	if( click_proc != null ) {
	    click_proc.funcall1( wrap_event( e, wrapper ) );
	}
	if( command_proc != null ) {
	    command_proc.funcall1( wrap_event( e, wrapper ) );
	}
    }

    public static BJMouseAdapter findAdapter( Component comp ) {
	MouseListener[] mls = (MouseListener[])(comp.getListeners( MouseListener.class ));
	if( mls.length == 0 ) {
	    return null;
	} else {
	    for( int i = mls.length - 1; i >= 0; i-- ) {
		if( mls[ i ] instanceof BJMouseAdapter )
		    return (BJMouseAdapter)mls[ i ];
	    }
	    return null;
	}
    }

    public static Object getMouseAdapterPress( Component comp ) {
	BJMouseAdapter a = findAdapter( comp );

	if( (a == null) || (a.press_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.press_proc;
	}
    }

    public static Object getMouseAdapterRelease( Component comp ) {
	BJMouseAdapter a = findAdapter( comp );

	if( (a == null) || (a.release_proc == null ) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.release_proc;
	}
    }

    public static Object getMouseAdapterEnter( Component comp ) {
	BJMouseAdapter a = findAdapter( comp );

	if( (a == null) || (a.enter_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.enter_proc;
	}
    }

    public static Object getMouseAdapterLeave( Component comp ) {
	BJMouseAdapter a = findAdapter( comp );

	if( (a == null) || (a.leave_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.leave_proc;
	}
    }

    public static Object getMouseAdapterClick( Component comp ) {
	BJMouseAdapter a = findAdapter( comp );

	if( (a == null) || (a.click_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.click_proc;
	}
    }

    public static Object getMouseAdapterCommand( Component comp ) {
	BJMouseAdapter a = findAdapter( comp );

	if( (a == null) || (a.command_proc == null) ) {
	    return foreign.BUNSPEC;
	} else {
	    return a.command_proc;
	}
    }

    public static void addMouseAdapter( Component comp,
				 Object p, Object r, 
				 Object e, Object l, 
				 Object c, Object cmd,
				 procedure w ) {
	BJMouseAdapter a = findAdapter( comp );

	if( a == null ) {
	    procedure press = null;
	    procedure release = null;
	    procedure enter = null;
	    procedure leave = null;
	    procedure click = null;
	    procedure command = null;

	    if( p instanceof procedure )
		press = (procedure)p;
	    if( r instanceof procedure )
		release = (procedure)r;
	    if( e instanceof procedure )
		enter = (procedure)e;
	    if( l instanceof procedure )
		leave = (procedure)l;
	    if( c instanceof procedure )
		click = (procedure)c;
	    if( cmd instanceof procedure )
		command = (procedure)cmd;

	    comp.addMouseListener( new BJMouseAdapter( press, release, 
						       enter, leave, 
						       click, command,
						       w ) );
	} else {
	    // press
	    if( p instanceof procedure )
		a.press_proc = (procedure)p;
	    else {
		if( p == foreign.BFALSE )
		    a.press_proc = null;
	    }
	    // release
	    if( r instanceof procedure )
		a.release_proc = (procedure)r;
	    else {
		if( r == foreign.BFALSE )
		    a.release_proc = null;
	    }
	    // enter
	    if( e instanceof procedure )
		a.enter_proc = (procedure)e;
	    else {
		if( e == foreign.BFALSE )
		    a.enter_proc = null;
	    }
	    // leave
	    if( l instanceof procedure )
		a.leave_proc = (procedure)l;
	    else {
		if( l == foreign.BFALSE )
		    a.leave_proc = null;
	    }
	    // click
	    if( c instanceof procedure )
		a.click_proc = (procedure)c;
	    else {
		if( c == foreign.BFALSE )
		    a.click_proc = null;
	    }
	    // command
	    if( cmd instanceof procedure )
		a.command_proc = (procedure)cmd;
	    else {
		if( cmd == foreign.BFALSE )
		    a.command_proc = null;
	    }
	}
    }
}
