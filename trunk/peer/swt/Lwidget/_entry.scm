;*=====================================================================*/
;*    swt/Lwidget/_entry.scm                                           */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Tue Aug  2 21:41:26 2005 (dciabrin)               */
;*    Copyright   :  2001-05 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    The Swing peer Entry implementation.                             */
;*    definition: @path ../../../biglook/Lwidget/entry.scm@            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%entry
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%awt
	   __biglook_%swing
	   __biglook_%swt
	   __biglook_%widget
	   __biglook_%color
	   __biglook_%event
	   __biglook_%callback)
   
   (export (class %entry::%peer
	      (%command (default #f)))

	   (%make-%entry ::%bglk-object)
	   
	   (%entry-command ::%bglk-object)
	   (%entry-command-set! ::%bglk-object ::obj)
	   
	   (%entry-text::bstring ::%bglk-object)
	   (%entry-text-set! ::%bglk-object ::bstring)
	   
	   (%entry-active?::bool ::%bglk-object)
	   (%entry-active?-set! ::%bglk-object ::bool)
	   
	   (%entry-width::int ::%bglk-object)
	   (%entry-width-set! ::%bglk-object ::int)))
	   
;*---------------------------------------------------------------------*/
;*    %make-%entry ...                                                 */
;*---------------------------------------------------------------------*/
(define (%make-%entry o::%bglk-object)
   (let* ((tfield (%swing-jtextfield-new))
	  (pdim (%swing-jcomponent-preferred-size tfield))
	  (mdim (%awt-dimension-new 10000 (%awt-dimension-height pdim))))
      (%swing-jcomponent-maximum-size-set! tfield mdim)
      (instantiate::%entry
	 (%bglk-object o)
	 (%builtin tfield))))

;*---------------------------------------------------------------------*/
;*    %entry-command ...                                               */
;*---------------------------------------------------------------------*/
(define (%entry-command o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (with-access::%entry %peer (%command)
	 %command)))

;*---------------------------------------------------------------------*/
;*    %entry-command-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%entry-command-set! o::%bglk-object v)
   (with-access::%bglk-object o (%peer)
      (with-access::%entry %peer (%command)
	 (if (procedure? %command)
	     (%uninstall-widget-callback! o 'return %command))
	 (if (procedure? v)
	     (%install-widget-callback! o 'return v))
	 (set! %command v))))

;*---------------------------------------------------------------------*/
;*    %entry-text ...                                                  */
;*---------------------------------------------------------------------*/
(define (%entry-text o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%bglk-jstring->bstring
       (%swing-jtextcomponent-text (%peer-%builtin %peer)))))

;*---------------------------------------------------------------------*/
;*    %entry-text-set! ...                                             */
;*---------------------------------------------------------------------*/
(define (%entry-text-set! o::%bglk-object v::bstring)
   (with-access::%bglk-object o (%peer)
      (%swing-jtextcomponent-text-set! (%peer-%builtin %peer)
				       (%bglk-bstring->jstring v))
      o))

;*---------------------------------------------------------------------*/
;*    %entry-active? ...                                               */
;*---------------------------------------------------------------------*/
(define (%entry-active? o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%awt-component-enabled? (%peer-%builtin %peer))))

;*---------------------------------------------------------------------*/
;*    %entry-active?-set! ...                                          */
;*---------------------------------------------------------------------*/
(define (%entry-active?-set! o::%bglk-object v::bool)
   (with-access::%bglk-object o (%peer)
      (%awt-component-enabled?-set! (%peer-%builtin %peer) v)
      o))

;*---------------------------------------------------------------------*/
;*    %entry-width ...                                                 */
;*---------------------------------------------------------------------*/
(define (%entry-width::int o::%bglk-object)
   (with-access::%bglk-object o (%peer)
      (%swing-jtextfield-width (%peer-%builtin %peer))))

;*---------------------------------------------------------------------*/
;*    %entry-width-set! ...                                            */
;*---------------------------------------------------------------------*/
(define (%entry-width-set! o::%bglk-object v::int)
   (with-access::%bglk-object o (%peer)
      (%swing-jtextfield-width-set! (%peer-%builtin %peer) v)
      o))

