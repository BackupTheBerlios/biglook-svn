/*=====================================================================*/
/*    swing/Jlib/BBox.java                                             */
/*    -------------------------------------------------------------    */
/*    Author      :  Damien Ciabrini                                   */
/*    Creation    :  Tue Apr 20 15:36:33 2004                          */
/*    Last change :  Wed Jun 16 11:31:37 2004 (dciabrin)               */
/*    Copyright   :  2004 Damien Ciabrini, see LICENCE file            */
/*    -------------------------------------------------------------    */
/*    An ad-hoc implemetation of the GtkBox container !                */
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

/*---------------------------------------------------------------------*/
/*    BBox ...                                                         */
/*---------------------------------------------------------------------*/
public class BBox extends Box {
    private ComponentAdapter containerSizeListener;
    private ComponentAdapter childrenSizeAdapter;
    private LinkedList expandedWidgets;
    private int axis;
    //private boolean resize_chlidren;
    
    public BBox(int a) {
	super(a);
	axis=a;
	expandedWidgets=new LinkedList();
	//resize_chlidren=false;
	
	containerSizeListener=new ComponentAdapter() {
		public void componentResized(ComponentEvent e) {
		    //BBox.this.resize_children=true;
		    int max=(axis == BoxLayout.Y_AXIS)?
			getWidth() : getHeight();
		    if (max>0) {
			Component[] c=getComponents();
			if (axis == BoxLayout.Y_AXIS) {
			    for (int i=0;i<c.length;i++) {
				c[i].setSize(max, c[i].getHeight());
			    }
			} else {
			    for (int i=0;i<c.length;i++) {
				c[i].setSize(c[i].getWidth(),max);
			    }
			}
		    }		    
		    //BBox.this.resize_children=false;
		}
	    };
	addComponentListener(containerSizeListener);	
	
	childrenSizeAdapter=new ComponentAdapter() {
		public void componentResized(ComponentEvent e) {
		    Component c=e.getComponent();
		    int max=(axis == BoxLayout.Y_AXIS)?
			getWidth() : getHeight();
		    
		    if (max>0) {
			if (axis == BoxLayout.Y_AXIS) {
			    if (c.getWidth() < max)
				c.setSize(max, c.getHeight());
			} else {
			    if (c.getHeight() < max)
				c.setSize(c.getWidth(),max);
			}
		    }
		    //if (!BBox.this.resize_children)
		    //	BBox.this.set
		}
	    };
    }

    public Component add(Component c) {
	//System.out.println("add");
	c.addComponentListener(childrenSizeAdapter);
	revalidate();
	repaint();
	return super.add(c);
    }

    public void add(Component c, Object filler) {
	System.out.println("add filler: "+filler);
	c.addComponentListener(childrenSizeAdapter);
	
	if (filler == bbool.vrai) {
	    expandedWidgets.add(c);
	    if (axis == BoxLayout.Y_AXIS)
		super.add(Box.createVerticalGlue());
	    else {
		System.out.println("whiuwhef");
		super.add(Box.createHorizontalGlue());
	    }
	    super.add(c);
	    if (axis == BoxLayout.Y_AXIS)
		super.add(Box.createVerticalGlue());
	    else {
		System.out.println("wfhiuwhef");
		super.add(Box.createHorizontalGlue());
	    }
	} else {
	    System.out.println("wefijhweifuhwieufhiuwhef");
	    super.add(c);
	}
	revalidate();
	repaint();
    }

    public void remove(Component c) {
	//System.out.println("remove");
	Component[] comps=getComponents();
	int i=0;
	while (i<comps.length && comps[i]!=c) i++;

	if (i==comps.length) return; // not found

	if (expandedWidgets.contains(c)) {
	    expandedWidgets.remove(c);
	    super.remove(i+1);
	    super.remove(i-1);
	    i--;
	}

	c.removeComponentListener(childrenSizeAdapter);	
	super.remove(i);

	if (((i-1)>=0) && (comps[i-1] instanceof Box.Filler)) {
	    super.remove(i-1);
	}

	revalidate();
	repaint();
    }
}

