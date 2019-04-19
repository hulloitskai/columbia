# ----- TARGETS ------
# Generic:
.PHONY: default setup help
__ARGS = $(filter-out $@,$(MAKECMDGOALS))

default: help
setup: # Set this project up on a new environment.
	@echo "Configuring githooks..." && \
	 git config core.hooksPath .githooks && \
	 echo done

# Show usage for the targets in this Makefile.
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | \
	 awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'


# git-secret:
.PHONY: secrets-hide secrets-reveal
secrets-hide: # Hides modified secret files using git-secret.
	@echo "Hiding modified secret files..." && git secret hide -m $(__ARGS)
secrets-reveal: # Reveals secret files that were hidden using git-secret.
	@echo "Revealing hidden secret files..." && git secret reveal $(__ARGS)


# HACKS:
# These targets are hacks that allow for Make targets to receive
# pseudo-arguments.
.PHONY: __FORCE
__FORCE:
%: __FORCE
	@:
