/*=====================================================================*/
/*    .../prgm/project/biglook/peer/swing/Jlib/BJTimerAdapter.java     */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Jul  7 09:50:46 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook Timer connection                                     */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import bigloo.*;

/*---------------------------------------------------------------------*/
/*    BJTimerAdapter                                                   */
/*---------------------------------------------------------------------*/
public class BJTimerAdapter implements java.awt.event.ActionListener {
    private final static LinkedList timer_list = new LinkedList();
    public procedure thunk;

    BJTimerAdapter( procedure t ) {
	super();
	thunk = t;
	// disable garbage collection for that timer
	timer_list.add( this );
    }

    public void actionPerformed( ActionEvent e ) {
	Object timer = e.getSource();

	if( thunk.funcall0() == foreign.BFALSE ) {
	    ((javax.swing.Timer)timer).stop();
	    // enable garbage collection for that timer
	    timer_list.remove( this );
	}
    }
}
    



