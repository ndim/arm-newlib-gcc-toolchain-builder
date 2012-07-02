.PHONY: all
all:
	@set -x; for script in 0*.sh; do \
		if bash "$$script"; then \
			:; \
		else \
			exit "$$?"; \
		fi; \
	done

.PHONY: clean
clean:
	rm -rf *_build *_sources
	@echo "Run the following command yourself if you want to:"
	@source ./environ.sh && echo "  " rm -rf "$$PREFIX/"
