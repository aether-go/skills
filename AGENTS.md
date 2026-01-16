<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# Agent Instructions for Aether Go Skills Project

This file contains essential information for AI coding assistants working in this repository. It covers build commands, testing, code style, and project conventions.

## Build, Test, and Lint Commands

### Essential Commands (from aether-go/Makefile)

```bash
# Build all components (backend + frontend)
make build

# Build backend only  
make build-backend
# Build frontend only
make build-frontend

# Run all tests
make test
# Run backend tests only
cd .. && go test ./... -v
# Run single test
cd .. && go test ./internal/plugin/core -v -run TestNewUnifiedPluginAdapter

# Lint code
make lint
# Go lint only
cd .. && golangci-lint run

# Clean build artifacts
make clean

# Install development dependencies
make install-deps

# Development environment
make dev
```

### Go-Specific Commands

```bash
# Run tests with coverage
cd .. && go test ./... -cover

# Run benchmarks
cd .. && go test ./... -bench=.

# Build with race detection
cd .. && go test -race ./...

# Update dependencies
cd .. && go get -u && go mod tidy

# Generate Swagger docs
make swagger
```

### Skills Project Commands

```bash
# Run OpenSpec commands (from skills directory)
openspec list                  # List active changes
openspec list --specs          # List specifications
openspec show [item]           # Display change or spec
openspec validate [item]       # Validate changes or specs
openspec archive <change-id>   # Archive after deployment

# Update OpenSpec instructions
openspec update
```

## Code Style Guidelines

### Go Conventions

**Imports Order:**
1. Standard library packages
2. Third-party packages  
3. Internal/project packages

```go
import (
    "fmt"
    "os"
    
    "github.com/spf13/cobra"
    "go.uber.org/zap"
    
    "dgbic.com/aether-go/aether-go/internal/cmd"
)
```

**Formatting:**
- Use `go fmt` automatically via gofmt
- Maximum line length: 120 characters
- Use tabs for indentation (not spaces)
- Braces on same line as declaration

**Naming Conventions:**
- Packages: lowercase, single-word names
- Interfaces: `-er` suffix when appropriate (e.g., `Reader`, `Writer`)
- Methods: `PascalCase` for exported, `camelCase` for unexported
- Variables: `camelCase`, descriptive names
- Constants: `ALL_CAPS` or `CamelCase` for exported constants

**Error Handling:**
- Always handle errors, never ignore them with `_`
- Use `errors.New()` or `fmt.Errorf()` for error creation
- Wrap errors with context: `fmt.Errorf("failed to connect: %w", err)`
- Return errors early (fail-fast pattern)

**Testing:**
- Test files: `*_test.go` in same package
- Test functions: `TestXxx(t *testing.T)`
- Table-driven tests for multiple test cases
- Use subtests with `t.Run()` for complex tests

### Project Structure

```
aether-go/
├── cmd/              # Application entry points
├── internal/         # Private application code
├── pkg/             # Public libraries
├── configs/         # Configuration files
├── plugins/         # Plugin system
└── web/             # Frontend (Vue.js)
```

### TypeScript/JavaScript Conventions (Frontend)

- Use TypeScript with strict mode
- ES6+ features preferred
- Async/await over callbacks
- Functional components in Vue 3 Composition API

## OpenSpec Workflow

For significant changes, follow OpenSpec workflow:

1. **Check existing work:** `openspec spec list --long`, `openspec list`
2. **Create proposal** for new capabilities, breaking changes, or architecture shifts
3. **Skip proposal** for bug fixes, typos, formatting, dependency updates
4. **Implement approved changes** following `tasks.md` sequentially
5. **Archive changes** after deployment with `openspec archive <change-id>`

Refer to `openspec/AGENTS.md` for detailed OpenSpec instructions.

## Development Workflow

1. **Before starting:** Run `make install-deps` to install all dependencies
2. **Testing:** Run `make test` before and after changes
3. **Linting:** Run `make lint` to check code quality
4. **Building:** Run `make build` to verify compilation
5. **Commits:** Include descriptive commit messages with context

## Important Notes

- **Go Version:** 1.24.6 (specified in go.mod)
- **Module Name:** `dgbic.com/aether-go/aether-go`
- **Frontend:** Vue.js with pnpm package manager
- **Backend:** Fiber web framework with Cobra CLI
- **Database:** GORM with MySQL/PostgreSQL/SQLite support
- **Logging:** Uber Zap structured logging

## AI Assistant Rules

No Cursor rules (`.cursorrules` or `.cursor/rules/`) or Copilot instructions (`.github/copilot-instructions.md`) were found in this project. Follow the conventions in this document and refer to `openspec/AGENTS.md` for OpenSpec-specific workflows.

## Quick Reference

### Running a Single Test
```bash
cd .. && go test ./internal/plugin/core -v -run TestNewUnifiedPluginAdapter
```

### Checking Code Coverage
```bash
cd .. && go test ./... -coverprofile=coverage.out && go tool cover -html=coverage.out
```

### Updating Dependencies
```bash
cd .. && go get -u && go mod tidy
make update  # Updates frontend dependencies too
```

### Creating OpenSpec Proposals
See `openspec/AGENTS.md` for complete proposal workflow and format requirements.