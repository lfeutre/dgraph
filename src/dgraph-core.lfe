(defmodule dgraph-core
  (behaviour gen_server)
  ;; gen_server implementation
  (export
   (start_link 1)
   (stop 0))
  ;; callback implementation
  (export
   (init 1)
   (handle_call 3)
   (handle_cast 2)
   (handle_info 2)
   (terminate 2)
   (code_change 3))
  ;; server API
  (export
   (base-url 0)
   (pid 0)
   (echo 1)
   (url 1) (url 2)))

(include-lib "include/options.lfe")

;;; ----------------
;;; config functions
;;; ----------------

(defun SERVER () (MODULE))
(defun genserver-opts () '())
(defun unknown-command () #(error "Unknown command."))

;;; -------------------------
;;; gen_server implementation
;;; -------------------------

(defun start_link (client-opts)
  (gen_server:start_link `#(local ,(SERVER))
                         (MODULE)
                         client-opts
                         (genserver-opts)))

(defun stop ()
  (gen_server:call (SERVER) 'stop))

;;; -----------------------
;;; callback implementation
;;; -----------------------

(defun init (state)
  `#(ok ,state))

(defun handle_cast (_msg state)
  `#(noreply ,state))

(defun handle_call
  (('base-url _from (= (match-client-opts base-url bu) state))
   `#(reply ,bu ,state))
  ((`#(client base-url) _from state)
   `#(reply ,(client-opts-base-url state) ,state))
  (('stop _from state)
    `#(stop shutdown ok ,state))
  ((`#(echo ,msg) _from state)
    `#(reply ,msg ,state))
  ((message _from state)
    `#(reply ,(unknown-command) ,state)))

(defun handle_info
  ((`#(EXIT ,_from normal) state)
   `#(noreply ,state))
  ((`#(EXIT ,pid ,reason) state)
   (io:format "Process ~p exited! (Reason: ~p)~n" `(,pid ,reason))
   `#(noreply ,state))
  ((_msg state)
   `#(noreply ,state)))

(defun terminate (_reason _state)
  'ok)

(defun code_change (_old-version state _extra)
  `#(ok ,state))

;;; --------------
;;; our server API
;;; --------------

(defun base-url ()
  (gen_server:call (SERVER) #(client base-url)))

(defun echo (msg)
  (gen_server:call (SERVER) `#(echo ,msg)))

(defun pid ()
  (erlang:whereis (SERVER)))

(defun url (path)
  (url path '()))

(defun url (path query)
  (let ((u `(,(base-url) #"/" ,path)))
    (case query
      ('() u)
      (_ (lists:append u (list #"?" query))))))

