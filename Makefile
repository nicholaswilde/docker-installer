include make.env

BUILD_DATE ?= $(shell date -u +%Y-%m-%dT%H%M%SZ)

.PHONY: push push-latest run rm help vars

## all		: Build all platforms
all: Dockerfile
	docker buildx build -t $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS) $(PLATFORMS) --build-arg VERSION=$(VERSION) --build-arg BUILD_DATE=$(BUILD_DATE) -f Dockerfile .

## build		: build the current platform (default)
build: Dockerfile
	docker buildx build -t $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS) --build-arg VERSION=$(VERSION) --build-arg BUILD_DATE=$(BUILD_DATE) -f Dockerfile .

## build-latest	: Build the latest current platform
build-latest: Dockerfile
	docker buildx build -t $(NS)/$(IMAGE_NAME):latest --build-arg VERSION=$(VERSION) --build-arg BUILD_DATE=$(BUILD_DATE) -f Dockerfile .

## lint		: Lint the Dockerfile with hadolint
lint:	Dockerfile
	hadolint Dockerfile && yamllint .

## load		: Load the release image
load: Dockerfile
	docker buildx build -t $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS) --build-arg VERSION=$(VERSION) --build-arg BUILD_DATE=$(BUILD_DATE) -f Dockerfile --load .

## load-latest	: Load the latest image
load-latest: Dockerfile
	docker buildx build -t $(NS)/$(IMAGE_NAME):latest --build-arg VERSION=$(VERSION) --build-arg BUILD_DATE=$(BUILD_DATE) -f Dockerfile --load .

## monitor	: Monitor the image with snyk
monitor:
	snyk container monitor $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS)

## prune		: Prune the docker builder
prune:
	docker builder prune --all

## push		: Push the release image
push: Dockerfile
	docker buildx build -t $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS) --build-arg VERSION=$(VERSION) --build-arg BUILD_DATE=$(BUILD_DATE) -f Dockerfile --push .

## push-latest	: PUsh the latest image
push-latest: Dockerfile
	docker buildx build -t $(NS)/$(IMAGE_NAME):latest $(PLATFORMS) --build-arg VERSION=$(VERSION) --build-arg BUILD_DATE=$(BUILD_DATE) -f Dockerfile --push .

## push-all	: Push all release platform images
push-all: Dockerfile
	docker buildx build -t $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS) $(PLATFORMS) --build-arg VERSION=$(VERSION) --build-arg BUILD_DATE=$(BUILD_DATE) -f Dockerfile --push .

## rm		: Remove the container
rm: stop
	docker rm $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

## run		: Run the Docker image
run:
	docker run --rm -it --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS)

## rund		: Run the Docker image in the background
rund:
	docker run -d --rm -it --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS)

shell:
	docker run --rm -it --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS) /bin/ash

## stop		: Stop the Docker container
stop:
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

## test		: Test the image with snyk
test:
	snyk container test $(NS)/$(IMAGE_NAME):$(VERSION)-ls$(LS) --file=Dockerfile

## help		: Show help
help: Makefile
	@sed -n 's/^##//p' $<

## vars		: Show all variables
vars:
	@echo VERSION		: $(VERSION)
	@echo NS				: $(NS)
	@echo IMAGE_NAME 			: $(IMAGE_NAME)
	@echo CONTAINER_NAME		: $(CONTAINER_NAME)
	@echo CONTAINER_INSTANCE	: $(CONTAINER_INSTANCE)
	@echo PORTS	: $(PORTS)
	@echo ENV	: $(ENV)
	@echo PLATFORMS	: $(PLATFORMS)
	@echo PLATFORMS_ARM	: $(PLATFORMS_ARM)
	@echo BUILDDATE	: $(BUILD_DATE)
default: build
