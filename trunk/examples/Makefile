#*=====================================================================*/
#*    serrano/prgm/project/biglook/examples/Makefile                   */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  5 10:28:17 2000                          */
#*    Last change :  Sun Jul 15 17:54:31 2001 (serrano)                */
#*    Copyright   :  2000-01 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    The general Makefile for testing Biglook                         */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    demo                                                             */
#*---------------------------------------------------------------------*/
DEMO	= simple label \
          button image checkbutton radio \
          frame grid area window \
          event event2 canvas \
          gauge scale entry listbox combobox \
          notepad paned \
          applet misc scroll \
          menubar toolbar \
          fileselect colorselect \
          anim1 anim2 \
          rc tree table

#*---------------------------------------------------------------------*/
#*    Goals                                                            */
#*---------------------------------------------------------------------*/
.PHONY: clean cleanall distclean null gtk swing

all: gtk swing

clean:
	for p in $(DEMO); do \
	  (cd $$p; echo `pwd`; $(MAKE) -s clean); \
        done

cleanall: clean

distclean: clean

null:
	for p in $(DEMO); do \
	  (cd $$p; echo `pwd`; $(MAKE) null) || exit 1; \
        done

gtk:
	for p in $(DEMO); do \
	  (cd $$p; echo `pwd`; $(MAKE) gtk) || exit 1; \
        done

swing:
	for p in $(DEMO); do \
	  (cd $$p; echo `pwd`; $(MAKE) swing) || exit 1; \
        done
