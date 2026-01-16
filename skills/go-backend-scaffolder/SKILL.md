---
name: go-backend-scaffolder
description: Use when generating clean architecture Go backend code based on bitcms patterns
---

# Go Backend Scaffolder

## Overview
Generate clean architecture Go backend code following bitcms patterns. Creates Fiber-based REST APIs with GORM, repository pattern, structured logging, Swagger docs, and comprehensive testing.

## When to Use

```
Need Go backend? ────────────────┐
                                 │
Building REST API? ────────────────┤
                                 ├─► Use go-backend-scaffolder
Clean architecture? ──────────────┤
                                 │
Bitcms patterns? ─────────────────┘
```

Use when:
- Starting new Go backend project
- Adding new domain/service to existing backend
- Implementing REST API endpoints
- Need Fiber + GORM + Swagger setup
- Want bitcms-style clean architecture
- Need standardized error handling and logging

Don't use when:
- Frontend-only work (use vue-quasar-scaffolder)
- Simple scripts or CLI tools
- Microservices with different architecture
- Already have established backend patterns

## Core Pattern

### Backend Structure (bitcms-inspired)

```
backend/
├── cmd/                          # Application entry points
│   └── server/
│       └── main.go               # Main server entry
├── internal/                     # Private application code
│   ├── app/                      # Application layer
│   ├── application/              # Use cases/services
│   ├── domain/                   # Domain models and business rules
│   ├── infrastructure/           # External adapters (DB, cache, etc.)
│   │   ├── database/
│   │   │   └── gorm/             # GORM implementations
│   │   └── cache/
│   ├── interfaces/               # API handlers, presenters
│   │   └── handlers/             # Fiber HTTP handlers
│   ├── middleware/               # Fiber middleware
│   ├── models/                   # Data models
│   ├── pkg/                      # Shared internal packages
│   │   ├── errors/               # Error handling
│   │   ├── logger/               # Structured logging
│   │   └── response/             # HTTP response utilities
│   ├── repositories/             # Repository interfaces
│   ├── router/                   # Route definitions
│   └── services/                 # Business logic services
├── pkg/                          # Public packages (optional)
├── api/                          # API definitions
├── configs/                      # Configuration files
├── migrations/                   # Database migrations
├── scripts/                      # Build and deployment scripts
└── web/                          # Static files (if serving frontend)
```

### Before (Generic Go Project)
```go
// main.go - everything in one file
package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello World")
    })
    http.ListenAndServe(":8080", nil)
}
```

### After (bitcms Clean Architecture)
```go
// main.go - organized entry point
package main

import (
    "bitcms/backend/internal/app"
    "bitcms/backend/internal/pkg/logger"
)

func main() {
    // Initialize structured logger
    log := logger.New()
    
    // Setup application with all dependencies
    application, err := app.New(log)
    if err != nil {
        log.Fatal("Failed to create application", "error", err)
    }
    
    // Start server
    if err := application.Start(); err != nil {
        log.Fatal("Server failed", "error", err)
    }
}
```

## Quick Reference

### Component Generation

| Component | Command/Template | Location |
|-----------|----------------|----------|
| Domain Model | `go-backend-scaffolder domain User` | `internal/domain/users/user.go` |
| HTTP Handler | `go-backend-scaffolder handler UserHandler` | `internal/interfaces/handlers/user_handler.go` |
| Service | `go-backend-scaffolder service UserService` | `internal/services/user_service.go` |
| Repository | `go-backend-scaffolder repository UserRepository` | `internal/repositories/user_repository.go` |
| Middleware | `go-backend-scaffolder middleware Auth` | `internal/middleware/auth_middleware.go` |
| Migration | `go-backend-scaffolder migration AddUsersTable` | `migrations/001_add_users_table.go` |

### Essential Templates

#### 1. Domain Model Template
```go
// internal/domain/users/user.go
package users

import (
    "time"
    "github.com/google/uuid"
)

type User struct {
    ID           uuid.UUID `gorm:"type:uuid;primary_key;default:gen_random_uuid()"`
    Email        string    `gorm:"type:varchar(255);uniqueIndex;not null"`
    Username     string    `gorm:"type:varchar(100);uniqueIndex"`
    PasswordHash string    `gorm:"type:varchar(255);not null"`
    IsActive     bool      `gorm:"default:true"`
    CreatedAt    time.Time
    UpdatedAt    time.Time
    DeletedAt    *time.Time `gorm:"index"`
}

// Repository interface for data access
type Repository interface {
    Create(user *User) error
    FindByID(id uuid.UUID) (*User, error)
    FindByEmail(email string) (*User, error)
    Update(user *User) error
    Delete(id uuid.UUID) error
    List(filter ListFilter) ([]*User, int64, error)
}
```

