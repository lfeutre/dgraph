(defmodule dgraph-app
  (behaviour application)
  ;; app implementation
  (export
   (start 2)
   (stop 0)))

;;; --------------------------
;;; application implementation
;;; --------------------------

(defun start (_type _args)
  (logger:set_application_level 'dgraph 'all)
  (logger:info "Starting dgraph application ...")
  (dgraph-sup:start_link))

(defun stop ()
  (dgraph-sup:stop)
  'ok)
