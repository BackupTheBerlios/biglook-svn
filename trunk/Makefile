#*=====================================================================*/
#*    biglook/Makefile                                                 */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Sat Mar 24 10:06:49 2001                          */
#*    Last change :  Thu Nov  6 17:09:42 2003 (dciabrin)               */
#*    Copyright   :  2001-03 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    The (gmake) Makefile to build Biglook.                           */
#*    -------------------------------------------------------------    */
#*    The main Biglook Makefile. Here is a short description of the    */
#*    makefile entries.                                                */
#*                                                                     */
#*    Public entries:                                                  */
#*       biglook.......... Compile the Biglook independant part.       */
#*       peer............. Compile the peer that is denoted by the     */
#*                         shell variable PEER.                        */
#*       peers............ Compile all peers (variable PEERS).         */
#*       clean............ Cleaning.                                   */
#*       cleanall......... Cleaning.                                   */
#*       distclean........ Cleaning.                                   */
#*                                                                     */
#*    Private entries:                                                 */
#*       install.......... Install the development version into the    */
#*                         Bigloo development tree.                    */
#*       uninstall........ Install the development version into the    */
#*                         Bigloo development tree.                    */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    The default configuration                                        */
#*---------------------------------------------------------------------*/
include Makefile.kconfig

#*---------------------------------------------------------------------*/
#*    Peers                                                            */
#*---------------------------------------------------------------------*/
PEER	= null
PEERS	= null gtk swing swt

#*---------------------------------------------------------------------*/
#*    goals                                                            */
#*---------------------------------------------------------------------*/
#*--- Main compilation goal -------------------------------------------*/
boot:
	@ for p in $(BACKENDS); do \
	   echo "[0m[1;31m>>> $$p[0m"; \
	   $(MAKE) boot-$$p || exit 1; \
	done

#*--- boot-null -------------------------------------------------------*/
boot-null: lib/null 
	@ echo "[0m[1;32m--->>> peer/null[0m"
	(cd peer/null; $(MAKE) c-all)

#*--- boot-jnull ------------------------------------------------------*/
boot-jnull: lib/null 
	@ echo "[0m[1;32m--->>> peer/null[0m"
	(cd peer/null; $(MAKE) jvm-all)

#*--- boot-gtk --------------------------------------------------------*/
boot-gtk: boot-null lib/gtk peer/gtk/Makefile.gtkconfig
	@ echo "[0m[1;32m--->>> biglook[0m"
	(cd biglook; $(MAKE) init heap lib)
	@ echo "[0m[1;32m--->>> peer/gtk[0m"
	(cd peer/gtk; $(MAKE))

#*--- boot-gtk --------------------------------------------------------*/
boot-swing: boot-jnull lib/swing
	@ echo "[0m[1;32m--->>> biglook[0m"
	(cd biglook; $(MAKE) init jheap zip)
	@ echo "[0m[1;32m--->>> peer/swing[0m"
	(cd peer/swing; $(MAKE))

#*--- boot-swt --------------------------------------------------------*/
boot-swt: boot-jnull lib/swt
	@ echo "[0m[1;32m--->>> biglook[0m"
	(cd biglook; $(MAKE) init jheap zip)
	@ echo "[0m[1;32m--->>> peer/swk[0m"
	(cd peer/swt; $(MAKE))

#*--- peers -----------------------------------------------------------*/
lib/null:
	mkdir -p lib/null
lib/gtk:
	mkdir -p lib/gtk
lib/swing:
	mkdir -p lib/swing
lib/swt:
	mkdir -p lib/swt

peer/gtk/Makefile.gtkconfig:
	@ echo "[0m[1;32m>>> peer/gtk[0m"
	(cd peer/gtk; ./configure)

#*---------------------------------------------------------------------*/
#*    install                                                          */
#*---------------------------------------------------------------------*/
include $(BGLLIBDIR)/Makefile.misc

install: install-biglook
	for p in $(BACKENDS); do \
            $(MAKE) install-$$p || exit 1; \
        done

install-biglook:
	cp $(BOOTKDIR)/Makefile.kconfig $(FILDIR)/Makefile.kconfig
	chmod $(BMASK) $(FILDIR)/Makefile.kconfig
	cp $(BOOTKDIR)/lib/biglook.init $(FILDIR)/biglook.init
	chmod $(BMASK) $(FILDIR)/biglook.init

install-gtk:
	mkdir -p $(FILDIR)/gtk
	chmod $(BMASK) $(FILDIR)/gtk
	cp $(BOOTKDIR)/lib/biglook.heap $(FILDIR)/biglook.heap
	chmod $(BMASK) $(FILDIR)/biglook.heap
	cp $(BOOTKDIR)/lib/gtk/biglook_peer.init \
           $(FILDIR)/gtk/biglook_peer.init
	chmod $(BMASK) $(FILDIR)/gtk/biglook_peer.init
	cp $(BOOTKDIR)/lib/gtk/biglook_peer.h $(FILDIR)/gtk/biglook_peer.h
	chmod $(BMASK) $(FILDIR)/gtk/biglook_peer.h
	$(MAKE) install-lib BOOTLIBDIR=lib LIB=libbiglook_s-$(KRELEASE)
	$(MAKE) install-lnlib BOOTLIBDIR=lib \
                              LIB=libbiglook_s-$(KRELEASE) \
                              LN=libbiglook_u-$(KRELEASE)
	$(MAKE) install-lib BOOTLIBDIR=lib \
                            SUBDIR=gtk/ \
                            LIB=libbiglook_peer_s-$(KRELEASE)
	$(MAKE) install-lnlib BOOTLIBDIR=lib \
                              SUBDIR=gtk/ \
                              LIB=libbiglook_peer_s-$(KRELEASE) \
                              LN=libbiglook_peer_u-$(KRELEASE)

