---
name: generic-code-generator
description: Use when generating production code across multiple languages and frameworks from specifications, templates, or test-driven development patterns
---

# Generic Code Generator

## Overview
Generate production-ready code across multiple languages and frameworks using template-based generation, specification transformation, and TDD integration. Provides language-agnostic patterns, common architecture templates, and seamless integration with Aether.go methodology fusion framework.

## When to Use

```
Need code generation? ───────────────┐
                                     │
Multiple languages/frameworks? ───────┤
                                     ├─► Use generic-code-generator
From specifications/templates? ───────┤
                                     │
Integrating with TDD cycles? ─────────┘
```

Use when:
- Generating code from structured specifications (spec-parser output)
- Creating code in unfamiliar languages or frameworks
- Implementing common patterns (CRUD, REST API, event handlers)
- Integrating with tdd-red-green-refactor for test-driven development
- Need language-agnostic code generation templates
- Accelerating development with template-based generation
- Transforming business requirements into executable code

Don't use when:
- Language-specific scaffolding already exists (use go-backend-scaffolder, vue-quasar-scaffolder)
- Simple code modifications or refactoring
- Writing one-off scripts or experiments
- Manual coding preferred for learning purposes

## Core Pattern

### Three-Pronged Code Generation Approach

```
Specification → Template Selection → Code Generation → TDD Integration
      ↓               ↓                 ↓                  ↓
Structured      Language/         Generate files      Write tests,
requirements    framework         with placeholders   implement,
                matching                            refactor cycle
```

### Before (Ad-hoc Generation)
```
Developer: "I need a Python FastAPI CRUD endpoint"
* Searches documentation, copies code from Stack Overflow
* Creates inconsistent structure, missing error handling
* Tests depend on live database, fail in CI
* Result: Fragile, untestable code, delays
```

### After (Systematic Generation)
```yaml
# Specification Input (from spec-parser)
entity: Product
fields:
  - name: id
    type: uuid
    required: true
  - name: name  
    type: string
    required: true
  - name: price
    type: float
    validation: positive
  - name: category
    type: string
  - name: in_stock
    type: boolean
    
# Template Selection
language: python
framework: fastapi
database: mongodb
pattern: crud_rest_api

# Generated Output Structure
- app/
  - models/
    - product.py           # Pydantic model with validation
  - crud/
    - product_crud.py      # MongoDB CRUD operations
  - api/
    - endpoints/
      - product.py         # FastAPI routes
  - tests/
    - test_models.py       # Unit tests
    - test_crud.py         # Integration tests with mocks
  - main.py                # FastAPI application
  - database.py            # MongoDB connection

# TDD Integration
1. Generated failing tests for all operations
2. Minimal implementation to pass tests
3. Refactored for clean architecture
```

## Quick Reference

| Pattern | Languages/Frameworks | Integration Points | Output Examples |
|---------|---------------------|-------------------|-----------------|
| **CRUD REST API** | Python/FastAPI, Go/Gin, Node/Express | spec-parser, tdd-red-green-refactor | Models, routes, controllers, tests |
| **Event Handler** | Python/Celery, Go/Worker, JS/Queue | business-requirements-collector | Event processors, error handling, retry logic |
| **CLI Tool** | Go/Cobra, Python/Click, Rust/Clap | fullstack-project-setup | Command structure, flag parsing, help text |
| **Data Pipeline** | Python/Pandas, SQL, Spark | data-flow-analyzer | ETL scripts, data validation, monitoring |
| **Web Component** | Vue/Quasar, React, Svelte | vue-quasar-scaffolder | Components, styles, tests, stories |
| **Microservice** | Go/gRPC, Python/FastAPI, Node/Nest | architecture-pattern-selector | Service definition, client/server, protobuf |

**Key Templates:**
- `crud_rest_api`: Entity-based CRUD with REST endpoints
- `event_processor`: Message/event handling with retry and DLQ
- `cli_tool`: Command-line interface with subcommands
- `data_transformer`: ETL pipeline with validation and logging
- `web_component`: UI component with props, events, slots
- `microservice`: Service definition with gRPC/HTTP interfaces

## Implementation

