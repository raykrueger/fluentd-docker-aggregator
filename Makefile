repository=raykrueger/fluentd

build:
	docker build -t $(repository) .

run: build
	docker run --rm -p 24224:24224 -v fluent-data:/fluentd/log $(repository)

push: build
	docker push $(repository)

start: build
	docker run --name fluentd -d -p 24224:24224 -v fluent-data:/fluentd/log $(repository)

stop:
	docker stop fluentd
	docker rm fluentd

restart: stop start
