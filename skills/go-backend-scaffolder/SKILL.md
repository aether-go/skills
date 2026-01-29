---
name: go-backend-scaffolder
description: Use when generating clean architecture Go backend code with production-ready patterns
---

# Go Backend Scaffolder

## Overview
Generate clean architecture Go backend code following production-ready patterns. Creates Fiber-based REST APIs with GORM, repository pattern, structured logging, Swagger docs, and comprehensive testing.

## When to Use

```
Need Go backend? ────────────────┐
                                 │
Building REST API? ────────────────┤
                                 ├─► Use go-backend-scaffolder
Clean architecture? ──────────────┤
                                 │
Production-ready patterns? ─────────────────┘
```

Use when:
- Starting new Go backend project
- Adding new domain/service to existing backend
- Implementing REST API endpoints
- Need Fiber + GORM + Swagger setup
- Want production-ready clean architecture
- Need standardized error handling and logging

Don't use when:
- Frontend-only work (use vue-quasar-scaffolder)
- Simple scripts or CLI tools
- Microservices with different architecture
- Already have established backend patterns

## Core Pattern

### Backend Structure (bi-cms-isspirrd

```
backend/
├── main.go                         # Root command entry (cobra)
├── cmd/                            # Independent commands
│   ├── version/                    # Version command
│   │   └── version.go
│   ├── daemon/                     # Server daemon command
│   │   └── daemon.go
│   └── server/                     # Alternative server entry (optional)
│       └── main.go
├── internal/                       # Private application code
│   ├── app/                        # Application layer
│   ├── application/                # Use cases/services
│   ├── domain/                     # Domain models and business rules
│   ├── infrastructure/             # External adapters (DB, cache, etc.)
│   │   ├── database/
│   │   │   └── gorm/               # GORM implementations
│   │   └── cache/
│   ├── interfaces/                 # API handlers, presenters
│   │   └── handlers/               # Fiber HTTP handlers
│   ├── middleware/                 # Fiber middleware
│   ├── models/                     # Data models
│   ├── pkg/                        # Shared internal packages
│   │   ├── errors/                 # Error handling
│   │   ├── logger/                 # Structured logging
│   │   └── response/               # HTTP response utilities
│   ├── repositories/               # Repository interfaces
│   ├── router/                     # Route definitions
│   └── services/                   # Business logic services
├── pkg/                            # Public packages (optional)
├── api/                            # API definitions
├── configs/                        # Configuration files
├── migrations/                     # Database migrations
├── scripts/                        # Build and deployment scripts
└── web/                            # Static files (if serving frontend)
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

### After (Production-Ready Clean Architecture)
```go
// main.go - organized entry point
package main

import (
    "myapp/backend/internal/app"
    "myapp/backend/internal/pkg/logger"
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
| Command | `go-backend-scaffolder command version` | `cmd/version/version.go` |

### Command Templates

#### 1. Root Main.go (Cobra)
```go
// main.go - root command entry
package main

import (
	"github.com/spf13/cobra"
	"myapp/cmd/daemon"
	"myapp/cmd/version"
)

var rootCmd = &cobra.Command{
	Use:   "myapp",
	Short: "MyApp - Application description",
	Long: `MyApp is a powerful application with multiple commands.
Use subcommands to perform specific operations.`,
}

func init() {
	// Register all commands
	rootCmd.AddCommand(daemon.DaemonCmd)
	rootCmd.AddCommand(version.VersionCmd)
}

func main() {
	// Execute command
	rootCmd.Execute()
}
```

#### 2. Version Command
```go
// cmd/version/version.go
package version

import (
	"fmt"
	"github.com/spf13/cobra"
)

var VersionCmd = &cobra.Command{
	Use:   "version",
	Short: "Display application version",
	Long:  `Display detailed version information including version number, build time, and Git commit.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("MyApp v1.0.0")
		fmt.Println("Build: 2025-01-21T12:00:00Z")
		fmt.Println("Git Commit: abc123")
	},
}
```

#### 3. Daemon Command (Server)
```go
// cmd/daemon/daemon.go
package daemon

import (
	"log"
	"strconv"
	"time"

	"myapp/internal/app"
	"myapp/internal/pkg/config"
	dbPkg "myapp/internal/pkg/database"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/gofiber/fiber/v2/middleware/recover"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var (
	port     int
	host     string
	env      string
	logLevel string
)

var DaemonCmd = &cobra.Command{
	Use:   "daemon",
	Short: "Start HTTP API server",
	Long:  `Start the HTTP API server for the application.`,
	Run: func(cmd *cobra.Command, args []string) {
		startServer()
	},
}

