/*=====================================================================*/
/*    .../biglook/peer/swing/Jlib/BJTreeWillExpandAdapter.java         */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:51:31 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook BJTreeWillExpandAdapter                              */
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
import javax.swing.tree.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJTreeWillExpandAdapter                                          */
/*---------------------------------------------------------------------*/
public class BJTreeWillExpandAdapter implements TreeWillExpandListener {
    procedure expand, collapse, wrapper;

    public BJTreeWillExpandAdapter( procedure e, procedure c, procedure w ) {
	expand = e;
	collapse = c;
	wrapper = w;
    }

    public static Object wrap_event( Object receiver, procedure wrapper ) {
	return wrapper.funcall2( null, receiver );
    }
	
    public void treeWillExpand( TreeExpansionEvent event ) {
	TreePath the_path = event.getPath();
	int size = the_path.getPathCount();
	Object[] path  = the_path.getPath();
	Object obj = Bglk.get_bglk_object( path[ size - 1 ] );

	expand.funcall1( wrap_event( obj, wrapper ) );
    }

    public void treeWillCollapse( TreeExpansionEvent event ) {
	TreePath the_path = event.getPath();
	int size = the_path.getPathCount();
	Object[] path  = the_path.getPath();
	Object obj = Bglk.get_bglk_object( path[ size - 1 ] );

	collapse.funcall1( wrap_event( obj, wrapper ) );
    }
}
