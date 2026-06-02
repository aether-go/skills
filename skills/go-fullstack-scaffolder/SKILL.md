---
name: go-fullstack-scaffolder
description: Use when initializing a complete Go + Vue + Quasar fullstack project with production-ready structure, scaffolding, Makefile, Docker, CI/CD, and bilingual documentation. This skill unifies the fullstack development toolchain and replaces go-backend-scaffolder, go-cli-builder, vue-quasar-scaffolder, fullstack-project-setup, go-vue-fullstack-workflow, makefile-backend-generator, and readme-license-generator.
---

# Go Fullstack Scaffolder

## Overview

The unified skill for initializing complete Go fullstack projects. This skill:
- Bootstraps complete monorepo structure (Go backend + Vue frontend)
- Generates production-ready Go backend with clean architecture
- Generates Vue 3 + Quasar + TypeScript frontend
- Creates Makefile with build, test, deploy targets
- Sets up Docker, docker-compose, and CI/CD
- Generates bilingual (CN/EN) README and LICENSE

**Replaces** (consolidated from 7 skills):
- `go-backend-scaffolder`
- `go-cli-builder`
- `vue-quasar-scaffolder`
- `fullstack-project-setup`
- `go-vue-fullstack-workflow`
- `makefile-backend-generator`
- `readme-license-generator`

## When to Use

```
Starting a new Go project? ───────────────┐
                                          │
Need fullstack monorepo setup? ───────────┤
                                          │
Building Go CLI tool? ────────────────────┼─► Use go-fullstack-scaffolder
                                          │
Building Vue 3 + Quasar frontend? ────────┤
                                          │
Need Makefile / Docker / CI-CD? ──────────┘
```

Use when:
- Starting a new Go backend service
- Starting a new Go CLI application
- Building Vue 3 + Quasar frontend
- Initializing fullstack monorepo
- Need Makefile / Docker / CI/CD templates

## Project Type Selection

| Project Type | Use Case | Key Stack |
|--------------|----------|-----------|
| `backend` | REST API / gRPC service | Go + Gin + GORM + PostgreSQL + Redis |
| `cli` | Command-line tool | Go + Cobra + Viper + Zap |
| `frontend` | SPA application | Vue 3 + Quasar + TypeScript + Pinia |
| `fullstack` | Web application | Go backend + Vue frontend (monorepo) |

## Generated Project Structures

### Backend (`project_type: backend`)

```
my-service/
├── cmd/
│   └── server/
│       └── main.go
├── internal/
│   ├── domain/         # Pure business logic
│   ├── repository/     # Data access (GORM)
│   ├── service/        # Application logic
│   ├── handler/        # HTTP/gRPC handlers
│   ├── middleware/     # Cross-cutting concerns
│   └── config/         # Configuration
├── migrations/         # DB migrations
├── tests/
│   ├── unit/
│   ├── integration/
│   └── contract/
├── api/                # OpenAPI specs
├── deployments/        # K8s manifests
├── scripts/            # Build scripts
├── .github/workflows/  # CI/CD
├── Dockerfile
├── docker-compose.yml
├── Makefile
├── go.mod
├── go.sum
├── README.md
└── LICENSE
```

### CLI (`project_type: cli`)

```
my-cli/
├── cmd/
│   └── mycli/
│       └── main.go
├── internal/
│   ├── cmd/            # Cobra commands
│   ├── config/         # Viper config
│   └── logger/         # Zap logger
├── pkg/                # Public packages
├── test/
├── .github/workflows/
├── Dockerfile
├── Makefile
├── go.mod
└── README.md
```

### Frontend (`project_type: frontend`)

```
my-app/
├── src/
│   ├── pages/          # Route components
│   ├── components/     # Reusable components
│   ├── composables/    # Reusable logic
│   ├── stores/         # Pinia stores
│   ├── api/            # API clients
│   ├── types/          # TypeScript types
│   ├── router/         # Vue Router
│   ├── boot/           # Quasar boot files
│   └── layouts/        # Layouts
├── tests/
│   ├── unit/           # Vitest
│   └── e2e/            # Playwright
├── public/
├── quasar.config.js
├── package.json
├── tsconfig.json
└── README.md
```

