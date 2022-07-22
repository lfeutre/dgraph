(defmodule dgraph-core-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "include/options.lfe")

;;; -----------
;;; library API
;;; -----------

(defun test-client ()
  (make-client-opts
   base-url "http://localhost:8080"))

(deftest base-url
  (dgraph:start (test-client))
  (is-equal "http://localhost:8080"
            (dgraph-core:base-url)))

(deftest url
  (dgraph:start (test-client))
  (is-equal "http://localhost:8080/metrics"
            (lists:flatten (dgraph-core:url "metrics"))))