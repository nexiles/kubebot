DOCKER=docker
IMAGE=kubebot

.PHONY: all

all: build push

build:
	$(DOCKER) build . --build-arg TAG_VERSION=${TAG_VERSION} -t $(IMAGE):${TAG_VERSION} -t $(IMAGE):latest

push:
	$(DOCKER) tag $(IMAGE):${TAG_VERSION}	${K8S_DOCKER_REPOSITORY}/$(IMAGE):${TAG_VERSION}
	$(DOCKER) tag $(IMAGE):latest 				${K8S_DOCKER_REPOSITORY}/$(IMAGE):latest
	$(DOCKER) tag $(IMAGE):${TAG_VERSION}	${NEXILES_DOCKER_REPOSITORY}/$(IMAGE):${TAG_VERSION}
	$(DOCKER) tag $(IMAGE):latest 				${NEXILES_DOCKER_REPOSITORY}/$(IMAGE):latest
	$(DOCKER) push ${K8S_DOCKER_REPOSITORY}/$(IMAGE)
