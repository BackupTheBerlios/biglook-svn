/*=====================================================================*/
/*    swing/Jlib/Bglk.java                                             */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Tue Apr 17 17:24:30 2001                          */
/*    Last change :  Tue Nov 30 16:24:28 2004 (dciabrin)               */
/*    Copyright   :  2001-04 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    Various utilities for the Biglook Jvm back-end.                  */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.*;
import javax.swing.tree.*;
import javax.swing.event.*;
import bigloo.*;
import java.lang.Thread;

/*---------------------------------------------------------------------*/
/*    Bglk ...                                                         */
/*---------------------------------------------------------------------*/
public class Bglk {
    private final static WeakHashMap bglk_object_table = new WeakHashMap();
    private static Font bglk_default_font;
    private static JApplet the_applet = null;

    public static void register_bglk_object( Object cmp, Object bgl ) {
	bglk_object_table.put( cmp, bgl );
    }

    public static void unregister_bglk_object( Object cmp ) {
	bglk_object_table.remove( cmp );
    }

    public static void unregister_bglk_object( Container container ) {
	int num = container.getComponentCount();

	while( num > 0 ) {
	    Component c = container.getComponent( num - 1 );
	    if( c instanceof Container )
		unregister_bglk_object( (Container) c );
	    else
		unregister_bglk_object( c );

	    num--;
	}

	unregister_bglk_object( (Object)container );
    }

    public static Object get_bglk_object( Object cmp ) {
	Object aux = bglk_object_table.get( cmp );
	
	if( aux instanceof object )
	    return aux;
	else
	    return bigloo.foreign.BFALSE;
    }

    public static void register_applet( JApplet an_applet ) {
	the_applet = an_applet;
    }

    public static JApplet get_applet() {
	if( the_applet == null ) {
	    the_applet = new JApplet();
	    the_applet.setSize( new Dimension( 400, 200 ) );
	}
	return the_applet;
    }

    public static Object bool_to_jobject( boolean b ) {
	return new Boolean( b );
    }

    public static Object object_to_jobject( object b ) {
	return b;
    }

    public static String string_to_jstring( Object str ) {
	if (str instanceof byte[]) {
	    return new String( (byte[])str );
	} else if (str instanceof char[]) {
	    return new String( (char[])str );
	} else {
	    throw new RuntimeException("invalid bigloo string: "+
				       str.getClass().getName());
	}
    }

    public static String bstring_to_jstring( byte[] str ) {
	return new String( str );
    }

    public static byte[] jstring_to_bstring( String str ) {
	if( str == null ) {
	    return new byte[ 0 ];
	} else {
	    return str.getBytes();
	}
    }

    public static void pack_to_toplevel( Container c, Component k ) {
	while( c != null ) {
	    if( c instanceof Window ) {
		if( c.isValid() ) {
		    ((Window)c).pack();
		} else {
		    c.validate();
		}
	    }
	    c = c.getParent();
	}
    }

    public static void gridbag_add( JPanel panel, Component comp,
			     int x, int w,
			     int y, int h,
			     boolean expand, boolean fillx, boolean filly ) {
	GridBagLayout gbl = (GridBagLayout)panel.getLayout();
	GridBagConstraints c = new GridBagConstraints();

	c.fill = GridBagConstraints.BOTH;
	c.gridx = x;
	c.gridy = y;
	c.gridwidth = w;
	c.gridheight = h;

	if( expand && fillx ) c.weightx = 1.0;
	if( expand && filly ) c.weighty = 1.0;

	panel.add( comp );
	gbl.setConstraints( comp, c );
    }

    public static int show_dialog( javax.swing.JFileChooser d, String t ) {
	return d.showDialog( null, t );
    }

    public static int jvm_main() {
	// starts a thread so that Biglook applications dont end immediatly
	Thread th = java.lang.Thread.currentThread();

	try {
	    while( true ) {
		th.sleep( 10000000 );
	    }
	}
	catch( Exception e ) {
	    return 0;
	}
    }

    public static int getWhen( InputEvent e ) {
	return (int)(e.getWhen() & (long)0x7fffffff);
    }

    private static Object enumeration_to_list( Enumeration e ) {
	Object res = foreign.BNIL;
	
	while( e.hasMoreElements() ) {
	    res = foreign.MAKE_PAIR( get_bglk_object( e.nextElement() ), res );
	}

	return res;
    }

    public static Object bglk_buttongroup_buttons( ButtonGroup g ) {
	return enumeration_to_list( g.getElements() );
    }

    public static Object bglk_treenode_items( TreeNode n ) {
	return enumeration_to_list( n.children() );
    }

    public static Object bglk_tree_coords_to_item( JTree t, int x, int y ) {
	TreePath tp = t.getPathForLocation(x, y);
	if (tp!=null) {
	    BJTreeNode tn=(BJTreeNode)tp.getLastPathComponent();
	    return tn.tree_item;
	} else {
	    return bigloo.bbool.faux;
	}
    }

    public static int bglk_listselectionevent_selection(ListSelectionEvent e) {
	ListSelectionModel lsm = (ListSelectionModel)e.getSource();
	if( !lsm.isSelectionEmpty() ) {
	    return lsm.getMinSelectionIndex();
	} else {
	    return -1;
	}
    }

    public static void after_idle( final procedure p ) {
	Thread idle = new Thread( new Runnable () {
		public void run() {
		    try {
			p.funcall0();
		    }
		    catch( Exception e ) { ; }
		}
	    });
	idle.start();
    }

    public static Font get_bglk_default_font() {
	return bglk_default_font;
    }

    static {
	bglk_default_font = new Font( "lucida", Font.BOLD, 14 );
    }
}