#### 2. Service Template
```go
// internal/services/user_service.go
package services

import (
    "context"
    "bitcms/backend/internal/domain/users"
    "bitcms/backend/internal/pkg/errors"
    "bitcms/backend/internal/pkg/logger"
)

type UserService struct {
    repo    users.Repository
    logger  *logger.Logger
}

func NewUserService(repo users.Repository, logger *logger.Logger) *UserService {
    return &UserService{
        repo:   repo,
        logger: logger,
    }
}

func (s *UserService) CreateUser(ctx context.Context, req CreateUserRequest) (*users.User, error) {
    s.logger.Info("Creating user", "email", req.Email)
    
    // Check if user exists
    existing, err := s.repo.FindByEmail(req.Email)
    if err != nil && !errors.IsNotFound(err) {
        return nil, errors.Wrap(err, "failed to check existing user")
    }
    if existing != nil {
        return nil, errors.NewConflict("user already exists with email %s", req.Email)
    }
    
    // Create user
    user := &users.User{
        Email:        req.Email,
        Username:     req.Username,
        PasswordHash: hashPassword(req.Password),
    }
    
    if err := s.repo.Create(user); err != nil {
        return nil, errors.Wrap(err, "failed to create user")
    }
    
    return user, nil
}
```

#### 3. HTTP Handler Template
```go
// internal/interfaces/handlers/user_handler.go
package handlers

import (
    "github.com/gofiber/fiber/v2"
    "bitcms/backend/internal/application/commands"
    "bitcms/backend/internal/pkg/errors"
    "bitcms/backend/internal/pkg/response"
)

type UserHandler struct {
    userService UserService
}

func NewUserHandler(userService UserService) *UserHandler {
    return &UserHandler{
        userService: userService,
    }
}

// @Summary Create new user
// @Description Creates a new user account
// @Tags users
// @Accept json
// @Produce json
// @Param request body CreateUserRequest true "User creation request"
// @Success 201 {object} UserResponse
// @Failure 400 {object} response.Error
// @Failure 409 {object} response.Error
// @Failure 500 {object} response.Error
// @Router /api/v1/users [post]
func (h *UserHandler) CreateUser(c *fiber.Ctx) error {
    var req CreateUserRequest
    if err := c.BodyParser(&req); err != nil {
        return response.BadRequest(c, "Invalid request body")
    }
    
    // Validate request
    if err := req.Validate(); err != nil {
        return response.BadRequest(c, err.Error())
    }
    
    // Execute command
    user, err := h.userService.CreateUser(c.Context(), req)
    if err != nil {
        if errors.IsConflict(err) {
            return response.Conflict(c, err.Error())
        }
        return response.InternalError(c, "Failed to create user", err)
    }
    
    return response.Created(c, ToUserResponse(user))
}
```

## Implementation

### Directory Creation Workflow

```bash
# Create backend structure
go-backend-scaffolder create-project myapp-backend

# Generate domain model
go-backend-scaffolder generate domain Product \
  --fields="Name:string,Description:string,Price:float64,Stock:int"

# Generate CRUD endpoints
go-backend-scaffolder generate crud Product \
  --skip=delete \
  --auth=required \
  --pagination=true

# Generate migration
go-backend-scaffolder generate migration CreateProductsTable
```

### Configuration Templates

#### 1. Go Mod Template
```go
// go.mod
module myapp-backend

go 1.24.0

require (
    github.com/gofiber/fiber/v2 v2.52.10
    github.com/golang-jwt/jwt/v5 v5.3.0
    github.com/google/uuid v1.6.0
    github.com/spf13/viper v1.21.0
    github.com/swaggo/fiber-swagger v1.3.0
    github.com/swaggo/swag v1.16.6
    gorm.io/driver/postgres v1.6.0
    gorm.io/gorm v1.31.1
)
```

