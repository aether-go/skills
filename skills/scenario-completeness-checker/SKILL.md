---
name: scenario-completeness-checker
description: Use when validating GWT scenario coverage completeness including positive paths, negative paths, and boundary conditions for L3 specification completeness
---

# Scenario Completeness Checker

## Overview
Validate GWT (Given-When-Then) acceptance scenario coverage completeness. Ensures every specification has adequate scenario coverage across positive paths, negative paths, and boundary conditions. Part of D3 Specification Derivation Domain validation.

## When to Use

```
GWT scenarios generated? ──────────────────────┐
                                              │
Coverage validation needed? ───────────────────┤
                                              ├─► Use scenario-completeness-checker
L3 specification completeness check? ──────────┤
                                              │
Preparing for test-pyramid-deriver? ───────────┘
```

Use when:
- Validating GWT scenario coverage
- Ensuring specification completeness
- Checking positive/negative path coverage
- Validating boundary condition scenarios
- Quality gate before L3→L4 derivation

## Core Pattern

### Coverage Validation Model

```
Specification
    │
    ├── Positive Path Coverage
    │     └── Main success scenario
    │         └── Must have ≥1 scenario
    │
    ├── Negative Path Coverage
    │     ├── Invalid input handling
    │     ├── Constraint violations
    │     └── Error conditions
    │         └── Must have ≥1 scenario per constraint
    │
    ├── Boundary Coverage
    │     ├── Min/max values
    │     ├── Empty/null values
    │     └── Threshold transitions
    │         └── Must test each boundary
    │
    └── Edge Case Coverage
          ├── Concurrent operations
          ├── Race conditions
          └── Recovery scenarios
```

### Coverage Matrix

```yaml
coverage_validation:
  specification: "SPEC-001"
  
  positive_coverage:
    required: 1
    found: 2
    status: "PASS"
    
  negative_coverage:
    required: "1 per constraint"
    constraints: ["email_format", "password_strength", "duplicate_email"]
    found: 4
    status: "PASS"
    
  boundary_coverage:
    required: "min + max + edge"
    boundaries: ["min_length", "max_length", "empty", "unicode"]
    found: 4
    status: "PASS"
```

## Quick Reference

### Coverage Rules

| Scenario Type | Minimum Required | Validation |
|--------------|------------------|------------|
| Positive | 1 per spec | Main success path |
| Negative | 1 per constraint | Each validation rule |
| Boundary | 3 per input | Min, max, edge |
| Error | 1 per error code | Each failure mode |

## Integration with Aether.go Methodology

- **Input from**: spec-to-scenario, bdd-scenario-writer
- **Output to**: test-pyramid-deriver (coverage validation)
- **Part of**: D3 Specification Derivation Domain
