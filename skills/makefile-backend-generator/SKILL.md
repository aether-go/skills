---
name: makefile-backend-generator
description: Use when creating or refactoring Makefiles for Go projects (CLI, backend, or fullstack) with modular templates and project type support
---

# Makefile Generator (Backend/CLI/Fullstack)

## Overview
Generate comprehensive Makefiles for Go projects (CLI, backend, or fullstack) with modular templates. Creates production-ready Makefiles with build, test, deployment, database operations, and development workflows tailored to project type.

## When to Use

### Project Type Selection
```
Need Makefile? ───────────────────────┐
                                      │
Select project type:                  │
  --type=cli     (CLI tools)          │
  --type=backend (Backend services)   ├─► Use makefile-backend-generator
  --type=fullstack (Fullstack apps)   │
                                      │
Production-ready/modular patterns? ─────────────┘
```

**Use when:**
- Starting new Go project (CLI, backend, or fullstack)
- Refactoring existing project's Makefile
- Need consistent build/deployment workflows
- Want modular Makefile organization by project type
- Need cross-platform compilation support
- Require project-type-specific features (CLI helpers, database ops, etc.)

**Don't use when:**
- Frontend-only projects (no Go backend)
- Projects with established Makefile conventions you want to keep
- Non-Go projects

## Project Type Support

This skill now supports multiple project types via the `--type` parameter:

### `--type=cli` (CLI Tools)
- Version injection into `internal/version` package
- Multi-platform builds with Windows .exe support
- CLI-specific test helpers and utilities
- Shell completion generation targets
- Binary distribution packaging

### `--type=backend` (Backend Services)
- Version injection into `pkg/version` package  
- Database migration/backup/restore operations
- Deployment targets (dev/staging/production)
- Swagger documentation generation
- Service health checks and monitoring

### `--type=fullstack` (Fullstack Applications)
- Combined backend and frontend build targets
- Coordinated deployment workflows
- Asset compilation and bundling
- Environment configuration management

### Default Behavior
If no `--type` specified, defaults to `--type=backend` for backward compatibility.

## Core Pattern

### Production-Ready Makefile Structure

Production-ready Makefiles follow a logical grouping with clear sections:

```makefile
# ========== Section 1: Variables ==========
# Project metadata, paths, tool definitions

# ========== Section 2: Build Targets ==========
# Compilation, cross-platform builds, releases

# ========== Section 3: Test Targets ==========
# Unit, integration, performance tests

# ========== Section 4: Deployment ==========
# Environment-specific deployment

# ========== Section 5: Database ==========
# Migrations, backups, restoration

# ========== Section 6: Development ==========
# Dev servers, dependency management

# ========== Section 7: Tools ==========
# Linting, formatting, code analysis

# ========== Section 8: Cross-Platform ==========
# Multi-architecture builds

# ========== Section 9: Help ==========
# Auto-generated help from comments
```

### Key Production-Ready Features Missing in Baseline

From baseline testing, these production-ready features are often missing:

1. **Auto-generated help** from `##` comments vs hardcoded help
2. **Complete cross-platform builds** with UPX compression
3. **Deployment targets** (dev/staging/prod)
4. **Database backup/restore** operations
5. **Code statistics** (cloc target)
6. **Proper version injection** into packages vs main
7. **Development tool installation** (install-deps)
8. **Clear section organization** with visual separators

## Quick Reference

### Essential Targets

| Target | Purpose | Production-Ready Pattern |
|--------|---------|----------------|
| `build` | Build backend binary | Uses `CGO_ENABLED=0`, injects version into package |
| `test` | Run all tests | Separate targets for unit/integration/e2e |
| `lint` | Code quality check | Runs golangci-lint |
| `dev` | Start development server | Backend-only (`dev-backend`) |
| `deploy-dev` | Deploy to development | Calls deployment scripts |
| `db-migrate` | Run migrations | Uses migration scripts |
| `cross-build` | Cross-platform builds | Supports multiple OS/arch with UPX |
| `clean` | Clean build artifacts | Comprehensive cleanup |
| `help` | Show help | Auto-generated from `##` comments |

