/*=====================================================================*/
/*    swing/Jlib/BJBoxLayout.java                                      */
/*    -------------------------------------------------------------    */
/*    Author      :  Damien Ciabrini                                   */
/*    Creation    :  Wed Jun 16 13:28:51 2004                          */
/*    Last change :  Thu Jun 24 16:49:15 2004 (dciabrin)               */
/*    Copyright   :  2004 Damien Ciabrini, see LICENCE file            */
/*    -------------------------------------------------------------    */
/*    An ad-hoc implementation of the GtkBox layout manager !          */
/*=====================================================================*/

package bigloo.biglook.peer.Jlib;
import java.io.*;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import bigloo.*;

public class BJBoxLayout implements LayoutManager2, Serializable {
    private static bigloo.bint paddingConstraint =
	new bigloo.bint(0);
    private int orientation;
    private Container target;

    private LinkedList children;
    private LinkedList childrenConstraints;
    private transient SizeRequirements[] childrenSize;
    private transient SizeRequirements xSize;
    private transient SizeRequirements ySize;

    public BJBoxLayout(Container target, int orientation) {
        if (orientation != BJBox.HORIZONTAL &&
	    orientation != BJBox.VERTICAL) {
            throw new AWTError("Invalid orientation");
        }
        this.orientation = orientation;
        this.target = target;
	children = new LinkedList();
	childrenConstraints = new LinkedList();
    }

    public synchronized void invalidateLayout(Container target) {
        checkContainer(target);
        childrenSize = null;
	xSize = null;
	ySize = null;
    }

    public void addLayoutComponent(String name, Component comp) {
    }

    public void removeLayoutComponent(Component comp) {
	int i=children.indexOf(comp);
	children.remove(i);
	childrenConstraints.remove(i);
	// Check if we have to remove a padding widget
	if ( ((i-1)>=0) &&
	     (childrenConstraints.get(i-1) == paddingConstraint) ) {
	    children.remove(i-1);
	    childrenConstraints.remove(i-1);
	}
    }

    public void addLayoutComponent(Component comp, Object constraints) {
	if (constraints instanceof bigloo.pair) {
	    bigloo.pair p=(bigloo.pair)constraints;
	    int padding=((bigloo.bint)p.cdr).value;
	    Component pad;
	    if (orientation==BJBox.HORIZONTAL) {
		pad=Box.createRigidArea(new Dimension(padding,0));
	    } else {
		pad=Box.createRigidArea(new Dimension(0,padding));
	    }
	    children.addLast(pad);
	    childrenConstraints.addLast(paddingConstraint);
	    constraints=p.car;
	}
	children.addLast(comp);
	childrenConstraints.addLast(constraints);
    }

    public Dimension preferredLayoutSize(Container target) {
	Dimension size;
	synchronized(this) {
	    checkContainer(target);
	    checkRequests();
	    size = new Dimension(xSize.preferred, ySize.preferred);
	}
        return size;
    }

    public Dimension minimumLayoutSize(Container target) {
	Dimension size;
	synchronized(this) {
	    checkContainer(target);
	    checkRequests();
	    size = new Dimension(xSize.minimum, ySize.minimum);
	}
        return size;
    }

    public Dimension maximumLayoutSize(Container target) {
	Dimension size;
	synchronized(this) {
	    checkContainer(target);
	    checkRequests();
	    size = new Dimension(xSize.maximum, ySize.maximum);
	}
        return size;
    }

    public float getLayoutAlignmentX(Container target) {
	return 0.0f;
    }

    public float getLayoutAlignmentY(Container target) {
	return 0.0f;
    }

