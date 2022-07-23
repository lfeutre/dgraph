(defmodule dgraph-http
  (export all))

(include-lib "include/http.lfe")

(defun request
  (((match-request method m path p headers h query q data d filename f options o))
   
   (case (hackney:request m (dgraph-core:url p (format:query q)) h (payload d f) o)
     (`#(ok ,s ,h ,ref) (case (hackney:body ref)
                          (`#(ok ,b) (make-response status s headers h body b))
                          (err err)))
     (err err))))

(defun get (req)
  (request (update-request req method 'get)))

(defun post (req)
  (request (update-request req method 'post)))

;; Utility functions

(defun add-header
  (((= (match-request headers h) req) field value)
   (update-request req headers (lists:append `(#(,field ,value)) h))))

(defun format-query
  (('())
   '())
  ((query-list)
   (lists:foldl
    (lambda (x acc)
      (lists:append acc (list (element 1 x)
                              #"="
                              (element 2 x)
                              #"&")))
    '()
    query-list)))

(defun payload (data filename)
  (case filename
    (#"" data)
    (name (case (file:read_file name)
            (`#(ok ,data) data)
            (err err)))))