### Critical Variables

```makefile
# Project identification
APP_NAME := myapp
GO_MODULE := github.com/user/myapp

# Version information (git-based)
VERSION := $(shell git describe --tags --always --dirty)
BUILD_TIME := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
COMMIT_HASH := $(shell git rev-parse --short HEAD)

# Cross-platform compilation
PLATFORMS = linux/amd64 linux/arm64 darwin/amd64 windows/amd64
```

## Implementation

### Modular Template System

This skill now provides modular Makefile templates for different project types. Each template follows production-ready pattern but is customized for specific needs.

#### Template Selection
- **CLI Template** (`--type=cli`): Optimized for command-line tools
- **Backend Template** (`--type=backend`): Optimized for backend services (default)
- **Fullstack Template** (`--type=fullstack`): Optimized for fullstack applications

####### CLI Makefile Template
```makefile
# CLI Makefile (production-ready pattern)
# ===========================================

# Project variables
APP_NAME := mycli
GO_MODULE := github.com/user/mycli

# Version information (git-based with fallbacks)
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "v0.0.0-dev")
BUILD_TIME := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
COMMIT_HASH := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
BUILD_TYPE := $(if $(findstring dirty,$(VERSION)),dev,$(if $(findstring -,$(VERSION)),dev,release))

# Cross-platform compilation targets
PLATFORMS := \
	linux/amd64 \
	linux/arm64 \
	linux/386 \
	darwin/amd64 \
	darwin/arm64 \
	windows/amd64 \
	windows/386

# Version injection path (CLI-specific)
VERSION_PACKAGE := $(GO_MODULE)/internal/version

# LDFLAGS for version injection
LDFLAGS := -X $(VERSION_PACKAGE).Version=$(VERSION) \
		   -X $(VERSION_PACKAGE).BuildTime=$(BUILD_TIME) \
		   -X $(VERSION_PACKAGE).Commit=$(COMMIT_HASH) \
		   -X $(VERSION_PACKAGE).BuildType=$(BUILD_TYPE)

# ========== Build Targets ==========

## Build CLI for current platform
build:
	@echo "Building $(APP_NAME)..."
	CGO_ENABLED=0 go build \
		-ldflags "$(LDFLAGS)" \
		-o bin/$(APP_NAME) .

## Build for all platforms
build-all: clean
	@echo "Building for all platforms..."
	@for platform in $(PLATFORMS); do \
		os=$$(echo $$platform | cut -d'/' -f1); \
		arch=$$(echo $$platform | cut -d'/' -f2); \
		output=dist/$$os-$$arch/$(APP_NAME); \
		ext=""; \
		if [ $$os = "windows" ]; then ext=".exe"; fi; \
		echo "Building $$os/$$arch..."; \
		mkdir -p dist/$$os-$$arch; \
		CGO_ENABLED=0 GOOS=$$os GOARCH=$$arch go build \
			-ldflags "$(LDFLAGS)" \
			-o $$output$$ext .; \
	done

# ========== Test Targets ==========

## Run all tests
test:
	@echo "Running tests..."
	go test ./... -v

## Run unit tests
test-unit:
	@echo "Running unit tests..."
	go test ./... -v -short

## Run integration tests  
test-integration:
	@echo "Running integration tests..."
	go test ./... -v -tags=integration

## Run CLI-specific tests
test-cli:
	@echo "Running CLI tests..."
	cd tests/cli && go test ./... -v

# ========== Development Targets ==========

## Install development dependencies
install-deps:
	@echo "Installing development dependencies..."
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install github.com/spf13/cobra-cli@latest

## Generate shell completions
completion:
	@echo "Generating shell completions..."
	mkdir -p completions
	go run . completion bash > completions/$(APP_NAME).bash
	go run . completion zsh > completions/$(APP_NAME).zsh
	go run . completion fish > completions/$(APP_NAME).fish
	go run . completion powershell > completions/$(APP_NAME).ps1

## Run linter
lint:
	@echo "Running code check..."
	golangci-lint run

## Format code
format:
	@echo "Formatting code..."
	go fmt ./...

## Clean build artifacts
clean:
	@echo "Cleaning build files..."
	rm -rf bin
	rm -rf dist
	rm -rf completions

## Show version information
version:
	@echo "Version: $(VERSION)"
	@echo "Build time: $(BUILD_TIME)"
	@echo "Commit hash: $(COMMIT_HASH)"

## Create release packages
release: build-all
	@echo "Creating release packages..."
	@for platform in $(PLATFORMS); do \
		os=$$(echo $$platform | cut -d'/' -f1); \
		arch=$$(echo $$platform | cut -d'/' -f2); \
		dir=dist/$$os-$$arch; \
		name=$(APP_NAME); \
		if [ $$os = "windows" ]; then name=$${name}.exe; fi; \
		tar -czf dist/$(APP_NAME)-$(VERSION)-$$os-$$arch.tar.gz -C $$dir $$name; \
		echo "Created: dist/$(APP_NAME)-$(VERSION)-$$os-$$arch.tar.gz"; \
	done

# ========== Default Target ==========
.PHONY: all
all: build

# ========== Help ==========
.PHONY: help
help:
	@printf "\033[36mUsage: make [target]\033[0m\n"
	@echo ""
	@printf "\033[36mTargets:\033[0m\n"
	@awk '/^[a-zA-Z\-_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  \033[33m%-20s\033[0m %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
```

