#*=====================================================================*/
#*    serrano/prgm/project/bglk/autoconf/Makefile                      */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Jun 19 20:48:50 1997                          */
#*    Last change :  Thu Aug 31 06:59:02 2000 (serrano)                */
#*    Copyright   :  1997-2000 Manuel Serrano, see LICENSE file        */
#*    -------------------------------------------------------------    */
#*    The global autoconf Makefile (mainly for backuping).             */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Flags                                                            */
#*---------------------------------------------------------------------*/
POPULATION	= Makefile bversion getbversion blibdir gmaketest \
                  blstlen

#*---------------------------------------------------------------------*/
#*    pop ...                                                          */
#*---------------------------------------------------------------------*/
pop: 
	@ echo $(POPULATION:%=autoconf/%)

#*---------------------------------------------------------------------*/
#*    clean                                                            */
#*---------------------------------------------------------------------*/
.PHONY: clean cleanall distclean

clean:
	@ find . \( -name '*[~%]' \
                       -o -name '.??*[~%]' \
                       -o -name '#*#' \
                       -o -name '?*#' \
                       -o -name \*core \) \
                     -type f -exec rm {} \;   
	@ echo "cleanup done..."
	@ echo "-------------------------------"

cleanall: clean
distclean: cleanall

#*---------------------------------------------------------------------*/
#*    distrib                                                          */
#*---------------------------------------------------------------------*/
distrib: $(POPULATION)
	@ if [ `pwd` = $$HOME/prgm/project/bglk/autoconf ]; then \
             echo "*** ERROR:Illegal dir to make a distrib `pwd`"; \
             exit 1; \
          fi
	@ $(MAKE) clean
	@ chmod a+rx $(POPULATION)


