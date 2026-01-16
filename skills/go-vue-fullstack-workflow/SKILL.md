---
name: go-vue-fullstack-workflow
description: Use when coordinating Go + Vue + Quasar fullstack development workflow with bitcms patterns and documentation
---

# Go Vue Fullstack Workflow

## Overview
Coordinate complete Go + Vue + Quasar fullstack development workflow using bitcms patterns. Guides from project initialization through requirements, development, testing, and deployment with integrated documentation.

## When to Use

```
Fullstack development? ──────────┐
                                 │
Need coordinated workflow? ───────┤
                                 ├─► Use go-vue-fullstack-workflow
Multiple skills integration? ─────┤
                                 │
End-to-end process? ──────────────┘
```

Use when:
- Starting new fullstack project from scratch
- Need guidance on development workflow
- Want to use all bitcms-inspired skills together
- Need end-to-end process from requirements to deployment
- Managing team development with standardized workflow
- Ensuring documentation and code quality throughout
- Following bitcms patterns and best practices

Don't use when:
- Working on isolated component or bug fix
- Only need single skill functionality
- Project already has established workflow
- Different technology stack

## Core Pattern

### Complete Development Workflow

```
1. Project Initialization
   ├── fullstack-project-setup create
   ├── Configure environment
   └── Set up CI/CD

2. Requirements & Documentation
   ├── requirements-to-code-docs init
   ├── Define business requirements
   ├── Create use cases
   └── Generate traceability matrix

3. Backend Development
   ├── go-backend-scaffolder generate domain
   ├── Implement services
   ├── Create API handlers
   └── Write tests

4. Frontend Development
   ├── vue-quasar-scaffolder generate components
   ├── Create pages and layouts
   ├── Implement stores and services
   └── Write tests

5. Integration & Testing
   ├── API integration
   ├── End-to-end testing
   ├── Performance testing
   └── Security testing

6. Deployment & Monitoring
   ├── Build and package
   ├── Deploy to environment
   ├── Set up monitoring
   └── Documentation deployment
```

### Before (Ad-hoc Development)
```
Day 1: Write some backend code
Day 2: Write some frontend code  
Day 3: Try to make them work together
Day 4: Fix integration issues
Day 5: Write documentation (maybe)
```

### After (Structured Workflow)
```
Week 1: Project setup & requirements
Week 2: Backend development with tests
Week 3: Frontend development with tests  
Week 4: Integration & deployment
Ongoing: Documentation & maintenance
```

## Quick Reference

### Workflow Stages and Commands

| Stage | Key Activities | Commands |
|-------|---------------|----------|
| **1. Init** | Project setup, env config | `fullstack-project-setup create`, `make init` |
| **2. Requirements** | Docs, use cases, traceability | `requirements-to-code-docs init`, `requirements-to-code-docs requirement` |
| **3. Backend** | Domain, services, API | `go-backend-scaffolder generate`, `make test-backend` |
| **4. Frontend** | Components, pages, stores | `vue-quasar-scaffolder generate`, `pnpm test` |
| **5. Integration** | API integration, E2E tests | `make dev`, `make test-e2e` |
| **6. Deployment** | Build, deploy, monitor | `make docker`, `make deploy` |

### Skill Integration Matrix

| Task | Primary Skill | Supporting Skills | Output |
|------|---------------|-------------------|--------|
| Create project | fullstack-project-setup | - | Complete project structure |
| Define requirements | requirements-to-code-docs | - | Requirements documents |
| Generate backend API | go-backend-scaffolder | requirements-to-code-docs | Go code with traceability |
| Generate frontend UI | vue-quasar-scaffolder | requirements-to-code-docs | Vue components with docs |
| API documentation | requirements-to-code-docs | go-backend-scaffolder | Auto-generated API docs |
| Testing setup | fullstack-project-setup | go-backend-scaffolder, vue-quasar-scaffolder | Test configuration |
| Deployment | fullstack-project-setup | - | Docker + CI/CD config |

## Implementation

### Complete Workflow Example

#### Phase 1: Project Initialization (Week 1)
```bash
# Step 1: Create project with all components
fullstack-project-setup create ecommerce-platform \
  --backend=go \
  --frontend=vue-quasar \
  --database=postgres \
  --cache=redis \
  --queue=rabbitmq \
  --monitoring=prometheus+grafana+loki \
  --ci=github-actions \
  --deploy=k8s

# Step 2: Navigate to project
cd ecommerce-platform

# Step 3: Initialize documentation
requirements-to-code-docs init \
  --project="Ecommerce Platform" \
  --template="bitcms" \
  --sections="all"

# Step 4: Set up development environment
make init
docker-compose up -d postgres redis
```

