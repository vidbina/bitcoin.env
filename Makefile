DOCKER=docker
DOCKER_ARGS=-v ${BITCOIN}:/src -w /src -u `id -u`:`id -g`
DOCKER_IMAGE=vidbina/bitcoin

image:
	${DOCKER} build --rm --force-rm -t ${DOCKER_IMAGE} .

shell:
	${DOCKER} run --rm -it \
		${DOCKER_ARGS} \
		${DOCKER_IMAGE} \
		/bin/bash
