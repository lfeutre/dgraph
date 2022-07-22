(defmodule dgraph-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

;;; -----------
;;; library API
;;; -----------

(deftest placeholder
  (is-equal 1 1))