#### Phase 2: Requirements & Planning (Week 1)
```bash
# Step 1: Create business requirements
requirements-to-code-docs requirement "Product Catalog" \
  --category="functional" \
  --priority="high" \
  --stakeholders="product,business,engineering"

requirements-to-code-docs requirement "Shopping Cart" \
  --category="functional" \
  --priority="high"

requirements-to-code-docs requirement "Order Management" \
  --category="functional" \
  --priority="high"

# Step 2: Generate use cases from requirements
requirements-to-code-docs usecases-from-reqs \
  --input="./docs/02-requirements" \
  --output="./docs/03-usecases" \
  --template="detailed"

# Step 3: Create traceability baseline
requirements-to-code-docs traceability \
  --baseline \
  --export="matrix.md,coverage-report.html"
```

#### Phase 3: Backend Development (Week 2)
```bash
# Step 1: Generate Product domain
go-backend-scaffolder generate domain Product \
  --fields="name:string,description:text,price:decimal,stock:int,category:string,images:json,tags:json" \
  --requirements="REQ-PROD-001,REQ-PROD-002" \
  --usecases="UC-PROD-001,UC-PROD-002"

# Step 2: Generate CRUD operations
go-backend-scaffolder generate crud Product \
  --api-version="v1" \
  --auth=required \
  --pagination=true \
  --filtering="name,category,price_range" \
  --sorting="name,price,created_at"

# Step 3: Generate Category domain
go-backend-scaffolder generate domain Category \
  --fields="name:string,slug:string,description:text,parent_id:uuid,image_url:string" \
  --nested=true

# Step 4: Run tests and verify
make test-backend
make lint-backend

# Step 5: Generate API documentation
requirements-to-code-docs api-from-code \
  --source="./backend/internal/interfaces/handlers" \
  --output="./docs/04-realize/api" \
  --format="markdown+openapi"
```

#### Phase 4: Frontend Development (Week 3)
```bash
# Step 1: Generate Product components
vue-quasar-scaffolder generate crud Product \
  --api="/api/v1/products" \
  --fields="name:string,description:text,price:number,stock:number,category:string" \
  --store=products \
  --layout=admin

# Step 2: Generate Product pages
vue-quasar-scaffolder generate page Products \
  --layout=admin \
  --crud \
  --filtering \
  --pagination

vue-quasar-scaffolder generate page ProductDetail \
  --layout=admin \
  --type=detail

# Step 3: Generate Category components
vue-quasar-scaffolder generate component CategoryTree \
  --type=hierarchical \
  --api="/api/v1/categories" \
  --store=categories

# Step 4: Run frontend tests
cd frontend && pnpm test
cd frontend && pnpm lint
cd frontend && pnpm type-check

# Step 5: Start development servers
make dev-backend &
make dev-frontend &
```

#### Phase 5: Integration & Testing (Week 4)
```bash
# Step 1: Run integration tests
make test-integration

# Step 2: Run end-to-end tests
make test-e2e

# Step 3: Performance testing
make test-performance

# Step 4: Security scanning
make security-scan

# Step 5: Update traceability matrix
requirements-to-code-docs traceability \
  --update \
  --validate \
  --export="matrix.md,dashboard.html"

# Step 6: Build for production
make build
```

#### Phase 6: Deployment & Monitoring (Week 4)
```bash
# Step 1: Build Docker images
make docker

# Step 2: Deploy to staging
make deploy staging

# Step 3: Run smoke tests
make smoke-test

# Step 4: Deploy to production
make deploy production

# Step 5: Monitor deployment
make monitor

# Step 6: Update documentation
requirements-to-code-docs deploy-docs \
  --target="production" \
  --version="1.0.0"
```

### Workflow Templates

