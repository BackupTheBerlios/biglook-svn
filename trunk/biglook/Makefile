#*=====================================================================*/
#*    biglook/Makefile                                                 */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Sat Mar 24 10:09:42 2001                          */
#*    Last change :  Wed Nov  5 22:58:32 2003 (braun)                  */
#*    Copyright   :  2001-03 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    The (gmake) Makefile to build the Biglook library.               */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    The default configuration                                        */
#*---------------------------------------------------------------------*/
include ../Makefile.kconfig

#*---------------------------------------------------------------------*/
#*    Local configuration                                              */
#*---------------------------------------------------------------------*/
BGLK_HEAP_FILE	= $(BOOTKDIR)/biglook/Misc/make-lib.scm
BGLK_PBASE	= bigloo.biglook
BGLK_JVM_DIR	= objs/class_s/bigloo/biglook
BGLK_BFLAGS	= 

#*---------------------------------------------------------------------*/
#*    Sources                                                          */
#*---------------------------------------------------------------------*/
LLIB		= configure app event color font after port cursor
LWIDGET		= bglkobject widget \
                  image \
                  container box grid area layout window frame scroll \
                  notepad paned \
                  button checkbutton radio \
                  label entry listbox combobox \
                  canvas canvitem \
                  gauge scale \
                  menu toolbar \
                  fileselector colorselector \
                  tree table text
MISC		= biglook.init options.sch

#*---------------------------------------------------------------------*/
#*    Objects                                                          */
#*---------------------------------------------------------------------*/
BGLK_OBJECTS	= $(LLIB:%=objs/Llib/%.o) \
                  $(LWIDGET:%=objs/Lwidget/%.o)

BGLK_CLASSES	= $(LLIB:%=$(BGLK_JVM_DIR)/Llib/%.class) \
                  $(LWIDGET:%=$(BGLK_JVM_DIR)/Lwidget/%.class)

#*---------------------------------------------------------------------*/
#*    Sources                                                          */
#*---------------------------------------------------------------------*/
BGLK_SOURCES	= $(LLIB:%=Llib/%.scm) \
                  $(LWIDGET:%=Lwidget/%.scm)

#*---------------------------------------------------------------------*/
#*    Population                                                       */
#*---------------------------------------------------------------------*/
BGLK_POPULATION	= Makefile \
                  $(BGLK_SOURCES) \
		  $(MISC:%=Misc/%)

#*---------------------------------------------------------------------*/
#*    all                                                              */
#*---------------------------------------------------------------------*/
all: init heap jheap lib

#*---------------------------------------------------------------------*/
#*    init                                                             */
#*---------------------------------------------------------------------*/
init: $(BOOTKDIR)/lib/biglook.init

$(BOOTKDIR)/lib/biglook.init: Misc/biglook.init
	@ cat $< | sed -e s,"<KRELEASE>",$(KRELEASE), > $@
	@ echo "biglook.init done... ($@)"
	@ echo "-------------------------------"

#*---------------------------------------------------------------------*/
#*    heap                                                             */
#*---------------------------------------------------------------------*/
heap: .afile $(BOOTKDIR)/lib/biglook.heap

$(BOOTKDIR)/lib/biglook.heap: $(BGLK_HEAP_FILE) $(BGLK_SOURCES)
	@ $(BIGLOO) $(BHEAPFLAGS) \
                    $(BGLK_HEAP_FILE) \
                    -addheap $(BOOTKDIR)/lib/biglook.heap
	@ echo "Heap Done... ($(BOOTKDIR)/lib/biglook.heap)"
	@ echo "-------------------------------"

#*---------------------------------------------------------------------*/
#*    jheap                                                            */
#*---------------------------------------------------------------------*/
jheap: .afile .jfile $(BOOTKDIR)/lib/biglook.jheap

$(BOOTKDIR)/lib/biglook.jheap: $(BGLK_HEAP_FILE) $(BGLK_SOURCES)
	@ $(BIGLOO) $(BHEAPFLAGS) \
                    $(BGLK_HEAP_FILE) \
                    -jvm -addheap $(BOOTKDIR)/lib/biglook.jheap
	@ echo "JHeap Done... ($(BOOTKDIR)/lib/biglook.jheap)"
	@ echo "-------------------------------"

#*---------------------------------------------------------------------*/
#*    lib                                                              */
#*---------------------------------------------------------------------*/
lib: dirs \
     $(BOOTKDIR)/lib/libbiglook_s-$(KRELEASE).$(SHAREDSUFFIX) \
     $(BOOTKDIR)/lib/libbiglook_s-$(KRELEASE).a