### Fullstack (`project_type: fullstack`)

Combined monorepo with both `backend/` and `frontend/` directories, plus shared `docker-compose.yml` and CI/CD.

## Input Format

```yaml
scaffolding_request:
  project_type: "fullstack"  # backend | cli | frontend | fullstack
  project_name: "aether-platform"
  description: "E-commerce platform"
  
  backend:
    enabled: true
    language: "go"
    go_version: "1.22"
    framework: "gin"  # gin | echo | fiber | chi
    database: "postgresql"  # postgresql | mysql | mongodb
    cache: "redis"  # redis | memcached | none
    orm: "gorm"  # gorm | sqlc | sqlx
    enable_grpc: false
    enable_auth: true
    auth_method: "jwt"  # jwt | session | oauth2
  
  frontend:
    enabled: true
    language: "typescript"
    framework: "vue3-quasar"  # vue3-quasar | vue3-vite | react-vite
    ui_library: "quasar"  # quasar | element-plus | vuetify
    state_management: "pinia"
    enable_pwa: false
    enable_i18n: true
    default_locale: "en"
  
  infrastructure:
    docker: true
    docker_compose: true
    kubernetes: false
    ci_cd: "github-actions"  # github-actions | gitlab-ci | jenkins
    cloud: "aws"  # aws | gcp | azure | none
  
  documentation:
    bilingual_readme: true  # EN + CN
    license: "MIT"  # MIT | Apache-2.0 | GPL-3.0
    api_docs: "openapi"  # openapi | swagger | none
```

## Output Format

```yaml
scaffolding_result:
  project_name: "aether-platform"
  project_type: "fullstack"
  timestamp: "2026-06-02T10:00:00Z"
  
  generated_files:
    backend:
      - path: "backend/cmd/server/main.go"
        lines: 50
      - path: "backend/internal/domain/.gitkeep"
        type: "directory"
      - path: "backend/internal/handler/health.go"
        lines: 35
      - path: "backend/internal/middleware/logger.go"
        lines: 45
      - path: "backend/internal/config/config.go"
        lines: 60
      - path: "backend/migrations/.gitkeep"
        type: "directory"
      - path: "backend/go.mod"
      - path: "backend/Makefile"
        lines: 120
    frontend:
      - path: "frontend/src/layouts/MainLayout.vue"
        lines: 60
      - path: "frontend/src/pages/IndexPage.vue"
        lines: 25
      - path: "frontend/src/boot/axios.ts"
        lines: 40
      - path: "frontend/src/router/index.ts"
        lines: 35
      - path: "frontend/src/stores/index.ts"
        lines: 15
      - path: "frontend/quasar.config.js"
        lines: 80
      - path: "frontend/package.json"
      - path: "frontend/tsconfig.json"
    infrastructure:
      - path: "Dockerfile"
      - path: "docker-compose.yml"
        lines: 75
      - path: ".github/workflows/ci.yml"
        lines: 60
    documentation:
      - path: "README.md"
        language: "en"
      - path: "README_CN.md"
        language: "cn"
      - path: "LICENSE"
  
  total_files: 25
  total_lines: 850
  
  build_verification:
    backend_compiles: true
    frontend_compiles: true
    docker_builds: true
  
  next_steps:
    - "cd backend && go mod tidy"
    - "cd frontend && npm install"
    - "docker-compose up"
    - "Visit http://localhost:9000 (Quasar) or :8080 (API)"
```

## Makefile Targets

Generated Makefile includes these targets:

### Backend
```makefile
.PHONY: build test run migrate lint fmt clean docker

build:           # Build binary
test:            # Run all tests with coverage
test-unit:       # Run unit tests only
test-integration:# Run integration tests
test-contract:   # Run contract tests
run:             # Run server locally
migrate-up:      # Apply DB migrations
migrate-down:    # Rollback DB migrations
lint:            # Run linters (golangci-lint)
fmt:             # Format code
clean:           # Clean build artifacts
docker-build:    # Build Docker image
docker-run:      # Run Docker container
```

