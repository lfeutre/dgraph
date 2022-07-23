(defrecord request
  (method 'get)
  (path #b"")
  (headers '())
  (data #b"")
  (filename #b"")
  (options '()))

(defrecord response
  (status 200)
  (headers '())
  (body #""))
           