all: clean build

clean:
	rm -f output-arm-image/image

docker:
	docker pull docker.pkg.github.com/solo-io/packer-builder-arm-image/packer-builder-arm

build: docker
	docker run \
		--rm \
		--privileged \
		-v ${PWD}:/build:ro \
		-v ${PWD}/packer_cache:/build/packer_cache \
		-v ${PWD}/output-arm-image:/build/output-arm-image \
		-e PACKER_CACHE_DIR=/build/packer_cache \
	packer-builder-arm build packer/aprs-pigate.json
	mv output-arm-image/image output-arm-image/aprs-pigate.img
