;*=====================================================================*/
;*    serrano/prgm/project/biglook/biglook/Llib/app.scm                */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Wed Sep  6 08:21:00 2000                          */
;*    Last change :  Mon Jul 30 05:46:04 2001 (serrano)                */
;*    Copyright   :  2001 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    The Biglook application initialization (e.g., arguments parsing, */
;*    main event loop, ...).                                           */
;*    -------------------------------------------------------------    */
;*    Implementation: @label App@                                      */
;*    null: @path ../../peer/null/Llib/_app.scm@                       */
;*    gtk: @path ../../peer/gtk/Llib/_app.scm@                         */
;*    swing: @path ../../peer/swing/Llib/_app.scm@                     */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module __biglook_app

   (library biglook_peer)
   
   (import  __biglook_configure
	    __biglook_event)

   (export  (biglook-release)
            (biglook-info)
            (biglook-args? ::bstring)
            the-biglook-args-parse-usage
            (biglook-args-parse-usage ::bool)
	    (biglook-rc-parse ::bstring)
	    (biglook-peer-special . options)))

;*---------------------------------------------------------------------*/
;*    biglook release ...                                              */
;*---------------------------------------------------------------------*/
(define (biglook-release)
   (string-append "Biglook v" (biglook-version)
		  ", Peer v" (%biglook-version)))

;*---------------------------------------------------------------------*/
;*    biglook-info ...                                                 */
;*---------------------------------------------------------------------*/
(define (biglook-info)
   (string-append "Peer (" (%biglook-peer-name) ")"))

;*---------------------------------------------------------------------*/
;*    *no-main-loop-apps* ...                                          */
;*    -------------------------------------------------------------    */
;*    The name of the applications that do not requires the tk main    */
;*    loop.                                                            */
;*---------------------------------------------------------------------*/
(define *no-main-loop-apps* '("biglook"))

;*---------------------------------------------------------------------*/
;*    biglook-args? ...                                                */
;*    -------------------------------------------------------------    */
;*    The list of command line options is taken from the regular       */
;*    command line option parsing.                                     */
;*---------------------------------------------------------------------*/
(define (biglook-args? arg)
   (member arg
           '("-help" "-name" "-display" "-geometry" "-sync" "-no-event-loop")))

;*---------------------------------------------------------------------*/
;*    the-biglook-args-parse-usage ...                                 */
;*---------------------------------------------------------------------*/
(define the-biglook-args-parse-usage the-biglook-args-parse-usage)

;*---------------------------------------------------------------------*/
;*    biglook-args-parse-usage ...                                     */
;*---------------------------------------------------------------------*/
(define (biglook-args-parse-usage opt)
   (if (procedure? the-biglook-args-parse-usage)
       (the-biglook-args-parse-usage opt)
       opt))

;*---------------------------------------------------------------------*/
;*    biglook-peer-special ...                                         */
;*---------------------------------------------------------------------*/
(define (biglook-peer-special . options)
   (%biglook-peer-special options))

;*---------------------------------------------------------------------*/
;*    biglook-start ...                                                */
;*    -------------------------------------------------------------    */
;*    This function is called at the very beginning of a Biglook       */
;*    application. It:                                                 */
;*      1- parses the Biglook specific arguments                       */
;*      2- initializes the event handling                              */
;*      3- runs the Biglook main loop                                  */
;*---------------------------------------------------------------------*/
(define (biglook-start)
   (let* ((args      (command-line))
	  (args      (if (pair? args)
			 args
			 '("biglook-application")))
	  (argv0     (car args))
	  (sync      0)
	  (name      "")
	  (display   (or (getenv "DISPLAY") ""))
	  (geometry  "")
	  (rc        #t)
	  (mainloop? (not (pair? (member (basename argv0)
					 *no-main-loop-apps*)))))
      (args-parse (cdr args)
	 (section "Biglook")
	 (("-name" ?nm (synopsis "Name to use for application"))
	  (set! name nm))
	 (("-display" ?value (synopsis "Display to use"))
	  (set! display value))
	 (("-geometry" ?geo (synopsis "Initial geometry for window"))
	  (set! geometry geo))
	 (("-sync" (synopsis "Use synchronous mode for display server"))
	  (set! sync #t))
	 (("-no-event-loop" (synopsis "Do not spawn event loop"))
	  (set! mainloop? #f))
	 (("-biglook-rc" ?f (synopsis "Use a specific rc file (#f to disable)"))
	  (if (string=? "#f" f)
	      (set! rc #f)
	      (set! rc f)))
	 (("-biglook-quiet" (synopsis "Do not load Biglook rc file"))
	  (set! rc #f))
	 (else
	  (set! the-biglook-args-parse-usage args-parse-usage)))
      ;; initialize events
      (initialize-events!)
      ;; start the main loop
      (%biglook-start mainloop? argv0 name rc)))

;*---------------------------------------------------------------------*/
;*    biglook-rc-parse ...                                             */
;*---------------------------------------------------------------------*/
(define (biglook-rc-parse rc-name)
   (%biglook-rc-parse rc-name))

;*---------------------------------------------------------------------*/
;*    The argument parsing                                             */
;*    -------------------------------------------------------------    */
;*    If one option is added, it has to be reported in the             */
;*    BIGLOOK-ARGS? function.                                          */
;*---------------------------------------------------------------------*/
(biglook-start)

