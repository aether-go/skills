---
name: fullstack-project-setup
description: Use when initializing complete Go + Vue + Quasar fullstack projects with production-ready structure
---

# Fullstack Project Setup

## Overview
Initialize complete Go + Vue + Quasar fullstack projects following production-ready structure. Creates production-ready project with monorepo setup, Docker configuration, CI/CD pipelines, and development environment.

## When to Use

```
Starting new project? ───────────┐
                                 │
Go + Vue fullstack? ──────────────┤
                                 ├─► Use fullstack-project-setup
Production ready setup? ──────────┤
                                 │
Production-ready structure? ────────────────┘
```

Use when:
- Starting new fullstack application
- Need complete development environment
- Want Docker and deployment configuration
- Need CI/CD pipeline setup
- Require monorepo structure
- Want production-ready-inspired architecture
- Need production-ready configuration from day one

Don't use when:
- Adding features to existing project (use specific scaffolder skills)
- Backend-only or frontend-only projects
- Simple prototypes
- Different technology stack
- Already have established project structure

## Core Pattern

### Project Structure (Production-Ready Pattern)

```
myapp/
├── backend/                      # Go backend application
│   ├── main.go                  # Application entry point
│   ├── internal/
│   │   ├── app/
│   │   ├── application/
│   │   ├── domain/
│   │   ├── infrastructure/
│   │   ├── interfaces/
│   │   ├── middleware/
│   │   ├── models/
│   │   ├── pkg/
│   │   ├── repositories/
│   │   ├── router/
│   │   └── services/
│   ├── api/
│   ├── configs/
│   ├── migrations/
│   ├── scripts/
│   ├── tests/
│   └── web/
├── frontend/                     # Vue + Quasar frontend
│   ├── src/
│   │   ├── api/
│   │   ├── assets/
│   │   ├── components/
│   │   ├── composables/
│   │   ├── layouts/
│   │   ├── pages/
│   │   ├── router/
│   │   ├── services/
│   │   ├── stores/
│   │   ├── theme/
│   │   └── utils/
│   ├── public/
│   └── tests/
├── docker/                       # Docker configuration
│   ├── backend/
│   │   └── Dockerfile
│   ├── frontend/
│   │   └── Dockerfile
│   └── docker-compose.yml
├── docs/                         # Project documentation
│   ├── 01-schedule/
│   ├── 02-requirements/
│   ├── 03-usecases/
│   ├── 04-realize/
│   ├── 05-prompts/
│   └── 06-manual/
├── scripts/                      # Build and deployment scripts
├── deploy/                       # Deployment configurations
├── tests/                        # Integration and e2e tests
├── .github/                      # GitHub workflows
├── Makefile                      # Project make commands
├── docker-compose.yml            # Development environment
├── .env.example                  # Environment variables
└── README.md                     # Project documentation
```

### Before (Manual Project Setup)
```
myapp/
├── server.js                    # Everything in one file
├── package.json
└── public/
    └── index.html
```

### After (Production-Ready Fullstack Structure)
```
myapp/
├── backend/                     # Production-ready Go backend
│   ├── clean architecture
│   ├── comprehensive testing
│   ├── structured logging
│   └── API documentation
├── frontend/                    # Production-ready Vue frontend
│   ├── TypeScript with strict mode
│   ├── Quasar UI framework
│   ├── Pinia state management
│   └── Component library
├── docker/                      # Containerization
├── ci-cd/                       # Automated pipelines
├── monitoring/                  # Observability
└── documentation/               # Complete docs
```

## Quick Reference

### Project Initialization Commands

| Command | Description | Output |
|---------|-------------|--------|
| `fullstack-project-setup create myapp` | Create new fullstack project | Complete project structure |
| `fullstack-project-setup add-service auth` | Add new microservice | New service with full setup |
| `fullstack-project-setup configure docker` | Configure Docker setup | Dockerfiles + compose |
| `fullstack-project-setup configure ci` | Configure CI/CD | GitHub Actions workflows |
| `fullstack-project-setup configure monitoring` | Configure monitoring | Prometheus + Grafana |
| `fullstack-project-setup add-docs` | Add documentation structure | Complete docs directory |

