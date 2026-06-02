---
name: code-generator
description: Use when generating implementation code from interface contracts for backend (Go) and frontend (Vue/React) in any language. This skill unifies D5 Implementation Derivation Domain (L4.5→L5) and replaces contract-driven-code-generator, backend-code-generator, frontend-code-generator, and generic-code-generator.
---

# Code Generator

## Overview

The unified skill for all L4.5→L5 code generation work. This skill:
- Generates Go backend code from interface contracts
- Generates Vue/React frontend code from interface contracts
- Supports language-agnostic code templates via `generic` mode
- Enforces contract compliance in generated code
- Supports TDD GREEN phase (minimal implementation that passes tests)

**Replaces** (consolidated from 4 skills):
- `contract-driven-code-generator`
- `backend-code-generator`
- `frontend-code-generator`
- `generic-code-generator`

## When to Use

```
Need to implement from contracts? ─────────────┐
                                              │
Go backend code from API spec? ───────────────┤
                                              │
Vue/React frontend from contracts? ───────────┼─► Use code-generator
                                              │
Language-agnostic templates? ─────────────────┤
                                              │
TDD GREEN phase implementation? ──────────────┘
```

Use when:
- Implementing backend services from interface contracts (Go preferred)
- Implementing frontend components from contracts (Vue 3 preferred)
- Generating language-agnostic code templates
- TDD green phase (minimal code to pass tests)
- API client generation from OpenAPI

Don't use when:
- Pure requirement analysis (use `requirement-analyzer`)
- Spec writing (use `spec-engineer`)
- Test code generation (use `test-planner`)
- Code refactoring (use `code-refactor-engine`)

## Core Pattern

### L4.5→L5 Code Generation Pipeline

```
Interface Contracts + Dispatch Decisions (L4.5 input)
    │
    ├──► [1] Determine Target Domain
    │         │
    │         ├── backend → [2] Backend Generation
    │         ├── frontend → [3] Frontend Generation
    │         └── generic → [4] Language-Agnostic Templates
    │
    ├──► [2] Backend Generation (Go)
    │         │
    │         ├──► Model/Entity generation
    │         ├──► Repository pattern (GORM/sqlc)
    │         ├──► Service layer (business logic)
    │         ├──► Handler layer (HTTP/gRPC)
    │         ├──► Middleware (auth, logging, CORS)
    │         └──► Test scaffolding (per TDD green)
    │
    ├──► [3] Frontend Generation (Vue 3 + Quasar)
    │         │
    │         ├──► Component generation
    │         ├──► API client (typed axios/fetch)
    │         ├──► Pinia store (state management)
    │         ├──► Composables (reusable logic)
    │         ├──► Form components (validation)
    │         └──► Router setup
    │
    └──► [4] Language-Agnostic Templates
              │
              ├──► Template scaffolding
              ├──► Project structure
              └──► Configuration files
    │
    ▼
L5 Implementation Code ready for testing
```

### Backend Layered Architecture (Go)

```
Generated backend project structure:
├── cmd/
│   └── server/
│       └── main.go              # Entry point
├── internal/
│   ├── domain/                  # Pure business logic
│   │   ├── user.go
│   │   └── errors.go
│   ├── repository/              # Data access
│   │   ├── user_repo.go
│   │   └── postgres/
│   │       └── user_repo.go
│   ├── service/                 # Application logic
│   │   └── user_service.go
│   ├── handler/                 # HTTP/gRPC handlers
│   │   └── user_handler.go
│   ├── middleware/              # Cross-cutting concerns
│   │   ├── auth.go
│   │   └── logger.go
│   └── config/                  # Configuration
│       └── config.go
├── migrations/                  # DB migrations
│   └── 001_create_users.up.sql
└── tests/
    ├── unit/
    ├── integration/
    └── contract/
```

### Frontend Layered Architecture (Vue 3 + Quasar)

```
Generated frontend project structure:
├── src/
│   ├── pages/                   # Route components
│   │   └── UserSignupPage.vue
│   ├── components/              # Reusable components
│   │   ├── UserForm.vue
│   │   └── UserTable.vue
│   ├── composables/             # Reusable logic
│   │   └── useUser.ts
│   ├── stores/                  # Pinia state
│   │   └── userStore.ts
│   ├── api/                     # API client
│   │   └── userApi.ts
│   ├── types/                   # TypeScript types
│   │   └── user.ts
│   ├── router/                  # Vue Router
│   │   └── index.ts
│   └── boot/                    # Quasar boot files
│       └── axios.ts
├── tests/
│   ├── unit/                    # Vitest
│   └── e2e/                     # Playwright
└── public/
```

