/*=====================================================================*/
/*    swing/Jlib/BJTable.java                                          */
/*    -------------------------------------------------------------    */
/*    Author      :  Damien Ciabrini                                   */
/*    Creation    :  Thu Apr 15 13:07:45 2004                          */
/*    Last change :  Tue May 18 17:54:28 2004 (dciabrin)               */
/*    Copyright   :  2004 Damien Ciabrini, see LICENCE file            */
/*    -------------------------------------------------------------    */
/*    The implementation of the Biglook JTable                         */
/*=====================================================================*/

/*---------------------------------------------------------------------*/
/*    The package                                                      */
/*---------------------------------------------------------------------*/
package bigloo.biglook.peer.Jlib;
import java.util.*;
import java.awt.*;
import javax.swing.*;
import javax.swing.table.*;
import bigloo.*;
import bigloo.biglook.peer.Jlib.*;

/*---------------------------------------------------------------------*/
/*    BJTable ...                                                      */
/*---------------------------------------------------------------------*/
public class BJTable extends JTable {

    /*-----------------------------------------------------------------*/
    /*    DEFAULT RENDERERS FOR BIGLOO TYPES                           */
    /*-----------------------------------------------------------------*/
    static class bboolRenderer extends JCheckBox implements TableCellRenderer
    {
	public bboolRenderer() {
	    super();
	    setHorizontalAlignment(JLabel.CENTER);
	}

        public Component getTableCellRendererComponent(JTable table,
						       Object value,
						       boolean isSelected,
						       boolean hasFocus,
						       int row, int column) {
	    if (isSelected) {
	        setForeground(table.getSelectionForeground());
	        super.setBackground(table.getSelectionBackground());
	    }
	    else {
	        setForeground(table.getForeground());
	        setBackground(table.getBackground());
	    }
            setSelected(value == bbool.vrai);
            return this;
        }
    }

    static class numeralRenderer extends DefaultTableCellRenderer {
	public numeralRenderer() {
	    super();
	    setHorizontalAlignment(JLabel.RIGHT);
	}
    }

    static class bintRenderer extends numeralRenderer {
	public bintRenderer() { super(); }

	public void setValue(Object value) {
	    setText((value == null) ? "" :
		    Integer.toString(((bint)value).value));
	}
    }

    static class belongRenderer extends numeralRenderer {
	public belongRenderer() { super(); }

	public void setValue(Object value) {
	    setText((value == null) ? "" :
		    Long.toString(((belong)value).value));
	}
    }

    static class bstringRenderer extends DefaultTableCellRenderer {
	public bstringRenderer() {
	    super();
	    setHorizontalAlignment(JLabel.LEFT);	    
	}

	public void setValue(Object value) {
	    setText((value == null) ? "" : new String((byte[])value));
	}
    }

    static class symbolRenderer extends DefaultTableCellRenderer {
	public symbolRenderer() {
	    super();
	    setHorizontalAlignment(JLabel.LEFT);	    
	}

	public void setValue(Object value) {
	    setText((value == null) ? "" : new String(((symbol)value).string));
	}
    }

    /*-----------------------------------------------------------------*/
    /*    DEFAULT EDITORS FOR BIGLOO TYPES                             */
    /*-----------------------------------------------------------------*/
    static class bboolEditor extends DefaultCellEditor {
	JCheckBox checkbox;
	public bboolEditor() {
	    super(new JCheckBox());
	    checkbox=(JCheckBox)getComponent();
	    checkbox.setHorizontalAlignment(JLabel.CENTER);
	}

	public Component getTableCellEditorComponent(JTable table,
						     Object value,
						     boolean isSelected,
						     int row, int column) {
	    checkbox.setSelected(value==bbool.vrai);
	    return checkbox;
	}

	public Object getCellEditorValue() {
	    return checkbox.isSelected() ? bbool.vrai : bbool.faux;
        }
    }
    
    
    public BJTable(TableModel model) {
	super(model);
	// Default Renderers
	setDefaultRenderer(bbool.class, new bboolRenderer());
	setDefaultRenderer(bint.class, new bintRenderer());
	setDefaultRenderer(belong.class, new belongRenderer());
	setDefaultRenderer(byte[].class, new bstringRenderer());
	setDefaultRenderer(symbol.class, new symbolRenderer());

	// Default Editors
	setDefaultEditor(bbool.class, new bboolEditor());
    }
}
