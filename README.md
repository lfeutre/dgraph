# dgraph

*An LFE Client for the dgraph database*

[![Project Logo][logo]][logo-large]


## Getting Started

Note: the following was adapted from the [Dgraph Getting Started page](https://dgraph.io/docs/get-started/).

Start up the REPL:

```shell
$ rebar3 lfe repl
```

Start the dgraph client:
```lisp
lfe> (dgraph:start)
```

Load the sample data:
```lisp
lfe> (include-lib "include/http.lfe")
lfe> (set req (make-request
                headers '(#(#"Content-Type" #"application/rdf"))
                filename #"./priv/testing/movies.rdf"))
lfe> (dgraph:mutate req)
```

Update the schema:
```lisp
lfe> (set req (make-request
                headers '(#(#"Content-Type" #"application/rdf"))
                filename #"./priv/testing/movies.schema"))
lfe> (dgraph:alter req)
```

Update the schema:
<!-- Named page links below: /-->

[logo]: priv/images/LFE-dgraph-logo-small.png
[logo-large]: priv/images/LFE-dgraph-logo-large.png
