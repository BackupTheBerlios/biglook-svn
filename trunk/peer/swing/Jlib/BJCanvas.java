/*=====================================================================*/
/*    swing/Jlib/BJCanvas.java                                         */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 25 18:03:46 2001                          */
/*    Last change :  Thu Nov 18 14:44:40 2004 (dciabrin)               */
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
    AffineTransform zoom;
    Dimension dim;

    public BJCanvas( procedure p ) {
	super( true );
	zoom=new AffineTransform();
	setBackground( java.awt.Color.white );
	bglk_painter = p;

    }

    public float getZoomX() {
	return (float)zoom.getScaleX();
    }
    public float getZoomY() {
	return (float)zoom.getScaleY();
    }
    public void setZoomX(float factor) {
	zoom.setToScale(factor,zoom.getScaleY());
	revalidate();
    }
    public void setZoomY(float factor) {
	zoom.setToScale(zoom.getScaleX(),factor);
	revalidate();
    }

    public void paint( Graphics g ) {
	super.paint( g );
	Graphics2D g2D=(Graphics2D)g;
	g2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
			     RenderingHints.VALUE_ANTIALIAS_ON);
	g2D.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
			     RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
	g2D.transform(zoom);
	bglk_painter.funcall2( peer, g );
    }

    public Graphics getGraphics() {
	Graphics2D g2D=(Graphics2D)super.getGraphics();
	if (g2D != null) {
	    
	    g2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
				 RenderingHints.VALUE_ANTIALIAS_ON);
	    g2D.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
				 RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
	    
	}
	return g2D;
    }

    public static Object getFontRenderContextFromGraphics2D(Graphics2D g2D) {
	if (g2D == null) {
	    return bigloo.bbool.faux;
	} else {
	    return g2D.getFontRenderContext();
	}
    }

    public static GeneralPath makeArrowPath(int a, int b, int c) {
	GeneralPath gp=new GeneralPath();
	gp.moveTo(-c,a);
	gp.lineTo(0,0);
	gp.lineTo(c,a);
	return gp;
    }

    public static GeneralPath makeBeginArrow(GeneralPath gp,
					     GeneralPath path) {
	double x1,y1,x2,y2;
	// get coordinates of points
	PathIterator pi=path.getPathIterator(null);
	double[] points=new double[6];
	pi.currentSegment(points); x1=points[0]; y1=points[1];
	pi.next();
	pi.currentSegment(points); x2=points[0]; y2=points[1];
	// compute slope and position
	AffineTransform at=new AffineTransform();
	double rot=Math.atan2(x2-x1,y2-y1);
	at.translate(x1,y1);
	at.rotate(Math.PI+Math.PI-rot);
	GeneralPath res=new GeneralPath(gp);
	res.transform(at);
	return res;
    }
									
    public static GeneralPath makeEndArrow(GeneralPath gp,
					   GeneralPath path) {
	AffineTransform at=new AffineTransform();
	double x1,y1,x2=0,y2=0;
	// get coordinates of points
	PathIterator pi=path.getPathIterator(null);
	double[] points=new double[6];
	int type;
	do {
	    type=pi.currentSegment(points);
	    x1=x2; y1=y2;
	    x2=points[0]; y2=points[1];
	    pi.next();
	} while (!pi.isDone());
	if (type==PathIterator.SEG_LINETO) {
	    x2=points[0]; y2=points[1];	    
	} else {
	    x1=points[2]; y1=points[3];	    
	    x2=points[4]; y2=points[5];	    
	}

	// compute slope and position
	double rot=Math.atan2(x2-x1,y2-y1);
	at.translate(x2,y2);
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

    public static Object getCanvasLinePoints(GeneralPath gp) {
	PathIterator pi=gp.getPathIterator(null);
	float[] points=new float[6];
	Object result=bigloo.nil.nil;
	while (!pi.isDone()) {
	    int type=pi.currentSegment(points);
	    switch (type) {
	    case PathIterator.SEG_MOVETO:
	    case PathIterator.SEG_LINETO:
		    result=new bigloo.pair(new bigloo.bint((int)points[1]),
					   new bigloo.pair(new bigloo.bint((int)points[0]), result));
		    break;
	    default:
	    case PathIterator.SEG_CUBICTO:
		    result=new bigloo.pair(new bigloo.bint((int)points[1]),
					   new bigloo.pair(new bigloo.bint((int)points[0]), result));
		    result=new bigloo.pair(new bigloo.bint((int)points[3]),
					   new bigloo.pair(new bigloo.bint((int)points[2]), result));
		    result=new bigloo.pair(new bigloo.bint((int)points[5]),
					   new bigloo.pair(new bigloo.bint((int)points[4]), result));
		
		//System.out.println(""+type);
		break;
	    }
	    pi.next();
	}
	return result;
    }

    public static boolean doesGeneralPathContain(GeneralPath gp,
						 BasicStroke s,
						 double x, double y) {
	PathIterator pi=gp.getPathIterator(null);
	double[] points=new double[6];
	double oldx1=0.0f;
	double oldy1=0.0f;
	double size=s.getLineWidth()/2.0;
	while (!pi.isDone()) {
	    int type=pi.currentSegment(points);
	    //System.out.print(""+type+" ");
	    switch (type) {
	    case PathIterator.SEG_MOVETO:
		//System.out.println(""+points[0]+","+points[1]);
		break;
	    case PathIterator.SEG_LINETO:
		//System.out.print(""+oldx1+","+oldy1+" "+
		//		 points[0]+","+points[1]+" -> ");
		double dist=
		    Line2D.ptSegDist(oldx1,oldy1,points[0],points[1],x,y);
		//System.out.println(""+dist);
		if (dist<size) return true;
		break;
	    default:
		break;
	    }
	    oldx1=points[0];
	    oldy1=points[1];
	    pi.next();
	}
	return false;
    }
}