####### Backend Makefile Template
```makefile
# Backend Makefile (production-ready pattern)
# ===========================================

# Project variables
APP_NAME := myapp
GO_MODULE := github.com/user/myapp

# Version information (git-based)
VERSION := $(shell git describe --tags --always --dirty)
BUILD_TIME := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
COMMIT_HASH := $(shell git rev-parse --short HEAD)

# Cross-platform compilation targets
PLATFORMS = linux/amd64 linux/arm64 darwin/amd64 windows/amd64
TEMP = $(subst /, ,$@)
OS = $(word 1, $(TEMP))
ARCH = $(word 2, $(TEMP))

# UPX compression tool
UPX = $(shell which upx)

# Version injection path (Backend-specific)
VERSION_PACKAGE := $(GO_MODULE)/pkg/version

# LDFLAGS for version injection
LDFLAGS := -X $(VERSION_PACKAGE).Version=$(VERSION) \
		   -X $(VERSION_PACKAGE).BuildTime=$(BUILD_TIME) \
		   -X $(VERSION_PACKAGE).Commit=$(COMMIT_HASH)

# ========== Build Targets ==========

## Build backend
build-backend:
	@echo "Building backend..."
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
		-ldflags "$(LDFLAGS)" \
		-o bin/$(APP_NAME) .

## Build all components
build: build-backend

# ========== Test Targets ==========

## Run all tests
test:
	@echo "Running tests..."
	go test ./... -v

## Run unit tests
test-unit:
	@echo "Running unit tests..."
	go test ./... -v

## Run integration tests
test-integration:
	@echo "Running integration tests..."
	cd tests/integration && go test ./... -v

## Run performance tests
test-performance:
	@echo "Running performance tests..."
	cd tests/performance && go test ./... -v

# ========== Deployment Targets ==========

## Deploy to development environment
deploy-dev:
	@echo "Deploying to development environment..."
	./scripts/deploy/deploy-dev.sh

## Deploy to staging environment
deploy-staging:
	@echo "Deploying to staging environment..."
	./scripts/deploy/deploy-staging.sh

## Deploy to production environment
deploy-prod:
	@echo "Deploying to production environment..."
	./scripts/deploy/deploy-prod.sh

# ========== Database Targets ==========

## Run database migrations
db-migrate:
	@echo "Running database migrations..."
	./scripts/database/migrate.sh

## Create database backup
db-backup:
	@echo "Creating database backup..."
	./scripts/database/backup.sh

## Restore database from backup
db-restore:
	@echo "Restoring database from backup..."
	./scripts/database/restore.sh

# ========== Development Targets ==========

## Start development server
dev-backend:
	@echo "Starting backend development server..."
	go run . daemon

## Update dependencies
update:
	@echo "Updating dependencies..."
	go get -u && go mod tidy

# ========== Tool Targets ==========

## Run code check
lint:
	@echo "Running Go code check..."
	golangci-lint run

## Format code
format:
	@echo "Formatting code..."
	go fmt ./...

## Clean build artifacts
clean:
	@echo "Cleaning build files..."
	rm -rf bin
	rm -rf dist
	find . -name "*.log" -delete

## Install development dependencies
install-deps:
	@echo "Installing development dependencies..."
	go install github.com/air-verse/air@latest
	go install github.com/swaggo/swag/cmd/swag@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

## Show version information
version:
	@echo "Version: $(VERSION)"
	@echo "Build time: $(BUILD_TIME)"
	@echo "Commit hash: $(COMMIT_HASH)"

## Generate Swagger documentation
swagger:
	@echo "Generating Swagger documentation..."
	swag init -g main.go -o api/swagger

## Count code lines
cloc:
	@echo "Go code line count (sorted by lines):"
	@echo ""
	@echo "Lines | File"
	@echo "----- | ----"
	@find . -name "*.go" -type f \
		-not -path "./vendor/*" \
		-not -path "./docs/*" \
		| while read file; do \
			lines=$$(wc -l < "$$file"); \
			echo "$$lines $$file"; \
		done \
		| sort -nr \
		| awk '{printf "%5d | %s\n", $$1, $$2}'

# ========== Cross-Platform Build ==========

## Cross-platform build target
$(PLATFORMS):
	@echo "Building for $(OS)/$(ARCH)..."
	CGO_ENABLED=0 GOOS=$(OS) GOARCH=$(ARCH) go build \
		-ldflags "$(LDFLAGS)" \
		-o dist/$(OS)-$(ARCH)/$(APP_NAME) .
ifneq ($(UPX),)
	@echo "Compressing binary with upx..."
	$(UPX) -9 dist/$(OS)-$(ARCH)/$(APP_NAME)
else
	@echo "Warning: upx not found, skipping compression"
endif

## Cross-build for all platforms
cross-build: $(PLATFORMS)

## Create release packages
release: cross-build
	@echo "Copying config files to release directory..."
	mkdir -p dist/linux-amd64/configs
	mkdir -p dist/linux-arm64/configs
	cp configs/*.yaml dist/linux-amd64/configs/
	cp configs/*.yaml dist/linux-arm64/configs/
	tar -czvf dist/$(APP_NAME)-$(VERSION)-linux-amd64.tar.gz -C dist/linux-amd64 $(APP_NAME) configs/
	tar -czvf dist/$(APP_NAME)-$(VERSION)-linux-arm64.tar.gz -C dist/linux-arm64 $(APP_NAME) configs/

# ========== Default Target ==========
.PHONY: all
all: build-backend

# ========== Help ==========
.PHONY: help
help:
	@printf "\033[36mUsage: make [target]\033[0m\n"
	@echo ""
	@printf "\033[36mTargets:\033[0m\n"
	@awk '/^[a-zA-Z\-_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  \033[33m%-20s\033[0m %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
```

