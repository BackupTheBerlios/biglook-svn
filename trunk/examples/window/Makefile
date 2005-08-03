all: gtk gtk2 swing

null:
	$(MAKE) -f ../Makefile.demo DEMO=`basename $$PWD` PEER=null

gtk:
	$(MAKE) -f ../Makefile.demo DEMO=`basename $$PWD` PEER=gtk

gtk2:
	$(MAKE) -f ../Makefile.demo DEMO=`basename $$PWD` PEER=gtk2

swing swt:
	(dem=`basename $$PWD`; \
	$(MAKE) -f ../Makefile.demo DEMO=$$dem PEER=$@ O=class BJFLAGS="-jvm")

clean:
	$(MAKE) -f ../Makefile.demo clean DEMO=`basename $$PWD` PEER=$(PEER)

