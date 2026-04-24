---
name: unit-test-generator
description: Use when generating unit tests from interface contracts with boundary value analysis and equivalence class partitioning for L5 implementation
---

# Unit Test Generator

## Overview
Generate unit tests from interface contracts using boundary value analysis and equivalence class partitioning. Part of D5 Implementation Derivation Domain, generating L5 unit tests that verify internal logic and component behavior against defined contracts.

## When to Use

```
Interface contracts defined? ──────────────────┐
                                              │
Unit test coverage needed? ────────────────────┤
                                              ├─► Use unit-test-generator
L4 -> L5 derivation? ────────────────────────┤
                                              │
TDD cycle preparation? ───────────────────────┘
```

Use when:
- Generating unit tests from contracts
- Following TDD methodology
- L4→L5 derivation
- Boundary value testing
- Preparing for tdd-cycle-runner

## Core Pattern

### L4→L5 Derivation

```
L4: Interface Contract
    │
    ├── Input Definition
    │     ├── Type, Format, Constraints
    │     └── Boundary Values
    │
    ├── Output Definition
    │     └── Success/Failure Semantics
    │
    └── Precondition/Postcondition
          │
          ▼
L5: Unit Tests
    │
    ├── Boundary Value Tests
    │     ├── Minimum boundary
    │     ├── Maximum boundary
    │     └── Just-outside boundaries
    │
    ├── Equivalence Class Tests
    │     ├── Valid class
    │     └── Invalid classes
    │
    └── Contract Behavior Tests
          ├── Precondition tests
          └── Postcondition tests
```

### Test Generation Template

```yaml
unit_tests:
  contract_id: "IC-001"
  component: "UserService.register"
  
  boundary_tests:
    - id: "ut-001"
      description: "Password at minimum length (8 chars)"
      input: {password: "Pass1234"}
      expected: "valid"
      
    - id: "ut-002"
      description: "Password below minimum (7 chars)"
      input: {password: "Pass123"}
      expected: "invalid_password_too_short"
      
    - id: "ut-003"
      description: "Password at maximum length (128 chars)"
      input: {password: "A" * 128}
      expected: "valid"
      
  equivalence_tests:
    - id: "ut-004"
      description: "Valid password with all requirements"
      class: "valid"
      input: {password: "SecurePass123!"}
      expected: "success"
      
    - id: "ut-005"
      description: "Missing uppercase"
      class: "invalid_no_uppercase"
      input: {password: "securepass123"}
      expected: "invalid_password"
```

## Quick Reference

### Test Coverage Requirements

| Input Type | Tests Required |
|------------|----------------|
| Numeric range | Min, Min-1, Max, Max+1, Middle |
| String length | Min, Min-1, Max, Max+1, Empty |
| Enum/Set | Each value + invalid value |
| Boolean | True, False |

## Integration with Aether.go Methodology

- **Input from**: interface-contract-designer (contracts), tdd-cycle-runner
- **Output to**: tdd-cycle-runner (RED phase)
- **Part of**: D5 Implementation Derivation Domain (L4→L5)
