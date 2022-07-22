(defmodule dgraph
  (export all))

(include-lib "include/options.lfe")

;;; -----------
;;; library API
;;; -----------

(defun start ()
  (start (make-client-opts
          base-url "http://localhost:8080")))

(defun start (opts)
  (application:ensure_all_started 'hackney)
  (dgraph-core:start_link opts))

