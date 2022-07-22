(defmodule dgraph-http
  (export all))

(include-lib "include/http.lfe")

(defun request
  (((match-request method m path p headers h payload d options o))
   (hackney:request m (dgraph-core:url p) h d o)))

(defun get (req)
  (request (record-update req request method 'get)))

(defun post (req)
  (request (record-update req request method 'post)))
