(defmodule dgraph-http
  (export all))

(include-lib "include/http.lfe")

(defun request
  (((match-request method m path p headers h payload d options o))
   (case (hackney:request m (dgraph-core:url p) h d o)
     (`#(ok ,s ,h ,ref) (case (hackney:body ref)
                          (`#(ok ,b) (make-response status s headers h body b))
                          (err err)))
     (err err))))

(defun get (req)
  (request (record-update req request method 'get)))

(defun post (req)
  (request (record-update req request method 'post)))
