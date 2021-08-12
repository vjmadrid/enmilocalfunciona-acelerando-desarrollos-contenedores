VERSION ?= 0.0.1-SNAPSHOT
IMAGE_NAME ?= vsftpd-alpine-3.9.4
CONTAINER_NAME ?= vsftpd-alpine

.PHONY: build
build:
	docker build . -t acme/${IMAGE_NAME}:${VERSION}

.PHONY: run
run:
	docker run -d --name ${CONTAINER_NAME} -p 20-22:20-22 -p 21100-21110:21100-21110 acme/${IMAGE_NAME}:${VERSION}


.PHONY: start
start:
	docker start ${CONTAINER_NAME}


.PHONY: stop
stop:
	docker stop ${CONTAINER_NAME}


.PHONY: clean-container
clean-container:
	docker container rm ${CONTAINER_NAME}


.PHONY: clean-images
clean-images:
	docker image rm acme/${IMAGE_NAME}:${VERSION}


.PHONY: clean-all
clean-all: clean-container clean-images


.PHONY: up
up: build run

.PHONY: down
down: stop clean-container