### Fullstack Template Notes

The fullstack template combines CLI and backend features with additional frontend targets:

```makefile
# Key additions for fullstack projects:

## Frontend build targets
build-frontend:
	@echo "Building frontend..."
	cd frontend && npm run build

## Combined build
build: build-backend build-frontend

## Development with hot reload
dev: dev-backend dev-frontend

dev-frontend:
	@echo "Starting frontend development server..."
	cd frontend && npm run dev

## Asset compilation
assets:
	@echo "Compiling assets..."
	cd frontend && npm run build:assets
```

### Template Usage Instructions

1. **Select template type** based on your project:
   - CLI tools: Use CLI template
   - Backend services: Use Backend template  
   - Fullstack apps: Use Backend template + add frontend targets

2. **Customize variables**:
   - `APP_NAME`: Your application name
   - `GO_MODULE`: Your Go module path
   - `VERSION_PACKAGE`: Adjust based on your project structure

3. **Add project-specific targets** as needed

4. **Keep the modular structure** - add new targets in appropriate sections

### Template Adaptation Guidelines

#### 1. **Select Appropriate Template**
Choose the template that matches your project type:
- **CLI projects**: Use CLI template (version in `internal/version`)
- **Backend services**: Use Backend template (version in `pkg/version`)  
- **Fullstack apps**: Use Backend template + add frontend targets

