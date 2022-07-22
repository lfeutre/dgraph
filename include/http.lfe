(defrecord request
  (method 'get)
  (path #b())
  (headers '())
  (payload #b())
  (options '()))

(defrecord response
  (status 200)
  (headers '())
  (body #""))
           