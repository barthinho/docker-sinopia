rmi: stop-test
	docker rmi barthinho/sinopia 2>&1 > /dev/null

build:
	docker build -t barthinho/sinopia:latest .

start-test: stop-test build
	docker run -p 4873:4873 --name sinopia-test -v /home/docker/sinopia-test:/opt/sinopia/storage barthinho/sinopia:latest
	docker logs sinopia-test

stop-test:
	-docker rm -f sinopia-test 2>&1 > /dev/null

test: build
	docker run --rm -i -t barthinho/sinopia:latest

shell: build
	docker run --rm -i -t barthinho/sinopia:latest /bin/sh

logs:
	docker logs sinopia-test

publish:
	docker push barthinho/sinopia:latest

test: start-test
