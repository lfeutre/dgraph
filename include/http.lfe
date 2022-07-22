(defrecord request
  (method 'get)
  path
  (headers '())
  (payload #b())
  (options '()))
