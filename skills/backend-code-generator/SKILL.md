---
name: backend-code-generator
description: Use when generating backend implementation code from interface contracts and business logic specifications for L5 implementation
---

# Backend Code Generator

## Overview
Generate backend implementation code from interface contracts and business logic specifications. Part of D5 Implementation Derivation Domain, producing code that passes unit tests and integrates with infrastructure components.

## When to Use

```
Interface contracts defined? ──────────────────┐
                                              │
Backend implementation needed? ────────────────┤
                                              ├─► Use backend-code-generator
L4 -> L5 code generation? ─────────────────────┤
                                              │
TDD GREEN phase execution? ───────────────────┘
```

Use when:
- Implementing backend services from contracts
- L4→L5 code generation
- TDD GREEN phase (minimal implementation)
- API endpoint development
- Business logic implementation

## Core Pattern

### L4→L5 Code Generation

```
L4: Interface Contract + Business Logic
    │
    ├── Contract-driven-code-generator
    │     └── Generates skeleton code
    │
    ├── unit-test-generator
    │     └── Tests defined (RED phase)
    │
    └── tdd-cycle-runner
          └── GREEN phase: minimal code
                │
                ▼
L5: Working Backend Code
```

### Code Structure Template

```yaml
backend_code:
  language: "go"  # or python, java, etc.
  
  structure:
    - package: "userservice"
      file: "service.go"
      imports: ["context", "errors"]
      
    - package: "userservice"
      file: "repository.go"
      imports: ["database/sql"]
      
    - package: "userservice"
      file: "handler.go"
      imports: ["net/http"]
```

## Quick Reference

### Generated Code Requirements

| Requirement | Description |
|-------------|-------------|
| Pass unit tests | All tests must pass |
| Contract compliance | Implements interface exactly |
| Error handling | All error paths covered |
| Logging | Structured logging included |

## Integration with Aether.go Methodology

- **Input from**: contract-driven-code-generator (skeleton), unit-test-generator (tests)
- **Output to**: tdd-cycle-runner (GREEN phase)
- **Part of**: D5 Implementation Derivation Domain (L4→L5)