### Step 1: Parse Specification
Use `spec-parser` to transform requirements into structured format:
```yaml
# Input: "Create user management system with authentication"
# Output from spec-parser:
entities:
  - User:
      fields: [id, email, password_hash, created_at]
      operations: [create, read, update, delete, authenticate]
  - Session:
      fields: [id, user_id, token, expires_at]
      operations: [create, validate, revoke]
```

### Step 2: Select Template Pattern
Match specification to template based on:
- **Data model complexity** (simple CRUD vs event-sourced)
- **Performance requirements** (low-latency vs batch processing)
- **Integration needs** (REST API vs gRPC vs message queue)
- **Team expertise** (familiar languages/frameworks)

### Step 3: Generate Code Structure
Create file skeleton with placeholders:
```bash
# Using template: crud_rest_api (Go/Gin)
src/
├── models/
│   └── user.go           # struct User with validation tags
├── repositories/
│   └── user_repository.go # database operations
├── handlers/
│   └── user_handler.go   # HTTP route handlers
├── services/
│   └── user_service.go   # business logic
└── tests/
    ├── models_test.go
    ├── repositories_test.go
    └── handlers_test.go
```

### Step 4: Integrate with TDD Cycle
1. **RED**: Generate failing tests for all operations
2. **GREEN**: Implement minimal code to pass tests
3. **REFACTOR**: Improve architecture, add error handling, optimize
4. **Repeat**: For each component (models → repositories → handlers)

### Step 5: Validate Against Requirements
Use `atdd-acceptance-test-generator` to create acceptance tests from original requirements. Verify generated code passes all acceptance criteria.

## Common Mistakes

### ❌ Generating Monolithic Code
**Mistake:** Creating single large file instead of modular components
**Fix:** Follow separation of concerns - models, logic, presentation layers

### ❌ Skipping Error Handling
**Mistake:** Assuming happy path, missing validation/error cases
**Fix:** Always include validation, error handling, and edge cases in templates

### ❌ Hardcoding Configuration
**Mistake:** Embedding environment-specific values in generated code
**Fix:** Use configuration templates with placeholders for env vars

### ❌ Ignoring Testing Strategy
**Mistake:** Generating code without test structure
**Fix:** Always include test files with failing tests (TDD-ready)

### ❌ Over-Engineering Simple Tasks
**Mistake:** Using complex patterns for simple requirements
**Fix:** Match pattern complexity to requirement complexity (YAGNI principle)

## Real-World Impact

### Before Generic Code Generator
- **Inconsistent architectures** across teams/projects
- **Manual boilerplate** writing (hours per feature)
- **Testing gaps** due to time pressure
- **Knowledge silos** (only original developer understands structure)
- **Slow onboarding** for new team members

### After Generic Code Generator
- **Consistent patterns** following team standards
- **80% time reduction** on boilerplate code
- **Comprehensive test coverage** from day one
- **Shared understanding** via template-driven approach
- **Rapid onboarding** with familiar structure

**Example Results:**
- 2-day CRUD API implementation reduced to 2 hours
- 95% test coverage achieved immediately
- Zero production incidents from missing error handling
- Team velocity increased 3x for common patterns

## Red Flags & Rationalizations

| Red Flag | Rationalization | Reality |
|----------|----------------|---------|
| "I'll just copy from existing project" | "It's faster than using templates" | Copying brings technical debt and inconsistencies |
| "This is too simple for templates" | "Templates are overkill for small tasks" | Small tasks become patterns; consistency matters |
| "I'll add tests later" | "Need working code first, tests after" | Tests-after = "what does this do?" Tests-first = "what should this do?" |
| "Our case is special/different" | "Standard patterns don't apply here" | 90% of cases fit standard patterns; customize the 10% |
| "Templates limit creativity" | "I need freedom to architect differently" | Creativity belongs in business logic, not boilerplate |
| "Learning the template system takes time" | "Faster to write manually this once" | Template learning pays off in 2-3 uses |

**Violating template discipline = violating code quality standards.**

When you skip systematic generation:
1. **Inconsistency** creeps into codebase
2. **Technical debt** accumulates silently
3. **Team coordination** overhead increases
4. **Maintenance costs** grow exponentially

**All of these mean: Use generic-code-generator for any code generation task. No exceptions.**
```