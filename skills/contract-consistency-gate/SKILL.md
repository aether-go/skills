---
name: contract-consistency-gate
description: Use when verifying that generated code conforms to component contracts before entering L5 implementation. Implements GATE-001 protocol. Part of D4.5 Generation Dispatch Domain.
---

# Contract Consistency Gate

## Overview
Verify that generated code conforms to component contracts before allowing it to enter L5 implementation layer. Implements GATE-001 protocol, ensuring interface compliance, type consistency, behavioral consistency, dependency conformance, and performance baseline adherence.

## When to Use

```
Code generated? ─────────────────────────┐
                                         │
Need contract verification? ─────────────┤
                                         ├─► Use contract-consistency-gate
Before L5 entry? ────────────────────────┤
                                         │
GATE-001 triggered? ─────────────────────┘
```

Use when:
- Code has been generated (either deterministic or AI)
- Need to verify conformance to component contracts
- Before allowing code to enter L5 implementation layer
- GATE-001 protocol is triggered by ConstitutionGuardian

Don't use when:
- No component contracts exist
- Only reviewing existing code without generation context
- Contracts are still being drafted

## Core Pattern

### Gate Checks

```
Generated Code + Component Contract
    |
    ├── Interface Compliance Check
    ├── Type Consistency Check
    ├── Behavioral Consistency Check
    ├── Dependency Conformance Check
    └── Performance Baseline Check
         |
         v
    Gate Result
         |
         ├── ALL PASS → Proceed to L5
         ├── WARNING → Proceed with notes
         └── FAIL → Block and remediate
```

### Check Details

| Check | Description | Pass Criteria |
|-------|-------------|---------------|
| **Interface Compliance** | Generated code implements all interface contracts | All methods implemented, signatures match |
| **Type Consistency** | Input/output types match contract definitions | No type mismatches, nullability correct |
| **Behavioral Consistency** | Pre/post conditions satisfied | All preconditions checked, postconditions guaranteed |
| **Dependency Conformance** | Dependencies match contract specifications | No unauthorized dependencies, versions correct |
| **Performance Baseline** | Meet performance budgets defined in contracts | Response times within budget, resource usage acceptable |

## Input Format

```yaml
gate_request:
  task_id: "task-001"
  contract:
    interface: "UserService"
    methods:
      - name: "Register"
        input: "RegisterRequest"
        output: "RegisterResponse"
        errors: ["ValidationError", "DuplicateError"]
    preconditions:
      - "email not exists in database"
    postconditions:
      - "user created with hashed password"
    performance_budget:
      response_time_ms: 200
      memory_mb: 50
  
  generated_code:
    path: "src/api/user.go"
    language: "go"
    lines: 245
```

## Output Format

```yaml
gate_result:
  task_id: "task-001"
  contract_id: "contract-001"
  status: passed|failed|warning
  
  checks:
    interface_compliance:
      status: passed
      details: []
      score: 1.00
    
    type_consistency:
      status: passed
      details: []
      score: 1.00
    
    behavioral_consistency:
      status: warning
      details:
        - "Edge case 'duplicate email' handling not explicitly covered"
      score: 0.85
    
    dependency_conformance:
      status: passed
      details: []
      score: 1.00
    
    performance_baseline:
      status: passed
      details: []
      score: 1.00
      metrics:
        response_time_ms: 150
        memory_mb: 42
  
  overall_confidence: 0.92
  action: proceed|remediate|block
  
  violations:
    - severity: warning
      check: behavioral_consistency
      issue: "Edge case not covered"
      suggestion: "Add explicit duplicate email handling"
  
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: code-generator-dispatcher, AI generation channel
- **Output to**: DispatchOrchestrator, L5 implementation layer
- **Protocol**: GATE-001
- **Part of**: D4.5 Generation Strategy Dispatch Domain

## Examples

### Example 1: Pass
```yaml
task: "User registration endpoint"
checks: {all passed}
action: proceed_to_l5
confidence: 0.98
```

### Example 2: Warning
```yaml
task: "Order processing logic"
checks: {4 passed, 1 warning}
warning: "Performance budget tight (195ms/200ms)"
action: proceed_with_notes
confidence: 0.88
```

### Example 3: Fail
```yaml
task: "Payment integration"
checks: {3 passed, 2 failed}
failures:
  - "Missing error type: PaymentDeclined"
  - "Dependency version mismatch: stripe-go v72 vs v74"
action: block_and_remediate
confidence: 0.45
```
