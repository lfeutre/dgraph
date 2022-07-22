(defmodule dgraph
  (export all))

(include-lib "include/http.lfe")
(include-lib "include/options.lfe")

;;; -----------
;;; Setup
;;; -----------

(defun start ()
  (start (make-client-opts
          base-url #"http://localhost:8080")))

(defun start (opts)
  (application:ensure_all_started 'hackney)
  (dgraph-core:start_link opts))

;;; -----------
;;; library API
;;; -----------

(defun metrics ()
  (dgraph-http:get
   (make-request
    path #"metrics")))