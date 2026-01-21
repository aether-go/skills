---
name: makefile-backend-generator
description: Use when creating or refactoring Makefiles for Go backend projects, especially those following bitcms patterns with Fiber, GORM, and Swagger
---

# Makefile Backend Generator

## Overview
Generate comprehensive Makefiles for Go backend projects following bitcms patterns. Creates production-ready Makefiles with build, test, deployment, database operations, and development workflows.

## When to Use

```
Need Makefile? ───────────────────────┐
                                      │
Go backend project? ──────────────────├─► Use makefile-backend-generator
                                      │
Bitcms/Fiber/GORM patterns? ──────────┘
```

Use when:
- Starting new Go backend project
- Refactoring existing project's Makefile
- Need consistent build/deployment workflows
- Want bitcms-style Makefile organization
- Need cross-platform compilation support
- Require database migration/backup targets

Don't use when:
- Frontend-only projects
- Simple scripts or CLI tools
- Projects with established Makefile conventions
- Non-Go backend projects

## Core Pattern

### Bitcms Makefile Structure

Bitcms Makefiles follow a logical grouping with clear sections:

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

### Key Bitcms Features Missing in Baseline

From baseline testing, these bitcms features are often missing:

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

| Target | Purpose | Bitcms Pattern |
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

### Complete Makefile Template

```makefile
# Backend Makefile (bitcms pattern)
# ===========================================

# 定义变量
APP_NAME := myapp
GO_MODULE := github.com/user/myapp
VERSION := $(shell git describe --tags --always --dirty)
BUILD_TIME := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
COMMIT_HASH := $(shell git rev-parse --short HEAD)

# 跨平台编译目标
PLATFORMS = linux/amd64 linux/arm64 darwin/amd64 windows/amd64
TEMP = $(subst /, ,$@)
OS = $(word 1, $(TEMP))
ARCH = $(word 2, $(TEMP))

# UPX压缩工具
UPX = $(shell which upx)

# ========== 构建相关 ==========

## 构建后端
build-backend:
	@echo "Building backend..."
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
		-ldflags "-X $(GO_MODULE)/pkg/version.Version=$(VERSION) \
				  -X $(GO_MODULE)/pkg/version.BuildTime=$(BUILD_TIME) \
				  -X $(GO_MODULE)/pkg/version.Commit=$(COMMIT_HASH)" \
		-o bin/$(APP_NAME) ./cmd/server

## 构建所有组件
build: build-backend

# ========== 测试相关 ==========

## 运行所有测试
test:
	@echo "Running tests..."
	go test ./... -v

## 运行单元测试
test-unit:
	@echo "Running unit tests..."
	go test ./... -v

## 运行集成测试
test-integration:
	@echo "Running integration tests..."
	cd tests/integration && go test ./... -v

## 运行性能测试
test-performance:
	@echo "Running performance tests..."
	cd tests/performance && go test ./... -v

# ========== 部署相关 ==========

## 部署到开发环境
deploy-dev:
	@echo "Deploying to development environment..."
	./scripts/deploy/deploy-dev.sh

## 部署到预发布环境
deploy-staging:
	@echo "Deploying to staging environment..."
	./scripts/deploy/deploy-staging.sh

## 部署到生产环境
deploy-prod:
	@echo "Deploying to production environment..."
	./scripts/deploy/deploy-prod.sh

# ========== 数据库相关 ==========

## 运行数据库迁移
db-migrate:
	@echo "Running database migrations..."
	./scripts/database/migrate.sh

## 创建数据库备份
db-backup:
	@echo "Creating database backup..."
	./scripts/database/backup.sh

## 从备份恢复数据库
db-restore:
	@echo "Restoring database from backup..."
	./scripts/database/restore.sh

# ========== 开发相关 ==========

## 启动开发环境
dev-backend:
	@echo "Starting backend development server..."
	go run ./cmd/server

## 升级依赖
update:
	@echo "Updating dependencies..."
	go get -u && go mod tidy

# ========== 工具相关 ==========

## 运行代码检查
lint:
	@echo "Running Go code check..."
	golangci-lint run

## 格式化代码
format:
	@echo "Formatting code..."
	go fmt ./...

## 清理构建文件
clean:
	@echo "Cleaning build files..."
	rm -rf bin
	rm -rf dist
	find . -name "*.log" -delete

## 安装开发依赖
install-deps:
	@echo "Installing development dependencies..."
	go install github.com/air-verse/air@latest
	go install github.com/swaggo/swag/cmd/swag@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

## 显示版本信息
version:
	@echo "Version: $(VERSION)"
	@echo "Build time: $(BUILD_TIME)"
	@echo "Commit hash: $(COMMIT_HASH)"

## 生成Swagger文档
swagger:
	@echo "Generating Swagger documentation..."
	swag init -g cmd/server/main.go -o api/swagger

## 统计代码行数
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

# ========== 跨平台编译 ==========

## 跨平台编译目标
$(PLATFORMS):
	@echo "Building for $(OS)/$(ARCH)..."
	CGO_ENABLED=0 GOOS=$(OS) GOARCH=$(ARCH) go build \
		-ldflags "-X $(GO_MODULE)/pkg/version.Version=$(VERSION) \
				  -X $(GO_MODULE)/pkg/version.BuildTime=$(BUILD_TIME) \
				  -X $(GO_MODULE)/pkg/version.Commit=$(COMMIT_HASH)" \
		-o dist/$(OS)-$(ARCH)/$(APP_NAME) ./cmd/server
ifneq ($(UPX),)
	@echo "Compressing binary with upx..."
	$(UPX) -9 dist/$(OS)-$(ARCH)/$(APP_NAME)
else
	@echo "Warning: upx not found, skipping compression"
endif

## 跨平台编译所有平台
cross-build: $(PLATFORMS)

## 创建发布包
release: cross-build
	@echo "Copying config files to release directory..."
	mkdir -p dist/linux-amd64/configs
	mkdir -p dist/linux-arm64/configs
	cp configs/*.yaml dist/linux-amd64/configs/
	cp configs/*.yaml dist/linux-arm64/configs/
	tar -czvf dist/$(APP_NAME)-$(VERSION)-linux-amd64.tar.gz -C dist/linux-amd64 $(APP_NAME) configs/
	tar -czvf dist/$(APP_NAME)-$(VERSION)-linux-arm64.tar.gz -C dist/linux-arm64 $(APP_NAME) configs/

# ========== 默认目标 ==========
.PHONY: all
all: build-backend

# ========== 帮助信息 ==========
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

### Adaptation Guidelines

1. **Replace placeholders**:
   - `APP_NAME` → Your application name
   - `GO_MODULE` → Your Go module path
   - Update `cmd/server` to your main package path

2. **Customize for your project**:
   - Add/remove platforms in `PLATFORMS`
   - Modify deployment scripts paths
   - Adjust database migration commands

3. **Add project-specific targets**:
   - Custom build steps
   - Additional test suites
   - Environment-specific configurations

### Minimal Viable Makefile

For simpler projects, this core structure is essential:

```makefile
APP_NAME := myapp
GO_MODULE := github.com/user/myapp
VERSION := $(shell git describe --tags --always --dirty)