$(BOOTKDIR)/lib/libbiglook_s-$(KRELEASE).$(SHAREDSUFFIX): $(BGLK_OBJECTS)
	@ /bin/rm -f $@
	@ $(LD) -o $@ $(BGLK_OBJECTS) -lm -lc
	@ echo "biglook_s-$(KRELEASE).$(SHAREDSUFFIX) done...($@)"
	@ echo "-------------------------------"

$(BOOTKDIR)/lib/libbiglook_s-$(KRELEASE).a: $(BGLK_OBJECTS)
	@ /bin/rm -f $@
	@ $(AR) $(ARFLAGS) $@ $(BGLK_OBJECTS)
	@ $(RANLIB) $@
	@ echo "biglook_s-$(KRELEASE).a done...($@)"
	@ echo "-------------------------------"

#*---------------------------------------------------------------------*/
#*    zip                                                              */
#*---------------------------------------------------------------------*/
jvm: zip
zip: dirs $(BOOTKDIR)/lib/biglook_s.zip

$(BOOTKDIR)/lib/biglook_s.zip: .jfile $(BGLK_CLASSES) 
	@ /bin/rm -f $@
	@ (cd objs/class_s; \
          $(ZIP) -q $(ZFLAGS) $@ $(BGLK_JVM_DIR:objs/class_s/%=%)/*/*.class)
	@ echo "biglook_s.zip done...($@)"
	@ echo "-------------------------------"

#*---------------------------------------------------------------------*/
#*    bee                                                              */
#*---------------------------------------------------------------------*/
bee: afile jfile btags

#*---------------------------------------------------------------------*/
#*    .afile                                                           */
#*---------------------------------------------------------------------*/
.afile: $(BGLK_SOURCES)
	$(MAKE) afile

afile:
	$(AFILE) $(BGLK_SOURCES) -o .afile
 
#*---------------------------------------------------------------------*/
#*    .jfile                                                           */
#*---------------------------------------------------------------------*/
.jfile: $(BGLK_SOURCES)
	$(MAKE) jfile

jfile:
	$(JFILE) -pbase $(BGLK_PBASE) $(BGLK_SOURCES) -o .jfile

#*---------------------------------------------------------------------*/
#*    .btags                                                           */
#*---------------------------------------------------------------------*/
.btags: $(BGLK_SOURCES)
	$(MAKE) btags

btags:
	$(BTAGS) $(BGLK_SOURCES) -o .btags

#*---------------------------------------------------------------------*/
#*    population                                                       */
#*---------------------------------------------------------------------*/
pop:
	@ echo "Makefile"
	@ echo $(BGLK_HEAP_FILE)
	@ echo $(BGLK_POPULATION)

#*---------------------------------------------------------------------*/
#*    directories                                                      */
#*---------------------------------------------------------------------*/
dirs: objs/Llib objs/Lwidget \
      objs/class_s/bigloo/biglook/Llib objs/class_s/bigloo/biglook/Lwidget

objs/Llib:
	mkdir -p $@

objs/Lwidget:
	mkdir -p $@

objs/class_s/bigloo/biglook/Llib:
	mkdir -p $@

objs/class_s/bigloo/biglook/Lwidget:
	mkdir -p $@

#*---------------------------------------------------------------------*/
#*    clean:                                                           */
#*---------------------------------------------------------------------*/
clean:
	/bin/rm -rf objs
	/bin/rm -rf .afile .jfile .btags

cleanall: clean
	/bin/rm -f $(BOOTKDIR)/lib/biglook_s.zip
	/bin/rm -f $(BOOTKDIR)/lib/libbiglook_s-$(KRELEASE).a
	/bin/rm -f $(BOOTKDIR)/lib/libbiglook_s-$(KRELEASE).$(SHAREDSUFFIX)
	/bin/rm -f $(BOOTKDIR)/lib/biglook.heap
	/bin/rm -f $(BOOTKDIR)/lib/biglook.jheap
	/bin/rm -f $(BOOTKDIR)/lib/biglook.init

distclean: cleanall

#*---------------------------------------------------------------------*/
#*    Automatic rules                                                  */
#*---------------------------------------------------------------------*/
# .scm -> .class
objs/class_s/bigloo/biglook/%.class: %.scm
	$(BIGLOO) -jvm $(BFLAGS) $(BGLK_BFLAGS) -c $< -o $@
# .scm -> .o
objs/%.o: %.scm
	$(BIGLOO) $(BFLAGS) $(BGLK_BFLAGS) -c $< -o $@
