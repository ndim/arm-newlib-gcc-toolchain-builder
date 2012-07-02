.PHONY: all
all:
	@set -x; for script in 0*.sh; do \
		if bash "$$script"; then \
			:; \
		else \
			exit "$$?"; \
		fi; \
	done
