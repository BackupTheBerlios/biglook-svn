/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/swing/Jlib/BJCanvas.java       */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 25 18:03:46 2001                          */
/*    Last change :  Fri Feb 15 11:13:20 2002 (serrano)                */
/*    Copyright   :  2001-02 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    My own (unefficient) implementation of the Canvas widget.        */
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
/*    BJCanvas ...                                                     */
/*---------------------------------------------------------------------*/
public class BJCanvas extends JPanel {
    procedure bglk_painter;
    public Object peer = null;
    Dimension dim;

    public BJCanvas( procedure p ) {
	super( true );
	setBackground( java.awt.Color.white );
	bglk_painter = p;

	dim = new Dimension( 200, 200 );
	setSize( getPreferredSize() );
    }

    public void paint( Graphics g ) {
	super.paint( g );
	bglk_painter.funcall2( peer, g );
    }

    public void setSize( int w, int h ) {
	dim.setSize( w, h );
    }
    
    public Dimension getMinimumSize() {
	return dim; 
    }

    public Dimension getSize() {
	return dim; 
    }

    public int getWidth() {
	return dim.width; 
    }

    public int getHeight() {
	return dim.height; 
    }

    public Dimension getPreferredSize() {
	return dim; 
    }
}
