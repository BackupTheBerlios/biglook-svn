#*=====================================================================*/
#*    tetris/Makefile                                                  */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Jan  7 10:36:01 1999                          */
#*    Last change :  Mon Jun 14 15:56:04 2004 (dciabrin)               */
#*    -------------------------------------------------------------    */
#*    The Makefile to build the tetris example.                        */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Standard path                                                    */
#*---------------------------------------------------------------------*/
include ../../Makefile.kconfig 

#*---------------------------------------------------------------------*/
#*    Goals                                                            */
#*---------------------------------------------------------------------*/
all: gtk swing

null:
	$(MAKE) PEER=null tetris.null

gtk:
	$(MAKE) PEER=gtk tetris.gtk

swing:
	(dem=`basename $$PWD`; \
	$(MAKE) PEER=swing O=class BJFLAGS="-jvm" tetris.swing)

#*---------------------------------------------------------------------*/
#*    flags                                                            */
#*---------------------------------------------------------------------*/
PEER		= null
EXAMPLE		= tetris
BGLOPTFLAGS	= -O3 +rm
VERBOSE		= 
ABFLAGS		= $(BGLOPTFLAGS) -L $(BOOTKDIR)/lib -eval \
                  "(set! *eval-options* (cons (list 'biglook-peer \"$(PEER)\") *eval-options*))" -copt "-I/usr/include/gdk-pixbuf-1.0"
LDFLAGS		= -library biglook -w
O		= o

#*---------------------------------------------------------------------*/
#*    Objects and sources                                              */
#*---------------------------------------------------------------------*/
SCM_FILE	= $(EXAMPLE)

SCM_OBJ		= $(SCM_FILE:%=%.$(O))
SCM_SRC		= $(SCM_FILE:%=%.scm)

#*---------------------------------------------------------------------*/
#*    All objects and sources                                          */
#*---------------------------------------------------------------------*/
OBJ		= $(C_OBJ) $(SCM_OBJ)
SRC		= $(C_SRC) $(SCM_SRC)

POPULATION	= $(SRC:%=examples/$(EXAMPLE)/%)

#*---------------------------------------------------------------------*/
#*    the goals.                                                       */
#*---------------------------------------------------------------------*/
tetris.$(PEER): $(OBJ) 
	$(BIGLOO) $(BJFLAGS) $(VERBOSE) $(LDFLAGS) $(BFLAGS) $(OBJ) -o tetris.$(PEER)

pop:
	@ echo $(POPULATION)

clean:
	@- \rm -f *~ '#*#' core
	@- \rm -f *.escm *.ast a.out
	@- \rm -f $(SCM_FILE:%=%.o)
	@- \rm -f $(SCM_FILE:%=%.class)
	@- \rm -f *.class
	@- \rm -f tetris.null tetris.gtk tetris.swing tetris.jar Manifest

#*---------------------------------------------------------------------*/
#*    Suffixes                                                         */
#*---------------------------------------------------------------------*/
.SUFFIXES:
.SUFFIXES: .scm .o .class

#*---------------------------------------------------------------------*/
#*    .scm.o                                                           */
#*---------------------------------------------------------------------*/
.scm.o: $*.scm
	$(BIGLOO) $(VERBOSE) -c $(BFLAGS) $*.scm -o $*.o

.scm.class: $*.scm
	$(BIGLOO) $(BJFLAGS) $(VERBOSE) -c $(BFLAGS) $*.scm -o $*.class