#### 2. **Customize Core Variables**
Replace these placeholders in your chosen template:

```makefile
# Project identification
APP_NAME := myapp                    # Your application name
GO_MODULE := github.com/user/myapp   # Your Go module path

# Version injection path (adjust based on template)
VERSION_PACKAGE := $(GO_MODULE)/internal/version   # For CLI
# OR
VERSION_PACKAGE := $(GO_MODULE)/pkg/version        # For Backend
```

#### 3. **Adjust Platform Support**
Modify `PLATFORMS` based on your target deployment environments:

```makefile
# Default platforms (adjust as needed)
PLATFORMS := \
	linux/amd64 \
	linux/arm64 \
	darwin/amd64 \
	darwin/arm64 \
	windows/amd64
```

#### 4. **Add Project-Specific Targets**
Extend the template with your custom needs:

```makefile
# ========== Custom Targets ==========

## Your custom build step
custom-build:
	@echo "Running custom build..."
	# Your commands here

## Environment-specific configuration  
deploy-custom:
	@echo "Deploying to custom environment..."
	./scripts/deploy-custom.sh
```

#### 5. **Script Organization**
For complex commands, create scripts instead of inline shell:

```bash
# Instead of:
# deploy-prod:
# 	@complex command here

# Create: scripts/deploy/prod.sh
# Then:
deploy-prod:
	./scripts/deploy/prod.sh
```

### Quick Start Templates

#### Minimal CLI Makefile
```makefile
APP_NAME := mycli
GO_MODULE := github.com/user/mycli
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "v0.0.0-dev")

.PHONY: build test clean help

build:
	CGO_ENABLED=0 go build -o bin/$(APP_NAME) .

test:
	go test ./... -v

clean:
	rm -rf bin

help:
	@echo "Available targets: build, test, clean"
```

#### Minimal Backend Makefile  
```makefile
APP_NAME := myapp
GO_MODULE := github.com/user/myapp
VERSION := $(shell git describe --tags --always --dirty)

.PHONY: build test lint clean help

build:
	CGO_ENABLED=0 go build -o bin/$(APP_NAME) .

test:
	go test ./... -v

lint:
	golangci-lint run

clean:
	rm -rf bin

help:
	@echo "Available targets: build, test, lint, clean"
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Hardcoded help messages | Maintenance burden, inconsistency | Use auto-generated help from `##` comments |
| Missing version injection | No version info in binaries | Use `-ldflags` with package variables |
| No cross-platform support | Limited deployment options | Implement `PLATFORMS` pattern |
| Inline complex commands | Hard to read/maintain | Move to scripts, use variables |
| No database operations | Manual migration/backup pain | Add `db-migrate`, `db-backup` targets |
| Missing development tools | Inconsistent dev environment | Add `install-deps` target |
| Poor organization | Hard to navigate | Use clear section comments |
| No cleanup targets | Accumulated build artifacts | Add comprehensive `clean` target |

### Rationalization Table

From baseline testing, these are common excuses for skipping production-ready patterns:

| Excuse | Reality | Fix |
|--------|---------|-----|
| "Hardcoded help is simpler" | Hard to maintain, becomes inconsistent | Auto-generated help updates automatically |
| "I don't need cross-platform builds" | Future deployment needs change | `PLATFORMS` pattern costs little, provides big flexibility |
| "Database ops can be done manually" | Error-prone, not reproducible | Scripts ensure consistency and documentation |
| "Version injection is too complex" | Essential for debugging production issues | Template provides ready-to-use pattern |
| "I'll add deployment targets later" | Often forgotten until urgent need | Include now, even if simple scripts |
| "My project is simple, doesn't need this" | Projects grow; foundation matters | Start with minimal template, extend as needed |
| "I can remember the commands" | Team members can't read your mind | Makefile documents workflow for everyone |

### Red Flags

- Help messages not auto-generated from comments
- Missing `CGO_ENABLED=0` for static binaries
- Version info injected into `main` instead of dedicated package
- No separation of unit/integration/e2e tests
- Complex shell commands inline instead of in scripts
- Hardcoded paths instead of variables
- Missing deployment targets
- No database backup/restore capabilities
- Thinking "I'll add it later" for core functionality
- Using project-specific excuses to skip established patterns

## Integration with Other Skills

This skill works with:

- `go-cli-builder` - Generate CLI structure (uses this skill for Makefile generation)
- `go-backend-scaffolder` - Generate backend code structure
- `fullstack-project-setup` - Initialize complete project
- `requirements-to-code-docs` - Generate API documentation
- `go-vue-fullstack-workflow` - Coordinated fullstack development

### Example Workflows

#### CLI Project Workflow
```bash
# 1. Generate CLI structure
go-cli-builder create-project mycli-tool

# 2. Create Makefile using CLI template
makefile-backend-generator create --type=cli

# 3. Customize for CLI needs
# Edit APP_NAME and GO_MODULE variables
# Add CLI-specific test targets

# 4. Use in development
make install-deps
make build
make test-cli
make completion
```

#### Backend Project Workflow
```bash
# 1. Generate backend structure
go-backend-scaffolder create-project myapp-backend

# 2. Create Makefile using backend template
makefile-backend-generator create --type=backend

# 3. Customize for backend needs
# Edit variables at top of Makefile
# Add project-specific targets

# 4. Use in development
make install-deps
make dev-backend
make test
make lint
```

#### Fullstack Project Workflow
```bash
# 1. Initialize fullstack project
fullstack-project-setup create myapp-fullstack

# 2. Create Makefile using backend template + frontend targets
makefile-backend-generator create --type=backend
# Add frontend build targets manually

# 3. Use in development
make install-deps
make dev  # starts both backend and frontend
make test-all
```

## Real-World Impact

### Before Modular Templates

**CLI Projects:**
- Manual Makefile creation for each CLI tool
- Inconsistent version injection (`internal/version` vs `pkg/version`)
- Missing CLI-specific features (shell completion, multi-platform builds)
- Duplicate effort across projects

**Backend Projects:**
- Generic Makefiles missing backend-specific operations
- No database migration/backup targets
- Limited deployment workflow support
- Hard to maintain and extend

### After Modular Templates

**CLI Projects:**
- Standardized CLI template with `internal/version` injection
- Built-in shell completion generation
- Comprehensive multi-platform build support
- Consistent structure across all CLI tools

**Backend Projects:**
- Specialized backend template with `pkg/version` injection
- Database operations (migrations, backups, restoration)
- Complete deployment workflow (dev/staging/prod)
- Swagger documentation generation

**Fullstack Projects:**
- Combined backend + frontend build targets
- Coordinated development and deployment
- Consistent structure for mixed technology stacks

### Unified Benefits
- **Consistency**: Same patterns across project types
- **Maintainability**: Easy to update and extend
- **Productivity**: Faster project setup
- **Reliability**: Production-ready from start
- **Team Alignment**: Clear conventions for everyone

**Outcome:** Professional-grade build system tailored to project type, reduced maintenance overhead, consistent team workflow, reliable deployment process across all project types.