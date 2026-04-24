---
name: frontend-code-generator
description: Use when generating frontend implementation code from interface contracts and UI specifications for L5 implementation
---

# Frontend Code Generator

## Overview
Generate frontend implementation code from interface contracts and UI specifications. Part of D5 Implementation Derivation Domain, producing code that passes E2E tests and follows frontend best practices.

## When to Use

```
Interface contracts defined? ──────────────────┐
                                              │
Frontend implementation needed? ──────────────┤
                                              ├─► Use frontend-code-generator
L4 -> L5 code generation? ─────────────────────┤
                                              │
UI component development? ─────────────────────┘
```

Use when:
- Implementing frontend components from contracts
- L4→L5 code generation
- UI component development
- API integration code
- State management implementation

## Core Pattern

### L4→L5 Code Generation

```
L4: Interface Contract + UI Specs
    │
    ├── Contract-driven-code-generator
    │     └── Generates API client code
    │
    ├── e2e-test-generator
    │     └── E2E tests defined
    │
    └── Code Generation
          │
          ▼
L5: Working Frontend Code
    │
    ├── Components (Vue/React)
    ├── API Client
    ├── State Management
    └── Styling
```

### Generated Code Template

```yaml
frontend_code:
  framework: "vue"  # or react, svelte
  
  structure:
    - component: "UserRegistration"
      file: "UserRegistration.vue"
      imports: ["ref", "computed"]
      
    - component: "LoginForm"
      file: "LoginForm.vue"
      imports: ["ref", "useRouter"]
      
    - api_client: "auth"
      file: "api/auth.ts"
      imports: ["axios"]
```

## Quick Reference

### Generated Code Requirements

| Requirement | Description |
|-------------|-------------|
| Pass E2E tests | All E2E tests must pass |
| Contract compliance | Implements interface exactly |
| Accessibility | WCAG compliance |
| Responsive design | Mobile-first approach |

## Integration with Aether.go Methodology

- **Input from**: contract-driven-code-generator (API contracts), e2e-test-generator
- **Output to**: Integration validation
- **Part of**: D5 Implementation Derivation Domain (L4→L5)
