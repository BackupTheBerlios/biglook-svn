/*=====================================================================*/
/*    swing/Jlib/BJText.java                                           */
/*    -------------------------------------------------------------    */
/*    Author      :  Damien Ciabrini                                   */
/*    Creation    :  Thu Nov 20 19:00:13 2003                          */
/*    Last change :  Tue Mar 23 09:04:21 2004 (dciabrin)               */
/*    Copyright   :  2003-04 Damien Ciabrini, see LICENCE file         */
/*    -------------------------------------------------------------    */
/*    Java part of the implementation of the text widget.              */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.text.*;
import bigloo.*;

/*---------------------------------------------------------------------*/
/*    BJText ...                                                       */
/*---------------------------------------------------------------------*/
public class BJText {
    public static bigloo.pair caretToLineColumn(JTextPane text, int carret) {
	StyledDocument sd=text.getStyledDocument();
	Element e=sd.getDefaultRootElement();
	int line=e.getElementIndex(carret);
	int column=carret-e.getElement(line).getStartOffset();
	return new bigloo.pair(new bigloo.bint(line), new bigloo.bint(column));
    }

    public static void putProperties(JTextPane text, int start, int end) {
	StyledDocument sd=text.getStyledDocument();
	/*
	Element e=sd.getDefaultRootElement();
	int line=e.getElementIndex(start);
	Element e2=e.getElement(line);
	*/
	SimpleAttributeSet attr=new SimpleAttributeSet();
	StyleConstants.setItalic(attr, true);
	sd.setParagraphAttributes(start, end, attr, false);
    }
}
