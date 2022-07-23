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

;;; -------------
;;; Low-level API
;;; -------------

(defun metrics ()
  (metrics (make-metrics-opts)))

(defun metrics
  (((match-metrics-opts full f))
   (let* (((= (match-response body b) resp) (dgraph-http:get
                                             (make-request
                                              path #"metrics")))
          (resp-lines (update-response resp body (binary:split b #"\n" '(global)))))
     (case f
       ('true resp-lines)
       (_ (metrics-only-filter resp-lines))))))

(defun mutation ()
  'tbd)

(defun query
  (((= (match-request headers h) req))
   (dgraph-http:post
    (update-request req
                    headers (lists:append '(#(#"Content-Type" #"application/dql")) h)))))

;; Utility functions

(defun metrics-only-filter
  (((= (match-response body b) resp))
   (lists:filter (lambda (x) (=/= x #""))
                 (list-comp ((<- l b))
                   (case (re:run l "^[^#].*" '(#(capture all binary)))
                     (`#(match ,data) data)
                     (_ #""))))))