#### 1. Development Sprint Template
```yaml
# .github/ISSUE_TEMPLATE/sprint-plan.md
# Sprint Planning: Sprint {number} - {dates}

## Sprint Goals
1. {Goal 1}
2. {Goal 2}
3. {Goal 3}

## Requirements Coverage
- [ ] REQ-{ID}: {Requirement description}
- [ ] REQ-{ID}: {Requirement description}

## Use Cases to Implement
- [ ] UC-{ID}: {Use case description}
- [ ] UC-{ID}: {Use case description}

## Backend Tasks
| Task | Estimate | Skill Used | Dependencies |
|------|----------|------------|--------------|
| Generate {Domain} domain | 2h | go-backend-scaffolder | - |
| Implement {Service} service | 4h | go-backend-scaffolder | Domain ready |
| Create API endpoints | 3h | go-backend-scaffolder | Service ready |
| Write tests | 3h | go-backend-scaffolder | Code complete |

## Frontend Tasks
| Task | Estimate | Skill Used | Dependencies |
|------|----------|------------|--------------|
| Generate {Component} components | 3h | vue-quasar-scaffolder | API ready |
| Create {Page} page | 2h | vue-quasar-scaffolder | Components ready |
| Implement {Store} store | 2h | vue-quasar-scaffolder | API spec ready |
| Write tests | 3h | vue-quasar-scaffolder | Code complete |

## Documentation Tasks
| Task | Estimate | Skill Used | Dependencies |
|------|----------|------------|--------------|
| Update API documentation | 1h | requirements-to-code-docs | API complete |
| Update traceability matrix | 1h | requirements-to-code-docs | Tasks complete |
| Create user guide | 2h | requirements-to-code-docs | Feature complete |

## Definition of Done
- [ ] All code generated with appropriate skills
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Code reviewed and approved
- [ ] Traceability matrix updated
- [ ] Deployed to staging
- [ ] Accepted by product owner
```

#### 2. Code Review Checklist
```markdown
# Code Review Checklist

## Backend Code Review
- [ ] Generated using go-backend-scaffolder
- [ ] Follows clean architecture pattern
- [ ] Includes comprehensive tests
- [ ] Error handling implemented
- [ ] Logging appropriate
- [ ] API documentation (Swagger) updated
- [ ] Traceability comments included
- [ ] Performance considerations addressed
- [ ] Security considerations addressed

## Frontend Code Review  
- [ ] Generated using vue-quasar-scaffolder
- [ ] Uses Composition API with TypeScript
- [ ] Includes component tests
- [ ] Error handling implemented
- [ ] Loading states handled
- [ ] Accessibility considerations
- [ ] Responsive design
- [ ] Dark mode support
- [ ] Performance optimized

## Integration Review
- [ ] API contracts match
- [ ] Error handling coordinated
- [ ] Loading states synchronized
- [ ] Data flow properly implemented
- [ ] End-to-end tests passing
- [ ] Cross-browser compatibility

## Documentation Review
- [ ] Requirements traceability updated
- [ ] Use case documentation complete
- [ ] API documentation generated
- [ ] User guide updated if needed
- [ ] Code comments adequate
```

#### 3. Deployment Pipeline Template
```yaml
# .github/workflows/deploy.yml
name: Deploy Pipeline

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Validate requirements traceability
        run: |
          requirements-to-code-docs traceability --validate
          if [ $? -ne 0 ]; then
            echo "Traceability validation failed"
            exit 1
          fi
      
      - name: Validate documentation
        run: |
          requirements-to-code-docs validate-docs
          if [ $? -ne 0 ]; then
            echo "Documentation validation failed"
            exit 1
          fi

  test:
    needs: validate
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16-alpine
        env: {...}
      redis:
        image: redis:7-alpine
    steps:
      - uses: actions/checkout@v4
      
      - name: Run backend tests
        run: make test-backend
      
      - name: Run frontend tests
        run: make test-frontend
      
      - name: Run integration tests
        run: make test-integration
      
      - name: Run e2e tests
        run: make test-e2e

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build backend
        run: make build-backend
      
      - name: Build frontend
        run: make build-frontend
      
      - name: Build Docker images
        run: make docker
      
      - name: Generate deployment documentation
        run: |
          requirements-to-code-docs generate-deploy-docs \
            --version=${{ github.sha }} \
            --output=./deploy/docs

  deploy-staging:
    needs: build
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy to staging
        run: make deploy-staging
      
      - name: Run smoke tests
        run: make smoke-test-staging
      
      - name: Update documentation
        run: |
          requirements-to-code-docs deploy-docs \
            --environment=staging \
            --version=${{ github.sha }}

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy to production
        run: make deploy-production
      
      - name: Run smoke tests
        run: make smoke-test-production
      
      - name: Update documentation
        run: |
          requirements-to-code-docs deploy-docs \
            --environment=production \
            --version=${{ github.sha }}
      
      - name: Send deployment notification
        run: |
          requirements-to-code-docs generate-release-notes \
            --version=${{ github.sha }} \
            --notify
```

### Skill Integration Patterns

