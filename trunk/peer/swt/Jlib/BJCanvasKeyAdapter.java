/*=====================================================================*/
/*    .../project/biglook/peer/swing/Jlib/BJCanvasKeyAdapter.java      */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Sat Apr 28 10:27:28 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    The Biglook Canvas MouseClickAdapter                             */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJCanvasKeyAdapter ...                                           */
/*---------------------------------------------------------------------*/
public class BJCanvasKeyAdapter extends KeyAdapter {
    public void keyPressed( KeyEvent e ) {
	System.out.println( "KeyPressed=" + e );
    }
    public void keyReleased( KeyEvent e ) {
	System.out.println( "KeyReleased=" + e );
    } 
}
