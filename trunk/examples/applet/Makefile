#*=====================================================================*/
#*    serrano/prgm/project/biglook/examples/applet/Makefile            */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Tue Jan 30 15:19:19 1996                          */
#*    Last change :  Mon Sep  3 08:10:51 2001 (serrano)                */
#*    Copyright   :  1996-2001 Manuel Serrano, see LICENSE file        */
#*    -------------------------------------------------------------    */
#*    The makefile to build socket                                     */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Standard path                                                    */
#*---------------------------------------------------------------------*/
include ../../Makefile.kconfig 

#*---------------------------------------------------------------------*/
#*    flags                                                            */
#*---------------------------------------------------------------------*/
BIGLOO          = $(BOOTBINDIR)/bigloo
BGLOPTFLAGS	= -O +rm -shapem
BFLAGS          = -g $(BGLOPTFLAGS) -L $(BOOTKDIR)/lib -eval \
                  "(set! *eval-options* (cons (list 'biglook-peer \"$(PEER)\") *eval-options*))"

#*---------------------------------------------------------------------*/
#*    Objects and sources                                              */
#*---------------------------------------------------------------------*/

#*--- scm -------------------------------------------------------------*/
SCM_FILE	= applet

SCM_OBJ		= $(SCM_FILE:%=%.class)
SCM_SRC		= $(SCM_OBJ:%.class=%.scm)

#*--- scm -------------------------------------------------------------*/
JVM_FILE	= BiglookApplet

JVM_OBJ		= $(JVM_FILE:%=%.class)
JVM_SRC		= $(JVM_OBJ:%.class=%.java)

#*---------------------------------------------------------------------*/
#*    All objects and sources                                          */
#*---------------------------------------------------------------------*/
OBJ		= $(SCM_OBJ) $(JVM_OBJ) 
SRC		= $(JVM_SRC) $(SCM_SRC)

POPULATION	= $(SRC:%=example/swing-applet/%) \
                  example/swing-applet/Makefile \
                  example/swing-applet/README \
                  example/swing-applet/BiglookApplet.html

#*---------------------------------------------------------------------*/
#*    the goals.                                                       */
#*---------------------------------------------------------------------*/
swing: applet.jar

gtk:

applet.jar: $(OBJ)
	$(BIGLOO) -jvm $(OBJ) $(BFLAGS) -jvm-jar -o applet

pop:
	@ echo $(POPULATION)

#*---------------------------------------------------------------------*/
#*    Cleaning                                                         */
#*---------------------------------------------------------------------*/
.PHONY: clean

clean:
	@ find . \( -name '*[~%]' \
                 -o -name '.??*[~%]' \
                 -o -name '#*#' \
                 -o -name '?*#' \
                 -o -name \*core \) \
                 -type f -exec rm {} \;   
	@- \rm -f $(OBJ) applet
	@- \rm -f java-test *.jas *.jast *.jar *.class
	@- \rm -f Manifest*

#*---------------------------------------------------------------------*/
#*    Suffixes                                                         */
#*---------------------------------------------------------------------*/
.SUFFIXES:
.SUFFIXES: .scm .java .class

#*---------------------------------------------------------------------*/
#*    .java.class                                                      */
#*---------------------------------------------------------------------*/
.java.class:
	@ echo $*.java:
	@ (export CLASSPATH=.:$(BOOTLIBDIR)/bigloo.zip:$(BOOTKDIR)/lib/biglook.zip:$(BOOTKDIR)/lib/swing/biglook_peer.zip:$$CLASSPATH; \
           $(JAVAC) $(JCFLAGS) $*.java)

#*---------------------------------------------------------------------*/
#*    .scm.class                                                       */
#*---------------------------------------------------------------------*/
.scm.class:
	$(BIGLOO) -jvm-purify -jvm -c $(BFLAGS) $*.scm -o $*.class