### Fullstack
```makefile
.PHONY: dev build test deploy

dev:             # Start dev environment (docker-compose)
build:           # Build both backend and frontend
test:            # Run all tests
deploy-staging:  # Deploy to staging
deploy-prod:     # Deploy to production
```

## Docker Compose Services

Generated `docker-compose.yml` includes:

```yaml
services:
  app:
    build: .
    ports: ["8080:8080"]
    depends_on: [postgres, redis]
  postgres:
    image: postgres:16
    environment:
      POSTGRES_DB: aether
      POSTGRES_USER: aether
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes: [pgdata:/var/lib/postgresql/data]
  redis:
    image: redis:7-alpine
volumes:
  pgdata:
```

## CI/CD Pipeline (GitHub Actions)

Generated `.github/workflows/ci.yml`:

```yaml
name: CI
on: [push, pull_request]
jobs:
  test-backend:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
      redis:
        image: redis:7
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-go@v5
        with: {go-version: "1.22"}
      - run: cd backend && go mod download
      - run: cd backend && make test
  
  test-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: {node-version: "20"}
      - run: cd frontend && npm ci
      - run: cd frontend && npm run test
      - run: cd frontend && npm run build
  
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: cd backend && make lint
      - run: cd frontend && npm run lint
```

## Bilingual README

Generates both English (`README.md`) and Chinese (`README_CN.md`) with:
- Project description
- Tech stack
- Quick start guide
- Development commands
- Deployment instructions
- Contributing guidelines
- License

## Implementation Notes

### Backend Scaffolding Decisions

| Component | Choice | Rationale |
|-----------|--------|-----------|
| HTTP framework | Gin | Performance, ecosystem, simplicity |
| ORM | GORM | Convention over config, good DX |
| Validation | go-playground/validator | De facto standard |
| Logging | Zap | Performance, structured logging |
| Config | Viper | 12-factor app compliance |
| Testing | go test + testify | Standard, well-documented |
| Migration | golang-migrate | Versioned, reversible |

### Frontend Scaffolding Decisions

| Component | Choice | Rationale |
|-----------|--------|-----------|
| Framework | Vue 3 + Composition API | Modern, performant |
| UI | Quasar | Comprehensive component library |
| State | Pinia | Official Vue 3 state mgmt |
| Build | Vite | Fast HMR, modern bundler |
| Type check | TypeScript | Type safety, better DX |
| Testing | Vitest + Playwright | Modern, fast, integrated |

## Validation Rules

- ✅ Project compiles (backend: `go build`, frontend: `npm run build`)
- ✅ Docker builds successfully
- ✅ CI pipeline passes
- ✅ All dependencies within P5 limit (≤5 core deps)
- ✅ Bilingual docs present

## Integration with Aether.go Methodology

- **Input from**: Project initialization request
- **Output to**:
  - `requirement-analyzer` (define requirements)
  - `architecture-planner` (design system)
  - `code-generator` (implement features)
- **Part of**: Project Support / Toolchain
- **Principle alignment**:
  - **P5 Occam's Razor**: Curated dependency choices
  - **P7 Constraint-Mechanization**: CI gates
  - **P3 Modularity-Orthogonality**: Layered structure

## Migration Notes

This skill consolidates 7 previously separate skills:
- `go-backend-scaffolder` → Backend layout
- `go-cli-builder` → CLI layout
- `vue-quasar-scaffolder` → Frontend layout
- `fullstack-project-setup` → Monorepo structure, Docker, CI
- `go-vue-fullstack-workflow` → Workflow guidance
- `makefile-backend-generator` → Makefile targets
- `readme-license-generator` → Bilingual docs

**Invocation parameters**:
- `project_type: backend` → Step 2a
- `project_type: cli` → Step 2b
- `project_type: frontend` → Step 2c
- `project_type: fullstack` → Step 2d