.PHONY: build test lint clean help

build:
	CGO_ENABLED=0 go build -o bin/$(APP_NAME) ./cmd/server

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

From baseline testing, these are common excuses for skipping bitcms patterns:

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

- `go-backend-scaffolder` - Generate backend code structure
- `fullstack-project-setup` - Initialize complete project
- `requirements-to-code-docs` - Generate API documentation
- `go-vue-fullstack-workflow` - Coordinated fullstack development

### Example Workflow

```bash
# 1. Generate backend structure
go-backend-scaffolder create-project myapp-backend

# 2. Create Makefile using bitcms patterns
makefile-backend-generator create

# 3. Customize for project needs
# Edit variables at top of Makefile
# Add project-specific targets

# 4. Use in development
make install-deps
make dev-backend
make test
make lint
```

## Real-World Impact

**Before (Generic Makefile):**
- Inconsistent target naming
- Missing critical operations (deployment, db backup)
- No version information in binaries
- Hard to navigate and maintain
- Limited cross-platform support

**After (Bitcms Pattern):**
- Consistent, organized structure
- Complete development workflow
- Production-ready deployment targets
- Versioned binaries with git metadata
- Easy maintenance and extension
- Multi-platform distribution support

**Outcome:** Professional-grade build system, reduced maintenance overhead, consistent team workflow, reliable deployment process.