# =============================================================================
# Makefile — Common project commands
#
# Run `make` or `make help` to see all available commands.
# Add your project-specific commands at the bottom.
# =============================================================================

.DEFAULT_GOAL := help
.PHONY: help setup lint fmt test clean

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

setup: ## Install dependencies / set up the project
	@echo "No setup configured yet."
	@echo "Add your install commands here (e.g. npm install, pip install -e '.[dev]')"

lint: ## Run all linters
	@echo "--- Markdown ---"
	@command -v markdownlint-cli2 >/dev/null 2>&1 \
		&& markdownlint-cli2 "**/*.md" \
		|| echo "markdownlint-cli2 not installed (npm install -g markdownlint-cli2)"
	@echo "--- YAML ---"
	@command -v yamllint >/dev/null 2>&1 \
		&& yamllint . \
		|| echo "yamllint not installed (pip install yamllint)"
	@echo "Add your project linters here (eslint, ruff, etc.)"

fmt: ## Auto-format code
	@echo "No formatter configured yet."
	@echo "Add your formatter here (e.g. prettier --write ., black .)"

test: ## Run tests
	@echo "No tests configured yet."
	@echo "Add your test command here (e.g. npm test, pytest, go test ./...)"

clean: ## Remove build artifacts
	@echo "No clean targets configured yet."
	@echo "Add directories to remove here (e.g. rm -rf dist/ build/)"

# =============================================================================
# Add project-specific commands below this line
# =============================================================================
