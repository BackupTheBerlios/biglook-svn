all: gtk swing

null:
	$(MAKE) -f ../Makefile.demo DEMO=`basename $$PWD` PEER=null

gtk:
	$(MAKE) -f ../Makefile.demo DEMO=`basename $$PWD` PEER=gtk

swing:
	(dem=`basename $$PWD`; \
	$(MAKE) -f ../Makefile.demo DEMO=$$dem PEER=swing O=class BJFLAGS="-jvm")

clean:
	$(MAKE) -f ../Makefile.demo clean DEMO=`basename $$PWD` PEER=$(PEER)

