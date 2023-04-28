.PHONY: help list           # Show this help
help: list
list: Makefile
	@echo "Usage: make [target]"
	@echo "Targets:"
	@sed -n -e 's/^\.PHONY: \(.\+\)/  \1/p' $<

.PHONY: start               # Start the stack
start: docker-compose.yml
	@echo "[+] Starting the stack..."
	@docker-compose up -d

.PHONY: status              # Show the status of the stack
status: docker-compose.yml
	@echo "[+] Showing status..."
	@docker-compose ps

.PHONY: stop                # Stop the stack
stop: docker-compose.yml
	@echo "[+] Stopping the stack..."
	@docker-compose down

.PHONY: restart             # Restart the stack
restart: stop start

.PHONY: log logs            # Show the logs of the stack
log: logs
logs: docker-compose.yml
	@echo "[+] Showing logs..."
	@docker-compose logs -f

.PHONY: purge prune clean   # Clean up the stack
purge: clean
prune: clean
clean: docker-compose.yml
	@echo "[+] Cleaning up..."
	@docker-compose down -v --remove-orphans
	@docker-compose rm -f -s -v