## Input Format

### Backend (Go)

```yaml
code_generation_request:
  project: "Aether Platform"
  target: "backend"  # backend | frontend | generic
  language: "go"
  framework: "gin"  # gin | echo | fiber | chi
  
  contracts:
    - id: "IC-User-001"
      name: "UserAPI"
      type: "rest_api"
      endpoints:
        - method: POST
          path: "/api/v1/users"
          request_schema: {email: "string", password: "string"}
          response_2xx: {user_id: "uuid"}
          response_4xx: [{status: 400, error: "validation_failed"}]
      models:
        - name: "User"
          fields:
            - {name: "id", type: "uuid", primary: true}
            - {name: "email", type: "string", unique: true}
            - {name: "password_hash", type: "string"}
            - {name: "created_at", type: "timestamp"}
  
  # TDD green phase
  tdd_mode: true  # Generate minimal code to pass tests
  
  # Generation options
  options:
    include_migrations: true
    include_middleware: true
    include_docker: true
    include_ci_cd: true
    test_coverage_target: 0.80
```

### Frontend (Vue)

```yaml
code_generation_request:
  project: "Aether Platform"
  target: "frontend"  # frontend
  language: "typescript"
  framework: "vue3-quasar"  # vue3-quasar | react-vite | svelte
  
  contracts:
    - id: "IC-User-001"
      name: "UserAPI"
      endpoints: [...]  # Same as backend
  
  ui_specs:
    pages:
      - name: "UserSignupPage"
        route: "/signup"
        layout: "auth"
        components: ["UserForm"]
    components:
      - name: "UserForm"
        props: [{name: "mode", type: "string"}]
        emits: ["submit", "cancel"]
        validation: ["email", "password"]
  
  options:
    include_pinia: true
    include_router: true
    include_i18n: true
    include_tests: true
```

## Output Format

### Backend Output

```yaml
code_generation_result:
  project: "Aether Platform"
  target: "backend"
  language: "go"
  
  generated_files:
    - path: "internal/domain/user.go"
      type: "domain_model"
      lines: 45
      contracts_implemented: ["IC-User-001"]
    - path: "internal/repository/postgres/user_repo.go"
      type: "repository"
      lines: 120
    - path: "internal/service/user_service.go"
      type: "service"
      lines: 95
    - path: "internal/handler/user_handler.go"
      type: "http_handler"
      lines: 110
    - path: "internal/middleware/auth.go"
      type: "middleware"
      lines: 65
    - path: "cmd/server/main.go"
      type: "entry_point"
      lines: 50
    - path: "migrations/001_create_users.up.sql"
      type: "migration"
      lines: 15
    - path: "internal/domain/user_test.go"
      type: "test_scaffold"
      lines: 80  # RED phase tests from test-planner
  
  total_files: 8
  total_lines: 580
  
  contracts_compliance:
    IC-User-001: "implemented"
  
  test_status:
    scaffold_generated: true
    tdd_ready: true
    next_step: "Run tests (should fail in RED phase)"
  
  build_check: "compiles"
```

### Frontend Output

```yaml
code_generation_result:
  project: "Aether Platform"
  target: "frontend"
  language: "typescript"
  framework: "vue3-quasar"
  
  generated_files:
    - path: "src/pages/UserSignupPage.vue"
      type: "page"
      lines: 95
    - path: "src/components/UserForm.vue"
      type: "component"
      lines: 130
    - path: "src/composables/useUser.ts"
      type: "composable"
      lines: 70
    - path: "src/stores/userStore.ts"
      type: "pinia_store"
      lines: 85
    - path: "src/api/userApi.ts"
      type: "api_client"
      lines: 95
    - path: "src/types/user.ts"
      type: "typescript_types"
      lines: 35
  
  total_files: 6
  total_lines: 510
  
  contracts_compliance:
    IC-User-001: "client_generated"
  
  build_check: "compiles"
```

## Implementation

### Step 1: Determine Target Domain

```python
def determine_target(request: dict) -> str:
    return request["target"]  # backend | frontend | generic
```