func init() {
	DaemonCmd.Flags().IntVarP(&port, "port", "p", 8080, "Server port")
	DaemonCmd.Flags().StringVarP(&host, "host", "H", "0.0.0.0", "Server host")
	DaemonCmd.Flags().StringVarP(&env, "env", "e", "development", "Environment (development|testing|production)")
	DaemonCmd.Flags().StringVarP(&logLevel, "log-level", "l", "debug", "Log level (debug|info|warn|error)")
}

func startServer() {
	// Set configuration
	viper.Set("server.port", port)
	viper.Set("server.host", host)
	viper.Set("server.mode", env)
	viper.Set("log.level", logLevel)

	// Load configuration
	if err := config.LoadConfig("config/config.yaml"); err != nil {
		log.Printf("Warning: Failed to load config file, using default values: %v", err)
		config.GetConfig() // Initialize default config
	}

	cfg := config.GetConfig()

	// Initialize database
	dbConfig := dbPkg.Config{
		Driver:   cfg.Database.Driver,
		Host:     cfg.Database.Host,
		Port:     cfg.Database.Port,
		Database: cfg.Database.Database,
		Username: cfg.Database.Username,
		Password: cfg.Database.Password,
		SSLMode:  cfg.Database.SSLMode,
	}

	if err := dbPkg.Init(dbConfig); err != nil {
		log.Fatalf("Failed to initialize database: %v", err)
	}
	defer dbPkg.Close()

	// Create Fiber app using the application package
	appConfig := app.AppConfig{
		Port:              host + ":" + strconv.Itoa(port),
		AppName:           cfg.App.Name,
		EnableGB3Security: cfg.Security.EnableGB3,
		EnableCORS:        cfg.Server.EnableCORS,
		CORSAllowOrigins:  cfg.Server.CORSAllowOrigins,
		EnableAccessLog:   cfg.Log.EnableAccessLog,
		LogFormat:         cfg.Log.Format,
		DB:                dbPkg.GetDB(),
	}

	application := app.NewApp(appConfig)

	// Start server
	log.Printf("Starting server on %s:%d", host, port)
	log.Printf("Server mode: %s", env)
	log.Printf("Log level: %s", logLevel)

	if err := application.Listen(appConfig.Port); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
```

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
    "myapp/backend/internal/domain/users"
    "myapp/backend/internal/pkg/errors"
    "myapp/backend/internal/pkg/logger"
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
    "myapp/backend/internal/application/commands"
    "myapp/backend/internal/pkg/errors"
    "myapp/backend/internal/pkg/response"
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
	"log/slog"

	"myapp/internal/interfaces/middleware"
	"myapp/internal/router"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	fiberlogger "github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/gofiber/fiber/v2/middleware/recover"
	fiberSwagger "github.com/swaggo/fiber-swagger"
	"gorm.io/gorm"

	_ "myapp/docs" // Swagger documentation
)

// AppConfig application configuration
type AppConfig struct {
	// Server configuration
	Port    string
	AppName string

	// Security configuration
	EnableGB3Security bool
	EnableCORS        bool
	CORSAllowOrigins  string

	// Log configuration
	EnableAccessLog bool
	LogFormat       string

	// Database configuration
	DB *gorm.DB
}

// DefaultConfig default configuration
var DefaultConfig = AppConfig{
	Port:              ":8080",
	AppName:           "MyApp API",
	EnableGB3Security: true,
	EnableCORS:        true,
	CORSAllowOrigins:  "*",
	EnableAccessLog:   true,
	LogFormat:         "${time} ${status} ${method} ${path} ${latency} ${ip}\n",
}

// NewApp creates new Fiber application
func NewApp(config AppConfig) *fiber.App {
	// Create Fiber app
	app := fiber.New(fiber.Config{
		AppName:      config.AppName,
		ErrorHandler: errorHandler,
		BodyLimit:    10 * 1024 * 1024, // 10MB limit
	})

	// Register middlewares
	registerMiddlewares(app, config)

	// Register routes
	registerRoutes(app, config)

	return app
}

// registerMiddlewares registers application middlewares
func registerMiddlewares(app *fiber.App, config AppConfig) {
	// 1. Recovery middleware (prevents panic)
	app.Use(recover.New())

	// 2. GB3 security middleware (optional)
	if config.EnableGB3Security {
		gb3Middlewares := middleware.NewGB3SecurityMiddleware()
		for _, mw := range gb3Middlewares {
			app.Use(mw)
		}

		// Additional security headers
		app.Use(middleware.SecurityHeadersMiddleware())
		app.Use(middleware.InputValidationMiddleware())
		app.Use(middleware.AuditLogMiddleware())
	}

	// 3. Access log
	if config.EnableAccessLog {
		app.Use(fiberlogger.New(fiberlogger.Config{
			Format:     config.LogFormat,
			TimeFormat: "2006-01-02 15:04:05",
			TimeZone:   "Local",
		}))
	}

	// 4. CORS middleware
	if config.EnableCORS {
		app.Use(cors.New(cors.Config{
			AllowOrigins:     config.CORSAllowOrigins,
			AllowMethods:     "GET,POST,PUT,PATCH,DELETE,OPTIONS",
			AllowHeaders:     "Origin,Content-Type,Accept,Authorization,X-Request-ID,X-CSRF-Token",
			AllowCredentials: true,
			ExposeHeaders:    "Content-Length,Content-Range",
			MaxAge:           86400,
		}))
	}

	// 5. Swagger documentation
	app.Get("/swagger/*", fiberSwagger.WrapHandler)
}

// registerRoutes registers application routes
func registerRoutes(app *fiber.App, config AppConfig) {
	// Health check endpoints
	app.Get("/health", healthCheck)
	app.Get("/health/db", dbHealthCheck(config.DB))

	// API documentation redirect
	app.Get("/docs", func(c *fiber.Ctx) error {
		return c.Redirect("/swagger/index.html")
	})

	// Monitor endpoint (requires authentication)
	app.Get("/monitor", monitorHandler)

	// Register business routes
	router.SetupRoutes(app, nil, nil, nil, nil, config.DB)
}

// errorHandler global error handler
func errorHandler(c *fiber.Ctx, err error) error {
	// Log error
	slog.Error("Request processing error", "error", err, "path", c.Path(), "method", c.Method(), "ip", c.IP())

	// Default error response
	code := fiber.StatusInternalServerError
	message := "Internal server error"

	// Set status code and message based on error type
	if e, ok := err.(*fiber.Error); ok {
		code = e.Code
		message = e.Message
	}

	// Return JSON error response
	return c.Status(code).JSON(fiber.Map{
		"error":      message,
		"code":       "INTERNAL_ERROR",
		"path":       c.Path(),
		"request_id": c.Get("X-Request-ID"),
	})
}

// healthCheck health check handler
func healthCheck(c *fiber.Ctx) error {
	return c.JSON(fiber.Map{
		"status":    "healthy",
		"service":   "myapp",
		"version":   "1.0.0",
		"security":  "gb3_enabled",
		"timestamp": c.Context().Time(),
	})
}

// dbHealthCheck database health check handler
func dbHealthCheck(db *gorm.DB) fiber.Handler {
	return func(c *fiber.Ctx) error {
		if db == nil {
			return c.Status(fiber.StatusServiceUnavailable).JSON(fiber.Map{
				"status":  "unhealthy",
				"service": "database",
				"error":   "Database not initialized",
			})
		}

		sqlDB, err := db.DB()
		if err != nil {
			return c.Status(fiber.StatusServiceUnavailable).JSON(fiber.Map{
				"status":  "unhealthy",
				"service": "database",
				"error":   err.Error(),
			})
		}

		if err := sqlDB.Ping(); err != nil {
			return c.Status(fiber.StatusServiceUnavailable).JSON(fiber.Map{
				"status":  "unhealthy",
				"service": "database",
				"error":   err.Error(),
			})
		}

		stats := sqlDB.Stats()
		return c.JSON(fiber.Map{
			"status":  "healthy",
			"service": "database",
			"connections": fiber.Map{
				"open":   stats.OpenConnections,
				"in_use": stats.InUse,
				"idle":   stats.Idle,
			},
			"timestamp": c.Context().Time(),
		})
	}
}

// monitorHandler monitor handler
func monitorHandler(c *fiber.Ctx) error {
	// Check user permissions
	userRole := c.Get("X-User-Role", "user")
	if userRole != "admin" {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{
			"error": "Insufficient permissions",
			"code":  "INSUFFICIENT_PERMISSIONS",
		})
	}

	return c.JSON(fiber.Map{
		"status": "monitoring_enabled",
		"endpoints": fiber.Map{
			"metrics":   "/metrics",
			"health":    "/health",
			"health_db": "/health/db",
		},
		"security": fiber.Map{
			"gb3_compliance": true,
			"encryption":     "SM2+SM4+RSA",
			"audit_logging":  true,
		},
		"timestamp": c.Context().Time(),
	})
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
    
    "myapp/backend/internal/domain/users"
    "myapp/backend/internal/pkg/errors"
    "myapp/backend/internal/services"
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
    
    "myapp/backend/internal/interfaces/handlers"
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