### Essential Templates

#### 1. Makefile Template
```makefile
# Makefile - Project build and development commands
.PHONY: help build test lint clean dev docker

# Default target
help:
	@echo "Available commands:"
	@echo "  make dev        - Start development environment"
	@echo "  make build      - Build all components"
	@echo "  make test       - Run all tests"
	@echo "  make lint       - Lint all code"
	@echo "  make docker     - Build Docker images"
	@echo "  make deploy     - Deploy to staging"
	@echo "  make clean      - Clean build artifacts"

# Development
dev: dev-backend dev-frontend

dev-backend:
	@echo "Starting backend development server..."
	cd backend && go run . daemon

dev-frontend:
	@echo "Starting frontend development server..."
	cd frontend && pnpm dev

# Build
build: build-backend build-frontend

build-backend:
	@echo "Building backend..."
	cd backend && go build -o ./bin/myapp .

build-frontend:
	@echo "Building frontend..."
	cd frontend && pnpm build

# Testing
test: test-backend test-frontend

test-backend:
	@echo "Running backend tests..."
	cd backend && go test ./... -v

test-frontend:
	@echo "Running frontend tests..."
	cd frontend && pnpm test

# Linting
lint: lint-backend lint-frontend

lint-backend:
	@echo "Linting backend..."
	cd backend && golangci-lint run

lint-frontend:
	@echo "Linting frontend..."
	cd frontend && pnpm lint

# Docker
docker: docker-backend docker-frontend

docker-backend:
	@echo "Building backend Docker image..."
	docker build -t myapp-backend:latest -f docker/backend/Dockerfile .

docker-frontend:
	@echo "Building frontend Docker image..."
	docker build -t myapp-frontend:latest -f docker/frontend/Dockerfile .

# Deployment
deploy: docker
	@echo "Deploying to staging..."
	docker-compose -f docker/docker-compose.prod.yml up -d

# Cleanup
clean:
	@echo "Cleaning build artifacts..."
	rm -rf backend/bin
	rm -rf frontend/dist
	rm -rf frontend/node_modules
	find . -name "coverage.out" -delete
	find . -name "*.log" -delete
```

#### 2. Docker Compose Template
```yaml
# docker-compose.yml - Development environment
version: '3.8'

services:
  # PostgreSQL database
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: myapp_user
      POSTGRES_PASSWORD: myapp_password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U myapp_user"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Redis cache
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    command: redis-server --appendonly yes

  # Backend API
  backend:
    build:
      context: ./backend
      dockerfile: ../docker/backend/Dockerfile.dev
    ports:
      - "8080:8080"
    environment:
      DB_HOST: postgres
      DB_PORT: 5432
      DB_NAME: myapp
      DB_USER: myapp_user
      DB_PASSWORD: myapp_password
      REDIS_HOST: redis
      REDIS_PORT: 6379
    volumes:
      - ./backend:/app
      - go_modules:/go/pkg/mod
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_started
    command: air -c .air.toml

  # Frontend application
  frontend:
    build:
      context: ./frontend
      dockerfile: ../docker/frontend/Dockerfile.dev
    ports:
      - "3000:3000"
    environment:
      VITE_API_URL: http://localhost:8080
    volumes:
      - ./frontend:/app
      - node_modules:/app/node_modules
    depends_on:
      - backend

  # Nginx reverse proxy (optional)
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - backend
      - frontend

volumes:
  postgres_data:
  redis_data:
  go_modules:
  node_modules:
```

