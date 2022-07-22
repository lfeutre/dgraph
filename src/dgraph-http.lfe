(defmodule dgraph-http
  (export all))

(include-lib "include/http.lfe")

(defun get (req)
  (request (record-update req request method 'get)))

(defun post (req)
  (request (record-update req request method 'post)))