#### 2. Main Application Template
```go
// internal/app/app.go
package app

import (
    "context"
    "fmt"
    "os"
    "os/signal"
    "syscall"
    "time"
    
    "github.com/gofiber/fiber/v2"
    "github.com/spf13/viper"
    
    "bitcms/backend/internal/pkg/logger"
    "bitcms/backend/internal/router"
)

type Application struct {
    config *viper.Viper
    logger *logger.Logger
    server *fiber.App
}

func New(logger *logger.Logger) (*Application, error) {
    // Load configuration
    config := viper.New()
    config.SetConfigName("config")
    config.SetConfigType("yaml")
    config.AddConfigPath("./configs")
    config.AddConfigPath(".")
    
    if err := config.ReadInConfig(); err != nil {
        return nil, fmt.Errorf("failed to read config: %w", err)
    }
    
    // Create Fiber app
    app := fiber.New(fiber.Config{
        AppName:               config.GetString("app.name"),
        ReadTimeout:           config.GetDuration("server.read_timeout"),
        WriteTimeout:          config.GetDuration("server.write_timeout"),
        IdleTimeout:           config.GetDuration("server.idle_timeout"),
        DisableStartupMessage: true,
    })
    
    // Setup application
    application := &Application{
        config: config,
        logger: logger,
        server: app,
    }
    
    // Initialize components
    if err := application.initDatabase(); err != nil {
        return nil, err
    }
    
    if err := application.initServices(); err != nil {
        return nil, err
    }
    
    // Setup routes
    router.Setup(app, application.services)
    
    return application, nil
}

func (a *Application) Start() error {
    addr := fmt.Sprintf(":%s", a.config.GetString("server.port"))
    
    // Graceful shutdown
    go func() {
        sigint := make(chan os.Signal, 1)
        signal.Notify(sigint, os.Interrupt, syscall.SIGTERM)
        <-sigint
        
        a.logger.Info("Shutting down server")
        
        ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
        defer cancel()
        
        if err := a.server.ShutdownWithContext(ctx); err != nil {
            a.logger.Error("Server shutdown error", "error", err)
        }
    }()
    
    a.logger.Info("Starting server", "addr", addr)
    return a.server.Listen(addr)
}
```

### Testing Templates

#### 1. Service Test Template
```go
// internal/services/user_service_test.go
package services_test

import (
    "context"
    "testing"
    "github.com/google/uuid"
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/mock"
    
    "bitcms/backend/internal/domain/users"
    "bitcms/backend/internal/pkg/errors"
    "bitcms/backend/internal/services"
)

type MockUserRepository struct {
    mock.Mock
}

func (m *MockUserRepository) Create(user *users.User) error {
    args := m.Called(user)
    return args.Error(0)
}

func (m *MockUserRepository) FindByEmail(email string) (*users.User, error) {
    args := m.Called(email)
    if args.Get(0) == nil {
        return nil, args.Error(1)
    }
    return args.Get(0).(*users.User), args.Error(1)
}

func TestUserService_CreateUser(t *testing.T) {
    t.Run("successful user creation", func(t *testing.T) {
        // Setup
        mockRepo := new(MockUserRepository)
        logger := testLogger()
        service := services.NewUserService(mockRepo, logger)
        
        // Expectations
        mockRepo.On("FindByEmail", "test@example.com").
            Return((*users.User)(nil), errors.NewNotFound("user not found"))
        
        mockRepo.On("Create", mock.AnythingOfType("*users.User")).
            Return(nil)
        
        // Execute
        req := services.CreateUserRequest{
            Email:    "test@example.com",
            Username: "testuser",
            Password: "password123",
        }
        
        user, err := service.CreateUser(context.Background(), req)
        
        // Verify
        assert.NoError(t, err)
        assert.NotNil(t, user)
        assert.Equal(t, "test@example.com", user.Email)
        mockRepo.AssertExpectations(t)
    })
}
```

#### 2. Handler Test Template
```go
// internal/interfaces/handlers/user_handler_test.go
package handlers_test

import (
    "bytes"
    "encoding/json"
    "testing"
    
    "github.com/gofiber/fiber/v2"
    "github.com/stretchr/testify/assert"
    
    "bitcms/backend/internal/interfaces/handlers"
)

func TestUserHandler_CreateUser(t *testing.T) {
    // Setup test app
    app := fiber.New()
    
    // Mock dependencies
    mockService := new(MockUserService)
    handler := handlers.NewUserHandler(mockService)
    
    // Register route
    app.Post("/api/v1/users", handler.CreateUser)
    
    t.Run("valid request", func(t *testing.T) {
        // Setup mock
        mockService.On("CreateUser", mock.Anything, mock.Anything).
            Return(&users.User{Email: "test@example.com"}, nil)
        
        // Create request
        reqBody := map[string]string{
            "email":    "test@example.com",
            "username": "testuser",
            "password": "password123",
        }
        body, _ := json.Marshal(reqBody)
        
        // Make request
        req := httptest.NewRequest("POST", "/api/v1/users", bytes.NewReader(body))
        req.Header.Set("Content-Type", "application/json")
        
        resp, err := app.Test(req)
        assert.NoError(t, err)
        assert.Equal(t, fiber.StatusCreated, resp.StatusCode)
    })
}
```

### Utility Templates

#### 1. Error Handling Package
```go
// internal/pkg/errors/errors.go
package errors

import "fmt"

type ErrorType string

const (
    ErrorTypeNotFound   ErrorType = "NOT_FOUND"
    ErrorTypeConflict   ErrorType = "CONFLICT"
    ErrorTypeValidation ErrorType = "VALIDATION"
    ErrorTypeInternal   ErrorType = "INTERNAL"
)

type AppError struct {
    Type    ErrorType
    Message string
    Err     error
    Code    string
}

func NewNotFound(format string, args ...interface{}) *AppError {
    return &AppError{
        Type:    ErrorTypeNotFound,
        Message: fmt.Sprintf(format, args...),
    }
}

func NewConflict(format string, args ...interface{}) *AppError {
    return &AppError{
        Type:    ErrorTypeConflict,
        Message: fmt.Sprintf(format, args...),
    }
}

func (e *AppError) Error() string {
    if e.Err != nil {
        return fmt.Sprintf("%s: %v", e.Message, e.Err)
    }
    return e.Message
}

func (e *AppError) Unwrap() error {
    return e.Err
}

func Wrap(err error, message string) error {
    if err == nil {
        return nil
    }
    return &AppError{
        Type:    ErrorTypeInternal,
        Message: message,
        Err:     err,
    }
}
```

#### 2. Response Package
```go
// internal/pkg/response/response.go
package response

import (
    "github.com/gofiber/fiber/v2"
)

type Response struct {
    Success bool        `json:"success"`
    Data    interface{} `json:"data,omitempty"`
    Error   *Error      `json:"error,omitempty"`
    Meta    *Meta       `json:"meta,omitempty"`
}

type Error struct {
    Code    string `json:"code"`
    Message string `json:"message"`
}

func Success(c *fiber.Ctx, data interface{}) error {
    return c.Status(fiber.StatusOK).JSON(Response{
        Success: true,
        Data:    data,
    })
}

func Created(c *fiber.Ctx, data interface{}) error {
    return c.Status(fiber.StatusCreated).JSON(Response{
        Success: true,
        Data:    data,
    })
}

func BadRequest(c *fiber.Ctx, message string) error {
    return c.Status(fiber.StatusBadRequest).JSON(Response{
        Success: false,
        Error: &Error{
            Code:    "BAD_REQUEST",
            Message: message,
        },
    })
}

func NotFound(c *fiber.Ctx, message string) error {
    return c.Status(fiber.StatusNotFound).JSON(Response{
        Success: false,
        Error: &Error{
            Code:    "NOT_FOUND",
            Message: message,
        },
    })
}
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Putting business logic in handlers | Violates separation of concerns | Move logic to services/application layer |
| Direct database access from services | Hard to test, violates repository pattern | Use repository interfaces |
| Ignoring error wrapping | Loss of context in error chain | Use errors.Wrap() consistently |
| No structured logging | Difficult to debug in production | Use structured logger with context |
| Missing Swagger annotations | Poor API documentation | Add Swagger comments to all handlers |
| Hardcoded configuration | Environment-specific issues | Use viper/configuration management |
| No graceful shutdown | Data loss on shutdown | Implement graceful shutdown |
| Skipping migration tests | Database schema issues | Test migrations before deployment |

### Red Flags

- Business logic in HTTP handlers
- Direct SQL queries in services
- Global variables for configuration
- No error handling for external calls
- Missing context propagation
- No request ID correlation
- Hardcoded secrets
- Missing health checks

## Integration with Fullstack Workflow

This skill works with:
- `vue-quasar-scaffolder` for frontend generation
- `fullstack-project-setup` for project initialization
- `requirements-to-code-docs` for API documentation
- `go-vue-fullstack-workflow` for coordinated workflow

### Example Workflow
```bash
# 1. Initialize project
fullstack-project-setup create myapp

# 2. Generate backend components
go-backend-scaffolder generate domain Product
go-backend-scaffolder generate crud Product
go-backend-scaffolder generate handler ProductHandler

# 3. Generate corresponding frontend
vue-quasar-scaffolder generate crud Product

# 4. Generate API documentation
requirements-to-code-docs generate api ProductAPI
```

## Real-World Impact

**Before (Manual Setup):**
- 2-3 days to setup basic backend
- Inconsistent architecture
- Missing error handling
- Poor test coverage
- Manual Swagger docs

**After (With Scaffolder):**
- 30 minutes for production-ready backend
- Consistent clean architecture
- Comprehensive error handling
- 80%+ test coverage
- Auto-generated Swagger docs

**Outcome:** Faster development, higher quality, easier maintenance, better team onboarding.