/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/swing/Jlib/BJTreeNode.java     */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:51:01 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook Tree Node class                                      */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import javax.swing.*;
import javax.swing.tree.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJTreeNode ...                                                   */
/*---------------------------------------------------------------------*/
public class BJTreeNode extends DefaultMutableTreeNode {
    public boolean leaf;
    public Object tree_item;
    public Object o_icon, c_icon;

    public BJTreeNode( Object ti, boolean l ) {
	super();
	leaf = l;
	tree_item = ti;
    }

    public boolean getAllowsChildren() {
	return !leaf;
    }

    public String toString() {
	return "<BJTreeNode: " + tree_item + " leaf: " + leaf + ">";
    }
    
    public TreePath getFullPath() {
	TreeNode[] p = super.getPath();
	TreePath path = new TreePath( (Object[])p );

	return path;
    }
}
