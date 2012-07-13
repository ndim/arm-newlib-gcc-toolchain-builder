.PHONY: all
all:
	@set -ex; for script in [0-9]*.sh; do bash "$$script"; done

.PHONY: clean
clean:
	rm -rf *_build *_sources
	rm -f *.*.log

.PHONY: uninstall
uninstall:
	@source ./environ.sh; set +x; \
	echo "Are you sure? Enter 'YES' to run 'rm -rf $$PREFIX_BOOT $$PREFIX_REAL'."; \
	read answer; \
	if test "$$answer" = "YES"; then \
		set -x; \
		rm -rf "$$PREFIX_BOOT" "$$PREFIX_REAL"; \
	else \
		echo "Aborted uninstall."; \
	fi
