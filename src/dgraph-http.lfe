(defmodule dgraph-http
  (export all))

(include-lib "include/http.lfe")

(defun request
  (((match-request method m path p headers h data d filename f options o))
   
   (case (hackney:request m (dgraph-core:url p) h (payload d f) o)
     (`#(ok ,s ,h ,ref) (case (hackney:body ref)
                          (`#(ok ,b) (make-response status s headers h body b))
                          (err err)))
     (err err))))

(defun get (req)
  (request (record-update req request method 'get)))

(defun post (req)
  (request (record-update req request method 'post)))

;; Utility functions

(defun payload (data filename)
  (case filename
    (#"" data)
    (name (case (file:read_file name)
            (`#(ok ,data) data)
            (err err)))))
