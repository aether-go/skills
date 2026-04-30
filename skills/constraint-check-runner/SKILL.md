---
name: constraint-check-runner
description: Use when executing constraint checks loaded from constraints/*.yml files. Implements P13 Constraint-Mechanization Principle and GATE-001 protocol. Part of D8 Meta-Capability Domain.
---

# Constraint Check Runner

## Overview
Execute constraint checks loaded from `constraints/*.yml` files. Implements P13 Constraint-Mechanization Principle and GATE-001 protocol, ensuring all constraints are executable and verifiable.

## When to Use

```
Constraints defined? ────────────────────┐
                                         │
Need to verify constraints? ─────────────┤
                                         ├─► Use constraint-check-runner
GATE-001 triggered? ─────────────────────┤
                                         │
P13 compliance check? ───────────────────┘
```

Use when:
- Constraints are defined in `constraints/*.yml`
- Need to verify constraint conformance
- GATE-001 protocol is triggered
- P13 compliance check is needed

Don't use when:
- No constraints are defined
- Only manual review is needed
- Constraints are not yet formalized

## Core Pattern

### Check Execution Process

```
Constraints Directory
    ├── Load constraint-*.yml files
    ├── Parse rules
    ├── Execute checks
    └── Report results
         |
         v
    Constraint Report
         |
         v
    GATE-001 Decision
```

### Constraint Types

| Type | Description | Example |
|------|-------------|---------|
| **Dependency Rule** | Module dependency constraints | "service-layer must not depend on controller-layer" |
| **Naming Convention** | Naming pattern constraints | "repository classes must end with Repository" |
| **Interface Rule** | Interface usage constraints | "all public methods must have tests" |
| **Performance Rule** | Performance budget constraints | "API response time < 200ms" |
| **Security Rule** | Security constraints | "no SQL injection vulnerabilities" |
| **Style Rule** | Code style constraints | "max line length: 120 characters" |

## Input Format

```yaml
check_request:
  constraints_path: ".aether/constraints/"
  
  scope:
    files: ["src/**/*.go"]
    exclude: ["vendor/**"]
  
  rules:
    - "dependency-rules.yml"
    - "naming-conventions.yml"
    - "performance-budgets.yml"
```

## Output Format

```yaml
constraint_report:
  timestamp: "2026-04-30T10:00:00Z"
  
  summary:
    total_rules: 23
    passed: 20
    failed: 2
    warning: 1
  
  results:
    - rule: "dependency-rules.yml:service-layer-isolation"
      type: dependency_rule
      status: passed
      details: "No violations found"
    
    - rule: "naming-conventions.yml:repository-suffix"
      type: naming_convention
      status: failed
      details: "UserRepo does not end with Repository"
      violations:
        - file: "src/repository/user.go"
          line: 15
          message: "Type UserRepo should be UserRepository"
    
    - rule: "performance-budgets.yml:api-response-time"
      type: performance_rule
      status: warning
      details: "P95: 195ms (budget: 200ms)"
      violations: []
  
  gate_001_status: warning
  action: proceed_with_notes
```

## Integration with Aether.go Methodology

- **Input from**: ConstitutionGuardian, contract-consistency-gate
- **Output to**: ConstitutionGuardian, GATE-001
- **Part of**: D8 Meta-Capability Domain

## Examples

### Example 1: All Passed
```yaml
constraints: 23
results: {passed: 23, failed: 0, warning: 0}
gate_001: passed
action: proceed
```

### Example 2: With Violations
```yaml
constraints: 23
results: {passed: 20, failed: 2, warning: 1}
violations:
  - "UserRepo naming violation"
  - "Missing performance test for GetUser"
gate_001: warning
action: proceed_with_notes
```
