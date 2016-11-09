.PHONY: install

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Builds the Docker container
	@docker build --build-arg NPMTOKEN=$$(awk -F'=' 'NR==1{print $$2}' ~/.npmrc) -t $$(basename $$(pwd)) .