install-swing:
	mkdir -p $(FILDIR)/swing
	chmod $(BMASK) $(FILDIR)/swing
	cp $(BOOTKDIR)/lib/biglook.jheap $(FILDIR)/biglook.jheap
	chmod $(BMASK) $(FILDIR)/biglook.jheap
	cp $(BOOTKDIR)/lib/biglook_peer.jheap $(FILDIR)/biglook_peer.jheap
	chmod $(BMASK) $(FILDIR)/biglook_peer.jheap
	cp $(BOOTKDIR)/lib/biglook_s.zip $(FILDIR)/biglook_s.zip
	chmod $(BMASK) $(FILDIR)/biglook_s.zip
	cp $(BOOTKDIR)/lib/swing/biglook_peer.init \
           $(FILDIR)/swing/biglook_peer.init
	chmod $(BMASK) $(FILDIR)/swing/biglook_peer.init
	(cd $(FILDIR); $(RM) -f biglook_u.zip; ln -s biglook_s.zip biglook_u.zip)
	cp $(BOOTKDIR)/lib/swing/biglook_peer_s.zip $(FILDIR)/swing/biglook_peer_s.zip
	chmod $(BMASK) $(FILDIR)/swing/biglook_peer_s.zip
	(cd $(FILDIR)/swing; \
         $(RM) -f biglook_peer_u.zip; \
         ln -s biglook_peer.zip biglook_peer_u.zip)

install-swt:
	mkdir -p $(FILDIR)/swt
	chmod $(BMASK) $(FILDIR)/swt
	cp $(BOOTKDIR)/lib/biglook.jheap $(FILDIR)/biglook.jheap
	chmod $(BMASK) $(FILDIR)/biglook.jheap
	cp $(BOOTKDIR)/lib/biglook_s.zip $(FILDIR)/biglook_s.zip
	chmod $(BMASK) $(FILDIR)/biglook_s.zip
	cp $(BOOTKDIR)/lib/swt/biglook_peer.init \
           $(FILDIR)/swt/biglook_peer.init
	chmod $(BMASK) $(FILDIR)/swt/biglook_peer.init
	(cd $(FILDIR); $(RM) -f biglook_u.zip; ln -s biglook_s.zip biglook_u.zip)
	cp $(BOOTKDIR)/lib/swt/biglook_peer_s.zip $(FILDIR)/swt/biglook_peer_s.zip
	chmod $(BMASK) $(FILDIR)/swt/biglook_peer_s.zip
	(cd $(FILDIR)/swt; \
         $(RM) -f biglook_peer_u.zip; \
         ln -s biglook_peer.zip biglook_peer_u.zip)

uninstall:
	$(RM) -f $(FILDIR)/Makefile.kconfig
	$(RM) -f $(FILDIR)/biglook.heap
	$(RM) -f $(FILDIR)/biglook.jheap
	$(RM) -f $(FILDIR)/biglook.init
	$(RM) -f $(FILDIR)/biglook_s.zip
	$(RM) -f $(FILDIR)/biglook_u.zip
	$(RM) -rf $(FILDIR)/gtk
	$(RM) -rf $(FILDIR)/swing
	$(MAKE) uninstall-lib LIB=libbiglook_s-$(KRELEASE)
	$(MAKE) uninstall-lib LIB=libbiglook_u-$(KRELEASE)
	$(MAKE) uninstall-lib SUBDIR=gtk/ LIB=libbiglook_peer_s-$(KRELEASE)
	$(MAKE) uninstall-lib SUBDIR=gtk/ LIB=libbiglook_peer_u-$(KRELEASE)
	$(RM) -f $(FILDIR)/swing/biglook_peer_s.zip
	$(RM) -f $(FILDIR)/swing/biglook_peer_u.zip
	for p in $(BACKENDS); do \
          $(RM) -rf $(FILDIR)/$$p; \
        done

#*---------------------------------------------------------------------*/
#*    clean                                                            */
#*---------------------------------------------------------------------*/
clean:
	(cd biglook; $(MAKE) clean)
	for p in $(PEERS); do \
	   (cd peer/$$p; $(MAKE) clean); \
        done
	(cd examples; $(MAKE) clean)
	(cd games; $(MAKE) clean)

clean-peer:
	(cd peer/$(PEER); $(MAKE) clean)

cleanall: clean
	(cd biglook; $(MAKE) cleanall)
	for p in $(PEERS); do \
	   (cd peer/$$p; $(MAKE) cleanall); \
        done
	(cd examples; $(MAKE) cleanall)
	(cd games; $(MAKE) cleanall)
	$(RM) Makefile.kconfig

distclean:
	for p in $(PEERS); do \
	   (cd peer/$$p; $(MAKE) distclean); \
        done
	$(MAKE) cleanall

#*---------------------------------------------------------------------*/
#*    tgz                                                              */
#*---------------------------------------------------------------------*/
tgz:
	$(MAKE) clean
	cleanup
	cd .. && tar cvfz kalpha1.0-`date "+%d%b%y"`.tgz biglook --exclude old --exclude work --exclude TODO && cd biglook
