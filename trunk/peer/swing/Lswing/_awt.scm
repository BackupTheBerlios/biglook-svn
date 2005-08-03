;*=====================================================================*/
;*    swing/Lswing/_awt.scm                                            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Apr 19 08:57:56 2001                          */
;*    Last change :  Tue Dec 14 14:10:17 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Awt connection                                               */
;*    -------------------------------------------------------------    */
;*    See also:                                                        */
;*      The Swing connection: @path ../Lswing/%swing.scm@              */
;*      The Peer implementation: @path ../Lwidget/%peer.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%awt
   
   (java (array int* ::int)
	 (array float* ::float)
	 (class %jobject
	    (method class::%jclass (::%jobject)
		    "getClass")
	    "java.lang.Object")
	 (class %jstring::%jobject "java.lang.String")

	 (class %jclass "java.lang.Class")
	 
	 (array %jobject* ::%jobject)
	 
	 (class %jvector::%jobject
	    (constructor new (::int))
	    (method add::bool (::%jvector ::%jobject) "add")
	    "java.util.Vector")
	 
	 (class %jfile::%jobject
	    (constructor new (::%jstring))
	    (method name::%jstring (::%jfile) "getName")
	    (method path::%jstring (::%jfile) "getAbsolutePath")
	    "java.io.File")
	 
	 ;; java.awt.image.ImageObserver
	 (class %awt-imageobserver::%jobject
	    "java.awt.image.ImageObserver")
	 
	 ;; java.awt.event.Event
	 (class %awt-event
	    (method type::int (::%awt-event) "getID")
	    "java.awt.AWTEvent")

	 (class %awt-point
	    (constructor new (::int ::int))
	    "java.awt.Point")

	 ;; java.awt.event.InputEvent
	 (class %awt-inputevent::%awt-event
	    (field static button1::int "BUTTON1_MASK")
	    (field static button2::int "BUTTON2_MASK")
	    (field static button3::int "BUTTON3_MASK")
	    (field static alt-graph::int "ALT_GRAPH_MASK")
	    (field static alt::int "ALT_MASK")
	    (field static ctrl::int "CTRL_MASK")
	    (field static meta::int "META_MASK")
	    (field static shift::int "SHIFT_MASK")
	    (method type::int (::%awt-inputevent) "getID")
	    ;; WARN long ret
	    (method time::long (::%awt-inputevent) "getWhen")
	    ;; WARN long ret
	    (method modifiers::long (::%awt-inputevent) "getModifiers")
	    "java.awt.event.InputEvent")
	 
	 ;; java.awt.event.MouseEvent
	 (class %awt-mouseevent::%awt-inputevent
	    (field static press::int "MOUSE_PRESSED")
	    (field static release::int "MOUSE_RELEASED")
	    (field static enter::int "MOUSE_ENTERED")
	    (field static exit::int "MOUSE_EXITED")
	    (field static move::int "MOUSE_MOVED")
	    (field static drag::int "MOUSE_DRAGGED")
	    (field static click::int "MOUSE_CLICKED")
	    (method x::int (::%awt-mouseevent) "getX")
	    (method y::int (::%awt-mouseevent) "getY")
	    (method click-count::int (::%awt-mouseevent) "getClickCount")
	    "java.awt.event.MouseEvent")
	 
	 ;; java.awt.event.KeyEvent
	 (class %awt-keyevent::%awt-inputevent
	    (method keycode::int (::%awt-keyevent) "getKeyCode")
	    (method keychar::ucs2 (::%awt-keyevent) "getKeyChar")
	    "java.awt.event.KeyEvent")
	 
	 ;; java.awt.event.FocusEvent
	 (class %awt-focusevent::%awt-inputevent
	    (field static gained::int "FOCUS_GAINED")
	    (field static lost::int "FOCUS_LOST")
	    "java.awt.event.FocusEvent")
	 
	 ;; java.awt.event.ComponentEvent
	 (class %awt-componentevent::%awt-inputevent
	    (field static hidden::int "COMPONENT_HIDDEN")
	    (field static shown::int "COMPONENT_SHOWN")
	    (field static moved::int "COMPONENT_MOVED")
	    (field static resized::int "COMPONENT_RESIZED")
	    "java.awt.event.ComponentEvent")
	 
	 ;; java.awt.event.WindowEvent
	 (class %awt-windowevent::%awt-componentevent
	    (field static closed::int "WINDOW_CLOSED")
	    (field static iconified::int "WINDOW_ICONIFIED")
	    (field static deiconified::int "WINDOW_DEICONIFIED")
	    "java.awt.event.WindowEvent")
	 
	 ;; awt-actionlistener
	 (class %awt-actionlistener
	    "java.awt.event.ActionListener")
	 
	 ;; javax.swing.AbstractAction
	 (class %awt-abstractaction
	    "javax.swing.AbstractAction")
	 
	 ;; awt-componentlistener
	 (class %awt-componentlistener
	    "java.awt.event.ComponentListener")
	 
	 ;; awt-componentadpater
	 (class %awt-componentadapter::%awt-componentlistener
	    "java.awt.event.ComponentAdapater")
	 
	 ;; java.awt.event.WindowListener
	 (class %awt-windowlistener
	    "java.awt.event.WindowListener")
	 
	 ;; java.awt.event.WindowAdapter
	 (class %awt-windowadapter::%awt-windowlistener
	    "java.awt.event.WindowAdapter")
	 
	 ;; java.awt.event.MouseListener
	 (class %awt-mouselistener
	    "java.awt.event.MouseListener")
	 
	 ;; java.awt.event.MouseAdapter
	 (class %awt-mouseadapter::%awt-mouselistener
	    "java.awt.event.MouseAdapter")
	 
	 ;; java.awt.event.MouseMotionListener
	 (class %awt-mousemotionlistener
	    "java.awt.event.MouseMotionListener")
	 
	 ;; java.awt.event.MouseMotionAdapter
	 (class %awt-mousemotionadapter::%awt-mousemotionlistener
	    "java.awt.event.MouseMotionAdapter")
	 
	 ;; java.awt.event.KeyListener
	 (class %awt-keylistener
	    "java.awt.event.KeyListener")
	 
	 ;; java.awt.event.KeyAdapter
	 (class %awt-keyadapter::%awt-keylistener
	    "java.awt.event.KeyAdapter")
	 
	 ;; java.awt.event.FocusListener
	 (class %awt-focuslistener
	    "java.awt.event.FocusListener")
	 
	 ;; java.awt.event.FocusAdapter
	 (class %awt-focusadapter::%awt-focuslistener
	    "java.awt.event.FocusAdapter")
	 
	 ;; java.awt.Insets
	 (class %awt-insets::%jobject
	    (constructor new (::int ::int ::int ::int))
	    (field bottom::int "bottom")
	    (field top::int "top")
	    (field left::int "left")
	    (field right::int "right")
	    "java.awt.Insets")
	 
	 ;; java.awt.Dimension
	 (class %awt-dimension
	    (constructor new (::int ::int))
	    (field width::int "width")
	    (field height::int "height")
	    "java.awt.Dimension")
	 
	 ;; java.awt.Dimension2D
	 (class %awt-geom-dimension2D::%jobject
	    (constructor new (::int ::int))
	    (method width::double (::%awt-geom-dimension2D) "getWidth")
	    (method height::double (::%awt-geom-dimension2D) "getHeight")
	    "java.awt.geom.Dimension2D")
	 
	 ;; java.awt.Image
	 (class %awt-image::%jobject
	    "java.awt.Image")
	 
	 ;; java.awt.Image.ImageProducer
	 (class %awt-image-producer::%jobject
	    "java.awt.image.ImageProducer")
	 
	 ;; java.awt.image.MemoryImageSource
	 (class %awt-memory-image-source::%awt-image-producer
	    (constructor new (::int ::int ::int* ::int ::int))
	    "java.awt.image.MemoryImageSource")
	 
	 ;; java.awt.Toolkit
	 (class %awt-toolkit
	    (method static default::%awt-toolkit
		    ()
		    "getDefaultToolkit")
	    (method create-file-image::%awt-image
		    (::%awt-toolkit ::%jstring)
		    "createImage")
	    (method create-data-image::%awt-image
		    (::%awt-toolkit ::string)
		    "createImage")
	    (method create-image::%awt-image
		    (::%awt-toolkit ::%awt-image-producer)
		    "createImage")
	    "java.awt.Toolkit")
	 
	 ;; java.awt.Font
	 (class %awt-font::%jobject
	    (constructor new (::%jstring ::int ::int))
	    (method copy::%awt-font (::%awt-font ::int ::float) "deriveFont")
	    (field static BOLD::int "BOLD")
	    (field static ITALIC::int "ITALIC")
	    (field static PLAIN::int "PLAIN")
	    (method name::%jstring (::%awt-font) "getFontName")
	    (method style::int (::%awt-font) "getStyle")
	    (method size::int (::%awt-font) "getSize")
	    (method bold?::bool (::%awt-font) "isBold")
	    (method italic?::bool (::%awt-font) "isItalic")
	    (method plain?::bool (::%awt-font) "isPlain")
	    "java.awt.Font")
	 
	 ;; java.awt.Colors
	 (class %awt-color::%jobject
	    (constructor new (::int ::int ::int ::int))
	    (field static WHITE::%awt-color "white")
	    (field static BLACK::%awt-color "black")
	    (method static find::%awt-color (::%jstring ::%awt-color) "getColor")
	    (method red::int (::%awt-color) "getRed")
	    (method green::int (::%awt-color) "getGreen")
	    (method blue::int (::%awt-color) "getBlue")
	    (method alpha::int (::%awt-color) "getAlpha")
	    "java.awt.Color")
	 
	 ;; java.awt.Component
	 (class %awt-component::%awt-imageobserver
	    (method toolkit::%awt-toolkit
		    (::%awt-component)
		    "getToolkit")
	    (method x::int
		    (::%awt-component)
		    "getX")
	    (method y::int
		    (::%awt-component)
		    "getY")
	    (method height::int
		    (::%awt-component)
		    "getHeight")
	    (method width::int
		    (::%awt-component)
		    "getWidth")
	    (method size-set!::void
		    (::%awt-component ::int ::int)
		    "setSize")
	    (method dimension-set!::void
		    (::%awt-component ::%awt-dimension)
		    "setSize")
	    (method location-set!::void
		    (::%awt-component ::int ::int)
		    "setLocation")
	    (method font::%awt-font
		    (::%awt-component)
		    "getFont")
	    (method font-set!::void
		    (::%awt-component ::%awt-font)
		    "setFont")
	    (method parent::%awt-container
		    (::%awt-component)
		    "getParent")
	    (method visible-set!::void
		    (::%awt-component ::bool)
		    "setVisible")
	    (method visible::bool
		    (::%awt-component)
		    "isVisible")
	    (method removenotify::void
		    (::%awt-component)
		    "removeNotify")
	    (method add-componentlistener!::void
		    (::%awt-component ::%awt-componentlistener)
		    "addComponentListener")
	    (method add-keylistener!::void
		    (::%awt-component ::%awt-keylistener)
		    "addKeyListener")
	    (method add-focuslistener!::void
		    (::%awt-component ::%awt-focuslistener)
		    "addFocusListener")
	    (method add-mouselistener!::void
		    (::%awt-component ::%awt-mouselistener)
		    "addMouseListener")
	    (method add-mousemotionlistener!::void
		    (::%awt-component ::%awt-mousemotionlistener)
		    "addMouseMotionListener")
	    (method repaint::void
		    (::%awt-component)
		    "repaint")
	    (method update::void
		    (::%awt-component ::%awt-graphics)
		    "update")
	    (method graphics::%awt-graphics
		    (::%awt-component)
		    "getGraphics")
	    (method background::%awt-color
		    (::%awt-component)
		    "getBackground")
	    (method background-set!::void
		    (::%awt-component ::%awt-color)
		    "setBackground")
	    (method enabled?::bool
		    (::%awt-component)
		    "isEnabled")
	    (method enabled?-set!::void
		    (::%awt-component ::bool)
		    "setEnabled")
	    (method invalidate!::void
		    (::%awt-component)
		    "invalidate")
	    (method validate!::void
		    (::%awt-component)
		    "validate")
	    (method repaint!::void
		    (::%awt-component)
		    "repaint")
	    (method cursor::%awt-cursor
		    (::%awt-component)
		    "getCursor")
	    (method cursor-set!::void
		    (::%awt-component ::%awt-cursor)
		    "setCursor")
	    (method valid?::bool
		    (::%awt-component)
		    "isValid")
	    "java.awt.Component")
	 
	 ;; java.awt.Container
	 (class %awt-container::%awt-component
	    (method children-number::int
		    (::%awt-container)
		    "getComponentCount")
	    (method child::%awt-component
		    (::%awt-container ::int)
		    "getComponent")
	    (method add!::%awt-component
		    (::%awt-container ::%awt-component)
		    "add")
	    (method add/constraint!::void
		    (::%awt-container ::%awt-component ::obj)
		    "add")
	    (method option-add!::void
		    (::%awt-container ::%awt-component ::%jobject)
		    "add")
	    (method update::void
		    (::%awt-container)
		    "doLayout")
	    (method validate!::void
		    (::%awt-container)
		    "validate")	    
	    (method repaint::void
		    (::%awt-container)
		    "repaint")
	    (method remove!::void
		    (::%awt-container ::%awt-component)
		    "remove")
	    (method removeall!::void
		    (::%awt-container)
		    "removeAll")
	    (method insets::%awt-insets
		    (::%awt-container)
		    "getInsets")
	    (method layout-set!::void
		    (::%awt-container ::%awt-layoutmanager)
		    "setLayout")
	    (method layout::%awt-layoutmanager
		    (::%awt-container)
		    "getLayout")
	    "java.awt.Container")
	 
	 ;; java.awt.LayoutManager
	 (class %awt-layoutmanager::%jobject
	    "java.awt.LayoutManager")
	 
	 ;; java.awt.GridLayout
	 (class %awt-gridlayout::%awt-layoutmanager
	    (constructor new ())
	    (method rows::int
		    (::%awt-gridlayout)
		    "getRows")
	    (method columns::int
		    (::%awt-gridlayout)
		    "getColumns")
	    (method rows-set!::void
		    (::%awt-gridlayout ::int)
		    "setRows")
	    (method columns-set!::void
		    (::%awt-gridlayout ::int)
		    "setColumns")
	    (method vgap::int
		    (::%awt-gridlayout)
		    "getVgap")
	    (method vgap-set!::void
		    (::%awt-gridlayout ::int)
		    "setVgap")
	    (method hgap::int
		    (::%awt-gridlayout)
		    "getHgap")
	    (method hgap-set!::void
		    (::%awt-gridlayout ::int)
		    "setHgap")
	    "java.awt.GridLayout")
	 
	 ;; java.awt.GridBagLayout
	 (class %awt-gridbaglayout::%awt-layoutmanager
	    (constructor new ())
	    (method rows::int
		    (::%awt-gridbaglayout)
		    "getRows")
	    (method columns::int
		    (::%awt-gridbaglayout)
		    "getColumns")
	    (method rows-set!::void
		    (::%awt-gridbaglayout ::int)
		    "setRows")
	    (method columns-set!::void
		    (::%awt-gridbaglayout ::int)
		    "setColumns")
	    (method vgap::int
		    (::%awt-gridbaglayout)
		    "getVgap")
	    (method vgap-set!::void
		    (::%awt-gridbaglayout ::int)
		    "setVgap")
	    (method hgap::int
		    (::%awt-gridbaglayout)
		    "getHgap")
	    (method hgap-set!::void
		    (::%awt-gridbaglayout ::int)
		    "setHgap")
	    "java.awt.GridBagLayout")
	 
	 ;; java.awt.GridBagConstraints
	 (class %awt-gridbagconstraints::%jobject
	    (constructor new ())
	    (field static RELATIVE::int "RELATIVE")
	    (field static HORIZONTAL::int "HORIZONTAL")
	    (field static VERTICAL::int "VERTICAL")
	    (field static BOTH::int "BOTH")
	    (field static NONE::int "NONE")
	    (field static CENTER::int "CENTER")
	    (field static NORTH::int "NORTH")
	    (field static SOUTH::int "SOUTH")
	    (field static EAST::int "EAST")
	    (field static WEST::int "WEST")
	    (field anchor::int "anchor")
	    (field gridx::int "gridx")
	    (field gridy::int "gridy")
	    (field weightx::double "weightx")
	    (field weighty::double "weighty")
	    (field fill::int "fill")
	    (field ipadx::int "ipadx")
	    (field ipady::int "ipady")
	    (field insets::%awt-insets "insets")
	    "java.awt.GridBagConstraints")
	 
	 ;; java.awt.BorderLayout
	 (class %awt-borderlayout::%awt-layoutmanager
	    (constructor new ())
	    (field static NORTH::%jstring "NORTH")
	    (field static WEST::%jstring "WEST")
	    (field static CENTER::%jstring "CENTER")
	    (field static EAST::%jstring "EAST")
	    (field static SOUTH::%jstring "SOUTH")
	    (method hgap::int
		    (::%awt-borderlayout)
		    "getHgap")
	    (method hgap-set!::void
		    (::%awt-borderlayout ::int)
		    "setHgap")
	    (method vgap::int
		    (::%awt-borderlayout)
		    "getVgap")
	    (method vgap-set!::void
		    (::%awt-borderlayout ::int)
		    "setVgap")
	    (method add!::void
		    (::%awt-borderlayout ::%awt-component ::%jobject)
		    "addLayoutComponent")
	    "java.awt.BorderLayout")
	 
	 ;; java.awt.Panel
	 (class %awt-panel::%awt-container
	    (constructor new ())
	    "java.awt.Panel")
	 
	 ;; java.awt.Window
	 (class %awt-window::%awt-container
	    (method add-listener!::void
		    (::%awt-window ::%awt-windowlistener)
		    "addWindowListener")
	    (method pack::void
		    (::%awt-window)
		    "pack")
	    (method hide::void
		    (::%awt-window)
		    "hide")
	    (method show::void
		    (::%awt-window)
		    "show")
	    "java.awt.Window")
	 
	 ;; java.awt.Window
	 (class %awt-dialog::%awt-window
	    "java.awt.Dialog")
	 
	 ;; java.awt.Frame
	 (class %awt-frame::%awt-window
	    (constructor new ())
	    (method title::%jstring
		    (::%awt-frame)
		    "getTitle")
	    (method title-set!::void
		    (::%awt-frame ::%jstring)
		    "setTitle")
	    (method resizable-set!::void
		    (::%awt-frame ::bool)
		    "setResizable")
	    "java.awt.Frame")
	 
	 ;; java.awt.Label
	 (class %awt-label::%awt-component
	    (constructor new ())
	    (method text::%jstring
		    (::%awt-label)
		    "getText")
	    (method text-set!::void
		    (::%awt-label ::%jstring)
		    "setText")
	    "java.awt.Label")
	 
	 ;; java.awt.Button
	 (class %awt-button::%awt-component
	    (constructor new ())
	    (method text::%jstring
		    (::%awt-button)
		    "getLabel")
	    (method text-set!::void
		    (::%awt-button ::%jstring)
		    "setLabel")
	    "java.awt.Button")
	 
	 ;; java.awt.Graphics
	 (class %awt-graphics::%jobject
	    (method draw-string::void
		    (::%awt-graphics ::string ::int ::int ::int ::int)
		    "drawBytes")
	    (method font-set!::void
		    (::%awt-graphics ::%awt-font)
		    "setFont")
	    (method color-set!::void
		    (::%awt-graphics ::%awt-color)
		    "setColor")
	    (method image-draw::bool
		    (::%awt-graphics
		     ::%awt-image
		     ::int ::int
		     ::%awt-imageobserver)
		    "drawImage")
	    (method scale-image-draw::bool
		    (::%awt-graphics
		     ::%awt-image
		     ::int ::int
		     ::int ::int
		     ::%awt-imageobserver)
		    "drawImage")
	    "java.awt.Graphics")
	 
	 ;; java.awt.Graphics2D
	 (class %awt-graphics2D::%awt-graphics
	    (method draw-string::void
		    (::%awt-graphics2D ::%jstring ::float ::float)
		    "drawString")
	    (method fontrender::%awt-fontrendercontext
		    (::%awt-graphics2D)
		    "getFontRenderContext")
	    (method stroke-set!::void
		    (::%awt-graphics2D ::%awt-stroke)
		    "setStroke")
	    (method translate!::void
		    (::%awt-graphics2D ::double ::double)
		    "translate")
	    (method shape-draw::void 
		    (::%awt-graphics2D ::%awt-shape)
		    "draw")
	    (method shape-fill::void 
		    (::%awt-graphics2D ::%awt-shape)
		    "fill")
	    "java.awt.Graphics2D")

	 ;; java.awt.geom.GeneralPath
	 (class %awt-generalpath::%awt-shape
	    (constructor new ())
	    (method lineto::void
		    (::%awt-generalpath ::float ::float)
		    "lineTo")	    
	    (method moveto::void
		    (::%awt-generalpath ::float ::float)
		    "moveTo")	    
	    (method curveto::void
		    (::%awt-generalpath ::float ::float ::float ::float
					::float ::float)
		    "curveTo")
	    (method contains?::bool (::%awt-generalpath ::double ::double)
		    "contains")
	    (method bbox::%awt-rectangle2D (::%awt-generalpath)
		    "getBounds2D")	    
	    "java.awt.geom.GeneralPath")
	 
	 ;; java.awt.image.BufferedImage
	 (class %awt-bufferedimage
	    (method graphics::%awt-graphics2D
		    (::%awt-bufferedimage)
		    "createGraphics")
	    "java.awt.image.BufferedImage")
	 
	 ;; java.awt.FontRenderContext
	 (class %awt-fontrendercontext::%jobject
	    "java.awt.font.FontRenderContext")
	 
	 ;; java.awt.font.TextLayout
	 (class %awt-textlayout::%jobject
	    (constructor new (::%jstring
			      ::%awt-font
			      ::%awt-fontrendercontext))
	    (method draw::void
		    (::%awt-textlayout ::%awt-graphics2D ::float ::float)
		    "draw")
	    (method getbounds::%awt-rectangle2D
		    (::%awt-textlayout)
		    "getBounds")
	    "java.awt.font.TextLayout")
	 
	 ;; java.awt.shape
	 (class %awt-shape::%jobject
	    (method contains::bool
		    (::%awt-shape ::double ::double)
		    "contains")
	    "java.awt.Shape")
	 
	 ;; java.awt.geom.Rectangle2D
	 (class %awt-rectangle2D::%awt-shape
	    (method width::double
		    (::%awt-rectangle2D)
		    "getWidth")
	    (method height::double
		    (::%awt-rectangle2D)
		    "getHeight")
	    "java.awt.geom.Rectangle2D")
	 
	 ;; java.awt.geom.Rectangle2D.Double
	 (class %awt-rectangle2D-double::%awt-shape
	    (constructor new ())
	    (method getWidth::double
		    (::%awt-rectangle2D-double)
		    "getWidth")
	    (method getHeight::double
		    (::%awt-rectangle2D-double)
		    "getHeight")
	    (method getX::double
		    (::%awt-rectangle2D-double)
		    "getX")
	    (method getY::double
		    (::%awt-rectangle2D-double)
		    "getY")
	    (method contains::bool
		    (::%awt-rectangle2D-double ::double ::double)
		    "contains")
	    (method set-rectangle::void
		    (::%awt-rectangle2D-double
		     ::double ::double ::double ::double)
		    "setRect")
	    "java.awt.geom.Rectangle2D$Double")
	 
	 ;; java.awt.geom.Ellipse2D
	 (class %awt-ellipse2D::%awt-shape
	    (method width::double
		    (::%awt-ellipse2D)
		    "getWidth")
	    (method height::double
		    (::%awt-ellipse2D)
		    "getHeight")
	    "java.awt.geom.Ellipse2D")
	 
	 ;; java.awt.geom.Ellipse2D.Double
	 (class %awt-ellipse2D-double::%awt-shape
	    (constructor new ())
	    (method getWidth::double
		    (::%awt-ellipse2D-double)
		    "getWidth")
	    (method getHeight::double
		    (::%awt-ellipse2D-double)
		    "getHeight")
	    (method getX::double
		    (::%awt-ellipse2D-double)
		    "getX")
	    (method getY::double
		    (::%awt-ellipse2D-double)
		    "getY")
	    (method contains::bool
		    (::%awt-ellipse2D-double ::double ::double)
		    "contains")
	    (method set-ellipse::void
		    (::%awt-ellipse2D-double
		     ::double ::double ::double ::double)
		    "setFrame")
	    "java.awt.geom.Ellipse2D$Double")
	 
	 ;; java.awt.geom.Line2D
	 (class %awt-line2D::%awt-shape
	    (method set!::void
		    (::%awt-line2D ::double ::double ::double ::double)
		    "setLine")
	    (method distance::double
		    (::%awt-line2D ::double ::double)
		    "ptLineDist")
	    (method segment-distance::double
		    (::%awt-line2D ::double ::double)
		    "ptSegDist")
	    "java.awt.geom.Line2D")
	 
	 ;; java.awt.geom.Line2D.Double
	 (class %awt-line2D-double::%awt-line2D
	    (constructor new ())
	    (method contains::bool
		    (::%awt-line2D-double ::double ::double)
		    "contains")
	    (method getbounds::%awt-rectangle2D
		    (::%awt-line2D-double)
		    "getBounds2D")
	    (method getX1::double
		    (::%awt-line2D-double)
		    "getX1")
	    (method getY1::double
		    (::%awt-line2D-double)
		    "getY1")
	    (method getX2::double
		    (::%awt-line2D-double)
		    "getX2")
	    (method getY2::double
		    (::%awt-line2D-double)
		    "getY2")
	    (method %awt-line2D-set!::void
		    (::%awt-line2D-double ::double ::double ::double ::double)
		    "setLine")
	    "java.awt.geom.Line2D$Double")

	 ;; java.awt.geom.CubicCurve2D.Double
	 (class %awt-cubic-curve2D-double
	    (constructor new ())
	    (method contains::bool
		    (::%awt-cubic-curve2D-double ::double ::double)
		    "contains")
	    (method getbounds::%awt-rectangle2D
		    (::%awt-cubic-curve2D-double)
		    "getBounds2D")
	    (method getX1::double
		    (::%awt-cubic-curve2D-double)
		    "getX1")
	    (method getY1::double
		    (::%awt-cubic-curve2D-double)
		    "getY1")
	    (method getX2::double
		    (::%awt-cubic-curve2D-double)
		    "getX2")
	    (method getY2::double
		    (::%awt-cubic-curve2D-double)
		    "getY2")
	    (method set::void
		    (::%awt-cubic-curve2D-double ::double ::double ::double ::double
						 ::double ::double ::double ::double)
		    "setCurve")
	    "java.awt.geom.CubicCurve2D$Double")

	 
	 ;; java.awt.Stroke
	 (class %awt-stroke::%jobject
	    "java.awt.Stroke")
	 
	 ;; java.awt.BasicStroke
	 (class %awt-basicstroke::%awt-stroke
	    (field static CAP_BUTT::int "CAP_BUTT")
	    (field static CAP_ROUND::int "CAP_ROUND")
	    (field static CAP_SQUARE::int "CAP_SQUARE")
	    (field static JOIN_MITER::int "JOIN_MITER")
	    (field static JOIN_ROUND::int "JOIN_ROUND")
	    (field static JOIN_BEVEL::int "JOIN_BEVEL")
	    (constructor new ())
	    (constructor width-new (::float))
	    (constructor new-ext (::float ::int ::int))
	    (constructor new-full (::float ::int ::int ::float ::float* ::float))
	    (method dash-array::float* (::%awt-basicstroke)
		    "getDashArray")
	    (method line-width::float (::%awt-basicstroke)
		    "getLineWidth")
	    (method cap-style::int (::%awt-basicstroke)
		    "getEndCap")
	    (method line-join::int (::%awt-basicstroke)
		    "getLineJoin")
	    "java.awt.BasicStroke")


	 ;; java.awt.Cursor
	 (class %awt-cursor
	    (field static CROSSHAIR_CURSOR::int "CROSSHAIR_CURSOR")
	    (field static CUSTOM_CURSOR::int "CUSTOM_CURSOR")
	    (field static DEFAULT_CURSOR::int "DEFAULT_CURSOR")
	    (field static E_RESIZE_CURSOR::int "E_RESIZE_CURSOR")
	    (field static HAND_CURSOR::int "HAND_CURSOR")
	    (field static MOVE_CURSOR::int "MOVE_CURSOR")
	    (field static N_RESIZE_CURSOR::int "N_RESIZE_CURSOR")
	    (field static NE_RESIZE_CURSOR::int "NE_RESIZE_CURSOR")
	    (field static NW_RESIZE_CURSOR::int "NW_RESIZE_CURSOR")
	    (field static S_RESIZE_CURSOR::int "S_RESIZE_CURSOR")
	    (field static SE_RESIZE_CURSOR::int "SE_RESIZE_CURSOR")
	    (field static SW_RESIZE_CURSOR::int "SW_RESIZE_CURSOR")
	    (field static TEXT_CURSOR::int "TEXT_CURSOR")
	    (field static W_RESIZE_CURSOR::int "W_RESIZE_CURSOR")
	    (field static WAIT_CURSOR::int "WAIT_CURSOR")
	    (constructor new ())
	    (constructor new/type (::int))
	    (method type::int (::%awt-cursor) "getType")
	    "java.awt.Cursor")
	))