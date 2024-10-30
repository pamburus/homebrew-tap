# Common makefile helpers
include build/make/common.mk

# Variables
tapctl := bin/tapctl.py $(if $(verbose),--verbose)

## Synchronize formulas
.PHONY: sync
sync:
	@$(tapctl) sync

## Synchronize formulas with force
.PHONY: sync-force
sync-force:
	@$(tapctl) sync --force
