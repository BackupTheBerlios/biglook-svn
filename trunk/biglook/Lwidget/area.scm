;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Lwidget/area.scm            */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Apr  9 17:06:53 2001                          */
;*    Last change :  Thu Jun  7 13:08:57 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The area layout manager                                          */
;*    -------------------------------------------------------------    */
;*    Source documentations:                                           */
;*       @path ../../manual/area.texi@                                 */
;*       @node Area@                                                   */
;*    Examples:                                                        */
;*       @path ../../examples/area/area.scm@                           */
;*    -------------------------------------------------------------    */
;*    Implementation: @label widget@                                   */
;*    null: @path ../../peer/null/Lwidget/_area.scm@                   */
;*    gtk: @path ../../peer/gtk/Lwidget/_area.scm@                     */
;*    jvm: @path ../../peer/jvm/Lwidget/_area.scm@                     */
;*    -------------------------------------------------------------    */
;*    Local indentation                                                */
;*    @eval (put 'let-options 'bee-indent-hook 'bee-let-indent)@       */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_area
   
   (include "Misc/options.sch")
   
   (library biglook_peer)
   
   (import  __biglook_bglk-object
	    __biglook_widget
	    __biglook_container)
   
   (export  (class area::container
	       ;; last add
	       (%last::pair-nil (default (list 'north 'west 'center 'east 'south)))
	       ;; horizontal spacing
	       (horizontal-spacing::int
		(get %area-horizontal-spacing)
		(set %area-horizontal-spacing-set!))
	       ;; vertical spacing
	       (vertical-spacing::int
		(get %area-vertical-spacing)
		(set %area-vertical-spacing-set!)))))

;*---------------------------------------------------------------------*/
;*    bglk-object-init ::area ...                                      */
;*---------------------------------------------------------------------*/
(define-method (bglk-object-init o::area)
   (with-access::area o (%peer)
      (set! %peer (%make-%area o))
      (call-next-method)
      o))

;*---------------------------------------------------------------------*/
;*    container-add! ::area ...                                        */
;*---------------------------------------------------------------------*/
(define-method (container-add! container::area widget . options)
   (with-access::area container (%last)
      (let ((last-zone 'n))
	 (if (pair? %last)
	     (set! last-zone (car %last)))
	 (let-options options ((:zone last-zone)
 			       (error-proc: "container-add!(area)"))
	    ;; check the zone
	    (if (not (pair? (memq zone '(north west center east south))))
		(error "container-add!(area)" "Illegal zone" zone)
		(begin
		   ;; store the position of the insertion
		   (let ((lzone (memq zone %last)))
		      (if (pair? lzone)
			  (set! %last (cdr lzone))
			  (set! %last '())))
		   ;; add the element
		   (%area-add! container widget zone)))))))

;*---------------------------------------------------------------------*/
;*    container-remove-all! ::area ...                                 */
;*---------------------------------------------------------------------*/
(define-method (container-remove-all! container::area)
   (with-access::area container (%last)
      (set! %last (list 'north 'west 'center 'east 'south))
      (call-next-method)))
