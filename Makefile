DOCKER_IMAGE_NAME ?= haskell-env

.PHONY: cbuild
cbuild:
	docker build --tag $(DOCKER_IMAGE_NAME) .

.PHONY: cbuild-clean
cbuild-clean:
	docker build --no-cache --tag $(DOCKER_IMAGE_NAME) .

UID=$(shell id -u)
GID=$(shell id -g)

.PHONY: crun
crun:
	docker run \
	--name $(DOCKER_IMAGE_NAME) \
	--volume ${PWD}:${PWD} \
	--workdir=${PWD} \
	--tty \
	--interactive \
	--detach \
	--rm \
	--volume="/etc/group:/etc/group:ro" \
	--volume="/etc/passwd:/etc/passwd:ro" \
	--volume="/etc/shadow:/etc/shadow:ro" \
	--env="DISPLAY" \
	--net=host \
	--env GID=$$GID \
	--env UID=$$UID \
	--env USER=$$USER \
	$(DOCKER_IMAGE_NAME)

.PHONY: csetup
csetup: cbuild crun

.PHONY: cattach
cattach:
	docker attach $(DOCKER_IMAGE_NAME)

.PHONY: cstop
cstop:
	docker stop $(DOCKER_IMAGE_NAME)

.PHONY: cexec
cexec:
	docker exec $(DOCKER_IMAGE_NAME) /bin/sh -c "${a}"
