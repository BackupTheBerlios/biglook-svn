/*=====================================================================*/
/*    swing/Jlib/BJTableModel.java                                     */
/*    -------------------------------------------------------------    */
/*    Author      :  Manuel Serrano                                    */
/*    Creation    :  Wed Apr 18 10:39:08 2001                          */
/*    Last change :  Thu Apr 15 14:10:35 2004 (dciabrin)               */
/*    Copyright   :  2001-04 Manuel Serrano                            */
/*    -------------------------------------------------------------    */
/*    The Biglook Table Model class                                    */
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
/*    BJTableModel ...                                                 */
/*---------------------------------------------------------------------*/
public class BJTableModel extends AbstractTableModel {
    private int column;
    private int row;
    private Object[] columns_name;
    private procedure cell_value;
    private procedure cell_editable;
    private Object bglk_object;
    private Object[][] rows;

    public BJTableModel( Object o, Object[] cn, procedure cv,
			 procedure ce) {
	super();
	bglk_object = o;
	columns_name = cn;
	column = columns_name.length;
	cell_value = cv;
	cell_editable = ce;
	row = 0;
	rows = null;
    }

    public void addRows( int num ) {
	int old_len = row;
	int new_len = old_len + num;

	if( (rows == null) || (new_len > rows.length) ) {
	    /* we have to allocate a new rows vector  */
	    /* because the current one is too small. */
	    Object[][] new_rows = new Object[ new_len ][ column ];
	    
	    for( int i = 0; i < old_len; i++ ) {
		System.arraycopy( rows[ i ], 0, new_rows[ i ], 0, column );
	    }

	    rows = new_rows;
	}
	
	row = new_len;
	// FIXME: too vague
	//Object[] t=(Object[])listenerList.getListenerList();
	//for (int i=0;i<t.length;i++) System.out.println(t[i]);
	fireTableDataChanged();
    }

    public void removeRows( int num ) {
	for( int i = num; i > 0; i-- ) {
	    for( int j = 0; j < column; j++ ) {
		rows[ i ][ j ] = null;
	    }
	}

	row -= num;
	// FIXME: too vague
	fireTableDataChanged();
    }
	
    public int getColumnCount() {
	return column;
    }

    public int getRowCount() {
	return row;
    }
  
    public String getColumnName( int col ) {
	Object name = foreign.VECTOR_REF( columns_name, col );

	if( name instanceof byte[] ) {
	    return new String( (byte[])name );
	} else {
	    if( name instanceof bigloo.symbol ) {
		return new String( foreign.SYMBOL_TO_STRING( (symbol)name ) );
	    } else {
		System.out.println( "name: " + name.getClass().getName() );
		return "???";
	    }
	}
    }

    public Object getValueAt( int row, int col  ) {
	Object val=rows[ row ][ col ];
	if( val == null ) {
	    val = cell_value.funcall3( bglk_object, 
				       new bint( col ), 
				       new bint( row ) );
	    rows[ row ][ col ] = val;
	}
	/*
	//System.err.println(rows[ row ][ col ]);
	if( val instanceof byte[] ) {
	    return new String( (byte[])val );
	} else {
	    if( val instanceof bint ) {
		return new Integer( ((bint)val).value ) ;
	    } else {
		if( val instanceof bbool ) {
		    if( (bbool)val == bbool.faux ) {
			return new Boolean( false );			
		    } else {
			return new Boolean( true );
		    }
		}
	    }
	    return val;
	}
	*/
	return val;
    }

    public void setValueAt( Object val, int row, int col  ) {
	Object scm_val=val;
	/*
	if( val instanceof String ) {
	    scm_val=((String)val).getBytes();
	} else {
	    if( val instanceof Integer ) {
		scm_val=new bint(((Integer)val).intValue());
	    } else {
		if( val instanceof Boolean ) {
		    if( ((Boolean)val).booleanValue() ) {
			scm_val=bbool.vrai;
		    } else {
			scm_val=bbool.faux;
		    }
		} else
		    scm_val=val;		
	    }
	}
	*/
	rows[ row ][ col ] = scm_val;	
	fireTableCellUpdated(row, col);
    }

    public Class getColumnClass( int c ) {
	Object val=getValueAt( 0, c );
	return val.getClass();
    }

    public boolean isCellEditable( int row, int col ) {
	Object val = cell_editable.funcall3( bglk_object, 
					     new bint( col ), 
					     new bint( row ) );
	return (val == bbool.vrai);
    }
}