### Step 2: Backend Generation (Go)

#### Model/Entity Generation

```go
// Generated internal/domain/user.go
package domain

import (
    "time"
    "github.com/google/uuid"
)

type User struct {
    ID           uuid.UUID `gorm:"type:uuid;primaryKey"`
    Email        string    `gorm:"type:varchar(255);uniqueIndex"`
    PasswordHash string    `gorm:"type:varchar(255)"`
    CreatedAt    time.Time `gorm:"autoCreateTime"`
    UpdatedAt    time.Time `gorm:"autoUpdateTime"`
}

func NewUser(email, passwordHash string) (*User, error) {
    if err := validateEmail(email); err != nil {
        return nil, err
    }
    return &User{
        ID:           uuid.New(),
        Email:        email,
        PasswordHash: passwordHash,
        CreatedAt:    time.Now(),
    }, nil
}
```

#### Repository Pattern

```go
// Generated internal/repository/user_repo.go
package repository

import (
    "context"
    "github.com/google/uuid"
    "yourapp/internal/domain"
)

type UserRepository interface {
    Create(ctx context.Context, user *domain.User) error
    GetByID(ctx context.Context, id uuid.UUID) (*domain.User, error)
    GetByEmail(ctx context.Context, email string) (*domain.User, error)
    Update(ctx context.Context, user *domain.User) error
    Delete(ctx context.Context, id uuid.UUID) error
}
```

#### Service Layer

```go
// Generated internal/service/user_service.go
package service

import (
    "context"
    "errors"
    "yourapp/internal/domain"
    "yourapp/internal/repository"
    "golang.org/x/crypto/bcrypt"
)

type UserService struct {
    repo repository.UserRepository
}

func NewUserService(repo repository.UserRepository) *UserService {
    return &UserService{repo: repo}
}

func (s *UserService) Register(ctx context.Context, email, password string) (*domain.User, error) {
    // Check existing
    existing, _ := s.repo.GetByEmail(ctx, email)
    if existing != nil {
        return nil, ErrEmailExists
    }
    
    // Hash password
    hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
    if err != nil {
        return nil, err
    }
    
    // Create user
    user, err := domain.NewUser(email, string(hash))
    if err != nil {
        return nil, err
    }
    
    if err := s.repo.Create(ctx, user); err != nil {
        return nil, err
    }
    
    return user, nil
}
```

#### HTTP Handler

```go
// Generated internal/handler/user_handler.go
package handler

import (
    "net/http"
    "github.com/gin-gonic/gin"
    "yourapp/internal/service"
)

type UserHandler struct {
    svc *service.UserService
}

func NewUserHandler(svc *service.UserService) *UserHandler {
    return &UserHandler{svc: svc}
}

type RegisterRequest struct {
    Email    string `json:"email" binding:"required,email"`
    Password string `json:"password" binding:"required,min=8"`
}

type RegisterResponse struct {
    UserID string `json:"user_id"`
}

func (h *UserHandler) Register(c *gin.Context) {
    var req RegisterRequest
    if err := c.ShouldBindJSON(&req); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "validation_failed"})
        return
    }
    
    user, err := h.svc.Register(c.Request.Context(), req.Email, req.Password)
    if err != nil {
        if errors.Is(err, service.ErrEmailExists) {
            c.JSON(http.StatusConflict, gin.H{"error": "email_exists"})
            return
        }
        c.JSON(http.StatusInternalServerError, gin.H{"error": "internal_error"})
        return
    }
    
    c.JSON(http.StatusCreated, RegisterResponse{UserID: user.ID.String()})
}
```

### Step 3: Frontend Generation (Vue 3 + Quasar)

#### Component Generation

```vue
<!-- Generated src/components/UserForm.vue -->
<script setup lang="ts">
import { ref, computed } from 'vue'
import { useUserStore } from 'stores/userStore'

interface Props {
  mode?: 'create' | 'edit'
}
const props = withDefaults(defineProps<Props>(), { mode: 'create' })

const emit = defineEmits<{
  submit: [user: { email: string; password: string }]
  cancel: []
}>()

const userStore = useUserStore()

const form = ref({
  email: '',
  password: '',
})

const isValid = computed(() => 
  /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.value.email) &&
  form.value.password.length >= 8
)

async function handleSubmit() {
  if (!isValid.value) return
  await userStore.register(form.value)
  emit('submit', form.value)
}
</script>

<template>
  <q-form @submit.prevent="handleSubmit">
    <q-input
      v-model="form.email"
      type="email"
      label="Email"
      :rules="[val => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val) || 'Invalid email']"
    />
    <q-input
      v-model="form.password"
      type="password"
      label="Password"
      :rules="[val => val.length >= 8 || 'Min 8 characters']"
    />
    <q-btn type="submit" label="Submit" :disable="!isValid" color="primary" />
  </q-form>
</template>
```

