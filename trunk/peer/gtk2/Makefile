#*=====================================================================*/
#*    serrano/prgm/project/biglook/peer/gtk2/Makefile                   */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Sat Mar 24 10:09:42 2001                          */
#*    Last change :  Thu Aug 16 09:58:36 2001 (serrano)                */
#*    Copyright   :  2001 Manuel Serrano                               */
#*    -------------------------------------------------------------    */
#*    The (gmake) Makefile GTk2 Biglook peer specific Makefile.        */
#*    -------------------------------------------------------------    */
#*    This Makefile "export" these variables:                          */
#*      PEER_NAME                                                      */
#*      PEER_OBJECTS                                                   */
#*      PEER_BFLAGS                                                    */
#*      PEER_CFLAGS                                                    */
#*      PEER_OBJ_DIRS                                                  */
#*      PEER_SOURCES                                                   */
#*      PEER_POPULATION                                                */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Gtk/Glib/Gnome configuration                                     */
#*---------------------------------------------------------------------*/
include Makefile.gtk2config

#*---------------------------------------------------------------------*/
#*    Target name                                                      */
#*---------------------------------------------------------------------*/
PEER_NAME	= gtk2
PEER_CFLAGS	= $(GTK_CFLAGS) \
                  $(GLIB_CFLAGS) \
                  $(GNOME_CFLAGS) \
                  -I$(BOOTKDIR)/lib/gtk2
PEER_BFLAGS	= -copt '$(PEER_CFLAGS)'
PEER_OBJ_DIRS	= objs/Clib objs/Lgtk2
PEER_CLEAN	= Include/event.h

#*---------------------------------------------------------------------*/
#*    Sources                                                          */
#*---------------------------------------------------------------------*/
LLIB		= _configure _app _error _event _callback \
                  _color _font _after _port _cursor
LWIDGET		= _peer _bglkobject _widget \
                  _image \
                  _container _window _frame _scroll \
                  _grid _area _box \
                  _button _checkbutton _radio \
                  _label _entry _listbox _combobox \
                  _canvas _canvitem \
                  _gauge _scale \
                  _notepad _paned \
                  _menu _toolbar \
                  _fileselector _colorselector \
                  _tree _table _text
LGTK		= gtk-misc
CLIB		= start gtkarg gtkimage gtkcall gtkevent \
                  gnomecanvas gtkafter gtklist gtktable gtkport \
		  gtktoolbar gtkwindow gtkmenu gtktext

#*---------------------------------------------------------------------*/
#*    Objects                                                          */
#*---------------------------------------------------------------------*/
PEER_OBJECTS	= $(LLIB:%=objs/Llib/%.o) \
                  $(LWIDGET:%=objs/Lwidget/%.o) \
                  $(LGTK:%=objs/Lgtk2/%.o) \
                  $(CLIB:%=objs/Clib/%.o)

#*---------------------------------------------------------------------*/
#*    Sources                                                          */
#*---------------------------------------------------------------------*/
PEER_SOURCES	= $(LLIB:%=Llib/%.scm) \
                  $(LWIDGET:%=Lwidget/%.scm) \
                  $(LGTK:%=Lgtk2/%.scm) \
                  $(CLIB:%=Clib/%.c)
                  
#*---------------------------------------------------------------------*/
#*    Population                                                       */
#*---------------------------------------------------------------------*/
PEER_POPULATION	= Makefile Init/biglook_peer.scm $(PEER_SOURCES)

#*---------------------------------------------------------------------*/
#*    all                                                              */
#*---------------------------------------------------------------------*/
all: bee init include lib

#*---------------------------------------------------------------------*/
#*    Local rules to make local directories                            */
#*---------------------------------------------------------------------*/
objs/Clib:
	mkdir -p $@

objs/Lgtk2:
	mkdir -p $@

#*---------------------------------------------------------------------*/
#*    The Biglook configuration and common Peer Makefile               */
#*---------------------------------------------------------------------*/
include ../Makefile.peer

#*---------------------------------------------------------------------*/
#*    include                                                          */
#*---------------------------------------------------------------------*/
include: $(BOOTKDIR)/lib/$(PEER_NAME)/biglook_peer.h

$(BOOTKDIR)/lib/$(PEER_NAME)/biglook_peer.h: Include/biglook_peer.h
	@ cp $< $@
	@ echo "Include done... ($@)"
	@ echo "-------------------------------"

#*---------------------------------------------------------------------*/
#*    Init/biglook_peer.init                                           */
#*---------------------------------------------------------------------*/
Init/biglook_peer.init: Init/biglook_peer.scm
	./configure --biglook_peer.init=$@ --libdir=$(BGLLIBDIR)

#*---------------------------------------------------------------------*/
#*    objs/Clib/gtkevent.o                                             */
#*---------------------------------------------------------------------*/
objs/Clib/gtkevent.o: Include/_event.h 

#*---------------------------------------------------------------------*/
#*    Include/_event.h                                                 */
#*---------------------------------------------------------------------*/
Include/_event.h: Llib/_event.scm
	$(BIGLOO) -hgen $< -o $@