#### Pattern 1: Feature Development Workflow
```bash
# Feature: User Profile Management

# 1. Requirements phase
requirements-to-code-docs requirement "User Profile" \
  --description="Users can view and edit their profile information"

requirements-to-code-docs usecase "Profile Management" \
  --actors="User" \
  --flows="view,edit,upload-avatar"

# 2. Backend implementation
go-backend-scaffolder generate domain Profile \
  --fields="user_id:uuid,avatar_url:string,bio:text,website:string,social_links:json"

go-backend-scaffolder generate crud Profile \
  --read-only-fields="user_id" \
  --auth=own-data-only

# 3. Frontend implementation
vue-quasar-scaffolder generate page Profile \
  --layout=user \
  --type=form-with-avatar

vue-quasar-scaffolder generate component AvatarUploader \
  --type=image-upload \
  --api="/api/v1/profiles/avatar"

# 4. Documentation sync
requirements-to-code-docs traceability --update
requirements-to-code-docs api-from-code --update
```

#### Pattern 2: Microservice Integration
```bash
# Integrating Notification Service

# 1. Add service to project
fullstack-project-setup add-service notifications \
  --type=go \
  --features="email,sms,push" \
  --queue=rabbitmq

# 2. Generate notification domain
go-backend-scaffolder generate domain Notification \
  --service=notifications \
  --fields="user_id:uuid,type:string,title:string,content:text,status:string"

# 3. Generate frontend components
vue-quasar-scaffolder generate component NotificationBell \
  --type=real-time \
  --api="/api/v1/notifications"

vue-quasar-scaffolder generate page Notifications \
  --layout=user \
  --type=list-with-actions

# 4. Update documentation
requirements-to-code-docs requirement "Notification System"
requirements-to-code-docs traceability --update
```

#### Pattern 3: API Versioning Workflow
```bash
# Versioning API from v1 to v2

# 1. Generate v2 API structure
go-backend-scaffolder generate api-version v2 \
  --from-version=v1 \
  --breaking-changes="remove-deprecated-fields"

# 2. Update frontend to use v2
vue-quasar-scaffolder migrate-api-version v2 \
  --update-endpoints \
  --maintain-compatibility

# 3. Generate migration guide
requirements-to-code-docs generate migration-guide \
  --from=v1 \
  --to=v2 \
  --breaking-changes \
  --examples

# 4. Update traceability
requirements-to-code-docs traceability \
  --api-versions="v1,v2" \
  --deprecation-schedule
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Skipping requirements phase | Building wrong thing, rework needed | Always start with requirements |
| Not using appropriate skill | Inconsistent code, missed patterns | Use designated skill for each task |
| Ignoring documentation | Knowledge loss, hard maintenance | Integrate docs into workflow |
| Not updating traceability | Can't track progress or coverage | Update traceability with each change |
| Testing after development | Bugs found late, expensive fixes | Test-driven development |
| Manual deployment | Human error, inconsistent deploys | Automated CI/CD pipeline |
| No monitoring setup | Issues not detected promptly | Set up monitoring from start |

### Red Flags

- Code written without using scaffolder skills
- Documentation not in sync with code
- No traceability between requirements and code
- Manual deployment processes
- Missing tests for generated code
- No monitoring or observability
- Requirements changing without documentation updates

## Integration with Development Methodology

### Agile/Scrum Integration
```
Sprint Planning → Requirements & Use Cases → Development → Review → Documentation
    ↑                                                                   ↓
    └────────────────────── Traceability Update ────────────────────────┘
```

### CI/CD Integration
```
Code Commit → Auto Tests → Build → Deploy Staging → Smoke Tests → Deploy Prod
    ↑           ↑           ↑           ↑               ↑              ↑
    └── Docs ───┴── Sync ──┴── Docs ───┴── Docs ───────┴── Docs ──────┘
```

### Quality Assurance Integration
```
Requirements → Use Cases → Code Implementation → Tests → Documentation
    ↑              ↑              ↑                ↑           ↑
    └── Trace ─────┴── Trace ────┴── Trace ───────┴── Trace ──┘
```

## Real-World Impact

**Before (Disconnected Workflow):**
- Requirements in JIRA, code in repo, docs in Confluence
- No traceability between artifacts
- Inconsistent code patterns
- Manual documentation updates
- Deployment issues common
- Hard to measure progress

**After (Integrated Workflow):**
- Single source of truth for all artifacts
- Complete traceability matrix
- Consistent, generated code patterns
- Auto-synced documentation
- Reliable automated deployments
- Clear progress tracking

**Outcome:** Faster development, higher quality, better collaboration, easier maintenance, predictable outcomes.