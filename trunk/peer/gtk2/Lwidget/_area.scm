;*=====================================================================*/
;*    serrano/prgm/project/biglook/peer/gtk/Lwidget/_area.scm          */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Sat Mar 24 09:14:39 2001                          */
;*    Last change :  Fri Jun  1 09:52:17 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Gtk peer Label implementation.                               */
;*    definition: @path ../../../biglook/Lwidget/area.scm@             */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_%area
   
   (import __biglook_%error
	   __biglook_%peer
	   __biglook_%bglk-object
	   __biglook_%container
	   __biglook_%grid
	   __biglook_%gtk-misc)
   
   (static (class %area::%container
	      (%grid::%peer read-only)))
	   
   (export (%make-%area ::%bglk-object)
	   
	   (%area-horizontal-spacing::int ::%bglk-object)
	   (%area-horizontal-spacing-set! ::%bglk-object ::int)
	   
	   (%area-vertical-spacing::int ::%bglk-object)
	   (%area-vertical-spacing-set! ::%bglk-object ::int)
	   
	   (%area-add! ::%bglk-object ::%bglk-object ::symbol)))

;*---------------------------------------------------------------------*/
;*    %make-%area ...                                                  */
;*---------------------------------------------------------------------*/
(define (%make-%area o::%bglk-object)
   (let* ((grid (%make-%grid o))
	  (%grid (%peer-%builtin grid)))
      (%bglk-g-property-set! (gobject %grid) "n-rows" 3)
      (%bglk-g-property-set! (gobject %grid) "n-columns" 3)
      (%bglk-g-property-set! (gobject %grid) "homogeneous" #f)
      (instantiate::%area
	 (%grid grid)
	 (%bglk-object o)
	 (%builtin %grid))))

;*---------------------------------------------------------------------*/
;*    %area-horizontal-spacing ...                                     */
;*---------------------------------------------------------------------*/
(define (%area-horizontal-spacing::int o::%bglk-object)
   (%grid-column-spacing o))

;*---------------------------------------------------------------------*/
;*    %area-horizontal-spacing-set! ...                                */
;*---------------------------------------------------------------------*/
(define (%area-horizontal-spacing-set! o::%bglk-object v::int)
   (%grid-column-spacing-set! o v))

;*---------------------------------------------------------------------*/
;*    %area-vertical-spacing ...                                       */
;*---------------------------------------------------------------------*/
(define (%area-vertical-spacing::int o::%bglk-object)
   (%grid-row-spacing o))

;*---------------------------------------------------------------------*/
;*    %area-vertical-spacing-set! ...                                  */
;*---------------------------------------------------------------------*/
(define (%area-vertical-spacing-set! o::%bglk-object v::int)
   (%grid-row-spacing-set! o v))

;*---------------------------------------------------------------------*/
;*    %area-add! ...                                                   */
;*---------------------------------------------------------------------*/
(define (%area-add! container::%bglk-object widget::%bglk-object zone::symbol)
   (with-access::%bglk-object container (%peer)
      (with-access::%area %peer (%grid)
	 (case zone
	    ((north)
	     (%grid-add! container widget 0 3 0 1 0 0 #f 'x)
	     container)
	    ((south)
	     (%grid-add! container widget 0 3 2 1 0 0 #f 'x)
	     container)
	    ((west)
	     (%grid-add! container widget 0 1 1 1 0 0 #f 'y)
	     container)
	    ((center)
	     (%grid-add! container widget 1 1 1 1 0 0 #t 'both)
	     container)
	    ((east)
	     (%grid-add! container widget 2 1 1 1 0 0 #f 'y)
	     container)
	    (else
	     (error "%area-add!" "Illegal zone" zone))))))

