;*=====================================================================*/
;*    swing/Lswing/_swing.scm                                          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Apr 19 08:57:56 2001                          */
;*    Last change :  Tue May 11 14:14:48 2004 (dciabrin)               */
;*    Copyright   :  2001-04 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing connection                                             */
;*    -------------------------------------------------------------    */
;*    See also:                                                        */
;*      The Awt connection: @path ../Lswing/%awt.scm@                  */
;*      The Peer implementation: @path ../Lwidget/%peer.scm@           */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%swing
   
   (import __biglook_%awt)
   
   (java   (class %integer
	      (field static max-value::int "MAX_VALUE")
	      "java.lang.Integer")
	   
	   (class %swing-icon::%jobject
	      "javax.swing.Icon")
	   
	   ;; javax.swing.SwingUtilities
	   (class %swing-utilities::%jobject
	      (method static button-left?::bool
		      (::%awt-mouseevent)
		      "isLeftMouseButton")
	      (method static button-middle?::bool
		      (::%awt-mouseevent)
		      "isMiddleMouseButton")
	      (method static button-right?::bool
		      (::%awt-mouseevent)
		      "isRightMouseButton")
	      "javax.swing.SwingUtilities")
	   
	   ;; javax.swing.event.ChangeEvent
	   (class %swing-changeevent
	      "javax.swing.event.ChangeEvent")
	   
	   ;; javax.swing.event.ListSelectionEvent
	   (class %swing-listselectionevent
	      (method firstindex::int
		      (::%swing-listselectionevent)
		      "getFirstIndex")
	      (method lastindex::int
		      (::%swing-listselectionevent)
		      "getLastIndex")
	      "javax.swing.event.ListSelectionEvent")

	   ;; javax.swing.event.TableModelEvent
	   (class %swing-tablemodelevent
	      (method row::int
		      (::%swing-tablemodelevent)
		      "getFirstRow")
	      (method column::int
		      (::%swing-tablemodelevent)
		      "getColumn")
	      "javax.swing.event.TableModelEvent")
	   
	   ;; javax.swing.Timer
	   (class %swing-timer
	      (constructor new
			   (::int ::%awt-actionlistener))
	      (method add-listener!::void
		      (::%swing-timer ::%awt-actionlistener)
		      "addActionListener")
	      (method remove-listener!::void
		      (::%swing-timer ::%awt-actionlistener)
		      "removeActionListener")
	      (method start::void
		      (::%swing-timer)
		      "start")
	      (method stop::void
		      (::%swing-timer)
		      "stop")
	      (method is-repeat-set!::void
		      (::%swing-timer ::bool)
		      "setRepeats")
	      "javax.swing.Timer")
	   
	   ;; javax.swing.Action
	   (class %swing-action::%awt-actionlistener
	      "javax.swing.Action")
	   
	   ;; javax.swing.AbstractAction
	   (class %swing-abstractaction::%swing-action
	      "javax.swing.AbstractAction")
	   
	   ;; javax.swing.border.Border
	   (class %swing-border::%jobject
	      "javax.swing.border.Border")
	   
	   ;; javax.swing.border.AbstractBorder
	   (class %swing-abstractborder::%swing-border
	      "javax.swing.border.AbstractBorder")
	   
	   ;; javax.swing.border.EmptyBorder
	   (class %swing-emptyborder::%swing-abstractborder
	      "javax.swing.border.EmptyBorder")
	   
	   ;; javax.swing.border.BevelBorder
	   (class %swing-bevelborder::%swing-abstractborder
	      (field static LOWERED::int
		     "LOWERED")
	      (method type::int
		      (::%swing-bevelborder)
		      "getBevelType")
	      "javax.swing.border.BevelBorder")
	   
	   ;; javax.swing.border.SoftBevelBorder
	   (class %swing-softbevelborder::%swing-bevelborder
	      "javax.swing.border.SoftBevelBorder")
	   
	   ;; javax.swing.border.EtchedBorder
	   (class %swing-etchedborder::%swing-abstractborder
	      (field static LOWERED::int
		     "LOWERED")
	      (method type::int
		      (::%swing-etchedborder)
		      "getEtchType")
	      "javax.swing.border.EtchedBorder")
	   
	   ;; javax.swing.border.CompoundBorder
	   (class %swing-compoundborder::%swing-abstractborder
	      (constructor new
			   (::%swing-border ::%swing-border))
	      "javax.swing.border.CompoundBorder")
	   
	   ;; javax.swing.border.TitledBorder
	   (class %swing-titledborder::%swing-abstractborder
	      (constructor new ())
	      (field static CENTER::int "CENTER")
	      (field static RIGHT::int "RIGHT")
	      (field static LEFT::int "LEFT")
	      (method title::%jstring
		      (::%swing-titledborder)
		      "getTitle")
	      (method title-set!::void
		      (::%swing-titledborder ::%jstring)
		      "setTitle")
	      (method justification::int
		      (::%swing-titledborder)
		      "getTitleJustification")
	      (method justification-set!::void
		      (::%swing-titledborder ::int)
		      "setTitleJustification")
	      "javax.swing.border.TitledBorder")
	   
	   ;; javax.swing.ImageIcon
	   (class %swing-imageicon::%swing-icon
	      (constructor new ())
	      (constructor new/image
			   (::%awt-image))
	      (method image::%awt-image
		      (::%swing-imageicon)
		      "getImage")
	      (method image-set!::void
		      (::%swing-imageicon ::%awt-image)
		      "setImage")
	      (method width::int
		      (::%swing-imageicon)
		      "getIconWidth")
	      (method height::int
		      (::%swing-imageicon)
		      "getIconHeight")
	      "javax.swing.ImageIcon")
	   
	   ;; javax.swing.Box
	   (class %swing-box::%awt-container
	      (method static horizontal-new::%swing-box
		      () 
		      "createHorizontalBox")
	      (method static vertical-new::%swing-box
		      () 
		      "createVerticalBox")
	      (method static horizontal-glue::%awt-component
		      ()
		      "createHorizontalGlue")
	      (method static vertical-glue::%awt-component
		      ()
		      "createVerticalGlue")
	      (method static rigid-area::%awt-component
		      (::%awt-dimension)
		      "createRigidArea")
	      "javax.swing.Box")

	   ;; javax.swing.BoxLayout
	   (class %swing-boxlayout::%awt-layoutmanager
	      (constructor new (::%awt-container ::int))
	      (field static X-AXIS::int
		     "X_AXIS")
	      (field static Y-AXIS::int
		     "Y_AXIS")
	      "javax.swing.BoxLayout")
	   
	   ;; javax.swing.JWindow
	   (class %swing-jwindow::%awt-window
	      (constructor new ())
	      (method contentpane::%awt-container
		      (::%swing-jwindow)
		      "getContentPane")
	      "javax.swing.JWindow")
	   
	   ;; javax.swing.JDialog
	   (class %swing-jdialog::%awt-dialog
	      (constructor new ())
	      (method contentpane::%awt-container
		      (::%swing-jdialog)
		      "getContentPane")
	      "javax.swing.JDialog")
	   
	   ;; javax.swing.WindowConstants
	   (class %swing-window-constants
	      (field static DO-NOTHING-ON-CLOSE::int
		     "DO_NOTHING_ON_CLOSE")
	      "javax.swing.WindowConstants")
	   
	   ;; javax.swing.Constants
	   (class %swing-constants
	      (field static TOP::int
		     "TOP")
	      (field static BOTTOM::int
		     "BOTTOM")
	      (field static LEFT::int
		     "LEFT")
	      (field static RIGHT::int
		     "RIGHT")
	      (field static HORIZONTAL::int
		     "HORIZONTAL")
	      (field static VERTICAL::int
		     "VERTICAL")
	      "javax.swing.SwingConstants")
	   
	   ;; javax.swing.JComponent
	   (class %swing-jcomponent::%awt-container
	      (method updateui::void
		      (::%swing-jcomponent)
		      "updateUI")
	      (method border::%swing-border
		      (::%swing-jcomponent)
		      "getBorder")
	      (method border-set!::void
		      (::%swing-jcomponent ::%swing-border)
		      "setBorder")
	      (method alignment-x-set!::void
		      (::%swing-jcomponent ::float)
		      "setAlignmentX")
	      (method alignment-y-set!::void
		      (::%swing-jcomponent ::float)
		      "setAlignmentY")
	      (method tooltip::%jstring
		      (::%swing-jcomponent)
		      "getToolTipText")
	      (method tooltip-set!::void
		      (::%swing-jcomponent ::%jstring)
		      "setToolTipText")
	      (method get-tooltip::%swing-jtooltip
		      (::%swing-jcomponent)
		      "createToolTip")
	      (method background-set!::void
		      (::%swing-jcomponent ::%awt-color)
		      "setBackground")
	      (method font-set!::void
		      (::%swing-jcomponent ::%awt-font)
		      "setFont")
	      (method minimum-size-set!::void
		      (::%swing-jcomponent ::%awt-dimension)
		      "setMinimumSize")
	      (method maximum-size-set!::void
		      (::%swing-jcomponent ::%awt-dimension)
		      "setMaximumSize")
	      (method preferred-size-set!::void
		      (::%swing-jcomponent ::%awt-dimension)
		      "setPreferredSize")
	      (method maximum-size::%awt-dimension
		      (::%swing-jcomponent)
		      "getMaximumSize")
	      (method preferred-size::%awt-dimension
		      (::%swing-jcomponent)
		      "getPreferredSize")
	      (method put-client-property::void
		      (::%swing-jcomponent ::%jobject ::%jobject)
		      "putClientProperty")
	      (method revalidate::void
		      (::%swing-jcomponent)
		      "revalidate")
	      (method enabled-set!::void
		      (::%swing-jcomponent ::bool)
		      "setEnabled")
	      (method enabled::bool
		      (::%swing-jcomponent)
		      "isEnabled")
	      "javax.swing.JComponent")
	   
	   ;; javax.swing.JFrame
	   (class %swing-jframe::%awt-frame
	      (constructor new ())
	      (method contentpane::%awt-container
		      (::%swing-jframe)
		      "getContentPane")
	      (method close-set!::void
		      (::%swing-jframe ::int)
		      "setDefaultCloseOperation")
	      (method static laf-decorated-set!::void (::bool)
		      "setDefaultLookAndFeelDecorated")
	      (method title::%jstring
		      (::%swing-jframe)
		      "getTitle")
	      (method title-set!::void
		      (::%swing-jframe ::%jstring)
		      "setTitle")
	      (method jmenubar-set!::void (::%swing-jframe ::%swing-jmenubar)
		      "setJMenuBar")	      
	      "javax.swing.JFrame")
	   
	   ;; javax.swing.JPanel
	   (class %swing-jpanel::%awt-panel
	      (constructor new ())
	      (constructor new/layout (::%awt-layoutmanager))
	      "javax.swing.JPanel")
	   
	   ;; javax.swing.JLabel
	   (class %swing-jlabel::%swing-jcomponent
	      (constructor new ())
	      (constructor new/icon (::%swing-icon))
	      (method text::%jstring
		      (::%swing-jlabel)
		      "getText")
	      (method text-set!::void
		      (::%swing-jlabel ::%jstring)
		      "setText")
	      (method icon::%swing-icon
		      (::%swing-jlabel)
		      "getIcon")
	      (method icon-set!::void
		      (::%swing-jlabel ::%swing-icon)
		      "setIcon")
	      "javax.swing.JLabel")
	   
	   ;; javax.swing.ButtonModel
	   (class %swing-buttonmodel
	      "javax.swing.ButtonModel")
	   
	   ;; java.swing.AbstractButton
	   (class %swing-abstractbutton::%swing-jcomponent
	      (method add-actionlistener!::void
		      (::%swing-abstractbutton ::%awt-actionlistener)
		      "addActionListener")
	      (method text::%jstring
		      (::%swing-abstractbutton)
		      "getText")
	      (method text-set!::void
		      (::%swing-abstractbutton ::%jstring)
		      "setText")
	      (method icon::%swing-icon
		      (::%swing-abstractbutton)
		      "getIcon")
	      (method icon-set!::void
		      (::%swing-abstractbutton ::%swing-icon)
		      "setIcon")
	      (method set-text-position!::void
		      (::%swing-abstractbutton ::int)
		      "setHorizontalTextPosition")
	      (method selected?::bool
		      (::%swing-abstractbutton)
		      "isSelected")
	      (method selected?-set!::void
		      (::%swing-abstractbutton ::bool)
		      "setSelected")
	      (method model::%swing-buttonmodel
		      (::%swing-abstractbutton)
		      "getModel")
	      (method alignment-set!::void
		      (::%swing-abstractbutton ::int)
		      "setHorizontalAlignment")
	      (method margin::%awt-insets
		      (::%swing-abstractbutton)
		      "getMargin")
	      (method margin-set!::void
		      (::%swing-abstractbutton ::%awt-insets)
		      "setMargin")
	      (method isborderpainted::bool
		      (::%swing-abstractbutton)
		      "isBorderPainted")
	      (method isborderpainted-set!::void
		      (::%swing-abstractbutton ::bool)
		      "setBorderPainted")
	      (field final public static leading::int "LEADING")
	      (field final public static center::int "CENTER")
	      "javax.swing.AbstractButton")
	   
	   ;; javax.swing.JButton
	   (class %swing-jbutton::%swing-abstractbutton
	      (constructor new ())
	      (method defaultcapable-set!::void
		      (::%swing-jbutton ::bool)
		      "setDefaultCapable")
	      "javax.swing.JButton")
	   
	   ;; javax.swing.JCheckBox
	   (class %swing-jcheckbox::%swing-abstractbutton
	      (constructor new ())
	      "javax.swing.JCheckBox")
	   
	   ;; javax.swing.ButtonGroup
	   (class %swing-buttongroup::%jobject
	      (constructor new ())
	      (method add!::void
		      (::%swing-buttongroup ::%swing-abstractbutton)
		      "add")
	      (method selected?::bool
		      (::%swing-buttongroup ::%swing-buttonmodel)
		      "isSelected")
	      (method selected?-set!::void
		      (::%swing-buttongroup ::%swing-buttonmodel ::bool)
		      "setSelected")
	      "javax.swing.ButtonGroup")
	   
	   ;; javax.swing.JRadioButton
	   (class %swing-jradiobutton::%swing-abstractbutton
	      (constructor new ())
	      "javax.swing.JRadioButton")
	   
	   ;; javax.swing.text.JTextComponent
	   (class %swing-jtextcomponent::%swing-jcomponent
	      (method editable?::bool
		      (::%swing-jtextcomponent)
		      "isEditable")
	      (method editable?-set!::void
		      (::%swing-jtextcomponent ::bool)
		      "setEditable")	      
	      (method caret-position::int (::%swing-jtextcomponent)
		      "getCaretPosition")
	      (method caret-position-set!::void (::%swing-jtextcomponent ::int)
		      "setCaretPosition")
	      (method text::%jstring (::%swing-jtextcomponent)
		      "getText")
	      (method text-set!::void (::%swing-jtextcomponent ::%jstring)
		      "setText")
	      (method view->model::int (::%swing-jtextcomponent ::%awt-point)
		      "viewToModel")
	      "javax.swing.text.JTextComponent")
	   
	   ;; javax.swing.JTextArea
	   (class %swing-jtextarea::%swing-jtextcomponent
	      (method text::%jstring
		      (::%swing-jtextarea)
		      "paramString")
	      "javax.swing.JTextArea")

	   ;; javax.swing.JEditorPane
	   (class %swing-jeditorpane::%swing-jtextcomponent
	      (constructor new ())
;	      (method text::%jstring (::%swing-jeditorpane)
;		      "getText")
;	      (method text-set!::void (::%swing-jeditorpane ::%jstring)
;		      "setText")
	      "javax.swing.JEditorPane")

	   ;; javax.swing.JTextPane
	   (class %swing-jtextpane::%swing-jeditorpane
	      (constructor new ())
	      (method styled-document::%swing-jstyleddocument (::%swing-jtextpane)
		      "getStyledDocument")
	      (method replace-selection::void (::%swing-jtextpane ::%jstring)
		      "replaceSelection")
	      "javax.swing.JTextPane")

	   (class %swing-element
	      (method start-offset::int (::%swing-element)
		      "getStartOffset")
	      (method end-offset::int (::%swing-element)
		      "getEndOffset")
	      (method child::%swing-element (::%swing-element ::int)
		      "getElement")
	      (method child-index::int (::%swing-element ::int)
		      "getElementIndex")
	      "javax.swing.text.Element")
	      
	   (class %swing-jdocument
	      (method foo::obj (::%swing-jdocument)
		      "getDefaultRootElement")
	      "javax.swing.text.Document")
	   
	   (class %swing-jstyleddocument::%swing-jdocument	      
	      "javax.swing.text.StyledDocument")
	   
	   ;; javax.swing.JTextField
	   (class %swing-jtextfield::%swing-jtextarea
	      (constructor new ())
	      (method width::int
		      (::%swing-jtextfield)
		      "getColumns")
	      (method width-set!::void
		      (::%swing-jtextfield ::int)
		      "setColumns")
	      "javax.swing.JTextField")
	   
	   ;; javax.swing.JToolTip
	   (class %swing-jtooltip::%swing-jcomponent
	      (method text::%jstring
		      (::%swing-jtooltip)
		      "getTipText")
	      (method text-set!::void
		      (::%swing-jtooltip ::%jstring)
		      "setTipText")
	      "javax.swing.JToolTip")
	   
	   ;; javax.swing.JProgressBar
	   (class %swing-jprogressbar::%swing-jcomponent
	      (constructor new ())
	      (method value::int
		      (::%swing-jprogressbar)
		      "getValue")
	      (method value-set!::void
		      (::%swing-jprogressbar ::int)
		      "setValue")
	      (method string::%jstring
		      (::%swing-jprogressbar)
		      "getString")
	      (method string-set!::void
		      (::%swing-jprogressbar ::%jstring)
		      "setString")
	      (method string-on?::bool
		      (::%swing-jprogressbar)
		      "isStringPainted")
	      (method string-on?-set!::void
		      (::%swing-jprogressbar ::bool)
		      "setStringPainted")
	      (method border-on?::bool
		      (::%swing-jprogressbar)
		      "isBorderPainted")
	      (method border-on?-set!::void
		      (::%swing-jprogressbar ::bool)
		      "setBorderPainted")
	      "javax.swing.JProgressBar")
	   
	   ;; javax.swing.JList
	   (class %swing-jlist::%swing-jcomponent
	      (constructor new ())
	      (method selection-mode::int
		      (::%swing-jlist)
		      "getSelectionMode")
	      (method selection-mode-set!::void
		      (::%swing-jlist ::int)
		      "setSelectionMode")
	      (method items-set!::void
		      (::%swing-jlist ::%jobject*)
		      "setListData")
	      (method selection-set!::void
		      (::%swing-jlist ::int*)
		      "setSelectedIndices")
	      (method is-selected?::bool
		      (::%swing-jlist ::int)
		      "isSelectedIndex")
	      "javax.swing.JList")
	   
	   ;; javax.swing.ListSelectionModel
	   (class %swing-listselectionmodel::%jobject
	      (field static MULTIPLE_INTERVAL_SELECTION::int
		     "MULTIPLE_INTERVAL_SELECTION")
	      (field static SINGLE_INTERVAL_SELECTION::int
		     "SINGLE_INTERVAL_SELECTION")
	      (field static SINGLE_SELECTION::int
		     "SINGLE_SELECTION")
	      "javax.swing.ListSelectionModel")
	   
	   ;; javax.swing.DefaultListSelectionModel
	   (class %swing-defaultlistselectionmodel::%swing-listselectionmodel
	      (method add::void
		      (::%swing-defaultlistselectionmodel
		       ::%swing-listselectionlistener)
		      "addListSelectionListener")
	      (method selection-mode::int
		      (::%swing-defaultlistselectionmodel)
		      "getSelectionMode")
	      "javax.swing.DefaultListSelectionModel")
	   
	   ;; javax.swing.JComboBox
	   (class %swing-jcombobox::%swing-jcomponent
	      (constructor new ())
	      (method remove-all!::void
		      (::%swing-jcombobox)
		      "removeAllItems")
	      (method add!::void
		      (::%swing-jcombobox ::%jobject)
		      "addItem")
	      (method ref::%jobject
		      (::%swing-jcombobox ::int)
		      "getItemAt")
	      (method length::int
		      (::%swing-jcombobox)
		      "getItemCount")
	      (method editor::%swing-jcomboboxeditor
		      (::%swing-jcombobox)
		      "getEditor")
	      (method selected::%jobject
		      (::%swing-jcombobox)
		      "getSelectedItem")
	      (method selected-set!::void
		      (::%swing-jcombobox ::int)
		      "setSelectedIndex")
	      (method editable?::bool
		      (::%swing-jcombobox)
		      "isEditable")
	      (method editable?-set!::void
		      (::%swing-jcombobox ::bool)
		      "setEditable")
	      "javax.swing.JComboBox")
	   
	   ;; javax.swing.ComboBoxEditor
	   (class %swing-jcomboboxeditor
	      (method get::%jobject
		      (::%swing-jcomboboxeditor)
		      "getItem")
	      (method set!::void
		      (::%swing-jcomboboxeditor ::%jobject)
		      "setItem")
	      "javax.swing.ComboBoxEditor")
	   
	   ;; javax.swing.JRootPane
	   (class %swing-jrootpane::%swing-jcomponent
	      "javax.swing.JRootPane")
	   
	   ;; javax.swing.JScrollBar
	   (class %swing-jscrollbar::%swing-jcomponent
	      (constructor new ())
	      (method minimum::int
		      (::%swing-jscrollbar)
		      "getMinimum")
	      (method maximum::int
		      (::%swing-jscrollbar)
		      "getMaximum")
	      (method visible::int
		      (::%swing-jscrollbar)
		      "getVisibleAmount")
	      (method value::int
		      (::%swing-jscrollbar)
		      "getValue")
	      (method value-set!::void
		      (::%swing-jscrollbar ::int)
		      "setValue")
	      "javax.swing.JScrollBar")
	   
	   ;; javax.swing.JScrollPane
	   (class %swing-jscrollpane::%swing-jcomponent
	      (constructor new (::%awt-component))
	      (constructor new/policy (::int ::int))
	      (constructor new/component (::%awt-component ::int ::int))
	      (method view-set!::void
		      (::%swing-jscrollpane ::%awt-component)
		      "setViewportView")
	      (method hpolicy::int
		      (::%swing-jscrollpane)
		      "getHorizontalScrollBarPolicy")
	      (method hpolicy-set!::void
		      (::%swing-jscrollpane ::int)
		      "setHorizontalScrollBarPolicy")
	      (method vpolicy::int
		      (::%swing-jscrollpane)
		      "getVerticalScrollBarPolicy")
	      (method vpolicy-set!::void
		      (::%swing-jscrollpane ::int)
		      "setVerticalScrollBarPolicy")
	      (method hscrollbar::%swing-jscrollbar
		      (::%swing-jscrollpane)
		      "getHorizontalScrollBar")
	      (method vscrollbar::%swing-jscrollbar
		      (::%swing-jscrollpane)
		      "getVerticalScrollBar")
	      (method hscrollbar-set!::void
		      (::%swing-jscrollpane ::%swing-jscrollbar)
		      "setHorizontalScrollBar")
	      (method vscrollbar-set!::void
		      (::%swing-jscrollpane ::%swing-jscrollbar)
		      "setVerticalScrollBar")
	      "javax.swing.JScrollPane")
	   
	   ;; javax.swing.ScrollPaneConstants
	   (class %swing-jscrollpaneconstants
	      (field static h-needed::int
		     "HORIZONTAL_SCROLLBAR_AS_NEEDED")
	      (field static h-never::int
		     "HORIZONTAL_SCROLLBAR_NEVER")
	      (field static h-always::int
		     "HORIZONTAL_SCROLLBAR_ALWAYS")
	      (field static v-needed::int
		     "VERTICAL_SCROLLBAR_AS_NEEDED")
	      (field static v-never::int
		     "VERTICAL_SCROLLBAR_NEVER")
	      (field static v-always::int
		     "VERTICAL_SCROLLBAR_ALWAYS")
	      "javax.swing.ScrollPaneConstants")
	   
	   ;; javax.swing.JTabbedPane
	   (class %swing-jtabbedpane::%swing-jcomponent
	      (constructor new ())
	      (method add-string!
		      (::%swing-jtabbedpane ::%jstring ::%awt-component)
		      "addTab")
	      (method add-text+icon!::void
		      (::%swing-jtabbedpane
		       ::%jstring
		       ::%swing-icon
		       ::%awt-component)
		      "addTab")
	      (method add-text!::void
		      (::%swing-jtabbedpane ::%jstring ::%awt-component)
		      "addTab")
	      (method length::int
		      (::%swing-jtabbedpane)
		      "getTabCount")
	      (method position::int
		      (::%swing-jtabbedpane)
		      "getTabPlacement")
	      (method position-set!::void
		      (::%swing-jtabbedpane ::int)
		      "setTabPlacement")
	      (method selected::%awt-component
		      (::%swing-jtabbedpane)
		      "getSelectedComponent")
	      (method selected-set!::void
		      (::%swing-jtabbedpane ::%awt-component)
		      "setSelectedComponent")
	      (method selected-index-set!::void
		      (::%swing-jtabbedpane ::int)
		      "setSelectedIndex")
	      (method remove::void
		      (::%swing-jtabbedpane ::%awt-component)
		      "remove")
	      "javax.swing.JTabbedPane")
	   
	   ;; javax.swing.event.ChangeListener
	   (class %swing-changelistener
	      "javax.swing.event.ChangeListener")
	   
	   ;; javax.swing.event.TreeExpansionListener
	   (class %swing-treeexpansionlistener
	      "javax.swing.event.TreeExpansionListener")
	   
	   ;; javax.swing.event.TreeWillExpandListener
	   (class %swing-treewillexpandlistener
	      "javax.swing.event.TreeWillExpandListener")
	   
	   ;; javax.swing.event.TreeSelectionListener
	   (class %swing-treeselectionlistener
	      "javax.swing.event.TreeSelectionListener")
	   
	   ;; javax.swing.event.ListSelectionListener
	   (class %swing-listselectionlistener
	      "javax.swing.event.ListSelectionListener")

	   ;; javax.swing.event.TableModelListener
	   (class %swing-tablemodellistener
	      "javax.swing.event.TableModelListener")
	   
	   ;; javax.swing.JSlider
	   (class %swing-jslider::%swing-jcomponent
	      (constructor new (::int))
	      (method add-changelistener!::void
		      (::%swing-jslider ::%swing-changelistener)
		      "addChangeListener")
	      (method value::int
		      (::%swing-jslider)
		      "getValue")
	      (method value-set!::void
		      (::%swing-jslider ::int)
		      "setValue")
	      (method minimum::int
		      (::%swing-jslider)
		      "getMinimum")
	      (method minimum-set!::void
		      (::%swing-jslider ::int)
		      "setMinimum")
	      (method maximum::int
		      (::%swing-jslider)
		      "getMaximum")
	      (method maximum-set!::void
		      (::%swing-jslider ::int)
		      "setMaximum")
	      (method paint-labels-set!::void
		      (::%swing-jslider ::bool)
		      "setPaintLabels")
	      (method paint-ticks-set!::void
		      (::%swing-jslider ::bool)
		      "setPaintTicks")
	      (method paint-track-set!::void
		      (::%swing-jslider ::bool)
		      "setPaintTrack")
	      (method snap-to-ticks-set!::void
		      (::%swing-jslider ::bool)
		      "setSnapToTicks")
	      (method inverted-set!::void
		      (::%swing-jslider ::bool)
		      "setInverted")
	      (method major-ticks::int
		      (::%swing-jslider)
		      "getMajorTickSpacing")
	      (method major-ticks-set!::void
		      (::%swing-jslider ::int)
		      "setMajorTickSpacing")
	      (method minor-ticks-set!::void
		      (::%swing-jslider ::int)
		      "setMinorTickSpacing")
	      "javax.swing.JSlider")
	   
	   ;; javax.swing.JApplet
	   (class %swing-japplet::%awt-panel
	      (method contentpane::%awt-container
		      (::%swing-japplet)
		      "getContentPane")
	      "javax.swing.JApplet")
	   
	   ;; javax.swing.JSplitPane
	   (class %swing-jsplitpane::%swing-jcomponent
	      (constructor new (::int))
	      (method setcontinuouslayout::void
		      (::%swing-jsplitpane ::bool)
		      "setContinuousLayout")
	      (method setonetouchexapandable::void
		      (::%swing-jsplitpane ::bool)
		      "setOneTouchExpandable")
	      (method settopcomponent::void
		      (::%swing-jsplitpane ::%awt-component)
		      "setTopComponent")
	      (method setbottomcomponent::void
		      (::%swing-jsplitpane ::%awt-component)
		      "setBottomComponent")
	      (method setleftcomponent::void
		      (::%swing-jsplitpane ::%awt-component)
		      "setLeftComponent")
	      (method setrightcomponent::void
		      (::%swing-jsplitpane ::%awt-component)
		      "setRightComponent")
	      (method setdividerlocation::void
		      (::%swing-jsplitpane ::double)
		      "setDividerLocation")
	      (method getdividerlocation::int
		      (::%swing-jsplitpane)
		      "getDividerLocation")
	      "javax.swing.JSplitPane")

	   (class %swing-jpopupmenu::%swing-jcomponent
	      (constructor new ())
	      (method show!::void (::%swing-jpopupmenu ::%awt-component ::int ::int)
		      "show")
	      "javax.swing.JPopupMenu")
	   
	   ;; javax.swing.JMenuBar
	   (class %swing-jmenubar::%swing-jcomponent
	      (constructor new ())
	      "javax.swing.JMenuBar")
	   
	   ;; javax.swing.JSeparator
	   (class %swing-jseparator::%swing-jcomponent
	      (constructor new ())
	      "javax.swing.JSeparator")
	   
	   ;; javax.swing.JMenuItem
	   (class %swing-jmenuitem::%swing-abstractbutton
	      (constructor new (::%jstring))
	      "javax.swing.JMenuItem")
	   
	   ;; javax.swing.JMenu
	   (class %swing-jmenu::%swing-jmenuitem
	      (constructor new (::%jstring))
	      (method delay-set!::void
		      (::%swing-jmenu ::int)
		      "setDelay")
	      "javax.swing.JMenu")
	   
	   ;; javax.swing.JCheckBoxMenuItem
	   (class %swing-jcheckboxmenuitem::%swing-jmenuitem
	      (constructor new (::%jstring))
	      "javax.swing.JCheckBoxMenuItem")
	   
	   ;; javax.swing.JRadioButtonMenuItem
	   (class %swing-jradiobuttonmenuitem::%swing-jmenuitem
	      (constructor new (::%jstring))
	      "javax.swing.JRadioButtonMenuItem")
	   
	   ;; javax.swing.JToolBar
	   (class %swing-jtoolbar::%swing-jcomponent
	      (constructor new
			   ())
	      (method add-separator::void
		      (::%swing-jtoolbar ::%awt-dimension)
		      "addSeparator")
	      (method set-floatable::void
		      (::%swing-jtoolbar ::bool)
		      "setFloatable")
	      (method set-borderpainted::void
		      (::%swing-jtoolbar ::bool)
		      "setBorderPainted")
	      (method set-orientation::void
		      (::%swing-jtoolbar ::int)
		      "setOrientation")
	      (method get-orientation::int
		      (::%swing-jtoolbar)
		      "getOrientation")
	      "javax.swing.JToolBar")
	   
	   ;; javax.swing.JFileChooser
	   (class %swing-jfilechooser::%swing-jcomponent
	      (constructor new ())
	      (method add-actionlistener!::void
		      (::%swing-jfilechooser ::%awt-actionlistener)
		      "addActionListener")
	      (method title-set!::void
		      (::%swing-jfilechooser ::%jstring)
		      "setDialogTitle")
	      (method path::%jfile
		      (::%swing-jfilechooser)
		      "getCurrentDirectory")
	      (method path-set!::void
		      (::%swing-jfilechooser ::%jfile)
		      "setCurrentDirectory")
	      (method file::%jfile
		      (::%swing-jfilechooser)
		      "getSelectedFile")
	      (method file-set!::void
		      (::%swing-jfilechooser ::%jfile)
		      "setSelectedFile")
	      (method file-show::int
		      (::%swing-jfilechooser ::%jstring)
		      "showDialog")
	      "javax.swing.JFileChooser")
	   
	   ;; javax.swing.JColorChooser
	   (class %swing-jcolorchooser::%swing-jcomponent
	      (constructor new ())
	      (method color::%awt-color
		      (::%swing-jcolorchooser)
		      "getColor")
	      (method color-set!::void
		      (::%swing-jcolorchooser ::%awt-color)
		      "setColor")
	      "javax.swing.JColorChooser")
	   
	   ;; javax.swing.JTree
	   (class %swing-jtree::%swing-jcomponent
	      (constructor new
			   (::%swing-treenode))
	      (constructor new/node
			   (::%swing-treenode ::bool))
	      (constructor new/model
			   (::%swing-treemodel))
	      (method add-willexpandlistener::void
		      (::%swing-jtree ::%swing-treewillexpandlistener)
		      "addTreeWillExpandListener")
	      (method add-selectionlistener!::void
		      (::%swing-jtree ::%swing-treeselectionlistener)
		      "addTreeSelectionListener")
	      (method remove-selectionlistener!::void
		      (::%swing-jtree ::%swing-treeselectionlistener)
		      "removeTreeSelectionListener")
	      (method set-cellrenderer::void
		      (::%swing-jtree ::%swing-treecellrenderer)
		      "setCellRenderer")
	      (method set-model::void
		      (::%swing-jtree ::%swing-treemodel)
		      "setModel")
	      (method set-rootvisible::void
		      (::%swing-jtree ::bool)
		      "setRootVisible")
	      (method set-showsroothandles::void
		      (::%swing-jtree ::bool)
		      "setShowsRootHandles")
	      (method model::%swing-treemodel
		      (::%swing-jtree)
		      "getModel")
	      (method expandrow::void
		      (::%swing-jtree ::int)
		      "expandRow")
	      (method expandpath::void
		      (::%swing-jtree ::%swing-treepath)
		      "expandPath")
	      (method collapsepath::void
		      (::%swing-jtree ::%swing-treepath)
		      "collapsePath")
	      (method fire-collapsed::void
		      (::%swing-jtree ::%swing-treepath)
		      "fireTreeCollapsed")
	      (method expanded?::bool
		      (::%swing-jtree ::%swing-treepath)
		      "isExpanded")
	      (method clearselection::void
		      (::%swing-jtree)
		      "clearSelection")
	      (method set-selection::void
		      (::%swing-jtree ::%swing-treepath)
		      "setSelectionPath")
	      (method scroll-path::void
		      (::%swing-jtree ::%swing-treepath)
		      "scrollPathToVisible")
	      "javax.swing.JTree")
	   
	   ;; javax.swing.tree.TreeCellRenderer
	   (class %swing-treecellrenderer::%jobject
	      (method component
		      (::%swing-treecellrenderer
		       ::%swing-jtree
		       ::%jobject
		       ::bool ::bool ::bool
		       ::int ::bool)
		      "getTreeCellRendererComponent")
	      "javax.swing.tree.TreeCellRenderer")
	   
	   ;; javax.swing.tree.TreeNode
	   (class %swing-treenode::%awt-container
	      "javax.swing.tree.TreeNode")
	   
	   ;; TreeNode[]
	   (array %swing-treenode* ::%swing-treenode)
	   
	   ;; javax.swing.tree.MutableTreeNode
	   (class %swing-mutabletreenode::%swing-treenode
	      "javax.swing.tree.MutableTreeNode")
	   
	   ;; javax.swing.tree.DefaultMutableTreeNode
	   (class %swing-defaultmutabletreenode::%swing-mutabletreenode
	      (constructor new
			   ())
	      (constructor new/label
			   (::%jobject))
	      (method add!::void
		      (::%swing-defaultmutabletreenode
		       ::%swing-mutabletreenode)
		      "add")
	      (method remove::void
		      (::%swing-defaultmutabletreenode
		       ::%swing-mutabletreenode)
		      "remove")
	      (method set-userobject::void
		      (::%swing-defaultmutabletreenode ::%jobject)
		      "setUserObject")
	      (method get-userobject::%jobject
		      (::%swing-defaultmutabletreenode)
		      "getUserObject")
	      (method childcount::int
		      (::%swing-defaultmutabletreenode)
		      "getChildCount")
	      "javax.swing.tree.DefaultMutableTreeNode")
	   
	   ;; javax.swing.tree.TreePath
	   (class %swing-treepath::%jobject
	      (constructor new (::%jobject*))
	      "javax.swing.tree.TreePath")
	   
	   ;; javax.swing.tree.TreeModel
	   (class %swing-treemodel::%jobject
	      (method set-root::void
		      (::%swing-treemodel ::%swing-treenode)
		      "setRoot")
	      (method root::%jobject
		      (::%swing-treemodel)
		      "getRoot")
	      (method child-at::%jobject
		      (::%swing-treemodel ::%jobject ::int)
		      "getChild")
	      "javax.swing.tree.TreeModel")
	   
	   ;; javax.swing.tree.DefaultTreeModel
	   (class %swing-defaulttreemodel::%swing-treemodel
	      (constructor new (::%swing-treenode ::bool))
	      (method insertnodeinto::void
		      (::%swing-defaulttreemodel
		       ::%swing-mutabletreenode
		       ::%swing-mutabletreenode
		       ::int)
		      "insertNodeInto")
	      "javax.swing.tree.DefaultTreeModel")
	   
	   ;; javax.swing.JTable
	   (class %swing-jtable::%swing-jcomponent
	      (constructor new (::%swing-tablemodel))
	      (field static AUTO_RESIZE_LAST_COLUMN::int
		     "AUTO_RESIZE_LAST_COLUMN")
	      (field static AUTO_RESIZE_OFF::int
		     "AUTO_RESIZE_OFF")
	      (method row-at-point::int
		      (::%swing-jtable ::%awt-point)
		      "rowAtPoint")
	      (method column-at-point::int
		      (::%swing-jtable ::%awt-point)
		      "columnAtPoint")
	      (method rowheight::int
		      (::%swing-jtable)
		      "getRowHeight")
	      (method set-rowheight::void
		      (::%swing-jtable ::int)
		      "setRowHeight")
	      (method getcolumnmodel::%swing-tablecolumnmodel
		      (::%swing-jtable)
		      "getColumnModel")
	      (method selection-model::%swing-listselectionmodel
		      (::%swing-jtable)
		      "getSelectionModel")
	      (method model::%swing-tablemodel
		      (::%swing-jtable)
		     "getModel")
	      (method auto-resize-mode-set!::void
		      (::%swing-jtable ::int)
		      "setAutoResizeMode")
	      (method selection-mode-set!::void
		      (::%swing-jtable ::int)
		      "setSelectionMode")
	      "javax.swing.JTable")
	   
	   ;; javax.swing.table.TableModel
	   (class %swing-tablemodel::%jobject
	      "javax.swing.table.TableModel")
	   
	   ;; javax.swing.table.AbstractTableModel
	   (class %swing-abstracttablemodel::%swing-tablemodel
	      (method value::obj
		      (::%swing-abstracttablemodel ::int ::int)
		      "getValueAt")
	      (method value-set!::void
		      (::%swing-abstracttablemodel ::int ::int ::obj)
		      "setValueAt")
	      (method getcolumnname::%jstring
		      (::%swing-abstracttablemodel ::int)
		      "getColumnName")
	      (method getrowcount::int
		      (::%swing-abstracttablemodel)
		      "getRowCount")
	      (method getcolumncount::int
		      (::%swing-abstracttablemodel)
		      "getColumnCount")
	      "javax.swing.table.AbstractTableModel")
	   
	   ;; javax.swing.table.TableColumn
	   (class %swing-tablecolumn::%jobject
	      (method setpreferredwidth::void
		      (::%swing-tablecolumn ::int)
		      "setPreferredWidth")
	      "javax.swing.table.TableColumn")
	   
	   ;; javax.swing.table.TableColumnModel
	   (class %swing-tablecolumnmodel::%jobject
	      (method getcolumn::%swing-tablecolumn
		      (::%swing-tablecolumnmodel ::int)
		      "getColumn")
	      "javax.swing.table.TableColumnModel")
	   
	   ;; javax.swing.table.DefaultTableColumnModel
	   (class %swing-defaulttablecolumnmodel::%swing-tablecolumnmodel
	      (method getcolumn::%swing-tablecolumn
		      (::%swing-defaulttablecolumnmodel ::int)
		      "getColumn")
	      "javax.swing.table.DefaultTableColumnModel")
	   
	   ;; javax.swing.table.TableCellRenderer
	   (class %swing-tablecellrenderer::%jobject
	      "javax.swing.table.DefaultTableCellRenderer")
	   
	   ;; javax.swing.table.DefaultTableCellRenderer
	   (class %swing-defaultTablecellrenderer::%swing-tablecellrenderer
	      "javax.swing.table.DefaultTableCellRenderer")

	   ;; javax.swing.table.JTableHeader
	   (class %swing-tableheader::%swing-jcomponent
	      "javax.swing.table.JTableHeader")))

	   


