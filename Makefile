#!/bin/sh

ncore:=24
src_tmp_dir:=$(PWD)
snort_etc:=
pcap_dir:=$(pcap_dir)
pcap_filename:=$(pcap_filename)

.PHONY: snort3-pcap
snort3-pcap: ## Run builder for producing snort3-image
	docker run --rm \
		-v $(pcap_dir):/root/pcaps \
		--network=host \
		--cpus=$(ncore) \
		chao123/snort3:latest \
		snort \
		-c /usr/local/etc/snort/snort.lua \
		--rule-path /usr/local/etc/rules \
		-r /root/pcaps/${pcap_filename}.pcap


.PHONY: snort3-builder
snort3-builder: ## Build snort3 docker image
	@docker build --network=host \
		--build-arg http_proxy=${HTTP_PROXY} \
		-t chao123/snort3:latest .

.PHONY: init ## Build snort3-builder and snort3 image
init:snort3-build snort3-image

.PHONY: snort3-sh
snort3-sh: ## run snort3 and shell in this container
	@docker run --rm \
		-v $(pcap_dir):/root/pcaps \
		--network=host \
		--cpus=$(ncore) \
		-it \
		chao123/snort3:latest

.PHONY: help
help: ## Show this help menu.
	@grep -E '^[a-zA-Z1-9_%-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
