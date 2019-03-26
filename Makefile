## ----- TARGETS ------
__ARGS = $(filter-out $@,$(MAKECMDGOALS))

## git-secret:
.PHONY: secrets-hide secrets-reveal
secrets-hide: ## Hides modified secret files using git-secret.
	@echo "Hiding modified secret files..." && git secret hide -m $(__ARGS)
secrets-reveal: ## Reveals secret files that were hidden using git-secret.
	@echo "Revealing hidden secret files..." && git secret reveal $(__ARGS)


## HACKS:
## These targets are hacks that allow for Make targets to receive
## pseudo-arguments.
.PHONY: __FORCE
__FORCE:
%: __FORCE
	@:
