/*=====================================================================*/
/*    .../project/biglook/peer/swing/Jlib/BJTreeCellRenderer.java      */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 15:53:53 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook TreeCell renderer                                    */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.tree.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJTreeCellRenderer                                               */
/*---------------------------------------------------------------------*/
public class BJTreeCellRenderer extends DefaultTreeCellRenderer {
    static symbol sleaf = foreign.string_to_symbol( "leaf".getBytes() );
    static symbol sopen = foreign.string_to_symbol( "open".getBytes() );
    static symbol sclose = foreign.string_to_symbol( "close".getBytes() );

    public procedure get_label = null;
    public procedure get_image = null;
    public procedure get_tooltips = null;

    public BJTreeCellRenderer( procedure gl, procedure gi, procedure gt ) {
	get_label = gl;
	get_image = gi;
	get_tooltips = gt;
    }

    public Component getTreeCellRendererComponent( JTree tree, 
						   Object value, 
						   boolean selected, 
						   boolean expanded, 
						   boolean leaf, 
						   int row, 
						   boolean hasFocus ) {
	super.getTreeCellRendererComponent( tree, 
					    value, 
					    selected, 
					    expanded, 
					    leaf, 
					    row, 
					    hasFocus );
	if( !(value instanceof BJTreeNode ) ) {
	    return this;
	} else {
	    BJTreeNode node = (BJTreeNode)value;
	    Object tree_item = node.tree_item;
	    Object icon, tooltips;
	    byte[] lbl;
	    symbol sym;

	    if( tree_item instanceof String ) {
		return this;
	    }

	    if( leaf ) {
		sym = sleaf;
		icon = node.o_icon;
	    } else {
		if( expanded ) {
		    icon = node.o_icon;
		    sym = sopen;
		}
		else {
		    icon = node.c_icon;
		    sym = sclose;
		}
	    }

	    if( icon == null ) {
		icon = get_image.funcall2( tree_item, sym );
		if( leaf ) {
		    node.o_icon = icon;
		} else {
		    if( expanded ) {
			node.o_icon = icon;
		    }
		    else {
			node.c_icon = icon;
		    }
		}
	    }

	    lbl = (byte [])get_label.funcall1( tree_item );

	    if( icon instanceof JLabel )
		setIcon( ((JLabel)icon).getIcon() );
	    else
		setIcon( null );

	    setText( new String( lbl ) );

	    tooltips = get_tooltips.funcall1( tree_item );
	    if( tooltips instanceof byte[] ) {
		setToolTipText( new String( (byte[])tooltips ) ); 
	    }

	    return this;
	}
    }
}
