#*=====================================================================*/
#*    trunk/Makefile                                                   */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Sat Mar 24 10:06:49 2001                          */
#*    Last change :  Wed Aug  3 11:43:44 2005 (dciabrin)               */
#*    Copyright   :  2001-05 Manuel Serrano                            */
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
_PEERS  = gtk gtk2 swing swt
PEERS_SH = gtk,gtk2,swing,swt
PEERS	= null $(_PEERS)

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

#*--- boot-gtk-generic ------------------------------------------------*/
boot-gtk-generic: boot-null lib/$(GTK) peer/$(GTK)/Makefile.$(GTK)config
	@ echo "[0m[1;32m--->>> biglook[0m"
	(cd biglook; $(MAKE) init heap lib)
	@ echo "[0m[1;32m--->>> peer/$(GTK)[0m"
	(cd peer/$(GTK); $(MAKE))

#*--- boot-gtk -------------------------------------------------------*/
boot-gtk: GTK=gtk
boot-gtk: boot-gtk-generic

#*--- boot-gtk2 -------------------------------------------------------*/
boot-gtk2: GTK=gtk2
boot-gtk2: boot-gtk-generic

#*--- boot-swing ------------------------------------------------------*/
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
$(foreach p,$(PEERS),lib/$(p)):
	mkdir -p $@

peer/$(GTK)/Makefile.$(GTK)config:
	@ echo "[0m[1;32m>>> peer/$(GTK)[0m"
	(cd peer/$(GTK); ./configure)

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

install-gtk: GTK=gtk
install-gtk: install-gtk-generic
	
install-gtk2: GTK=gtk2
install-gtk2: install-gtk-generic
	
install-gtk-generic:
	mkdir -p $(FILDIR)/$(GTK)
	chmod $(BMASK) $(FILDIR)/$(GTK)
	cp $(BOOTKDIR)/lib/biglook.heap $(FILDIR)/biglook.heap
	chmod $(BMASK) $(FILDIR)/biglook.heap
	cp $(BOOTKDIR)/lib/$(GTK)/biglook_peer.init \
           $(FILDIR)/$(GTK)/biglook_peer.init
	chmod $(BMASK) $(FILDIR)/$(GTK)/biglook_peer.init
	cp $(BOOTKDIR)/lib/$(GTK)/biglook_peer.h $(FILDIR)/$(GTK)/biglook_peer.h
	chmod $(BMASK) $(FILDIR)/$(GTK)/biglook_peer.h
	$(MAKE) install-lib BOOTLIBDIR=lib LIB=libbiglook_s-$(KRELEASE)
	$(MAKE) install-lnlib BOOTLIBDIR=lib \
                              LIB=libbiglook_s-$(KRELEASE) \
                              LN=libbiglook_u-$(KRELEASE)
	$(MAKE) install-lib BOOTLIBDIR=lib \
                            SUBDIR=$(GTK)/ \
                            LIB=libbiglook_peer_s-$(KRELEASE)
	$(MAKE) install-lnlib BOOTLIBDIR=lib \
                              SUBDIR=$(GTK)/ \
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
	$(RM) -rf $(FILDIR)/{$(PEERS_SH)}
	$(MAKE) uninstall-lib LIB=libbiglook_s-$(KRELEASE)
	$(MAKE) uninstall-lib LIB=libbiglook_u-$(KRELEASE)
	for p in gtk gtk2; do \
         $(MAKE) uninstall-lib SUBDIR=$$p LIB=libbiglook_peer_s-$(KRELEASE) ;\
	 $(MAKE) uninstall-lib SUBDIR=$$p LIB=libbiglook_peer_u-$(KRELEASE) ;\
	done
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
