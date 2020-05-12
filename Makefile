# Needed SHELL since I'm using zsh
SHELL := /bin/bash

.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: lint
lint: ### Lint project using clippy
	cargo clippy

.PHONY: clean
clean: ### Clean up project artifacts
	cargo clean

.PHONY: build
build: ### Build NPM package
	wasm-pack build tinysearch --target nodejs

.PHONY: install
install: ## Install tinysearch
	cargo install --force --path bin 

.PHONY: test
test: ## Run unittests
	cargo test

.PHONY: run
run: ## Run tinysearch with sample input
	cargo run -- fixtures/index.json

.PHONY: pack
pack: ## create a tar of the NPM package but don't publish!
	wasm-pack pack

.PHONY: publish
publish: pack ## Publish tinysearch to NPM
	wasm-pack publish
