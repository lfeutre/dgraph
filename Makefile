docker:
	@docker run -it \
	-p 5080:5080 \
	-p 6080:6080 \
	-p 8080:8080 \
	-p 9080:9080 \
	-p 8000:8000 \
	-v `pwd`/priv/data/dgraph:/dgraph \
	--name dgraph \
	--rm \
	dgraph/standalone:v21.03.0 \
	--telemetry "sentry=false;"
