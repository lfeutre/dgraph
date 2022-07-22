(defmodule dgraph-api-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "include/options.lfe")

;;; -----------
;;; library API
;;; -----------

(deftest base-url
  (dgraph:start (make-record client-opts base-url "http://localhost:8080"))
  (is-equal "http://localhost:8080" (dgraph-api:base-url)))