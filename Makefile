.PHONY: all
all: setup all-no-setup

.PHONY: all-no-setup
all-no-setup: lint
	@stack build --test --coverage --haddock

.PHONY: clean
clean:
	@stack clean

.PHONY: mrproper
mrproper:
	@stack purge

.PHONY: setup
setup:
	@stack setup

.PHONY: lint
lint:
	@hlint .

.PHONY: build
build: setup
	@stack build

.PHONY: test
test: setup
	@stack build --test

.PHONY: test-coverage
test-coverage: setup
	@stack build --test --coverage

.PHONY: docs
docs: setup
	@stack build --haddock

.PHONY: publish
publish: build
	@cabal sdist

.PHONY: watch
watch:
	@${MAKE} setup
	@find . -not \( -path './.stack-work*' -or -path './.git*' \) \
	| entr -cd ${MAKE} all-no-setup