    public void layoutContainer(Container target) {
	checkContainer(target);
	int n = children.size();
	int[] offsets = new int[n];
	int[] spans = new int[n];
	    
	Dimension targetSize = target.getSize();

	// compute children placement
	synchronized(this) {
	    checkRequests();
	    /*
	    System.out.println("DIM: "+targetSize);
	    if (orientation==BJBox.VERTICAL)
		System.out.println("ySize: "+ySize);
	    else
		System.out.println("xSize: "+xSize);
	    */
	    if (orientation==BJBox.VERTICAL)
		SizeRequirements.calculateTiledPositions(targetSize.height,
							 ySize,
							 childrenSize,
							 offsets, spans);
	    else
		SizeRequirements.calculateTiledPositions(targetSize.width,
							 xSize,
							 childrenSize,
							 offsets, spans);
	}
	
	// update children bounds into the target container
	Iterator i=children.iterator();
	Iterator i2=childrenConstraints.iterator();
	int j=0;
	while (i.hasNext()) {
            Component c = (Component)i.next();
	    int constraint = ((bigloo.bint)i2.next()).value;
	    int offset=offsets[j];
	    int span=spans[j];
	    if 	(((constraint & BJBox.FILL)==0) &&
		 (childrenSize[j].preferred<span)) {
		span=childrenSize[j].preferred;
		offset+=(spans[j]-childrenSize[j].preferred)/2;
	    }
	    
	    if (orientation==BJBox.VERTICAL)
		c.setBounds(0, offset, targetSize.width, span);
	    else
		c.setBounds(offset, 0, span, targetSize.height);
	    j++;
        }
    }

    void checkContainer(Container target) {
        if (this.target != target) {
            throw new AWTError("BJBoxLayout can't be shared");
        }
    }
    
    void checkRequests() {
        if ((xSize == null) || (ySize == null)) {
            // The requests have been invalidated... We need to 
            // recompute the request information.
	    xSize=new SizeRequirements();
	    ySize=new SizeRequirements();
	    int n = children.size();
            childrenSize = new SizeRequirements[n];
	    int j=0;
	    Iterator i=children.iterator();
	    Iterator i2=childrenConstraints.iterator();
            while (i.hasNext()) {
                Component c = (Component)i.next();
		int constraint = ((bigloo.bint)i2.next()).value;
                Dimension min = c.getMinimumSize();
                Dimension pref = c.getPreferredSize();
                Dimension max = c.getMaximumSize();

		if ((constraint & BJBox.EXPAND)!=0) {
		    if (orientation==BJBox.VERTICAL)
			max.height=Integer.MAX_VALUE;
		    else
			max.width=Integer.MAX_VALUE;
		} else {
		    if (orientation==BJBox.VERTICAL)
			max.height=pref.height;
		    else
			max.width=pref.width;
		}
		/*
		System.out.println(""+c.getClass().getName()+"@"+
				   c.hashCode()+" minimum: "+min);
		System.out.println(""+c.getClass().getName()+"@"+
				   c.hashCode()+" preferred: "+pref);
		System.out.println(""+c.getClass().getName()+"@"+
				   c.hashCode()+" maximum: "+max);
		*/
		if (orientation==BJBox.VERTICAL) {
		    childrenSize[j] = new SizeRequirements(min.height,
							   pref.height,
							   max.height, 0);
		    xSize.minimum=Math.max(xSize.minimum,min.width);
		    xSize.preferred=Math.max(xSize.preferred,pref.width);
		    xSize.maximum=Math.max(xSize.maximum,max.width);
		} else {
		    childrenSize[j] = new SizeRequirements(min.width,
							   pref.width,
							   max.width, 0);
		    ySize.minimum=Math.max(ySize.minimum,min.height);
		    ySize.preferred=Math.max(ySize.preferred,pref.height);
		    ySize.maximum=Math.max(ySize.maximum,max.height);
		}
		j++;
            }
	    if (orientation==BJBox.VERTICAL)
		ySize=SizeRequirements.getTiledSizeRequirements(childrenSize);
	    else
		xSize=SizeRequirements.getTiledSizeRequirements(childrenSize);
	}
    }
}

