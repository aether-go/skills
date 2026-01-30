---
name: generic-code-generator
description: Use when generating language-agnostic code templates and patterns from specifications, delegating to language-specific skills for implementation, or creating reusable code generation templates across projects
---

# Generic Code Generator

## Overview
Create language-agnostic code templates and patterns from specifications, delegating implementation to language-specific skills. Focus on template design, pattern extraction, and cross-project consistency while integrating with Aether.go methodology fusion framework.

## When to Use

```
Need language-agnostic templates? ───┐
                                     │
Creating cross-project patterns? ─────┤
                                     ├─► Use generic-code-generator
Delegating to language skills? ──────┤
                                     │
Designing template architecture? ────┘
```

Use when:
- Creating language-agnostic code templates from specifications
- Designing patterns that can be implemented across multiple languages
- Delegating code generation to language-specific skills (go-backend-scaffolder, vue-quasar-scaffolder)
- Establishing consistent coding patterns across projects
- Extracting common architectural patterns from specifications
- Creating template libraries for reuse across teams

Don't use when:
- Language-specific implementation is needed (use language-specific skills)
- Simple code modifications or refactoring
- Writing one-off scripts or experiments
- Manual coding for learning purposes
- Direct code generation without template design

## Core Pattern

### Three-Pronged Code Generation Approach

```
Specification → Template Design → Pattern Extraction → Delegation to Language Skills
      ↓               ↓                 ↓                         ↓
Structured      Language-agnostic   Reusable patterns    go-backend-scaffolder,
requirements    template creation   across projects      vue-quasar-scaffolder,
                                       ↓                 tdd-red-green-refactor
                                  Consistent architecture
```

### Before (Ad-hoc Generation)
```
Developer: "I need a Python FastAPI CRUD endpoint"
* Searches documentation, copies code from Stack Overflow
* Creates inconsistent structure, missing error handling
* Tests depend on live database, fail in CI
* Result: Fragile, untestable code, delays
```

### After (Template Design & Delegation)
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
  
# Template Design (Language-agnostic)
template_type: crud_rest_api
components:
  - model_template: "Entity model with validation rules"
  - repository_template: "Data access layer with CRUD operations"
  - service_template: "Business logic layer"
  - controller_template: "API endpoint definitions"
  - test_template: "Test structure for each component"

# Pattern Extraction
patterns:
  - validation_pattern: "Field validation based on type"
  - error_handling_pattern: "Consistent error responses"
  - logging_pattern: "Structured logging across layers"
  - testing_pattern: "Isolated unit tests with mocks"

# Delegation to Language-Specific Skills
delegation:
  - go_backend: "Use go-backend-scaffolder with clean architecture"
  - vue_frontend: "Use vue-quasar-scaffolder with component structure"
  - tdd_integration: "Use tdd-red-green-refactor for test-driven implementation"
  - api_documentation: "Use requirements-to-code-docs for API specs"

# Template Output (Language-agnostic structure)
template_structure:
  - models/: "Entity definitions with validation"
  - repositories/: "Data access interfaces and implementations"
  - services/: "Business logic"
  - controllers/: "API endpoints"
  - tests/: "Unit and integration tests"
  - docs/: "Generated documentation"
```

## Quick Reference

**Template Patterns and Delegation**

| Pattern | Template Components | Delegation Skills | Output Artifacts |
|---------|-------------------|-------------------|------------------|
| **CRUD REST API** | Model, Repository, Service, Controller templates | go-backend-scaffolder, vue-quasar-scaffolder, tdd-red-green-refactor | Language-agnostic template structure, validation rules, test patterns |
| **Event Handler** | Event processor, error handler, retry logic templates | business-requirements-collector, data-flow-analyzer | Event processing patterns, error handling strategies, monitoring config |
| **CLI Tool** | Command structure, flag parsing, help text templates | go-cli-builder, rust-cli-builder, fullstack-project-setup | CLI architecture patterns, help system design, plugin structure |
| **Data Pipeline** | ETL stage, validation, monitoring templates | data-flow-analyzer, metrics-definer | Pipeline patterns, data validation rules, monitoring dashboards |
| **Web Component** | Component, props, events, slots templates | vue-quasar-scaffolder, architecture-pattern-selector | Component patterns, styling guidelines, testing strategies |
| **Microservice** | Service definition, API contracts, client templates | architecture-pattern-selector, spec-parser | Service patterns, API design, client library templates |

**Key Template Types:**
- `crud_rest_api`: Language-agnostic CRUD template with layer separation
- `event_processor`: Event handling patterns with resilience features
- `cli_tool`: Command-line interface architecture templates
- `data_transformer`: ETL pipeline template with validation stages
- `web_component`: UI component templates with props and events
- `microservice`: Service template with API contracts and client libraries

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

### Step 2: Design Language-Agnostic Templates
Create template components that can be implemented in any language:
- **Model templates**: Entity definitions with validation rules
- **Repository templates**: Data access patterns (CRUD, queries)
- **Service templates**: Business logic patterns
- **Controller templates**: API endpoint definitions
- **Test templates**: Testing patterns for each component

### Step 3: Extract Reusable Patterns
Identify patterns that apply across languages and projects:
- **Validation patterns**: Field validation based on type and constraints
- **Error handling patterns**: Consistent error responses and logging
- **Logging patterns**: Structured logging across layers
- **Testing patterns**: Isolated unit tests with mocking strategies
- **Configuration patterns**: Environment-specific configuration management

### Step 4: Delegate to Language-Specific Skills
Use existing language-specific skills for implementation:
- **Go backend**: `go-backend-scaffolder` for clean architecture Go code
- **Vue frontend**: `vue-quasar-scaffolder` for Vue 3 + Quasar components
- **CLI tools**: `go-cli-builder` for production Go CLI applications, `rust-cli-builder` for production Rust CLI applications
- **TDD integration**: `tdd-red-green-refactor` for test-driven implementation
- **Documentation**: `requirements-to-code-docs` for API and user documentation

### Step 5: Validate Template Output
Verify template design meets requirements:
- Use `spec-parser` output to validate template coverage
- Check pattern extraction against original requirements
- Validate delegation plan with language-specific skill capabilities
- Ensure templates produce consistent architecture across implementations

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
- **Consistent template libraries** across teams and projects
- **Language-agnostic patterns** that can be implemented in any stack
- **Efficient delegation** to language-specific skills for implementation
- **Comprehensive test patterns** included in all templates
- **Shared understanding** via standardized template approach
- **Rapid onboarding** with familiar template patterns

**Example Results:**
- Template library with 50+ reusable patterns across 5 languages
- 90% reduction in cross-project architecture inconsistencies
- Consistent error handling and logging patterns across all services
- Team velocity increased 2x through template reuse and delegation

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