#### 3. Environment Configuration Template
```yaml
# configs/config.yaml - Backend configuration
app:
  name: "MyApp"
  version: "1.0.0"
  env: "development"

server:
  host: "0.0.0.0"
  port: "8080"
  read_timeout: "30s"
  write_timeout: "30s"
  idle_timeout: "120s"
  graceful_shutdown_timeout: "10s"

database:
  driver: "postgres"
  host: "localhost"
  port: 5432
  name: "myapp"
  user: "myapp_user"
  password: "myapp_password"
  ssl_mode: "disable"
  max_open_conns: 25
  max_idle_conns: 5
  conn_max_lifetime: "5m"

redis:
  host: "localhost"
  port: 6379
  password: ""
  db: 0
  pool_size: 10
  min_idle_conns: 2

jwt:
  secret: "your-secret-key-here-change-in-production"
  expiration: "24h"
  refresh_expiration: "168h"  # 7 days

logging:
  level: "info"
  format: "json"
  output: "stdout"

cors:
  allowed_origins:
    - "http://localhost:3000"
    - "http://localhost:8080"
  allowed_methods:
    - "GET"
    - "POST"
    - "PUT"
    - "DELETE"
    - "OPTIONS"
  allowed_headers:
    - "Content-Type"
    - "Authorization"
  allow_credentials: true
```

## Implementation

### Project Creation Workflow

```bash
# Create new fullstack project
fullstack-project-setup create myapp \
  --backend=go \
  --frontend=vue-quasar \
  --database=postgres \
  --cache=redis \
  --docker=true \
  --ci=github-actions

# Navigate to project
cd myapp

# Start development environment
make dev

# Or use Docker Compose
docker-compose up
```

### Configuration Templates

#### 1. Backend Dockerfile
```dockerfile
# docker/backend/Dockerfile
# Build stage
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache git ca-certificates tzdata

# Copy go mod files
COPY backend/go.mod backend/go.sum ./
RUN go mod download

# Copy source code
COPY backend/ ./

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /app/bin/server .

# Runtime stage
FROM alpine:3.19

WORKDIR /app

# Install runtime dependencies
RUN apk add --no-cache ca-certificates tzdata

# Create non-root user
RUN addgroup -g 1000 -S appuser && \
    adduser -u 1000 -S appuser -G appuser

# Copy binary from builder
COPY --from=builder --chown=appuser:appuser /app/bin/server ./server

# Copy configuration files
COPY --from=builder --chown=appuser:appuser /app/configs ./configs

# Switch to non-root user
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

# Expose port
EXPOSE 8080

# Run the application
CMD ["./server"]
```

#### 2. Frontend Dockerfile
```dockerfile
# docker/frontend/Dockerfile
# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy package files
COPY frontend/package.json frontend/pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY frontend/ ./

# Build the application
RUN pnpm build

# Runtime stage
FROM nginx:alpine

# Copy built files
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY docker/frontend/nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:80 || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
```

#### 3. CI/CD Pipeline Template
```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  # Backend tests
  backend:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16-alpine
        env:
          POSTGRES_DB: test_db
          POSTGRES_USER: test_user
          POSTGRES_PASSWORD: test_password
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432
      
      redis:
        image: redis:7-alpine
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 6379:6379
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Go
        uses: actions/setup-go@v5
        with:
          go-version: '1.24'
      
      - name: Run tests
        working-directory: ./backend
        run: |
          go test ./... -v -coverprofile=coverage.out
          go tool cover -func=coverage.out
      
      - name: Lint
        working-directory: ./backend
        run: |
          go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
          golangci-lint run

  # Frontend tests
  frontend:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'
          cache-dependency-path: './frontend/pnpm-lock.yaml'
      
      - name: Install pnpm
        run: npm install -g pnpm
      
      - name: Install dependencies
        working-directory: ./frontend
        run: pnpm install --frozen-lockfile
      
      - name: Type check
        working-directory: ./frontend
        run: pnpm type-check
      
      - name: Lint
        working-directory: ./frontend
        run: pnpm lint
      
      - name: Run tests
        working-directory: ./frontend
        run: pnpm test

  # Build and push Docker images
  docker:
    needs: [backend, frontend]
    runs-on: ubuntu-latest
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      
      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      
      - name: Build and push backend
        uses: docker/build-push-action@v5
        with:
          context: ./backend
          file: ./docker/backend/Dockerfile
          push: true
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/myapp-backend:latest
            ${{ secrets.DOCKER_USERNAME }}/myapp-backend:${{ github.sha }}
      
      - name: Build and push frontend
        uses: docker/build-push-action@v5
        with:
          context: ./frontend
          file: ./docker/frontend/Dockerfile
          push: true
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/myapp-frontend:latest
            ${{ secrets.DOCKER_USERNAME }}/myapp-frontend:${{ github.sha }}
```

