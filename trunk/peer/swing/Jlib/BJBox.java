/*=====================================================================*/
/*    swing/Jlib/BJBox.java                                            */
/*    -------------------------------------------------------------    */
/*    Author      :  Damien Ciabrini                                   */
/*    Creation    :  Tue Apr 20 15:36:33 2004                          */
/*    Last change :  Mon Jun 21 17:12:48 2004 (dciabrin)               */
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
/*    BJBox ...                                                        */
/*---------------------------------------------------------------------*/
public class BJBox extends JComponent {
    public static int HORIZONTAL=0;
    public static int VERTICAL=1;

    public static int FILL=1;
    public static int EXPAND=2;

    private int orientation;
    
    public BJBox() {
	this(BJBox.VERTICAL);
    }

    public BJBox(int orientation) {
	this.orientation=orientation;
	super.setLayout(new BJBoxLayout(this,orientation));
    }

    public void setLayout(LayoutManager l) {
	throw new AWTError("BJBox only uses its own layout manager");
    }
}
