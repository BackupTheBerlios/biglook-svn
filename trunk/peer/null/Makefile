#*=====================================================================*/
#*    null/Makefile                                                    */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Sat Mar 24 10:09:42 2001                          */
#*    Last change :  Wed Nov  5 23:08:45 2003 (braun)                  */
#*    Copyright   :  2001-03 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    The (gmake) Makefile Null Biglook peer specific Makefile.        */
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
PEER_NAME	= null
CLASS_DIR	= objs/class_s/bigloo/biglook/peer
PEER_CLASS_DIRS	= Lwidget Llib
PEER_OBJ_DIRS	= $(PEER_CLASS_DIRS:%=$(CLASS_DIR)/%)

#*---------------------------------------------------------------------*/
#*    Sources                                                          */
#*---------------------------------------------------------------------*/
LLIB		= _configure _app _error _event _callback \
                  _color _font _after _port _cursor
LWIDGET		= _peer _bglkobject _widget \
                  _image \
                  _container _grid _area _box _window _frame _scroll \
                  _notepad _paned \
                  _button _checkbutton _radio \
                  _label _entry _listbox _combobox \
                  _canvas _canvitem \
                  _gauge _scale \
                  _menu _toolbar \
                  _fileselector _colorselector \
                  _tree _table _text

#*---------------------------------------------------------------------*/
#*    Objects                                                          */
#*---------------------------------------------------------------------*/
PEER_OBJECTS	= $(LLIB:%=objs/Llib/%.o) \
                  $(LWIDGET:%=objs/Lwidget/%.o)

#*---------------------------------------------------------------------*/
#*    Classes                                                          */
#*---------------------------------------------------------------------*/
PEER_CLASSES	= $(LLIB:%=$(PEER_CDIR)/Llib/%.class) \
                  $(LWIDGET:%=$(PEER_CDIR)/Lwidget/%.class)

#*---------------------------------------------------------------------*/
#*    Sources                                                          */
#*---------------------------------------------------------------------*/
PEER_SOURCES	= $(LLIB:%=Llib/%.scm) \
                  $(LWIDGET:%=Lwidget/%.scm)

#*---------------------------------------------------------------------*/
#*    Population                                                       */
#*---------------------------------------------------------------------*/
PEER_POPULATION	= Makefile Init/biglook_peer.init $(PEER_SOURCES)

#*---------------------------------------------------------------------*/
#*    all                                                              */
#*---------------------------------------------------------------------*/
all: c-all jvm-all

c-all: init heap
jvm-all: init jheap

#*---------------------------------------------------------------------*/
#*    Local rules to make local directories                            */
#*---------------------------------------------------------------------*/
$(CLASS_DIR)/Lwidget:
	mkdir -p $@

$(CLASS_DIR)/Llib:
	mkdir -p $@

#*---------------------------------------------------------------------*/
#*    The Biglook configuration and common Peer Makefile               */
#*---------------------------------------------------------------------*/
include ../Makefile.peer
