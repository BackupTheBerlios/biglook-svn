/*=====================================================================*/
/*    serrano/prgm/project/biglook/peer/swing/Jlib/BJBorder.java       */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Fri Apr 20 06:08:42 2001                          */
/*    Last change :  Sun Jun 24 13:39:46 2001 (serrano)                */
/*    Copyright   :  2001 Manuel Serrano                               */
/*    -------------------------------------------------------------    */
/*    Biglook Borders                                                  */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.border.*;

/*---------------------------------------------------------------------*/
/*    BJBorder ...                                                     */
/*---------------------------------------------------------------------*/
public class BJBorder extends javax.swing.border.CompoundBorder {
    static EmptyBorder empty_border = new EmptyBorder( 0, 0, 0, 0 );

    // constructors
    BJBorder( Border out, String title ) {
	super( out, new TitledBorder( title ) );
    }

    public static BJBorder make_BJBorder( Border out, String t ) {
	return new BJBorder( out, t );
    }

    public BJBorder copy_BJBorder( Border out ) {
	return new BJBorder( out, ((TitledBorder)getInsideBorder()).getTitle() );
    }
    
    public static EtchedBorder make_etched_in_border() {
	return new EtchedBorder( EtchedBorder.LOWERED );
    }

    public static EtchedBorder make_etched_out_border() {
	return new EtchedBorder( EtchedBorder.RAISED );
    }

    public static BevelBorder make_bevel_in_border() {
	return new BevelBorder( BevelBorder.LOWERED );
    }

    public static BevelBorder make_bevel_out_border() {
	return new BevelBorder( BevelBorder.RAISED );
    }

    public static SoftBevelBorder make_softbevel_in_border() {
	return new SoftBevelBorder( BevelBorder.LOWERED );
    }

    public static SoftBevelBorder make_softbevel_out_border() {
	return new SoftBevelBorder( BevelBorder.RAISED );
    }

    public static EmptyBorder make_empty_border() {
	return empty_border;
    }

    // accessors
    public String getTitle() {
	Border inside_border = getInsideBorder();
	return ((TitledBorder)inside_border).getTitle();
    }
	
    public void setTitle( String title ) {
	Border inside_border = getInsideBorder();
	((TitledBorder)inside_border).setTitle( title );
    }

    public int getTitleJustification() {
	Border inside_border = getInsideBorder();
	return ((TitledBorder)inside_border).getTitleJustification();
    }

    public void setTitleJustification( int justification ) {
	Border inside_border = getInsideBorder();
	((TitledBorder)inside_border).setTitleJustification( justification );
    }
}
	