### Development Environment Templates

#### 1. VS Code Configuration
```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "[go]": {
    "editor.defaultFormatter": "golang.go"
  },
  "[vue]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "go.formatTool": "gofumpt",
  "go.lintTool": "golangci-lint",
  "go.lintFlags": ["--fast"],
  "typescript.preferences.importModuleSpecifier": "non-relative"
}
```

#### 2. Development Tools Configuration
```toml
# backend/.air.toml - Live reload for Go
root = "."
testdata_dir = "testdata"
tmp_dir = "tmp"

[build]
  args_bin = []
  bin = "./tmp/main"
  cmd = "go build -o ./tmp/main ."
  delay = 1000
  exclude_dir = ["assets", "tmp", "vendor", "testdata"]
  exclude_file = []
  exclude_regex = ["_test.go"]
  exclude_unchanged = false
  follow_symlink = false
  full_bin = ""
  include_dir = []
  include_ext = ["go", "tpl", "tmpl", "html"]
  include_file = []
  kill_delay = "0s"
  log = "build-errors.log"
  send_interrupt = false
  stop_on_error = true

[color]
  app = ""
  build = "yellow"
  main = "magenta"
  runner = "green"
  watcher = "cyan"

[log]
  main_only = false
  time = false

[misc]
  clean_on_exit = false

[screen]
  clear_on_rebuild = false
  keep_scroll = true
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Missing environment configuration | Hard to deploy, environment-specific bugs | Use config files + env vars |
| No health checks in Docker | Kubernetes can't detect failures | Add health checks to all services |
| Hardcoded secrets | Security risk, can't rotate secrets | Use secrets management |
| Missing monitoring | Can't detect production issues | Add metrics, logs, tracing |
| No backup strategy | Data loss risk | Configure database backups |
| Single point of failure | Service downtime | Add redundancy and failover |
| Missing documentation | Hard to onboard new team members | Include comprehensive docs |
| No rollback strategy | Can't recover from failed deployments | Implement blue-green or canary |

### Red Flags

- No .env.example file
- Hardcoded database credentials
- Missing health endpoints
- No error tracking integration
- Missing CI/CD pipeline
- No test coverage reporting
- Single Docker Compose for all environments
- No documentation for deployment

## Integration with Other Skills

This skill coordinates with:
- `go-backend-scaffolder` for backend code generation
- `vue-quasar-scaffolder` for frontend code generation
- `requirements-to-code-docs` for project documentation
- `go-vue-fullstack-workflow` for development workflow

### Example Complete Workflow

```bash
# 1. Create complete project
fullstack-project-setup create ecommerce-app \
  --features="auth,products,orders,payments" \
  --database=postgres \
  --cache=redis \
  --queue=rabbitmq \
  --monitoring=prometheus+grafana

# 2. Generate domain-specific code
go-backend-scaffolder generate domain Product
go-backend-scaffolder generate crud Product
go-backend-scaffolder generate handler ProductHandler

vue-quasar-scaffolder generate crud Product
vue-quasar-scaffolder generate page Products --layout=admin

# 3. Generate documentation
requirements-to-code-docs generate api ProductAPI
requirements-to-code-docs generate docs architecture

# 4. Set up development environment
docker-compose up -d
make dev

# 5. Run tests and verify
make test
make lint
make build

# 6. Deploy to staging
make deploy staging
```

## Real-World Impact

**Before (Manual Project Setup):**
- 1-2 weeks for production-ready setup
- Inconsistent project structure
- Missing critical components
- Manual deployment process
- Poor observability
- Security vulnerabilities

**After (With Fullstack Setup):**
- 30 minutes for production-ready project
- Consistent, battle-tested structure
- All essential components included
- Automated CI/CD pipelines
- Comprehensive monitoring
- Security best practices baked in

**Outcome:** Faster time to market, higher quality, better security, easier maintenance, scalable architecture.