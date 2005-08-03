#*=====================================================================*/
#*    swt/Makefile                                                     */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Sat Mar 24 10:09:42 2001                          */
#*    Last change :  Tue Aug  2 15:10:00 2005 (dciabrin)               */
#*    Copyright   :  2001-05 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    The (gmake) Makefile Swing Biglook peer specific Makefile.       */
#*    -------------------------------------------------------------    */
#*    This Makefile must only "export" five variables:                 */
#*      PEER_NAME                                                      */
#*      PEER_OBJECTS                                                   */
#*      PEER_SOURCES                                                   */
#*      PEER_POPULATION                                                */
#*      PEER_OBJ_DIRS                                                  */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Target name                                                      */
#*---------------------------------------------------------------------*/
PEER_NAME	= swt
CLASS_DIR	= objs/class_s/bigloo/biglook/peer
PEER_CLASS_DIRS	= Lwidget Llib Lswt Jlib
PEER_OBJ_DIRS	= $(PEER_CLASS_DIRS:%=$(CLASS_DIR)/%)

#*---------------------------------------------------------------------*/
#*    Sources                                                          */
#*---------------------------------------------------------------------*/
LLIB		= _configure _app _error _event _callback \
                  _color _font _xpm _after _port
LWIDGET		= _peer _bglkobject _widget \
                  _image \
                  _container _window _frame _scroll _grid _area _box \
                  _button _checkbutton _radio \
                  _label _entry _listbox _combobox \
                  _canvas _canvitem \
                  _gauge _scale \
                  _notepad _paned \
                  _menu _toolbar \
                  _fileselector _colorselector \
                  _tree _table
LSWT		= _awt _swt _swing swingmisc
JLIB		= Bglk BglkSWT BJBorder \
                  BJComponentAdapter BJShellAdapter \
                  BJMouseAdapter BJMouseMotionAdapter BJKeyAdapter \
                  BJCanvas \
                  BJCanvasMouseAdapter BJCanvasMouseMotionAdapter \
                  BJCanvasKeyAdapter BJTimerAdapter BJFocusAdapter \
                  BJChangeAdapter BJActionAdapter \
                  BJTreeCellRenderer BJTreeNode \
                  BJTreeWillExpandAdapter BJTreeSelectionAdapter \
                  BJTableModel BJListSelectionAdapter BJPort

#*---------------------------------------------------------------------*/
#*    Classes                                                          */
#*---------------------------------------------------------------------*/
PEER_CLASSES	= $(LLIB:%=$(PEER_CDIR)/Llib/%.class) \
                  $(LSWT:%=$(PEER_CDIR)/Lswt/%.class) \
                  $(LWIDGET:%=$(PEER_CDIR)/Lwidget/%.class)

#*---------------------------------------------------------------------*/
#*    Sources                                                          */
#*---------------------------------------------------------------------*/
PEER_SOURCES	= $(LLIB:%=Llib/%.scm) \
                  $(LWIDGET:%=Lwidget/%.scm) \
                  $(LSWT:%=Lswt/%.scm) \
                  $(JLIB:%=Jlib/%.java)

#*---------------------------------------------------------------------*/
#*    Population                                                       */
#*---------------------------------------------------------------------*/
PEER_POPULATION	= Makefile Init/biglook_peer.init $(PEER_SOURCES)

#*---------------------------------------------------------------------*/
#*    all                                                              */
#*---------------------------------------------------------------------*/
all: bee init jlib jvm
al: bee init jvm

#*---------------------------------------------------------------------*/
#*    Local rules to make local directories                            */
#*---------------------------------------------------------------------*/
$(CLASS_DIR)/Lwidget:
	mkdir -p $@

$(CLASS_DIR)/Llib:
	mkdir -p $@

$(CLASS_DIR)/Lswt:
	mkdir -p $@

$(CLASS_DIR)/Jlib:
	mkdir -p $@

#*---------------------------------------------------------------------*/
#*    The Biglook configuration and common Peer Makefile               */
#*---------------------------------------------------------------------*/
include ../Makefile.peer

#*---------------------------------------------------------------------*/
#*    Install the link for the Java sources                            */
#*---------------------------------------------------------------------*/
jlib: dirs $(JLIB:%=$(PEER_CDIR)/Jlib/%.java)
	(cd objs/class_s/bigloo; \
         CLASSPATH=.:$(FILDIR)/bigloo_s.zip:$$CLASSPATH; \
         export CLASSPATH; \
         $(JAVAC) $(JCFLAGS) biglook/peer/Jlib/*.java)

$(PEER_CDIR)/Jlib/%.java: Jlib/$(@F)
	/bin/rm -f $(BOOTKDIR)/lib/$(PEER_NAME)/biglook_peer_s.zip
	(p=`pwd`; \
         cd $(PEER_CDIR)/Jlib; \
         /bin/rm -f $(@F); \
         ln -s $$p/Jlib/$(@F) $(@F))

