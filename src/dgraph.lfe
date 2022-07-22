(defmodule dgraph
  (export all))

;;; -----------
;;; library API
;;; -----------

(defun start (opts)
  (application:ensure_all_started 'hackney)
  (dgraph-api:start_link opts))

