#*=====================================================================*/
#*    serrano/prgm/project/biglook/games/Makefile                      */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  5 10:28:17 2000                          */
#*    Last change :  Mon Jun 11 06:46:08 2001 (serrano)                */
#*    Copyright   :  2000-01 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    The general Makefile for testing Biglook                         */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    demo                                                             */
#*---------------------------------------------------------------------*/
DEMO	= mine tetris

#*---------------------------------------------------------------------*/
#*    Goals                                                            */
#*---------------------------------------------------------------------*/
.PHONY: clean cleanall distclean null gtk swing

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
