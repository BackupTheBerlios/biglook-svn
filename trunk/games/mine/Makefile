#*=====================================================================*/
#*    serrano/prgm/project/biglook/games/mine/Makefile                 */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Jan  7 10:36:01 1999                          */
#*    Last change :  Fri Nov  9 12:23:03 2001 (serrano)                */
#*    -------------------------------------------------------------    */
#*    The Makefile to build the mine example.                          */
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
	$(MAKE) PEER=null mine.null

gtk:
	$(MAKE) PEER=gtk mine.gtk

swing:
	(dem=`basename $$PWD`; \
	$(MAKE) PEER=swing O=class BJFLAGS="-jvm" mine.swing)

#*---------------------------------------------------------------------*/
#*    flags                                                            */
#*---------------------------------------------------------------------*/
PEER		= null
EXAMPLE		= mine
BGLOPTFLAGS	= -O3
VERBOSE		= 
BFLAGS		= $(BGLOPTFLAGS) -L $(BOOTKDIR)/lib -eval \
                  "(set! *eval-options* (cons (list 'biglook-peer \"$(PEER)\") *eval-options*))"
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
mine.$(PEER): $(OBJ) 
	$(BIGLOO) $(BJFLAGS) $(VERBOSE) $(LDFLAGS) $(BFLAGS) $(OBJ) -o mine.$(PEER)

pop:
	@ echo $(POPULATION)

clean:
	@- \rm -f *~ '#*#' core
	@- \rm -f *.escm *.ast a.out
	@- \rm -f $(SCM_FILE:%=%.o)
	@- \rm -f $(SCM_FILE:%=%.class)
	@- \rm -f *.class
	@- \rm -f mine.null mine.gtk mine.swing mine.jar Manifest

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

