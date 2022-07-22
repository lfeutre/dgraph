(defmodule dgraph-api
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
   (echo 1)))

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

(defun start_link (state)
  (gen_server:start_link `#(local ,(SERVER))
                         (MODULE)
                         state
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
  ((`#(request ,(match-request method m path p headers h payload d options o)) _from (= (match-client-opts base-url bu) state))
   `#(reply ,(hackney:request m (io_lib:format "%s/%s" (list base-url path)) sp h d o) ,state))
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
  (gen_server:call (SERVER) 'base-url))

(defun echo (msg)
  (gen_server:call (SERVER) `#(echo ,msg)))

(defun pid ()
  (erlang:whereis (SERVER)))

(defun request (req)
  (gen_server:call (SERVER) `#(request ,req)))