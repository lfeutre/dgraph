(defrecord request
  (method 'get)
  (path #"")
  (headers '())
  (query '())
  (data #"")
  (filename #"")
  (options '()))

(defrecord response
  (status 200)
  (headers '())
  (body #""))
