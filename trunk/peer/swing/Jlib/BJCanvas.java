/*=====================================================================*/
/*    swing/Jlib/BJCanvas.java                                         */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 25 18:03:46 2001                          */
/*    Last change :  Tue Jun  1 18:21:51 2004 (braun)                  */
/*    Copyright   :  2001-04 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    My own (unefficient) implementation of the Canvas widget.        */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.geom.*;
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
	Graphics2D g2D=(Graphics2D)g;
	g2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
			     RenderingHints.VALUE_ANTIALIAS_ON);
	g2D.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
			     RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
	super.paint( g );
	bglk_painter.funcall2( peer, g );
    }

    public Graphics getGraphics() {
	Graphics2D g2D=(Graphics2D)super.getGraphics();
	g2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
			     RenderingHints.VALUE_ANTIALIAS_ON);
	g2D.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
			     RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
	return g2D;
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
    
    public static GeneralPath makeArrowPath(int a, int b, int c) {
	GeneralPath gp=new GeneralPath();
	gp.moveTo(-c,a);
	gp.lineTo(0,0);
	gp.lineTo(c,a);
	return gp;
    }

    public static GeneralPath makeBeginArrow(GeneralPath gp, Line2D l) {
	AffineTransform at=new AffineTransform();
	double rot=Math.atan2(l.getX2()-l.getX1(),l.getY2()-l.getY1());
	at.translate(l.getX1(), l.getY1());
	at.rotate(Math.PI+Math.PI-rot);
	GeneralPath res=new GeneralPath(gp);
	res.transform(at);
	return res;
    }
									
    public static GeneralPath makeEndArrow(GeneralPath gp, Line2D l) {
	AffineTransform at=new AffineTransform();
	double rot=Math.atan2(l.getX2()-l.getX1(),l.getY2()-l.getY1());
	at.translate(l.getX2(), l.getY2());
	at.rotate(Math.PI-rot);
	GeneralPath res=new GeneralPath(gp);
	res.transform(at);
	return res;
    }
    
    public static void drawEndArrow(Graphics2D g, GeneralPath arrow,
				    double x1, double y1, double x2, double y2) {
	AffineTransform at=new AffineTransform();
	g.translate(x2,y2);
	g.fill(arrow);
	g.translate(-x2,-y2);
    }
}