#### API Client

```typescript
// Generated src/api/userApi.ts
import axios, { AxiosInstance } from 'axios'

export interface User {
  id: string
  email: string
  created_at: string
}

export interface RegisterRequest {
  email: string
  password: string
}

export interface RegisterResponse {
  user_id: string
}

export class UserApi {
  private client: AxiosInstance

  constructor(baseURL: string) {
    this.client = axios.create({ baseURL })
  }

  async register(data: RegisterRequest): Promise<RegisterResponse> {
    const response = await this.client.post<RegisterResponse>('/api/v1/users', data)
    return response.data
  }

  async getById(id: string): Promise<User> {
    const response = await this.client.get<User>(`/api/v1/users/${id}`)
    return response.data
  }
}
```

#### Pinia Store

```typescript
// Generated src/stores/userStore.ts
import { defineStore } from 'pinia'
import { ref } from 'vue'
import { UserApi, type RegisterRequest, type User } from 'src/api/userApi'

export const useUserStore = defineStore('user', () => {
  const api = new UserApi(import.meta.env.VITE_API_BASE_URL)
  
  const currentUser = ref<User | null>(null)
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  async function register(data: RegisterRequest) {
    isLoading.value = true
    error.value = null
    try {
      await api.register(data)
    } catch (e) {
      error.value = e instanceof Error ? e.message : 'Unknown error'
      throw e
    } finally {
      isLoading.value = false
    }
  }

  return { currentUser, isLoading, error, register }
})
```

### Step 4: Language-Agnostic Templates

For cross-language or new languages, generate:
- Project structure template
- Build configuration template
- Linting/formatting configuration
- Test framework setup

## Validation Rules

- ✅ Generated code compiles (Go: `go build`, Vue: `npm run build`)
- ✅ All contracts have corresponding implementations
- ✅ Test scaffolds present (for TDD)
- ✅ No more than 5 core dependencies (P5)
- ✅ All files follow project conventions

## Integration with Aether.go Methodology

- **Input from**:
  - `generation-dispatcher` (dispatch decision + contract)
  - `test-planner` (test scaffolding for GREEN phase)
- **Output to**:
  - `tdd-cycle-runner` (execute tests)
  - `code-refactor-engine` (improve design)
- **Part of**: D5 Implementation Derivation Domain (L4.5→L5)
- **Principle alignment**:
  - **P4 Interface-First**: Implements declared contracts
  - **P6 Test-First**: Generates minimal code to pass tests
  - **P3 Modularity-Orthogonality**: Layered architecture
  - **P5 Occam's Razor**: ≤5 core dependencies

## Examples

### Example 1: REST API in Go

```yaml
target: backend
language: go
framework: gin
contracts: 5
files_generated: 28
total_lines: 1450
compiles: true
tdd_ready: true
```

### Example 2: SPA in Vue

```yaml
target: frontend
language: typescript
framework: vue3-quasar
components: 12
stores: 4
api_clients: 5
compiles: true
```

### Example 3: Multi-Language Microservice

```yaml
services:
  - {name: "auth", language: "go", files: 22}
  - {name: "web", language: "vue3", files: 18}
  - {name: "worker", language: "go", files: 12}
total_files: 52
```

## Migration Notes

This skill consolidates the following previously separate skills:
- `contract-driven-code-generator` — Generic contract-to-code
- `backend-code-generator` — Go-specific backend
- `frontend-code-generator` — Vue/React frontend
- `generic-code-generator` — Language-agnostic templates

**Invocation parameters**:
- `target: backend` → Step 2
- `target: frontend` → Step 3
- `target: generic` → Step 4
- `target: full` (default) → All applicable

**TDD Mode**:
- `tdd_mode: true` → Generate minimal stubs that compile but fail tests (RED→GREEN→REFACTOR ready)
- `tdd_mode: false` → Generate full implementation (skips RED phase)
