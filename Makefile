
## Print help
help:
	@echo "$$(tput setaf 2)Usage$$(tput sgr0)";sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## /---/;td" -e"s/:.*//;G;s/\\n## /===/;s/\\n//g;p;}" ${MAKEFILE_LIST}|awk -F === -v n=$$(tput cols) -v i=4 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"  '$$(tput setaf 2)make$$(tput sgr0)' %s%s%s\t",a,$$1,z;m=split($$2,w,"---");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;}printf"%*s%s\n",-i," ",w[j];}}' | column -ts $$'\t'
.PHONY: help

# Variables
tapctl := bin/tapctl.py $(if $(verbose),--verbose)

## Synchronize formulas
sync:
	@$(tapctl) sync
.PHONY: sync

## Synchronize formulas with force
sync-force:
	@$(tapctl) sync --force
.PHONY: sync-force
