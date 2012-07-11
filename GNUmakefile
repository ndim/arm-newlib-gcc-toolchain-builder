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

.PHONY: uninstall
uninstall:
	@source ./environ.sh; set +x; \
	echo "Are you sure? Enter 'YES' to run 'rm -rf $$BOOT_PREFIX $$REAL_PREFIX'."; \
	read answer; \
	if test "$$answer" = "YES"; then \
		set -x; \
		rm -rf "$$BOOT_PREFIX" "$$REAL_PREFIX"; \
	else \
		echo "Aborted uninstall."; \
	fi
