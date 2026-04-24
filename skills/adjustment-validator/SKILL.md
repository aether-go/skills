---
name: adjustment-validator
description: Use when validating proposed architecture adjustments for correctness, safety, and impact before implementation
---

# Adjustment Validator

## Overview
Validate proposed architecture adjustments for correctness, safety, and impact before implementation. Ensures proposed changes don't introduce new issues while solving identified problems. Follows META-004 protocol.

## When to Use

```
Adjustment proposed? ───────────────────────────┐
                                              │
Pre-implementation validation needed? ─────────┤
                                              ├─► Use adjustment-validator
Safety check required? ────────────────────────┤
                                              │
Impact analysis needed? ───────────────────────┘
```

Use when:
- adjustment-proposer generates a proposal
- Need to verify proposal correctness
- Need to assess implementation risks
- Need to validate impact scope

## Core Pattern

### Validation Checklist

```
Adjustment Validation
    │
    ├── Correctness Check
    │     ├── Addresses root cause
    │     ├── Doesn't conflict with other components
    │     └── Follows methodology principles
    │
    ├── Safety Check
    │     ├── No new failure modes introduced
    │     ├── Backward compatibility maintained
    │     └── Rollback plan exists
    │
    └── Impact Analysis
    │     ├── Affects only necessary components
    │     ├── Migration path clear
    │     └── Resource requirements feasible
    │
    ▼
Validation Result: APPROVED / REJECTED / MODIFIED
```

### Validation Result

```yaml
validation_result:
  proposal_id: "AP-20250424-001"
  validator: "adjustment-validator"
  
  correctness:
    addresses_root_cause: true
    conflicts_with_components: []
    follows_principles: true
    score: 0.92
    
  safety:
    new_failure_modes: []
    backward_compatible: true
    rollback_plan: "documented"
    score: 0.95
    
  impact:
    affected_components: ["test-pyramid-deriver", "workflow-orchestrator"]
    migration_effort: "low"
    resource_requirements: "within_capacity"
    score: 0.88
    
  overall:
    status: "APPROVED"
    confidence: 0.91
    conditions: []
```

## Integration with Aether.go Methodology

- **Input from**: adjustment-proposer
- **Output to**: WorkflowOrchestrator (implementation)
- **Part of**: D8 Meta-Capability Domain (META-004)
