(defrecord request
  (method 'get)
  (path #"")
  (headers '())
  (data #"")
  (filename #"")
  (options '()))

(defrecord response
  (status 200)
  (headers '())
  (body #""))
