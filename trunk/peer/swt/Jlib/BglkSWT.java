package bigloo.biglook.peer.Jlib;

import org.eclipse.swt.*;
import org.eclipse.swt.widgets.*;

public class BglkSWT {
    public static Display display=new Display();

    public static Display foo () {return display;}
    
    public static int jvm_main() {
	while (true) {
	    if (!display.readAndDispatch())
		display.sleep();
	}
    }
}