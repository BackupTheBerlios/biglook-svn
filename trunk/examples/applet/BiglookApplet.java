/*=====================================================================*/
/*    .../prgm/project/biglook/examples/applet/BiglookApplet.java      */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Mon May  7 16:09:17 2001                          */
/*    Last change :  Tue Feb 11 08:36:56 2003 (serrano)                */
/*    Copyright   :  2001-03 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    The template to build Biglook Applets                            */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
import java.awt.*;
import java.awt.event.*;
import java.net.*;
import java.applet.*;
import javax.swing.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BiglookApplet ...                                                */
/*---------------------------------------------------------------------*/
public class BiglookApplet extends JApplet {
    public void init() {
	Bglk.register_applet( this );
	applet.BGL_DYNAMIC_LOAD_INIT();
    }

    public void stop() {
	;
    }
}
	
